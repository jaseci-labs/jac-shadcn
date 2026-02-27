# Export Feature: Themed Jacpack Generation

## Overview

Add the ability for users to **download a ready-to-use jac-client project** configured with their selected theme. The user configures style, colors, font, radius, etc. in the jac-shadcn customizer, clicks "Download", and receives a `.jacpack` file. They unpack it with `jac create myapp --use ./themed-project.jacpack` and have a fully styled, runnable project.

---

## How shadcn Does It (Reference)

When a user runs `npx shadcn create --preset "https://ui.shadcn.com/init?style=vega&theme=rose&..."`:

1. CLI creates a Vite project
2. Writes `components.json` (style config)
3. Generates `src/index.css` with themed CSS variables
4. Installs npm dependencies
5. Scaffolds UI components with **Tailwind classes baked in** (no `.cn-*` classes)
6. Creates `src/lib/utils.ts`

Key insight: **the output components have NO `.cn-*` CSS classes**. The style's Tailwind utilities are resolved and embedded directly in the component code. There is no separate `style-*.css` file in the output.

---

## Our Approach

### The Core Algorithm: Style Resolution

Our base components use `.cn-*` CSS class names as placeholders:

```jac
# Base button (style-agnostic)
glob _buttonVariants: Any = cva(
    "cn-button inline-flex items-center justify-center ...",
    {
        "variants": {
            "variant": {
                "default": "cn-button-variant-default",
                "outline": "cn-button-variant-outline"
            },
            "size": {
                "default": "cn-button-size-default",
                "sm": "cn-button-size-sm"
            }
        }
    }
);
```

Each style CSS file (`styles/style-nova.css`, `styles/style-vega.css`, etc.) defines what those classes resolve to:

```css
/* style-nova.css */
.cn-button {
  @apply focus-visible:border-ring rounded-lg border border-transparent text-sm font-medium ...;
}
.cn-button-variant-default {
  @apply bg-primary text-primary-foreground [a]:hover:bg-primary/80;
}
.cn-button-size-default {
  @apply h-8 gap-1.5 px-2.5 has-data-[icon=inline-end]:pr-2;
}
```

```css
/* style-vega.css (different!) */
.cn-button {
  @apply focus-visible:border-ring rounded-md border border-transparent text-sm font-medium ...;
}
.cn-button-variant-default {
  @apply bg-primary text-primary-foreground hover:bg-primary/80;
}
.cn-button-size-default {
  @apply h-9 gap-1.5 px-2.5 has-data-[icon=inline-end]:pr-2;
}
```

**The algorithm**:

```
1. Parse selected style CSS file (e.g., style-nova.css)
2. Build resolution map:
     "cn-button"                 → "focus-visible:border-ring rounded-lg ..."
     "cn-button-variant-default" → "bg-primary text-primary-foreground ..."
     "cn-button-size-default"    → "h-8 gap-1.5 px-2.5 ..."
     ... (327 entries per style)

3. For each component .cl.jac file:
     - Read file content
     - Find every "cn-{name}" token in string literals
     - Replace with resolved Tailwind classes from the map
     - Store resolved content

4. Result: component files with Tailwind classes baked in, no .cn-* references
```

**Before resolution** (base component):

```jac
className={cn("cn-card ring-foreground/10 bg-card text-card-foreground cn-card-gap ...", props.className)}
```

**After resolution** (for nova style):

```jac
className={cn("ring-foreground/10 bg-card text-card-foreground gap-4 overflow-hidden rounded-xl pt-4 pb-4 ...", props.className)}
```

No `.cn-*` classes remain. No style CSS file needed. The `cn()` utility with `tailwind-merge` handles any class duplication at runtime.

### Style Differences (Why This Matters)

The same component looks different per style because the resolved classes differ:

| `.cn-*` Class            | Vega                   | Nova         | Maia                   | Lyra           |
| ------------------------ | ---------------------- | ------------ | ---------------------- | -------------- |
| `cn-button`              | `rounded-md`           | `rounded-lg` | `rounded-xl`           | `rounded-none` |
| `cn-button-size-default` | `h-9 px-2.5`           | `h-8 px-2.5` | `h-9 px-3`             | `h-8 px-2.5`   |
| `cn-card`                | `py-6 gap-6 shadow-xs` | `py-4 gap-4` | `py-6 gap-6 shadow-sm` | `py-4 gap-4`   |

Same component code structure, different visual personality.

---

## Implementation Plan

### Phase 1: Backend — Style CSS Parser

**File**: `lib/style_resolver.jac` (server-side)

Parse a style CSS file and build the resolution map:

```
Input:  style-nova.css content (string)
Output: dict { "cn-button": "focus-visible:border-ring ...", "cn-button-variant-default": "bg-primary ...", ... }
```

Parsing logic:

1. Find all blocks matching pattern: `.cn-{name} { @apply {classes}; }`
2. Extract `name` and `classes` for each
3. Return as dict

The CSS follows a strict, consistent format — every `.cn-*` rule is:

```css
  .cn-{name} {
    @apply {tailwind-classes};
  }
```

No nested rules, no multi-line `@apply`, no exceptions across all 5 style files (verified: 327 `.cn-*` entries per file).

### Phase 2: Backend — Component Resolver

**File**: `lib/component_resolver.jac` (server-side)

Takes a `.cl.jac` file content + resolution map → produces resolved content:

```
Input:  component source (string), resolution map (dict)
Output: resolved component source (string) with all cn-* tokens replaced
```

Logic:

1. For each key in the resolution map (sorted longest-first to avoid partial matches):
   - Replace all occurrences of the key in the source string with its resolved classes
2. Return the modified source

### Phase 3: Backend — Global CSS Generator

**File**: `lib/css_generator.jac` (server-side)

Generates the `global.css` content based on config:

```
Input:  config dict { style, baseColor, theme, font, radius, menuAccent, menuColor }
Output: complete global.css content (string)
```

The generated CSS includes:

- `@import "tailwindcss";`
- `@import "tw-animate-css";`
- `@import "shadcn/tailwind.css";`
- `@import "@fontsource-variable/{selected-font}";`
- `@custom-variant dark (&:is(.dark *));`
- `:root { ... }` — CSS variables resolved from selected baseColor + theme + menuAccent + radius
- `.dark { ... }` — dark mode variables
- `@theme inline { ... }` — Tailwind theme integration with selected font
- `@layer base { ... }` — base reset styles

Uses the same theme/config data from `lib/themes.cl.jac` and `lib/config.cl.jac`.

### Phase 4: Backend — Jacpack Builder

**File**: `lib/jacpack_builder.jac` (server-side)

Assembles the complete `.jacpack` JSON:

```
Input:  config dict
Output: jacpack JSON (dict) ready to serve as download
```

Steps:

1. **Parse style CSS** — call style resolver with selected style file
2. **Resolve components** — for each of the 13 UI components, read base `.cl.jac` file and resolve `.cn-*` classes
3. **Generate global.css** — from config
4. **Generate jac.toml config** — with all required dependencies
5. **Generate main.jac** — basic entry point
6. **Bundle lib/utils.cl.jac** — the `cn()` utility
7. **Assemble jacpack dict**:

```python
{
    "name": "jac-shadcn-themed-project",
    "description": "Themed jac-client project generated by jac-shadcn",
    "config": {
        "project": {
            "name": "themed-project",
            "version": "1.0.0",
            "description": "Jac client application with custom theme",
            "entry-point": "main.jac"
        },
        "dependencies": {
            "npm": {
                "jac-client-node": "1.0.4",
                "class-variance-authority": "^0.7.1",
                "clsx": "^2.1.1",
                "tailwind-merge": "^3.5.0",
                "tw-animate-css": "^1.4.0",
                "radix-ui": "^1.4.3",
                "@base-ui/react": "^1.2.0",
                "@hugeicons/core-free-icons": "^3.1.1",
                "@hugeicons/react": "^1.1.5",
                "shadcn": "^3.8.5",
                "@fontsource-variable/{font}": "*",
                "dev": {
                    "@jac-client/dev-deps": "1.0.0",
                    "@tailwindcss/vite": "latest",
                    "tailwindcss": "latest"
                }
            }
        },
        "serve": { "base_route_app": "app" },
        "plugins": {
            "client": {
                "vite": {
                    "plugins": ["tailwindcss()"],
                    "lib_imports": ["import tailwindcss from '@tailwindcss/vite'"]
                }
            }
        },
        "jacpack": {
            "name": "jac-shadcn-themed-project",
            "description": "Themed jac-client project"
        }
    },
    "files": {
        "main.jac": "...",
        "global.css": "...(generated)...",
        "lib/utils.cl.jac": "...",
        "components/ui/button.cl.jac": "...(resolved)...",
        "components/ui/card.cl.jac": "...(resolved)...",
        "components/ui/badge.cl.jac": "...(resolved)...",
        "components/ui/input.cl.jac": "...(resolved)...",
        "components/ui/textarea.cl.jac": "...(resolved)...",
        "components/ui/label.cl.jac": "...(resolved)...",
        "components/ui/separator.cl.jac": "...(resolved)...",
        "components/ui/field.cl.jac": "...(resolved)...",
        "components/ui/input-group.cl.jac": "...(resolved)...",
        "components/ui/select.cl.jac": "...(resolved)...",
        "components/ui/combobox.cl.jac": "...(resolved)...",
        "components/ui/dropdown-menu.cl.jac": "...(resolved)...",
        "components/ui/alert-dialog.cl.jac": "...(resolved)..."
    },
    "directories": [
        "lib",
        "components",
        "components/ui"
    ],
    "root_gitignore_entries": [
        "packages/", "*.jbc", "*.jir", "__pycache__/",
        "*.py[cod]", ".venv/", "venv/", ".idea/",
        ".vscode/", "*.swp", "node_modules/", ".jac/",
        "*.session", "*.session.*"
    ]
}
```

### Phase 5: Backend — Download Endpoint

**File**: `main.jac` (add endpoint)

A walker or `@restspec` endpoint that:

1. Receives config from the frontend (`POST /walker/export_theme` or similar)
2. Calls jacpack builder
3. Returns the JSON as a downloadable file

```jac
walker export_theme {
    has config: dict;

    can start with Root entry {
        jacpack = build_jacpack(config);
        report jacpack;
    }
}
```

Frontend triggers download by creating a Blob from the JSON response and using `URL.createObjectURL()`.

### Phase 6: Frontend — Download Button

**File**: `components/customizer.cl.jac` (add button)

Add a "Download Project" button to the customizer panel:

1. Reads current config from `useDesignSystem()` context
2. Sends config to backend endpoint
3. Receives jacpack JSON
4. Triggers browser download as `themed-project.jacpack`

---

## User Workflow

```
1. Visit jac-shadcn at localhost:8000
2. Configure theme:
   - Pick style (Nova)
   - Pick colors (Gray base + Rose accent)
   - Pick font (Inter)
   - Pick radius (Medium)
   - Adjust menu accent/color
3. Click "Download Project"
4. Receive themed-project.jacpack
5. In terminal:
   $ jac create myapp --use ./themed-project.jacpack
   $ cd myapp
   $ jac start main.jac
6. Running project with:
   - All 13 UI components with Nova+Rose+Inter styling baked in
   - Themed CSS variables
   - All dependencies installed
   - Ready to build on top of
```

---

## Output Project Structure

```
myapp/
├── main.jac                    # Entry point
├── global.css                  # Themed CSS variables + imports
├── jac.toml                    # Project config with all deps
├── lib/
│   └── utils.cl.jac            # cn() utility
└── components/
    └── ui/
        ├── button.cl.jac       # Style-resolved (Tailwind classes baked in)
        ├── card.cl.jac
        ├── badge.cl.jac
        ├── alert-dialog.cl.jac
        ├── input.cl.jac
        ├── textarea.cl.jac
        ├── label.cl.jac
        ├── separator.cl.jac
        ├── field.cl.jac
        ├── input-group.cl.jac
        ├── select.cl.jac
        ├── combobox.cl.jac
        └── dropdown-menu.cl.jac
```

No `styles/` directory. No `.cn-*` indirection. Components are self-contained with Tailwind utilities. Just like shadcn's output.

---

## Future: `jac create` Integration (Approach B)

> **Note**: This is a long-term vision, not part of the current implementation. Documented here for future reference.

The ultimate goal is to integrate theme scaffolding directly into the `jac create` CLI, similar to how `npx shadcn create --preset` works.

### Concept

```bash
# Create a themed project in one command
jac create myapp --use client --theme "style=nova&baseColor=gray&theme=rose&font=inter&radius=medium"

# Or using a jac-shadcn preset URL
jac create myapp --use jaccn --preset "https://jac-shadcn.jaseci.org/init?style=nova&theme=rose&..."
```

### What This Would Require

1. **`jac create` CLI changes** — accept `--theme` or `--preset` parameter alongside `--use client`
2. **Theme registry** — a hosted or bundled registry of:
   - Style CSS files (vega, nova, maia, lyra, mira)
   - Theme definitions (21 color themes in OKLCH)
   - Font mappings
   - Base component templates
3. **Style resolver in jac-client** — the same CSS parsing + component resolution algorithm, but built into the `jac` CLI toolchain
4. **Preset URL protocol** — a `/init` endpoint (like shadcn's) that returns a config JSON from URL parameters

### Flow

```
jac create myapp --use client --theme "style=nova&theme=rose&font=inter"
         ↓
CLI parses theme parameters
         ↓
Fetches base component templates from registry
         ↓
Resolves .cn-* classes using style CSS (same algorithm as jac-shadcn export)
         ↓
Generates global.css with themed CSS variables
         ↓
Writes all files to myapp/
         ↓
Installs npm dependencies
         ↓
Ready to run
```

### Advantages Over Jacpack Approach

- **One command** — no separate download + unpack step
- **Always up to date** — fetches latest components from registry
- **Composable** — could support `jac add button` to add individual components later
- **Familiar** — mirrors the `npx shadcn create` experience exactly

### Prerequisites

- jac-client CLI supports plugin/extension mechanism for `--theme` flag
- Component registry is hosted (or bundled with jac-client)
- Style resolver is ported from jac-shadcn's Python/Jac implementation to work within the CLI

This would position Jac as having a first-class design system toolchain comparable to shadcn/ui's developer experience.

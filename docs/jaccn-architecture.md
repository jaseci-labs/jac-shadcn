# JacCN Architecture: Theme Customizer + Component Registry

## Overview

JacCN is a design system for Jac — 55 UI components with 5 visual styles, 21 color themes, 12 fonts, and configurable radius/menu options. Users customize their theme on **jac-shadcn** (the web UI), then get a working Jac project through one of three delivery methods:

1. **URL** — `jac create myapp --use "https://jac-shadcn.jaseci.org/jacpack?style=nova&theme=rose&font=inter"`
2. **Download** — customize on jac-shadcn, download `.jacpack`, run `jac create myapp --use ./file.jacpack`
3. **On-demand** — `jac create myapp --use jaccn` then `jac add --ui button dialog tabs`

All three use the same core: parse style CSS, resolve `cn-*` tokens to Tailwind classes, generate themed CSS variables, assemble into jacpack format.

---

## System Diagram

```
                    ┌──────────────────────────────────────┐
                    │         jac-shadcn (hosted)              │
                    │    Customizer + Registry Server       │
                    │                                      │
                    │  ┌──────────────────────────────┐    │
                    │  │  Base Components (55 .cl.jac) │    │
                    │  │  with cn-* placeholder tokens │    │
                    │  └──────────────────────────────┘    │
                    │  ┌──────────────────────────────┐    │
                    │  │  5 Style CSS Files            │    │
                    │  │  (nova, vega, maia, lyra, mira)│   │
                    │  └──────────────────────────────┘    │
                    │  ┌──────────────────────────────┐    │
                    │  │  Style Resolution Engine      │    │
                    │  │  (parse CSS → resolve cn-*)   │    │
                    │  └──────────────────────────────┘    │
                    │                                      │
                    │  Web UI:  Visual theme customizer     │
                    │                                      │
                    │  GET /jacpack?style=nova&theme=rose   │
                    │      → full .jacpack for jac create   │
                    │                                      │
                    │  GET /component/button?style=nova     │
                    │      → single resolved component      │
                    │                                      │
                    │  GET /registry                        │
                    │      → component list + metadata       │
                    └──────────┬───────────┬───────────────┘
                               │           │
              ┌────────────────▼──┐  ┌─────▼──────────────┐
              │  jac create       │  │  jac add --ui       │
              │  --use URL or     │  │  button dialog tabs │
              │  --use file.jacpack│  │                    │
              │                   │  │  Fetches individual │
              │  Full project     │  │  components from    │
              │  scaffolding      │  │  registry, resolves │
              └───────────────────┘  │  per project style  │
                                     └────────────────────┘
```

---

## The `[jaccn]` Config (like shadcn's `components.json`)

Every JacCN project has a `[jaccn]` section in `jac.toml` that stores the full theme configuration. This is the Jac equivalent of shadcn's `components.json`.

### Format

```toml
[jaccn]
style = "nova"
baseColor = "gray"
theme = "rose"
font = "inter"
radius = "medium"
menuAccent = "subtle"
menuColor = "default"
registry = "https://jac-shadcn.jaseci.org"
```

### What Each Field Controls

| Field        | Values                                                                                                                        | What It Does                                                                                                     |
| ------------ | ----------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| `style`      | nova, vega, maia, lyra, mira                                                                                                  | Component visual personality — spacing, radius, density. Determines which style CSS is used for cn-\* resolution |
| `baseColor`  | neutral, stone, zinc, gray                                                                                                    | Base neutral palette — affects background, foreground, border, muted, card colors                                |
| `theme`      | neutral, amber, blue, cyan, emerald, fuchsia, green, indigo, lime, orange, pink, purple, red, rose, sky, teal, violet, yellow | Accent color — overrides primary, chart, sidebar-primary colors on top of base                                   |
| `font`       | geist, inter, noto-sans, nunito-sans, figtree, roboto, raleway, dm-sans, public-sans, outfit, jetbrains-mono, geist-mono      | Font family for `--font-sans` CSS variable and `@import` in global.css                                           |
| `radius`     | default, none, small, medium, large                                                                                           | Border radius scale — sets `--radius` CSS variable (0, 0.45rem, 0.625rem, 0.875rem)                              |
| `menuAccent` | subtle, bold                                                                                                                  | When "bold": accent/sidebar-accent colors = primary color                                                        |
| `menuColor`  | default, inverted                                                                                                             | When "inverted": dropdown menus get `.dark` class for inverted look                                              |
| `registry`   | URL                                                                                                                           | Where `jac add --ui` fetches components from                                                                     |

### How It's Used

**During `jac create`**: jac-shadcn generates the `[jaccn]` section from the user's selections. All components in the jacpack are already resolved — the config is stored for reference and for future `jac add --ui` calls.

**During `jac add --ui`**: the plugin reads `[jaccn]` to know which style to use when resolving new components. It sends `style=nova` to the registry and gets back a pre-resolved component.

**Comparison with shadcn's `components.json`**:

```
shadcn (Vite/React)              JacCN (Jac)
─────────────────────            ─────────────────────
components.json                  jac.toml [jaccn]
  style: "new-york"               style = "nova"
  baseColor: "gray"               baseColor = "gray"
  cssVariables: true               theme = "rose"
  tailwind.config: "..."          font = "inter"
  aliases.components: "@/..."     radius = "medium"
                                   menuAccent = "subtle"
                                   menuColor = "default"
                                   registry = "https://..."
```

---

## The Three User Flows

### Flow 1: URL-based Creation (Primary)

The recommended flow. User customizes theme on jac-shadcn, copies a URL, creates project in one command.

```bash
jac create myapp --use "https://jac-shadcn.jaseci.org/jacpack?style=nova&baseColor=gray&theme=rose&font=inter&radius=medium&menuAccent=subtle&menuColor=default"
cd myapp
jac start main.jac
```

**What happens:**

```
CLI detects URL → downloads jacpack JSON from jac-shadcn
                                    ↓
          jac-shadcn endpoint receives query params
                                    ↓
          Parses style-nova.css → builds cn-* resolution map (327 entries)
                                    ↓
          Reads 55 base components, resolves cn-* → Tailwind classes
                                    ↓
          Builds global.css with themed CSS vars (from baseColor + theme + menuAccent + radius)
                                    ↓
          Generates jac.toml config with [jaccn] section + all npm deps
                                    ↓
          Returns .jacpack JSON
                                    ↓
CLI unpacks: creates directories, writes files, generates jac.toml, .gitignore
                                    ↓
Post-create: runs bun install
                                    ↓
Done — project ready to run
```

**jac-shadcn endpoint**: `GET /jacpack`

Query parameters match the `[jaccn]` config fields:

- `style` (default: nova)
- `baseColor` (default: neutral)
- `theme` (default: neutral)
- `font` (default: figtree)
- `radius` (default: default)
- `menuAccent` (default: subtle)
- `menuColor` (default: default)

Returns raw jacpack JSON (not wrapped in TransportResponse).

**jac-shadcn web UI integration**: The customizer panel shows a "Copy URL" button alongside "Download Project". Clicking it copies the full `jac create --use "https://..."` command to clipboard.

### Flow 2: Download from Web UI

Same as today. User customizes, clicks download, gets `.jacpack` file.

```bash
# Download themed-project.jacpack from jac-shadcn web UI
jac create myapp --use ./themed-project.jacpack
cd myapp
jac start main.jac
```

### Flow 3: Base Project + Add Components On Demand

For users who want a lean project and add components as needed.

```bash
# Step 1: Create base project (theme + utils, no UI components)
jac create myapp --use jaccn
cd myapp

# Step 2: Add components individually
jac add --ui button card
jac add --ui dialog tabs checkbox switch
jac add --ui table

# Step 3: Run
jac start main.jac
```

**`jac create --use jaccn`** creates a minimal themed project:

```
myapp/
├── main.jac          # Starter app (imports nothing yet)
├── jac.toml          # Config with [jaccn] section
├── global.css        # Themed CSS variables
├── lib/
│   └── utils.cl.jac  # cn() utility
└── components/
    └── ui/           # Empty — user adds components here
```

**`jac add --ui button`** then:

1. Reads `jac.toml` → `[jaccn] style = "nova"`, `registry = "https://jac-shadcn.jaseci.org"`
2. Fetches `GET {registry}/component/button?style=nova`
3. Writes `components/ui/button.cl.jac` (already resolved, no cn-\*)
4. Checks component manifest → button needs `cva`, `radix-ui` npm packages
5. Adds missing npm deps to `[dependencies.npm]` in `jac.toml`
6. Runs `bun install`
7. Prints: `Added button`

**Dependency resolution for `jac add --ui alert-dialog`**:

1. Fetches alert-dialog manifest → needs peer component: `button`
2. Checks if `components/ui/button.cl.jac` exists
3. If not → auto-adds button first
4. Fetches alert-dialog, writes it
5. Adds npm deps (`radix-ui` if missing)
6. Prints: `Added alert-dialog + button (dependency)`

---

## Component Registry

### `registry.json` — Component Manifest

Lives in jac-shadcn, served at `GET /registry`. Describes all 55 components with their dependencies.

```json
{
  "version": "1.0.0",
  "components": {
    "accordion": {
      "file": "accordion.cl.jac",
      "npmDeps": ["radix-ui"],
      "peerComponents": []
    },
    "alert": {
      "file": "alert.cl.jac",
      "npmDeps": [],
      "peerComponents": []
    },
    "alert-dialog": {
      "file": "alert-dialog.cl.jac",
      "npmDeps": ["radix-ui"],
      "peerComponents": ["button"]
    },
    "avatar": {
      "file": "avatar.cl.jac",
      "npmDeps": ["radix-ui"],
      "peerComponents": []
    },
    "badge": {
      "file": "badge.cl.jac",
      "npmDeps": ["class-variance-authority", "radix-ui"],
      "peerComponents": []
    },
    "button": {
      "file": "button.cl.jac",
      "npmDeps": ["class-variance-authority", "radix-ui"],
      "peerComponents": []
    },
    "card": {
      "file": "card.cl.jac",
      "npmDeps": [],
      "peerComponents": []
    },
    "checkbox": {
      "file": "checkbox.cl.jac",
      "npmDeps": ["radix-ui"],
      "peerComponents": []
    },
    "combobox": {
      "file": "combobox.cl.jac",
      "npmDeps": ["@base-ui/react"],
      "peerComponents": ["button", "input-group"]
    },
    "dialog": {
      "file": "dialog.cl.jac",
      "npmDeps": ["radix-ui"],
      "peerComponents": []
    },
    "dropdown-menu": {
      "file": "dropdown-menu.cl.jac",
      "npmDeps": ["radix-ui", "@hugeicons/react", "@hugeicons/core-free-icons"],
      "peerComponents": []
    },
    "field": {
      "file": "field.cl.jac",
      "npmDeps": ["class-variance-authority"],
      "peerComponents": ["label", "separator"]
    },
    "input": {
      "file": "input.cl.jac",
      "npmDeps": [],
      "peerComponents": []
    },
    "input-group": {
      "file": "input-group.cl.jac",
      "npmDeps": ["class-variance-authority"],
      "peerComponents": ["button", "input", "textarea"]
    },
    "label": {
      "file": "label.cl.jac",
      "npmDeps": ["radix-ui"],
      "peerComponents": []
    },
    "select": {
      "file": "select.cl.jac",
      "npmDeps": ["radix-ui", "@hugeicons/react", "@hugeicons/core-free-icons"],
      "peerComponents": []
    },
    "separator": {
      "file": "separator.cl.jac",
      "npmDeps": ["radix-ui"],
      "peerComponents": []
    },
    "switch": {
      "file": "switch.cl.jac",
      "npmDeps": ["radix-ui"],
      "peerComponents": []
    },
    "table": {
      "file": "table.cl.jac",
      "npmDeps": [],
      "peerComponents": []
    },
    "tabs": {
      "file": "tabs.cl.jac",
      "npmDeps": ["radix-ui"],
      "peerComponents": []
    },
    "textarea": {
      "file": "textarea.cl.jac",
      "npmDeps": [],
      "peerComponents": []
    },
    "tooltip": {
      "file": "tooltip.cl.jac",
      "npmDeps": ["radix-ui"],
      "peerComponents": []
    }
  },
  "sharedDeps": {
    "clsx": "^2.1.1",
    "tailwind-merge": "^3.5.0",
    "tw-animate-css": "^1.4.0",
    "shadcn": "^3.8.5"
  }
}
```

> Note: Only a subset of the 55 components shown above. The full manifest will include all components once converted.

### Registry Endpoints

**`GET /registry`**
Returns `registry.json` — the full component manifest.

**`GET /component/{name}?style=nova`**
Returns a single resolved component file content. Used by `jac add --ui`.

Response:

```json
{
  "name": "button",
  "content": "cl import from \"class-variance-authority\" { cva }\n...",
  "npmDeps": ["class-variance-authority", "radix-ui"],
  "peerComponents": []
}
```

**`GET /jacpack?style=nova&baseColor=gray&theme=rose&font=inter&radius=medium&menuAccent=subtle&menuColor=default`**
Returns a complete `.jacpack` JSON with all components resolved. Used by `jac create --use URL`.

---

## The `jaccn` Plugin Package

A pip-installable plugin that extends the `jac` CLI with `--ui` support and registers the base template.

### Package Structure

```
jaccn/
├── pyproject.toml
├── jaccn/
│   ├── __init__.py
│   ├── plugin.jac              # Hook implementations
│   ├── ui_handler.jac          # --ui add logic
│   └── templates/
│       └── jaccn.jacpack       # Pre-built base template (default theme)
```

### Plugin Registration

```toml
# pyproject.toml
[project.entry-points."jac"]
plugin_config = "jaccn.plugin:JaccnPluginConfig"
```

### What the Plugin Does

**1. Registers `jaccn` template** (for `jac create --use jaccn`):

```
@hookimpl
register_project_template() → loads jaccn.jacpack from templates/
```

**2. Extends `jac add` with `--ui` flag**:

```
@hookimpl
create_cmd() → registry.extend_command("add",
    args=[Arg.create("ui", typ=bool, ...)],
    pre_hook=_handle_ui_add
)
```

**3. Handles `jac add --ui {components}`**:

```
_handle_ui_add(ctx):
  1. Read jac.toml [jaccn] → style, registry URL
  2. For each component name:
     a. GET {registry}/component/{name}?style={style}
     b. Resolve peer dependencies (recursive)
     c. Write .cl.jac files to components/ui/
     d. Collect all npm deps
  3. Add missing npm deps to jac.toml [dependencies.npm]
  4. Run bun install
  5. Print summary
```

### Installation

```bash
pip install jaccn
# Now available:
jac create myapp --use jaccn
jac add --ui button dialog tabs
```

---

## Implementation Phases

### Phase 1: Convert Remaining Components (42 of 55)

**Goal**: All 55 shadcn components ported to `.cl.jac` with `cn-*` tokens.

**Source**: `/home/ahzan/Documents/jaseci/ui-main/apps/v4/registry/bases/radix/ui/`

**Already done (13)**:
accordion ~~alert-dialog~~ ~~badge~~ ~~button~~ ~~card~~ ~~combobox~~ ~~dropdown-menu~~ ~~field~~ ~~input~~ ~~input-group~~ ~~label~~ ~~select~~ ~~separator~~ ~~textarea~~

**Remaining (42)**:
accordion, alert, aspect-ratio, avatar, breadcrumb, button-group, calendar, carousel, chart, checkbox, collapsible, command, context-menu, dialog, direction, drawer, empty, hover-card, input-otp, item, kbd, menubar, native-select, navigation-menu, pagination, popover, progress, radio-group, resizable, scroll-area, sheet, sidebar, skeleton, slider, sonner, spinner, switch, table, tabs, toggle, toggle-group, tooltip

**Process per component**:

1. Read the `.tsx` source from the shadcn registry
2. Convert to `.cl.jac` syntax (JSX patterns, imports, props handling)
3. Keep `cn-*` class tokens (style-agnostic)
4. Verify it resolves cleanly against all 5 style CSS files (0 unresolved tokens)
5. Test in jac-shadcn customizer (renders correctly, style switching works)

**Conversion guide**: See `docs/tsx-to-jac-conversion-guide.md` for patterns, gotchas, and troubleshooting.

### Phase 2: Build Component Manifest

**Goal**: `registry.json` with metadata for all 55 components.

**Per component, document**:

- `npmDeps` — which npm packages it imports (radix-ui, cva, @base-ui/react, etc.)
- `peerComponents` — which other components it imports (button, input, label, etc.)

**Source**: Extract from each component's `cl import from` statements.

### Phase 3: Update Export Service

**Goal**: Export all 55 components (not just 13), support component selection, resolve peer dependencies.

**Changes to `lib/export_service.jac`**:

1. Update `COMPONENT_FILES` list from 13 → 55
2. Add `registry.json` loading for dependency resolution
3. Add component selection logic (user picks which components to include)
4. Resolve peer dependencies recursively (adding alert-dialog adds button)
5. Build `[jaccn]` section in the exported jac.toml config
6. Collect only the npm deps needed for selected components

### Phase 4: Add GET Endpoint for URL-based Creation

**Goal**: `GET /jacpack?style=nova&theme=rose&...` returns raw jacpack JSON.

**Challenge**: `@restspec` wraps responses in TransportResponse. The `jac create` CLI expects raw jacpack JSON.

**Solutions**:

- **Option A**: Custom ASGI middleware that intercepts `/jacpack` path and serves raw JSON
- **Option B**: Standalone endpoint outside jac-scale (a simple Python HTTP handler mounted on the ASGI app)
- **Option C**: Modify `jac create`'s URL handler to unwrap TransportResponse (requires jac-client PR)

**Also add**: "Copy URL" button in the jac-shadcn customizer UI alongside "Download Project".

### Phase 5: Build `jaccn` Plugin Package

**Goal**: `pip install jaccn` enables `jac create --use jaccn` and `jac add --ui`.

**Sub-tasks**:

1. Create `jaccn/` Python package with `pyproject.toml`
2. Implement `register_project_template` hook → registers pre-built `jaccn.jacpack`
3. Implement `create_cmd` hook → extends `jac add` with `--ui` flag
4. Implement `_handle_ui_add` handler:
   - Read `[jaccn]` config from `jac.toml`
   - Fetch components from registry
   - Resolve peer dependencies
   - Write files + update `jac.toml` npm deps
   - Run `bun install`
5. Generate the default `jaccn.jacpack` (nova + neutral + figtree)
6. Package and publish to PyPI

### Phase 6: Host jac-shadcn

**Goal**: jac-shadcn running at `jac-shadcn.jaseci.org` with all endpoints live.

**Includes**:

- Deploy jac-shadcn as a service
- Serve the GET `/jacpack` endpoint
- Serve the GET `/component/{name}` endpoint
- Serve the GET `/registry` endpoint
- Web UI accessible for visual customization

---

## Output Project Structure

After `jac create myapp --use URL` with all components:

```
myapp/
├── main.jac                         # Starter app
├── jac.toml                         # Config with [jaccn] section
├── global.css                       # Themed CSS variables + imports
├── lib/
│   └── utils.cl.jac                 # cn() utility (clsx + tailwind-merge)
└── components/
    └── ui/
        ├── accordion.cl.jac         # All resolved — Tailwind classes baked in
        ├── alert.cl.jac             # No cn-* tokens
        ├── alert-dialog.cl.jac      # No style CSS needed
        ├── avatar.cl.jac
        ├── badge.cl.jac
        ├── button.cl.jac
        ├── card.cl.jac
        ├── checkbox.cl.jac
        ├── ...
        └── tooltip.cl.jac           # (55 total)
```

No `styles/` directory. No `.cn-*` indirection. Components are self-contained with Tailwind utilities. Just like shadcn's output.

---

## Style Resolution Algorithm (Reference)

The same algorithm powers all three flows. Already implemented in `lib/export_service.jac`.

```
Input:
  - Style name (e.g., "nova")
  - Base component source (e.g., button.cl.jac with cn-* tokens)

Process:
  1. Parse styles/style-{name}.css
  2. Extract all .cn-{class} { @apply {tailwind-classes}; } rules
  3. Build resolution map: { "cn-button": "rounded-lg border ...", ... }
     (327 entries per style)
  4. Sort keys longest-first (avoid partial matches)
  5. String-replace all cn-* tokens in component source

Output:
  - Resolved component source with Tailwind classes baked in
```

**Example**:

Before (base component):

```jac
"cn-button focus-visible:border-ring ..."
```

After resolution (nova style):

```jac
"focus-visible:border-ring rounded-lg border border-transparent text-sm font-medium ..."
```

After resolution (vega style):

```jac
"focus-visible:border-ring rounded-md border border-transparent text-sm font-medium ..."
```

Different styles produce different class values. Same structure, different visual personality.

---

## Summary

```
Phase 1: Convert 42 components        ← Foundation (biggest effort)
Phase 2: Build registry.json          ← Component metadata
Phase 3: Update export service         ← Support all 55 + selection + deps
Phase 4: GET /jacpack endpoint         ← Enable URL-based jac create
Phase 5: jaccn plugin package          ← Enable jac add --ui
Phase 6: Host jac-shadcn                  ← Make it all live
```

The core algorithm (style resolution) is already built and tested. Converting components is the main remaining work. Everything else is delivery infrastructure built on top.

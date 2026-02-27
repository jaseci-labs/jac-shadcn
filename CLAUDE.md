# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**jac-shadcn** is a shadcn-style UI component library and theme customizer for the Jac language. It provides UI components ported from TypeScript/React to Jac (`.cl.jac`), a visual theme customizer with 5 styles, 21 color themes, and 12 fonts, and a registry server that serves resolved components for `jac add --shadcn`.

Hosted at: `https://jac-shadcn.jaseci.org`

## Running the Project

```bash
source /home/ahzan/.jacvenv/bin/activate    # Required — always activate this venv first
jac start main.jac                          # Serves on http://localhost:8000
```

No separate build step. The Jac compiler handles transpilation to JS + Vite bundling automatically.

## Project Structure

```
jac-shadcn/
├── main.jac                          # Entry point — app + 3 REST endpoints
├── jac.toml                          # Project config (npm deps, Vite plugins, Tailwind)
├── global.css                        # Tailwind CSS + shadcn theme variables (oklch)
├── styles/                           # 5 style CSS files (cn-* token definitions, ~327 per file)
├── lib/
│   ├── utils.cl.jac                  # cn() utility (clsx + tailwind-merge)
│   ├── config.cl.jac                 # buildRegistryTheme() + RADII, PRESETS, defaults
│   ├── themes.cl.jac                 # 21 color themes (oklch CSS variables)
│   ├── fonts.cl.jac                  # 12 font families (@fontsource-variable)
│   ├── styles.cl.jac                 # Style metadata (names, descriptions)
│   ├── design-system-provider.cl.jac # React context — applies theme to DOM
│   └── export_service.jac            # Server-side: parse CSS, resolve components, build jacpack
├── components/
│   ├── customizer.cl.jac             # Right sidebar — 7 picker sub-components
│   ├── preview-panel.cl.jac          # Center — live component preview
│   ├── item-explorer.cl.jac          # Left sidebar — component list
│   ├── component-showcases.cl.jac    # Component demo cards
│   └── ui/                           # UI components (button, card, dialog, etc.)
├── data/                             # themes.json, registry.json
└── docs/                             # tsx-to-jac-conversion-guide.md, jaccn-architecture.md
```

## Core Architecture: Theme → CSS → Components

The system has three layers that work together. Understanding this flow is essential for any changes.

### Layer 1: Config (lib/config.cl.jac)

A config object with 7 fields drives the entire theme:
```
{ style, baseColor, theme, font, radius, menuAccent, menuColor }
```

`buildRegistryTheme(config)` is the pivot function — it merges a base color palette (4 neutrals: neutral/stone/zinc/gray) with an accent theme (17 colors like rose/blue/emerald), applies menuAccent overrides, and computes radius values. Returns `{ name, cssVars: { light: {...}, dark: {...} } }` with 30+ oklch CSS variables.

### Layer 2: DesignSystemProvider (lib/design-system-provider.cl.jac)

A React Context that applies the config to the DOM via three mechanisms:

1. **Body classes** (`useLayoutEffect`): Adds `.style-nova .base-color-gray` to body — activates the correct `styles/style-*.css` rules
2. **Inline CSS variables** (`useLayoutEffect`): Creates `<style id="ds-theme-vars">` injecting all 30+ CSS vars as body inline styles — highest specificity, overrides `@theme inline`
3. **Font application**: Sets `--font-sans` + inline `fontFamily` on both `documentElement` and `body` (three places needed for reliable switching)

Also handles menu color inversion via `MutationObserver` watching for `.cn-menu-target` elements.

### Layer 3: cn-* Token System (the core innovation)

Components use **style-agnostic placeholder class names** like `cn-button`, `cn-card-header`, `cn-button-variant-default`. These are NOT real CSS classes — they're resolved differently per style.

**In a component** (`components/ui/button.cl.jac`):
```jac
cva("cn-button focus-visible:border-ring ... inline-flex items-center", {
    "variants": { "variant": { "default": "cn-button-variant-default bg-primary ..." } }
})
```

**In a style file** (`styles/style-nova.css`):
```css
.style-nova .cn-button { @apply rounded-lg border border-transparent text-sm font-medium; }
.style-nova .cn-button-variant-default { @apply bg-primary text-primary-foreground; }
```

**In another style** (`styles/style-vega.css`):
```css
.style-vega .cn-button { @apply rounded-md border border-transparent text-sm font-medium; }
```

Same component code → different visual output per style. The `.style-*` body class determines which CSS rules activate.

### Export Service: Inverting the Flow (lib/export_service.jac)

Server-side Python that produces standalone themed projects. The pipeline:
1. `parse_style_css(style)` — regex-extracts all cn-* → Tailwind mappings from the style CSS file
2. `resolve_component(source, map)` — replaces cn-* tokens with resolved Tailwind classes (sorted longest-first to avoid partial matches)
3. `generate_global_css(font, cssVars)` — produces themed global.css with baked-in color vars
4. `build_jacpack()` — assembles all resolved files into a downloadable jacpack

Exported projects have **no cn-* tokens** — all classes are resolved to concrete Tailwind.

## Registry Endpoints (defined in main.jac)

- **`GET /registry`** — Component manifest (names, npmDeps, peerComponents)
- **`GET /component/{name}?style=nova`** — Single resolved component file content
- **`GET /jacpack?style=nova&theme=rose&font=inter&...`** — Complete .jacpack for `jac create --use URL`

## Plugin Package

The CLI plugin lives at `/home/ahzan/Documents/jaseci/jaseci/jac-ui/plugins/jac-shadcn/`:
- `jac add --shadcn button card` — adds components from this registry
- `jac remove --shadcn button` — removes components
- `jac create --use jac-shadcn` — scaffolds themed project

## Technology Stack

| Layer | Technology |
|-------|-----------|
| Language | Jac (`.cl.jac` for client-side JSX) |
| UI Primitives | Radix UI (`radix-ui` ^1.4.3), Base UI (`@base-ui/react` ^1.2.0) |
| Styling | Tailwind CSS v4 + `class-variance-authority` (CVA) |
| Icons | HugeIcons (`@hugeicons/react` + `@hugeicons/core-free-icons`) |
| CSS Utilities | `clsx` + `tailwind-merge` via `cn()` |
| Build | Vite (auto-configured by Jac compiler) |
| React | v18.3.1 (pinned by `jac-client-node`) — no ref-as-prop (React 19 feature) |

## Component Authoring Patterns

Full documentation: `docs/tsx-to-jac-conversion-guide.md`

### CVA + cn-* Token Pattern
```jac
glob _buttonVariants: Any = cva(
    "cn-button focus-visible:border-ring inline-flex items-center ...",
    {
        "variants": {
            "variant": {
                "default": "cn-button-variant-default bg-primary text-primary-foreground ...",
                "outline": "cn-button-variant-outline border-border bg-background ..."
            },
            "size": {
                "default": "cn-button-size-default h-8 gap-1.5 px-2.5 ..."
            }
        },
        "defaultVariants": { "variant": "default", "size": "default" }
    }
);
```

### Props Extraction (no destructuring)
```jac
def:pub Button(props: Any) -> JsxElement {
    variant = props.variant or "default";
    size = props.size or "default";
    variantsFn = _buttonVariants;
    computedClass = cn(variantsFn.call(None, {"variant": variant, "size": size, "className": props.className}));
    return <button className={computedClass} {...props}>{props.children}</button>;
}
```

### Sub-component Pattern (Card, Dialog, etc.)
```jac
def:pub Card(props: Any) -> JsxElement {
    return <div {...props} data-slot="card" className={cn("cn-card bg-card ...", props.className)} />;
}
def:pub CardHeader(props: Any) -> JsxElement {
    return <div {...props} data-slot="card-header" className={cn("cn-card-header ...", props.className)} />;
}
```

### No `React.forwardRef` — Apply Styles Directly
Jac compiles components as plain functions. For Radix triggers, apply `buttonVariants()` directly:
```jac
<DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "ghost", "size": "icon"})}>
    Click
</DropdownMenuTrigger>
```

### `has` = `useState`
```jac
has theme: str = "light";
# Generates: const [theme, setTheme] = useState("light")
```

## Jac Compiler Gotchas

- **No tuple unpacking**: `a, b = func()` is invalid
- **No nested `def` inside `def`**: Define all helpers at module level
- **No docstrings inside function bodies**: Place before `def`
- **No JSX comments**: Remove all `{/* */}` and `# comment` from JSX return blocks
- **String `?` in JSX**: Must wrap: `{"?"}` not bare `?`
- **String `&` in JSX**: Must wrap: `{"Privacy & Security"}` not bare `&`
- **`True`/`False`/`None`**: Capitalized (Python-style)
- **`Reflect.construct()`**: Use instead of `new` for `Date`, `WebSocket`, `Map`, etc.
- **Lambda callback gotcha**: Function params inside lambdas compile to `new fn()`. Assign to local var and use `.call(None, args)`.
- **`glob` for module-level constants**: `glob _frameworks: list = [...]` — not `const`
- **Boolean in JSX**: Use `Boolean(anchor)` not `!!anchor`
- **`"\n"` bug**: Compiles to literal `"\\n"`. Use `style.setProperty()` for CSS that needs newlines.
- **Physical CSS properties**: Use `pt-4 pb-4` not `py-4` — ensures `pt-0` overrides cleanly with `twMerge`

## Adding New Components

1. Read the TSX source from the shadcn registry
2. Follow `docs/tsx-to-jac-conversion-guide.md` step by step
3. Use `cn-*` class tokens (style-agnostic) in base components — one token per semantic element
4. Add corresponding `cn-*` definitions to all 5 style CSS files (`styles/style-*.css`)
5. Verify resolution: 0 unresolved cn-* tokens across all styles
6. Register in `data/registry.json` with npmDeps and peerComponents
7. Add showcase in `components/component-showcases.cl.jac`
8. Add to export_service.jac component list for jacpack generation
9. Test in customizer: renders correctly, all 5 style switches work

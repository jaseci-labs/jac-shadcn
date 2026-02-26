# CLAUDE.md — jac-way (Shadcn/UI Component Library in Jac)

This file provides guidance to Claude Code when working with this repository.

## Project Overview

**jac-way** is a shadcn/ui component library ported from TypeScript/React (`.tsx`) to the Jac language (`.cl.jac`). It mirrors a reference Vite/TypeScript implementation at `../vite-way/` and demonstrates that Jac's client-side JSX syntax can produce the same UI output as standard React/TSX.

## Running the Project

```bash
source /home/ahzan/.jacvenv/bin/activate    # Required — always activate this venv first
jac start main.jac                          # Serves on http://localhost:8000
```

No separate build step. The Jac compiler handles transpilation to JS + Vite bundling automatically.

## Project Structure

```
jac-way/
├── main.jac                    # Entry point — imports app component + global CSS
├── jac.toml                    # Project config (npm deps, Vite plugins, Tailwind)
├── global.css                  # Tailwind CSS + shadcn theme variables (oklch)
├── lib/
│   └── utils.cl.jac            # cn() utility (clsx + tailwind-merge)
├── components/
│   ├── example.cl.jac          # ExampleWrapper + Example layout components
│   ├── component-example.cl.jac # Showcase page using all UI components
│   └── ui/                     # Shadcn/UI component library (13 components)
│       ├── alert-dialog.cl.jac
│       ├── badge.cl.jac
│       ├── button.cl.jac
│       ├── card.cl.jac
│       ├── combobox.cl.jac     # Base UI (@base-ui/react)
│       ├── dropdown-menu.cl.jac # Radix UI
│       ├── field.cl.jac
│       ├── input.cl.jac
│       ├── input-group.cl.jac
│       ├── label.cl.jac
│       ├── select.cl.jac       # Radix UI
│       ├── separator.cl.jac    # Radix UI
│       └── textarea.cl.jac
├── assets/                     # Static assets
└── .jac/                       # Build artifacts (auto-generated, gitignored)
    └── client/
        ├── compiled/           # Transpiled JavaScript output
        ├── configs/            # Auto-generated vite.config.js, tsconfig.json, etc.
        └── node_modules/       # npm dependencies
```

## Reference Implementation

The TSX originals live at:
```
../vite-way/src/components/ui/   # Original .tsx components
../vite-way/src/lib/utils.ts     # Original cn() utility
```

When converting new components, always read the `.tsx` source first, then apply the conversion patterns documented in `docs/tsx-to-jac-conversion-guide.md`.

## Technology Stack

| Layer | Technology |
|-------|-----------|
| Language | Jac (`.cl.jac` for client-side JSX) |
| UI Primitives | Radix UI (`radix-ui` ^1.4.3), Base UI (`@base-ui/react` ^1.2.0) |
| Styling | Tailwind CSS v4 + `class-variance-authority` (CVA) |
| Icons | HugeIcons (`@hugeicons/react` + `@hugeicons/core-free-icons`) |
| CSS Utilities | `clsx` + `tailwind-merge` via `cn()` |
| Build | Vite (auto-configured by Jac compiler) |
| React | v18.3.1 (pinned by `jac-client-node`) |

## Key Conversion Patterns (TSX to .cl.jac)

Full documentation: `docs/tsx-to-jac-conversion-guide.md`

Quick reference of the most critical rules:

### 1. No `React.forwardRef` — The #1 Breaking Issue

Jac compiles components as plain functions. React 18 cannot pass refs to plain function components. This breaks:
- **`asChild` pattern** (Radix Slot) — triggers won't position popups correctly
- **`render` prop pattern** (Base UI) — floating elements appear at (0,0)

**Fix for `asChild` on triggers**: Use `buttonVariants()` styling directly instead:
```jac
# WRONG — ref lost, popup hidden at translate(0, -200%)
<DropdownMenuTrigger asChild={True}>
    <Button variant="ghost" size="icon">Click</Button>
</DropdownMenuTrigger>

# CORRECT — trigger manages its own ref
<DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "ghost", "size": "icon"})}>
    Click
</DropdownMenuTrigger>
```

**Fix for `render` prop**: Use plain DOM elements, not function components:
```jac
# WRONG — ref lost, popup at (0,0)
<ComboboxPrimitive.Input render={<InputGroupInput />} />

# CORRECT — DOM elements always accept refs
<ComboboxPrimitive.Input render={<input className="..." />} />
```

### 2. No Destructured Props

```jac
# TSX: function Button({ className, variant = "default", ...props })
# Jac: Always use props object
def:pub Button(props: Any) -> JsxElement {
    variant = props.variant or "default";
    return <button className={cn(variant)} {...props} />;
}
```

### 3. No JSX Comments

```jac
# WRONG — causes compiler error
return <div>
    {/* This is a comment */}
    <span>Hello</span>
</div>;

# CORRECT — remove all comments from JSX blocks
return <div>
    <span>Hello</span>
</div>;
```

### 4. CVA Function Call Pattern

```jac
# Jac compiles function params in lambdas to `new fn()` — use .call(None, ...)
variantsFn = _buttonVariants;
computedClass = cn(variantsFn.call(None, {"variant": variant, "size": size}));
```

### 5. `has` = `useState`

```jac
# `has` declares state with auto-generated setter
has theme: str = "light";
# Generates: const [theme, setTheme] = useState("light");
# Use: theme = "dark";  (compiles to setTheme("dark"))
```

## Jac Compiler Gotchas

- **No tuple unpacking**: `a, b = func()` is invalid
- **No nested `def` inside `def`**: Define all helpers at module level
- **No docstrings inside function bodies**: Place before `def`
- **String `?` in JSX**: Must wrap: `{"?"}` not bare `?`
- **String `&` in JSX**: Must wrap: `{"Privacy & Security"}` not bare `&`
- **`True`/`False`/`None`**: Capitalized (Python-style), not `true`/`false`/`null`
- **`Reflect.construct()`**: Use instead of `new` for `Date`, `WebSocket`, `Map`, etc.
- **Lambda callback gotcha**: Function params inside lambdas compile to `new fn()`. Assign to local var and use `.call(None, args)`.
- **`glob` for module-level constants**: `glob _frameworks: list = [...]` — not `const`
- **Boolean in JSX**: Use `Boolean(anchor)` not `!!anchor`

## npm Dependencies (jac.toml)

```toml
[dependencies.npm]
jac-client-node = "1.0.4"         # Jac runtime (pins React 18.3.1)
"class-variance-authority" = "^0.7.1"
clsx = "^2.1.1"
"tailwind-merge" = "^3.5.0"
"tw-animate-css" = "^1.4.0"
"radix-ui" = "^1.4.3"
"@fontsource-variable/figtree" = "^5.2.10"
"@hugeicons/core-free-icons" = "^3.1.1"
"@hugeicons/react" = "^1.1.5"
"@base-ui/react" = "^1.2.0"
shadcn = "^3.8.5"
```

## Adding New Components

1. Read the TSX source from `../vite-way/src/components/ui/`
2. Follow `docs/tsx-to-jac-conversion-guide.md` step by step
3. Test that popup/floating components position correctly (check for ref issues)
4. Add usage example in `components/component-example.cl.jac`

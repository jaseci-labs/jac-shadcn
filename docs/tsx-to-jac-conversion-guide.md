# TSX to Jac (.cl.jac) Conversion Guide

A comprehensive guide for converting shadcn/ui React components from TypeScript (`.tsx`) to the Jac language (`.cl.jac`). This documents every pattern, pitfall, and workaround discovered during the jac-shadcn project.

---

## Table of Contents

1. [Overview](#overview)
2. [File Structure](#file-structure)
3. [Import Syntax](#import-syntax)
4. [Component Definition](#component-definition)
5. [Props Handling (The Biggest Difference)](#props-handling)
6. [CVA (class-variance-authority)](#cva-class-variance-authority)
7. [The cn() Utility](#the-cn-utility)
8. [State Management (has = useState)](#state-management)
9. [The forwardRef Problem (Critical)](#the-forwardref-problem)
10. [The asChild/Slot Pattern (Critical)](#the-aschild-slot-pattern)
11. [The render Prop Pattern (Critical)](#the-render-prop-pattern)
12. [Lambda & Callback Gotchas](#lambda--callback-gotchas)
13. [JSX Syntax Differences](#jsx-syntax-differences)
14. [Module-Level Globals](#module-level-globals)
15. [Complete Side-by-Side Examples](#complete-side-by-side-examples)
16. [Conversion Checklist](#conversion-checklist)
17. [Tailwind v4 Gotchas (Critical)](#tailwind-v4-gotchas-critical)
18. [Jac String Compilation Gotchas](#jac-string-compilation-gotchas)
19. [Dynamic Theming & CSS Variables](#dynamic-theming--css-variables)
20. [Font Loading with @fontsource-variable](#font-loading-with-fontsource-variable)
21. [Browser API Patterns](#browser-api-patterns)
22. [Troubleshooting](#troubleshooting)

---

## Overview

Jac's `.cl.jac` files compile to React JSX/JavaScript. The syntax is similar but has important differences from TSX. The Jac compiler (`jac-client`) transpiles `.cl.jac` files into `.js` files using a `__jacJsx` function that mirrors `React.createElement`.

**Key constraint**: `jac-client-node` pins React to `^18.2.0` (resolved to 18.3.1). React 18 does NOT support ref-as-prop on function components (that's a React 19 feature). This is the root cause of the hardest bugs you'll encounter.

---

## File Structure

### TSX Project Structure
```
src/
├── components/ui/button.tsx
├── lib/utils.ts
└── App.tsx
```

### Jac Project Structure
```
components/
├── ui/button.cl.jac
lib/
├── utils.cl.jac
main.jac
```

**Key differences**:
- `.tsx` becomes `.cl.jac` (the `cl` prefix signals client-side code)
- `.ts` (non-JSX) also becomes `.cl.jac` if it's client-side
- Server-side code uses plain `.jac` (no `cl` prefix)
- No `src/` directory — components live at the project root
- `main.jac` (not `.cl.jac`) is the entry point
- `jac.toml` replaces `package.json` for dependency management

---

## Import Syntax

### TSX
```tsx
import * as React from "react"
import { cva, type VariantProps } from "class-variance-authority"
import { Slot } from "radix-ui"
import { cn } from "@/lib/utils"
import { Button } from "@/components/ui/button"
import { HugeiconsIcon } from "@hugeicons/react"
import { Tick02Icon } from "@hugeicons/core-free-icons"
```

### Jac (.cl.jac)
```jac
cl import from "class-variance-authority" { cva }
cl import from "radix-ui" { Slot }
cl import from ...lib.utils { cn }
cl import from .button { Button }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { Tick02Icon }
```

**Rules**:
- `cl import` prefix for client-side imports (inside `.cl.jac` files)
- `import` (no `cl`) for server-side imports (inside `.jac` files)
- npm packages use quoted strings: `"radix-ui"`, `"@hugeicons/react"`
- Local modules use dot notation: `...lib.utils` (= `../../lib/utils`), `.button` (= `./button`)
- Hyphenated names must be quoted: `".ui.dropdown-menu"`, `".input-group"`
- No `type` imports — Jac is dynamically typed
- No `* as React` — React is implicit (provided by `@jac/runtime`)
- No `@/` alias — use relative dot notation instead
- `useState`, `useEffect`, `useRef`, `useMemo` etc. are available from `@jac/runtime` or `react`

### Dot Notation for Local Imports

| TSX Path | Jac Dot Notation |
|----------|-----------------|
| `./button` | `.button` |
| `../lib/utils` | `..lib.utils` |
| `../../lib/utils` | `...lib.utils` |
| `./input-group` | `".input-group"` (quoted because of hyphen) |
| `../ui/alert-dialog` | `".ui.alert-dialog"` (quoted) |

Each leading dot represents one level up. One dot = current directory, two dots = parent, etc.

---

## Component Definition

### TSX
```tsx
function Input({ className, type, ...props }: React.ComponentProps<"input">) {
  return (
    <input
      type={type}
      data-slot="input"
      className={cn("...", className)}
      {...props}
    />
  )
}

export { Input }
```

### Jac (.cl.jac)
```jac
cl {
    def:pub Input(props: Any) -> JsxElement {
        return <input
            {...props}
            data-slot="input"
            className={cn("...", props.className)}
        />;
    }
}
```

**Rules**:
- All components are wrapped in a `cl { ... }` block
- `def:pub` makes the function exported (equivalent to `export`)
- `def` (without `:pub`) makes it private to the module
- Return type is always `JsxElement` (or `Any` for conditional returns like `FieldError`)
- Props are always a single `props: Any` parameter — no destructuring
- All JSX return statements end with `;`
- No TypeScript types — everything is `Any`

---

## Props Handling

This is the biggest syntactic difference. TSX components destructure props; Jac components receive a single `props` object.

### TSX — Destructured Props
```tsx
function Card({
  className,
  size = "default",
  ...props
}: React.ComponentProps<"div"> & { size?: "default" | "sm" }) {
  return (
    <div
      data-slot="card"
      data-size={size}
      className={cn("ring-foreground/10 bg-card ...", className)}
      {...props}
    />
  )
}
```

### Jac — Props Object
```jac
def:pub Card(props: Any) -> JsxElement {
    size = props.size or "default";
    return <div
        {...props}
        data-slot="card"
        data-size={size}
        className={cn("ring-foreground/10 bg-card ...", props.className)}
    />;
}
```

**Pattern**: For simple components, access props directly:
- `className` becomes `props.className`
- `children` becomes `props.children`
- Default values: `size = props.size or "default"`

### The Props Exclude-and-Spread Pattern (Advanced)

When a component has custom props that should NOT be spread onto the DOM element, you must manually exclude them. In TSX, destructuring handles this naturally (`{ customProp, ...rest }`). In Jac, you need to filter:

```jac
glob _buttonExcludeKeys: list = ["className", "variant", "size", "asChild", "children"];

cl {
    def:pub Button(props: Any) -> JsxElement {
        variant = props.variant or "default";
        size = props.size or "default";
        asChild = props.asChild or False;

        restProps = {};
        excludeKeys = _buttonExcludeKeys;
        Object.keys(props).forEach(lambda(key: Any) -> None {
            if excludeKeys.indexOf(key) == -1 {
                restProps[key] = props[key];
            }
        });

        return <button
            data-slot="button"
            className={cn(computedClass)}
            {...restProps}
        >
            {props.children}
        </button>;
    }
}
```

**When to use this pattern**:
- Component has custom props that aren't valid HTML attributes (e.g., `variant`, `size`, `asChild`)
- Spreading `{...props}` would cause React "unknown prop" warnings
- The underlying element is a DOM element (`<button>`, `<div>`, `<input>`)

**When you can skip it**:
- Passing all props to a Radix/Base UI primitive (they handle unknown props internally)
- Simple wrapper components where all props are valid HTML attributes

---

## CVA (class-variance-authority)

CVA variant definitions are nearly identical, but must be declared as module-level globals.

### TSX
```tsx
const buttonVariants = cva(
  "base-classes...",
  {
    variants: {
      variant: {
        default: "bg-primary text-primary-foreground",
        outline: "border-border bg-background",
      },
      size: {
        default: "h-8 gap-1.5 px-2.5",
        sm: "h-7 gap-1 px-2.5",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)
```

### Jac
```jac
glob _buttonVariants: Any = cva(
    "base-classes...",
    {
        "variants": {
            "variant": {
                "default": "bg-primary text-primary-foreground",
                "outline": "border-border bg-background"
            },
            "size": {
                "default": "h-8 gap-1.5 px-2.5",
                "sm": "h-7 gap-1 px-2.5"
            }
        },
        "defaultVariants": {
            "variant": "default",
            "size": "default"
        }
    }
);
```

**Differences**:
- `const` becomes `glob _varName: Any =` (module-level global with underscore prefix convention)
- Object keys MUST be quoted strings: `"variants"`, `"variant"`, `"default"`
- Trailing commas after the last object property should be omitted
- Statement ends with `;`

### Calling CVA Functions

**TSX**:
```tsx
className={cn(buttonVariants({ variant, size, className }))}
```

**Jac** (important — `.call(None, ...)` pattern):
```jac
variantsFn = _buttonVariants;
computedClass = cn(variantsFn.call(None, {"variant": variant, "size": size, "className": props.className}));
```

**Why `.call(None, ...)`?** The Jac compiler sometimes generates `new fn(args)` when calling function variables directly inside certain contexts. Using `.call(None, args)` ensures a normal function call. Assign the glob to a local variable first, then call `.call(None, ...)`.

### Exporting CVA for External Use

```jac
cl {
    def:pub buttonVariants() -> Any {
        return _buttonVariants;
    }
}
```

Consumers call: `buttonVariants().call(None, {"variant": "ghost", "size": "icon"})`

---

## The cn() Utility

### TSX
```ts
import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
```

### Jac
```jac
"""Utility function for merging CSS class names."""

import from "clsx" { clsx }
import from "tailwind-merge" { twMerge }

"""Merge class names with Tailwind CSS conflict resolution."""
def:pub cn(inputs: Any) -> str {
    args = [].slice.call(arguments);
    return twMerge(clsx(args));
}
```

**Note**: Jac doesn't support rest parameters (`...inputs`). Use `[].slice.call(arguments)` to capture all arguments as an array. This is a JavaScript `arguments` object trick.

**Note**: The `utils.cl.jac` file does NOT use a `cl { }` block. It uses `import` (not `cl import`) because `cn()` is a pure utility function. But it's still a `.cl.jac` file because it's imported by client-side code.

---

## State Management

### TSX — useState
```tsx
const [theme, setTheme] = useState("light")
const [notifications, setNotifications] = useState({
  email: true, sms: false, push: true
})
```

### Jac — has keyword
```jac
has theme: str = "light";
has notifications: Any = {"email": True, "sms": False, "push": True};
```

**Rules**:
- `has varName: Type = defaultValue` compiles to `const [varName, setVarName] = useState(defaultValue)`
- Setting the value compiles to calling the setter: `theme = "dark"` becomes `setTheme("dark")`
- NEVER manually define `def setTheme()` — it's auto-generated
- `True`/`False` (capitalized) — not `true`/`false`
- `has` must be inside a component function within a `cl { }` block

### Updating Object State

**TSX**:
```tsx
setNotifications({ ...notifications, email: checked === true })
```

**Jac**:
```jac
notifications = {**notifications, "email": checked == True};
```

- Spread uses `**dict` (Python-style double-star), not `...obj`
- Comparison uses `==` not `===`

---

## The forwardRef Problem (Critical)

This is the **most important section** of this guide. It explains the root cause of popup/floating components not positioning correctly.

### Background

In TSX with React 18, `React.forwardRef()` allows function components to receive a `ref` prop. shadcn/ui components use `forwardRef` extensively because:

1. **Radix Slot (`asChild`)** uses `React.cloneElement(child, { ref: composedRef })` to pass refs to children
2. **Base UI `render` prop** uses `React.cloneElement(renderElement, { ref })` similarly
3. **Floating UI** (used by Radix/Base UI for dropdowns, selects, comboboxes) needs a ref to the trigger element to measure its position and place the popup

### The Problem in Jac

Jac compiles all components as **plain function components** — there is no way to express `React.forwardRef()` in Jac syntax. When a library tries to pass a ref via `cloneElement`, the ref is silently dropped.

**What happens**:
- Floating UI can't measure the trigger element's position
- The popup gets `transform: translate(0px, -200%)` (Radix) or appears at coordinates (0, 0) (Base UI)
- The popup is rendered in the DOM but is invisible or mispositioned

### How to Detect This Issue

1. Open DevTools, find the popup element (look for `[data-radix-popper-content-wrapper]` or similar)
2. Check the `style` attribute — if it shows `transform: translate(0px, -200%)` or `transform: translate(0px, 0px)`, the ref was lost
3. Manually changing the transform to reasonable pixel values (e.g., `translate(500px, 300px)`) will make the popup appear, confirming this is a positioning bug, not a visibility bug

### Solution 1: Avoid `asChild` on Triggers

Instead of wrapping a `<Button>` inside a trigger with `asChild`, apply button styles directly to the trigger element using `buttonVariants()`:

**TSX (works fine)**:
```tsx
<DropdownMenuTrigger asChild>
  <Button variant="ghost" size="icon">
    <HugeiconsIcon icon={MoreVerticalCircle01Icon} strokeWidth={2} />
  </Button>
</DropdownMenuTrigger>
```

**Jac (BROKEN — popup hidden)**:
```jac
<DropdownMenuTrigger asChild={True}>
    <Button variant="ghost" size="icon">
        <HugeiconsIcon icon={MoreVerticalCircle01Icon} strokeWidth={2} />
    </Button>
</DropdownMenuTrigger>
```

**Jac (FIXED — popup works)**:
```jac
<DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "ghost", "size": "icon"})}>
    <HugeiconsIcon icon={MoreVerticalCircle01Icon} strokeWidth={2} />
</DropdownMenuTrigger>
```

**Why this works**: Without `asChild`, Radix's `Trigger` renders its own `<button>` element and manages the ref internally. The `buttonVariants()` CSS classes give it the same visual appearance as `<Button>`.

### Solution 2: Use DOM Elements in `render` Props

Base UI's `render` prop clones the provided element with a ref. If that element is a Jac function component, the ref is lost.

**TSX (works fine)**:
```tsx
<ComboboxPrimitive.Input
  render={<InputGroupInput disabled={disabled} />}
  {...props}
/>
```

**Jac (BROKEN — popup at 0,0)**:
```jac
<ComboboxPrimitive.Input
    render={<InputGroupInput disabled={disabled} />}
    {...inputProps}
/>
```

**Jac (FIXED — popup positioned correctly)**:
```jac
<ComboboxPrimitive.Input
    render={<input
        data-slot="input-group-control"
        className="rounded-none border-0 bg-transparent shadow-none ring-0 focus-visible:ring-0 disabled:bg-transparent aria-invalid:ring-0 dark:bg-transparent dark:disabled:bg-transparent flex-1 text-base md:text-sm placeholder:text-muted-foreground w-full min-w-0 outline-none px-2.5 py-1"
        disabled={disabled}
    />}
    {...inputProps}
/>
```

**Why this works**: Plain DOM elements (`<input>`, `<button>`, `<div>`) always accept refs. By inlining the styles that `InputGroupInput` would have applied, you get the same visual result without the ref-forwarding chain.

### Solution 3: `asChild` Between Primitives Is Safe

When BOTH the parent and child are Radix/Base UI primitives (not Jac components), `asChild` works fine because the primitives use `forwardRef` internally:

```jac
# This is SAFE — AlertDialogPrimitive.Action is a forwardRef component
def:pub AlertDialogAction(props: Any) -> JsxElement {
    return <Button variant={variant} size={size} asChild={True}>
        <AlertDialogPrimitive.Action {...props} />
    </Button>;
}
```

Wait — this pattern works because `AlertDialogPrimitive.Action` is a Radix primitive that uses `forwardRef`. But `Button` here is our Jac component... Actually, in this case `Button` renders `Slot.Root` when `asChild={True}`, and `Slot.Root` clones `AlertDialogPrimitive.Action` with a ref. Since `AlertDialogPrimitive.Action` IS a `forwardRef` component (it's from Radix, not from Jac), the ref is preserved.

**Rule of thumb**: `asChild` works when the CHILD element is either:
- A native DOM element (`<button>`, `<a>`, `<div>`)
- A library component that uses `React.forwardRef` (Radix primitives, Base UI primitives)

`asChild` BREAKS when the child is a Jac-defined function component.

---

## The asChild/Slot Pattern (Critical)

### How Radix Slot Works

When you set `asChild={true}` on a Radix component, it uses `Slot` internally:

```tsx
// Simplified Radix Slot behavior:
function Slot({ children, ...slotProps }) {
  return React.cloneElement(children, {
    ...mergedProps,
    ref: composedRef  // <-- This ref is lost if child is a plain function component
  })
}
```

### Converting Button with asChild

**TSX** — uses conditional `Comp` variable:
```tsx
function Button({ className, variant, size, asChild = false, ...props }) {
  const Comp = asChild ? Slot.Root : "button"
  return (
    <Comp data-slot="button" className={cn(buttonVariants({ variant, size, className }))} {...props} />
  )
}
```

**Jac** — uses explicit if/else (no dynamic component variable):
```jac
def:pub Button(props: Any) -> JsxElement {
    variant = props.variant or "default";
    size = props.size or "default";
    asChild = props.asChild or False;

    restProps = {};
    excludeKeys = _buttonExcludeKeys;
    Object.keys(props).forEach(lambda(key: Any) -> None {
        if excludeKeys.indexOf(key) == -1 {
            restProps[key] = props[key];
        }
    });

    variantsFn = _buttonVariants;
    computedClass = cn(variantsFn.call(None, {"variant": variant, "size": size, "className": props.className}));

    if asChild {
        return <Slot.Root data-slot="button" data-variant={variant} data-size={size} className={computedClass} {...restProps}>
            {props.children}
        </Slot.Root>;
    }

    return <button data-slot="button" data-variant={variant} data-size={size} className={computedClass} {...restProps}>
        {props.children}
    </button>;
}
```

**Why not `Comp = asChild ? Slot.Root : "button"`?** Jac doesn't support dynamic tag names in JSX. You must use explicit `if`/`else` branches with different JSX returns.

---

## The render Prop Pattern (Critical)

Base UI components (like `@base-ui/react` Combobox) use a `render` prop to customize the rendered element while preserving behavior. The library clones the rendered element with additional props including a ref.

### Safe render Prop Usage

Always use **DOM elements** in render props, never Jac function components:

```jac
# SAFE — DOM element
<ComboboxPrimitive.Input render={<input className="..." />} />

# SAFE — DOM element with data-slot
<ComboboxPrimitive.ItemIndicator
    render={<span className="pointer-events-none absolute right-2 flex size-4 items-center justify-center" />}
/>

# UNSAFE — Jac function component (ref will be lost)
<ComboboxPrimitive.Input render={<InputGroupInput />} />
<ComboboxPrimitive.Clear render={<InputGroupButton variant="ghost" />} />
```

**Exception**: `render` with `<Button>` works for `ComboboxPrimitive.ChipRemove` because the chip remove doesn't need floating-ui positioning — it's inline content, not a popup anchor.

---

## Lambda & Callback Gotchas

### The `new callback()` Bug

When you pass a function as a parameter and call it inside a lambda, Jac compiles it as `new callback(args)` instead of `callback(args)`. This crashes at runtime.

**Fix**: Assign to a local variable and use `.call(None, ...)`:

```jac
# BAD — compiles to `new onMessage(msg)` (crashes)
ws.onmessage = lambda(e: Any) { onMessage(msg); };

# GOOD — normal function call
msgHandler = onMessage;
ws.onmessage = lambda(e: Any) { msgHandler.call(None, msg); };
```

**Note**: This only affects function PARAMETERS. Object property calls (`props.onClick(e)`, `setTheme(v)`) compile correctly.

### Lambda Syntax for Event Handlers

**TSX**:
```tsx
onCheckedChange={(checked) => {
  setNotifications({ ...notifications, email: checked === true })
}}
```

**Jac**:
```jac
onCheckedChange={lambda(checked: Any) -> None { notifications = {**notifications, "email": checked == True}; }}
```

### Lambda Syntax for useEffect

```jac
useEffect(lambda {
    console.log("mounted");
}, []);
```

### Lambda Syntax for Array Methods

```jac
# map
items.map(lambda(item: Any) -> Any {
    return <div key={item.id}>{item.name}</div>;
})

# forEach with exclude pattern
Object.keys(props).forEach(lambda(key: Any) -> None {
    if excludeKeys.indexOf(key) == -1 {
        restProps[key] = props[key];
    }
});

# render function (ComboboxList)
{lambda(item: Any) -> Any {
    return <ComboboxItem key={item} value={item}>{item}</ComboboxItem>;
}}
```

---

## JSX Syntax Differences

### No Comments in JSX

```jac
# WRONG — causes compiler error
return <div>
    {/* Comment */}
    <span>Hello</span>
</div>;

# WRONG — also causes compiler error
return <div>
    # This is a comment
    <span>Hello</span>
</div>;

# CORRECT — no comments in JSX blocks
return <div>
    <span>Hello</span>
</div>;
```

### Special Characters Must Be Wrapped

```jac
# WRONG — bare ? and & cause parser errors
<AlertDialogTitle>Allow accessory to connect?</AlertDialogTitle>
<span>Privacy & Security</span>

# CORRECT — wrap in JSX expressions
<AlertDialogTitle>Allow accessory to connect{"?"}</AlertDialogTitle>
<span>{"Privacy & Security"}</span>

# Apostrophes in contractions also need wrapping
<AlertDialogCancel>{"Don't allow"}</AlertDialogCancel>
```

### Boolean Values

```jac
# Capitalized (Python-style)
required={True}
disabled={False}
asChild={True}

# JavaScript boolean conversion
data-chips={Boolean(anchor)}    # Not !!anchor
```

### Self-Closing Tags

```jac
# Self-closing works the same as TSX
<DropdownMenuSeparator />
<Input id="name" placeholder="Enter name" />
```

### Ternary Expressions

```jac
# Standard ternary works
{isOpen ? <OpenView /> : <ClosedView />}

# Conditional rendering with `and` (equivalent to &&)
{showTrigger and (<TriggerComponent />)}
{props.children and (<span>{props.children}</span>)}
```

### String Expressions

```jac
# Use String() to convert non-strings in JSX
{String(count)}
{String(isActive)}
```

---

## Module-Level Globals

### TSX — `const` at Module Level
```tsx
const buttonVariants = cva("...", { ... })
const EXCLUDE_KEYS = ["className", "variant"]
```

### Jac — `glob` Keyword
```jac
glob _buttonVariants: Any = cva("...", { ... });
glob _excludeKeys: list = ["className", "variant"];
glob _frameworks: list = ["Next.js", "SvelteKit", "Nuxt.js"];
```

**Rules**:
- `glob` declares a module-level variable (like `const` at file scope)
- Convention: prefix with underscore (`_buttonVariants`) for private module globals
- Type annotation is required: `Any`, `list`, `str`, `bool`, etc.
- Must be declared OUTSIDE the `cl { }` block
- CSS import: `cl import ".global.css";` (at file top level, no `{ }`)

---

## Complete Side-by-Side Examples

### Example 1: Simple Component (Input)

**TSX**:
```tsx
import * as React from "react"
import { cn } from "@/lib/utils"

function Input({ className, type, ...props }: React.ComponentProps<"input">) {
  return (
    <input
      type={type}
      data-slot="input"
      className={cn(
        "dark:bg-input/30 border-input focus-visible:border-ring ...",
        className
      )}
      {...props}
    />
  )
}

export { Input }
```

**Jac**:
```jac
cl import from ...lib.utils { cn }

cl {
    def:pub Input(props: Any) -> JsxElement {
        return <input
            {...props}
            data-slot="input"
            className={cn("dark:bg-input/30 border-input focus-visible:border-ring ...", props.className)}
        />;
    }
}
```

### Example 2: Component with CVA Variants (Badge)

**TSX**:
```tsx
import { cva, type VariantProps } from "class-variance-authority"
import { Slot } from "radix-ui"
import { cn } from "@/lib/utils"

const badgeVariants = cva("h-5 gap-1 rounded-4xl ...", {
  variants: {
    variant: {
      default: "bg-primary text-primary-foreground",
      secondary: "bg-secondary text-secondary-foreground",
    },
  },
  defaultVariants: { variant: "default" },
})

function Badge({
  className,
  variant = "default",
  asChild = false,
  ...props
}: React.ComponentProps<"span"> & VariantProps<typeof badgeVariants> & { asChild?: boolean }) {
  const Comp = asChild ? Slot.Root : "span"
  return <Comp data-slot="badge" data-variant={variant} className={cn(badgeVariants({ variant }), className)} {...props} />
}

export { Badge, badgeVariants }
```

**Jac**:
```jac
cl import from "class-variance-authority" { cva }
cl import from "radix-ui" { Slot }
cl import from ...lib.utils { cn }

glob _badgeVariants: Any = cva("h-5 gap-1 rounded-4xl ...", {
    "variants": {
        "variant": {
            "default": "bg-primary text-primary-foreground",
            "secondary": "bg-secondary text-secondary-foreground"
        }
    },
    "defaultVariants": { "variant": "default" }
});

cl {
    def:pub Badge(props: Any) -> JsxElement {
        variant = props.variant or "default";
        asChild = props.asChild or False;

        variantsFn = _badgeVariants;
        computedClass = cn(variantsFn.call(None, {"variant": variant}), props.className);

        if asChild {
            return <Slot.Root {...props} data-slot="badge" data-variant={variant} className={computedClass} />;
        }

        return <span {...props} data-slot="badge" data-variant={variant} className={computedClass} />;
    }

    def:pub badgeVariants() -> Any {
        return _badgeVariants;
    }
}
```

### Example 3: Radix Primitive Wrapper (Separator)

**TSX**:
```tsx
import { Separator as SeparatorPrimitive } from "radix-ui"
import { cn } from "@/lib/utils"

function Separator({
  className,
  orientation = "horizontal",
  decorative = true,
  ...props
}: React.ComponentProps<typeof SeparatorPrimitive.Root>) {
  return (
    <SeparatorPrimitive.Root
      data-slot="separator"
      decorative={decorative}
      orientation={orientation}
      className={cn("bg-border shrink-0 data-horizontal:h-px ...", className)}
      {...props}
    />
  )
}

export { Separator }
```

**Jac**:
```jac
cl import from "radix-ui" { Separator as SeparatorPrimitive }
cl import from ...lib.utils { cn }

cl {
    def:pub Separator(props: Any) -> JsxElement {
        orientation = props.orientation or "horizontal";
        decorative = props.decorative;
        if decorative == None {
            decorative = True;
        }
        return <SeparatorPrimitive.Root
            {...props}
            data-slot="separator"
            decorative={decorative}
            orientation={orientation}
            className={cn("bg-border shrink-0 data-horizontal:h-px ...", props.className)}
        />;
    }
}
```

**Note**: For boolean defaults that should be `True`, you can't use `props.decorative or True` because that would make `False` impossible (falsy `or` True = True). Instead, check for `None` explicitly.

### Example 4: Component with State (FormExample)

**TSX**:
```tsx
function FormExample() {
  const [notifications, setNotifications] = useState({ email: true, sms: false, push: true })
  const [theme, setTheme] = useState("light")

  return (
    <DropdownMenuCheckboxItem
      checked={notifications.email}
      onCheckedChange={(checked) => setNotifications({ ...notifications, email: checked === true })}
    >
      Show Sidebar
    </DropdownMenuCheckboxItem>
  )
}
```

**Jac**:
```jac
def:pub FormExample() -> JsxElement {
    has notifications: Any = {"email": True, "sms": False, "push": True};
    has theme: str = "light";

    return <DropdownMenuCheckboxItem
        checked={notifications.email}
        onCheckedChange={lambda(checked: Any) -> None { notifications = {**notifications, "email": checked == True}; }}
    >
        Show Sidebar
    </DropdownMenuCheckboxItem>;
}
```

---

## Conversion Checklist

Use this checklist when converting a `.tsx` file to `.cl.jac`:

### File Setup
- [ ] Create `.cl.jac` file in the matching directory structure
- [ ] Convert all `import` statements to `cl import from` syntax
- [ ] Replace `@/` aliases with dot notation (`.`, `..`, `...`)
- [ ] Quote hyphenated module names: `".dropdown-menu"`
- [ ] Remove `type` imports and `* as React` imports

### Module Level
- [ ] Convert `const` declarations to `glob _name: Type =`
- [ ] Quote all object keys in CVA configs: `"variants"`, `"default"`, etc.
- [ ] Place `glob` declarations OUTSIDE the `cl { }` block
- [ ] Add `cl { }` block for all component definitions

### Component Definitions
- [ ] Replace destructured params with `(props: Any)`
- [ ] Add `def:pub` for exported functions, `def` for private ones
- [ ] Add return type: `-> JsxElement` (or `-> Any`)
- [ ] Extract destructured defaults: `variant = props.variant or "default"`
- [ ] Replace `className` with `props.className`, `children` with `props.children`
- [ ] Handle boolean defaults carefully: use `None` check for `True` defaults
- [ ] Replace `...props` with `{...props}` in JSX
- [ ] Replace `const Comp = asChild ? ... : ...` with if/else branching
- [ ] Add exclude-and-spread pattern if component has custom non-HTML props

### JSX
- [ ] Remove ALL comments from JSX blocks (both `{/* */}` and `//`)
- [ ] Wrap `?` characters: `{"?"}`
- [ ] Wrap `&` in text: `{"Privacy & Security"}`
- [ ] Wrap apostrophes: `{"Don't allow"}`
- [ ] Replace `true`/`false`/`null` with `True`/`False`/`None`
- [ ] Replace `!!value` with `Boolean(value)`
- [ ] Replace `&&` with `and` for conditional rendering
- [ ] End every JSX return statement with `;`

### CVA / Variants
- [ ] Assign CVA function to local var before calling: `variantsFn = _variants`
- [ ] Use `.call(None, {...})` pattern: `variantsFn.call(None, {"variant": v})`

### State
- [ ] Replace `useState()` with `has varName: Type = default`
- [ ] Replace `setVar(newValue)` with `varName = newValue`
- [ ] Remove any manual setter function definitions

### Callbacks & Lambdas
- [ ] Convert arrow functions to `lambda(args) -> ReturnType { ... }`
- [ ] Use `.call(None, ...)` for function params called inside lambdas
- [ ] Convert `(checked) => { ... }` to `lambda(checked: Any) -> None { ... }`

### Ref-Sensitive Components (Critical)
- [ ] Check if `asChild` is used on trigger components — replace with `buttonVariants()` approach
- [ ] Check if `render` prop receives a Jac component — replace with plain DOM element
- [ ] Test that all popup/floating components position correctly after conversion
- [ ] Open DevTools and verify no `transform: translate(0px, -200%)` on popup wrappers

### Exports
- [ ] `def:pub` makes a function exported (no separate `export` statement needed)
- [ ] Export CVA variants with a getter function: `def:pub buttonVariants() -> Any { return _buttonVariants; }`

---

## Tailwind v4 Gotchas (Critical)

### Logical vs Physical CSS Properties — The `py-*` / `pt-*` Conflict

In Tailwind v4, shorthand padding/margin utilities generate **CSS logical properties**, while axis-specific utilities generate **physical properties**:

| Tailwind Class | Generated CSS |
|---|---|
| `py-4` | `padding-block: calc(var(--spacing) * 4)` |
| `pt-0` | `padding-top: calc(var(--spacing) * 0)` |
| `px-4` | `padding-inline: calc(var(--spacing) * 4)` |
| `pl-2` | `padding-left: calc(var(--spacing) * 2)` |

**The problem**: `padding-block` (logical) and `padding-top` (physical) are **different CSS properties**. Even though they both resolve to the same top padding in LTR writing mode, they don't always override each other as expected. When both are applied to an element (e.g., a component has `py-4` in its base classes and a consumer passes `pt-0`), the logical property can win despite the physical property appearing later in the stylesheet.

**Real-world example (Card component)**:
```jac
# Card base class includes py-4 (padding-block: 1rem)
# Consumer passes pt-0 (padding-top: 0) to remove top padding for an image

# BROKEN — image has a gray gap at the top
<Card className="overflow-hidden pt-0">
    <img className="aspect-video w-full object-cover" />
</Card>
```

The gray gap appears because `padding-block: 1rem` from `.py-4` doesn't get properly overridden by `padding-top: 0` from `.pt-0`.

**Fix**: In component base classes, use physical properties instead of logical shorthands:

```jac
# BAD — uses logical shorthand, hard to override with pt-0 / pb-0
className={cn("py-4 ...", props.className)}

# GOOD — uses physical properties, pt-0 / pb-0 overrides cleanly
className={cn("pt-4 pb-4 ...", props.className)}
```

This applies to all shorthand utilities:
- `py-*` → `pt-* pb-*`
- `px-*` → `pl-* pr-*`
- `my-*` → `mt-* mb-*`
- `mx-*` → `ml-* mr-*`

Also applies to variant-prefixed versions: `data-[size=sm]:py-3` → `data-[size=sm]:pt-3 data-[size=sm]:pb-3`.

### `has-[>selector]:` Variants and Child Order

Tailwind v4 supports `:has()` selectors. shadcn/ui Card uses this to auto-remove padding when an image is the first child:

```
has-[>img:first-child]:pt-0
```

This generates: `.has-\[>img\:first-child\]:pt-0:has(>img:first-child) { padding-top: 0 }`

**Gotcha**: This selector checks if `<img>` is literally the **first child** in the DOM. If you have an absolutely positioned overlay `<div>` before the image, the selector won't match:

```jac
# BROKEN — <div> is first child, not <img>, so has-[>img:first-child] doesn't match
<Card className="relative overflow-hidden">
    <div className="absolute inset-0 z-30 opacity-50 mix-blend-color" />
    <img className="relative z-20 aspect-video w-full object-cover" />
</Card>

# FIXED — <img> is first child, overlay div moved after (still renders on top due to z-index)
<Card className="relative overflow-hidden">
    <img className="relative z-20 aspect-video w-full object-cover" />
    <div className="absolute inset-0 z-30 opacity-50 mix-blend-color" />
</Card>
```

Since the overlay is `position: absolute`, its visual position is controlled by `z-index`, not DOM order. Moving it after the `<img>` doesn't change the visual result but enables the CSS selector.

### `@theme inline` and CSS Variable Overrides

Tailwind v4's `@theme inline` block in `global.css` defines theme variables:

```css
@theme inline {
    --font-sans: 'Figtree Variable', sans-serif;
    --color-primary: var(--primary);
    --radius-lg: var(--radius);
}
```

These generate CSS custom property declarations with specific cascade layer placement. Overriding them requires understanding CSS specificity:

| Method | Specificity | Works? |
|---|---|---|
| Injected `<style>` with `:root {}` | Low — single pseudo-class selector | Often fails against `@theme inline` |
| `document.documentElement.style.setProperty("--var", value)` | Highest — inline style | Always works |
| CSS `!important` on custom property | Force override | Works but fragile |

**Always use inline styles** for runtime CSS variable overrides:

```jac
# BAD — injected <style> may not override @theme inline
styleEl.textContent = ":root { --primary: oklch(0.8 0.2 90); }";

# GOOD — inline style has highest specificity
document.documentElement.style.setProperty("--primary", "oklch(0.8 0.2 90)");
```

---

## Jac String Compilation Gotchas

### `\n` Compiles to Literal `\\n`

Jac's `"\n"` does **NOT** compile to a JavaScript newline character. It compiles to the literal two-character sequence `\\n` (backslash + n):

```jac
# Jac source:
cssText = ":root {\n  --primary: red;\n}";

# Compiled JavaScript output:
let cssText = ":root {\\n  --primary: red;\\n}";

# What the browser receives as a string:
# ":root {\n  --primary: red;\n}"
# (literal \n characters, NOT actual newlines)
```

**Why this matters**: When building CSS strings dynamically (e.g., for `<style>` element injection), the literal `\n` characters produce invalid CSS. In CSS, `\n` is an escape sequence that resolves to the character `n` — breaking property names.

**Fix**: Use spaces instead of newlines, or use string concatenation:

```jac
# BAD — \n becomes literal \\n in the string
cssText = ":root {\n--primary: " + value + ";\n}";

# GOOD — spaces work fine for CSS
cssText = ":root { --primary: " + value + "; }";

# BEST — avoid building CSS strings entirely, use inline style API
document.documentElement.style.setProperty("--primary", value);
```

This applies to all escape sequences: `\t`, `\r`, `\\`, etc. If you need actual control characters in compiled JavaScript, avoid Jac string literals — use a different approach.

---

## Dynamic Theming & CSS Variables

### Design System Provider Pattern

When building a theme customizer that dynamically changes colors, fonts, radius, etc., use this pattern:

```jac
cl import from react { createContext, useContext, useMemo, useLayoutEffect, useEffect }

glob _DesignSystemContext: Any = createContext(None);

cl {
    def:pub DesignSystemProvider(props: Any) -> Any {
        has config: dict = props.initialConfig or getDefaultConfig();
        has isReady: bool = False;

        styleName = config["style"] or "default";
        fontValue = config["font"] or "figtree";

        # 1. Apply body classes (style, base color) via useLayoutEffect
        useLayoutEffect(lambda -> Any {
            body = document.body;
            body.classList.forEach(lambda(cls: Any) -> None {
                if String(cls).startsWith("style-") {
                    body.classList.remove(cls);
                }
            });
            body.classList.add("style-" + styleName);
            isReady = True;
        }, [styleName]);

        # 2. Apply CSS variables via inline styles (highest specificity)
        useLayoutEffect(lambda -> Any {
            root = document.documentElement;
            lightVars = registryTheme["cssVars"]["light"] or {};
            lightKeys = Object.keys(lightVars);
            for i in range(lightKeys.length) {
                k = lightKeys[i];
                v = lightVars[k];
                if v {
                    root.style.setProperty("--" + k, v);
                }
            }
        }, [registryTheme]);

        # 3. Apply font via both CSS variable AND direct style
        useLayoutEffect(lambda -> Any {
            # ... find selectedFont from fonts data ...
            if selectedFont {
                fontFamily = selectedFont["family"];
                document.documentElement.style.setProperty("--font-sans", fontFamily);
                document.documentElement.style.fontFamily = fontFamily;
                document.body.style.fontFamily = fontFamily;
            }
        }, [fontValue]);

        # 4. Provide context for child components
        contextValue = useMemo(lambda -> Any {
            return {"config": config, "setConfig": setConfig};
        }, [config]);

        if not isReady {
            return <></>;
        }

        return <_DesignSystemContext.Provider value={contextValue}>
            {props.children}
        </_DesignSystemContext.Provider>;
    }
}
```

**Key lessons learned**:

1. **Use `useLayoutEffect`, not `useEffect`**, for visual changes (CSS variables, classes, fonts). `useLayoutEffect` runs synchronously before the browser paints, preventing flicker.

2. **Set font-family THREE ways** to guarantee it takes effect:
   - `style.setProperty("--font-sans", family)` — updates the CSS variable
   - `document.documentElement.style.fontFamily = family` — inline style on `<html>`
   - `document.body.style.fontFamily = family` — inline style on `<body>`

   Setting only the CSS variable may not work because Tailwind v4's `@theme inline` can have specificity that prevents the variable from cascading to computed `font-family` properties.

3. **Separate concerns into individual effects** with precise dependency arrays. Don't put all theme logic in one `useLayoutEffect` — split by font, CSS variables, and body classes.

4. **Always use `document.documentElement.style.setProperty()`** for CSS variable overrides. Never inject `<style>` elements with `:root {}` rules — they have lower specificity than Tailwind v4's `@theme inline`.

---

## Font Loading with @fontsource-variable

### Setup

1. **Add font packages to `jac.toml`**:
```toml
[dependencies.npm]
"@fontsource-variable/figtree" = "^5.2.10"
"@fontsource-variable/geist" = "*"
"@fontsource-variable/inter" = "*"
"@fontsource-variable/jetbrains-mono" = "*"
```

**Important**: Not all `@fontsource-variable` packages share version numbers. Use `"*"` for most packages to avoid version-not-found errors. Only pin versions for packages you've verified.

2. **Import in `global.css`**:
```css
@import "@fontsource-variable/figtree";
@import "@fontsource-variable/geist";
@import "@fontsource-variable/inter";
@import "@fontsource-variable/jetbrains-mono";
```

All font imports must be present even if only one is used initially — they register the `@font-face` declarations so fonts are available when switched dynamically.

3. **Define font data in a `.cl.jac` module**:
```jac
glob FONTS: list = [
    {
        "name": "Figtree",
        "value": "figtree",
        "family": "'Figtree Variable', sans-serif",
        "type": "sans"
    },
    {
        "name": "JetBrains Mono",
        "value": "jetbrains-mono",
        "family": "'JetBrains Mono Variable', monospace",
        "type": "mono"
    }
];
```

The `family` string must match the `font-family` name from the `@fontsource-variable` package's `@font-face` declaration. Always check the package's `index.css` to verify the exact name.

### Font Family Naming Convention

`@fontsource-variable` packages use `"<Name> Variable"` as the font-family name:

| Package | CSS font-family |
|---|---|
| `@fontsource-variable/figtree` | `'Figtree Variable'` |
| `@fontsource-variable/geist` | `'Geist Variable'` |
| `@fontsource-variable/inter` | `'Inter Variable'` |
| `@fontsource-variable/jetbrains-mono` | `'JetBrains Mono Variable'` |

Always include a fallback: `'Figtree Variable', sans-serif` or `'JetBrains Mono Variable', monospace`.

---

## Browser API Patterns

### `Reflect.construct` for `new` Expressions

Jac doesn't support the `new` keyword directly. Use `Reflect.construct`:

```jac
# WebSocket
ws = Reflect.construct(WebSocket, ["ws://localhost:8080"]);

# Date
now = Reflect.construct(Date, []);
fromISO = Reflect.construct(Date, [isoString]);

# MutationObserver
observer = Reflect.construct(MutationObserver, [lambda -> None {
    # mutation callback
}]);
observer.observe(document.body, {"childList": True, "subtree": True});

# Return cleanup function in useEffect
return lambda -> None {
    observer.disconnect();
};
```

### DOM Manipulation in Effects

```jac
# Setting CSS variables
document.documentElement.style.setProperty("--primary", "oklch(0.8 0.2 90)");

# Setting inline styles directly
document.documentElement.style.fontFamily = "'Inter Variable', sans-serif";
document.body.style.fontFamily = "'Inter Variable', sans-serif";

# Class list manipulation
document.body.classList.add("style-nova");
document.body.classList.remove("style-vega");
document.body.classList.forEach(lambda(cls: Any) -> None {
    if String(cls).startsWith("style-") {
        document.body.classList.remove(cls);
    }
});

# Query selectors
elements = document.querySelectorAll(".cn-menu-target");
elements.forEach(lambda(el: Any) -> None {
    el.classList.add("dark");
});
```

### `Object.keys` Iteration Pattern

Jac's `for...in` on objects doesn't always work as expected. Use `Object.keys()` with index-based access:

```jac
# BAD — may not iterate as expected
for k in myDict {
    v = myDict[k];
}

# GOOD — explicit key iteration
keys = Object.keys(myDict);
for i in range(keys.length) {
    k = keys[i];
    v = myDict[k];
    if v {
        doSomething(k, v);
    }
}
```

---

## Troubleshooting

### Popup/Dropdown appears hidden or at wrong position

**Symptom**: Clicking a trigger does nothing visible. DevTools shows the popup element exists with `transform: translate(0px, -200%)` or `translate(0px, 0px)`.

**Cause**: A ref is being lost due to a Jac function component in the ref-forwarding chain. See [The forwardRef Problem](#the-forwardref-problem).

**Fix**: Remove `asChild` from the trigger and use `buttonVariants()` styling. Or replace function components in `render` props with plain DOM elements.

### "Unknown prop" React warnings

**Symptom**: Console warnings about unknown props like `variant`, `size`, `asChild` on DOM elements.

**Cause**: Spreading `{...props}` passes custom props to DOM elements.

**Fix**: Use the [exclude-and-spread pattern](#the-props-exclude-and-spread-pattern-advanced) to filter out custom props.

### CVA function called with `new`

**Symptom**: Runtime error or unexpected behavior when calling a CVA variants function.

**Cause**: Jac compiler generates `new variantsFn({...})` instead of `variantsFn({...})`.

**Fix**: Assign to a local variable and use `.call(None, ...)`:
```jac
variantsFn = _buttonVariants;
result = variantsFn.call(None, {"variant": "default"});
```

### Boolean default `True` doesn't work

**Symptom**: Setting `prop={False}` has no effect; it always behaves as `True`.

**Cause**: Using `props.decorative or True` — when `props.decorative` is `False`, the `or` evaluates to `True`.

**Fix**: Check for `None` explicitly:
```jac
decorative = props.decorative;
if decorative == None {
    decorative = True;
}
```

### Object keys without quotes cause errors

**Symptom**: Compiler error in CVA config or object literal.

**Cause**: Jac requires string keys in object literals (Python dict syntax).

**Fix**: Quote all keys: `{"variant": "default"}` not `{variant: "default"}`.

### Font files 404

**Symptom**: Custom fonts don't load; network tab shows 404 for `.woff2` files.

**Cause**: The Jac server's root asset handler may not check `.jac/client/dist/` where Vite places built font files.

**Fix**: This was fixed in `jac-scale`'s `serve.static.impl.jac` by adding `.jac/client/dist/` to the asset search candidates. If you encounter this, ensure the server checks `base_path / '.jac' / 'client' / 'dist' / file_name`.

### `has` state value not updated immediately

**Symptom**: After `myVar = newValue`, reading `myVar` in the same function still gives the old value.

**Cause**: `has` compiles to `useState`. State updates are NOT synchronous — the new value is only available on the next render.

**Fix**: Store in a local variable if you need the new value immediately:
```jac
localVal = computedResult;
myVar = localVal;         # triggers re-render with new value
doSomething(localVal);    # use local var, not state var
```

### Card image has gray gap at the top

**Symptom**: A Card with an image as the first visual element shows a gray strip between the card border and the image top edge. The card's `bg-card` background is visible.

**Cause**: Two compounding issues:
1. The Card base class uses `py-4` which generates `padding-block` (logical CSS property). Consumer passes `pt-0` which generates `padding-top` (physical CSS property). These are different CSS properties that don't reliably override each other in Tailwind v4.
2. If an absolutely positioned overlay `<div>` is placed before the `<img>` in the DOM, the Card's `has-[>img:first-child]:pt-0` selector doesn't match because `<img>` isn't the first child.

**Fix**: Both changes together:
```jac
# 1. In Card component: change py-4 to pt-4 pb-4
className={cn("pt-4 pb-4 ...", props.className)}  # not py-4

# 2. In card usage: put <img> first, overlay after
<Card className="relative overflow-hidden">
    <img className="z-20 aspect-video w-full object-cover" />
    <div className="absolute inset-0 z-30 opacity-50 mix-blend-color" />
</Card>
```

See [Tailwind v4 Gotchas](#tailwind-v4-gotchas-critical) for full explanation.

### Dynamic CSS variables don't take effect

**Symptom**: Setting CSS custom properties at runtime (e.g., for theme switching) doesn't change the visual appearance. DevTools shows the variable is set but computed styles don't update.

**Cause**: Tailwind v4's `@theme inline` block generates CSS custom properties with cascade layer placement that overrides injected `<style>` elements.

**Fix**: Use `document.documentElement.style.setProperty()` instead of `<style>` injection:
```jac
# BAD — low specificity, overridden by @theme inline
styleEl.textContent = ":root { --primary: oklch(0.8 0.2 90); }";
document.head.appendChild(styleEl);

# GOOD — inline style, highest specificity
document.documentElement.style.setProperty("--primary", "oklch(0.8 0.2 90)");
```

### Font doesn't change when switching themes

**Symptom**: Changing the font selection in a theme customizer doesn't visually update the page font, even though the CSS variable `--font-sans` is being set.

**Cause**: Setting only the CSS variable may not cascade through Tailwind v4's theme system. The `@theme inline { --font-sans: ... }` declaration can have specificity that prevents runtime overrides from reaching computed `font-family` values.

**Fix**: Set font-family in three places:
```jac
fontFamily = selectedFont["family"];
document.documentElement.style.setProperty("--font-sans", fontFamily);
document.documentElement.style.fontFamily = fontFamily;
document.body.style.fontFamily = fontFamily;
```

Also ensure all `@fontsource-variable` font packages are imported in `global.css` so the `@font-face` declarations are registered before any font switch.

### Dynamically built CSS string produces invalid styles

**Symptom**: A `<style>` element with CSS built from string concatenation produces broken styles. Properties don't apply, or the entire block is ignored.

**Cause**: Jac's `"\n"` compiles to JavaScript `"\\n"` (two literal characters: backslash + n), not an actual newline. In CSS, `\n` is an escape sequence that produces the character `n`, breaking property names like `\n--primary` → `nprimary`.

**Fix**: Don't use `\n` in CSS strings. Use spaces, or better, avoid building CSS strings entirely:
```jac
# BAD
cssText = ":root {\n  --primary: red;\n}";

# GOOD (spaces instead of newlines)
cssText = ":root { --primary: red; }";

# BEST (inline style API — no string building)
document.documentElement.style.setProperty("--primary", "red");
```

### @fontsource-variable package version not found

**Symptom**: `jac install` fails with a version resolution error like "No matching version found for @fontsource-variable/geist@^5.2.10".

**Cause**: Different `@fontsource-variable` packages have different version ranges. A version that exists for one package may not exist for another.

**Fix**: Use `"*"` as the version for font packages in `jac.toml`:
```toml
[dependencies.npm]
"@fontsource-variable/figtree" = "^5.2.10"  # specific if verified
"@fontsource-variable/geist" = "*"           # wildcard — safe for fonts
"@fontsource-variable/inter" = "*"
```

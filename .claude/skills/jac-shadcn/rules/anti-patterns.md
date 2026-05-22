# Anti-Patterns — Mandatory Pre-Submit Checklist

Run through this list before producing any UI code. These are the most common amateur-LLM mistakes that make output look cheap. Each row maps the anti-pattern (left) to the professional alternative (right).

> Use this file alongside [blocks.md](./blocks.md). This file is the negative ruleset (what to avoid); blocks.md is the positive ruleset (what to do).

---

## Color & Tokens

| Anti-pattern | Professional alternative | Why |
|---|---|---|
| `opacity-70` / `opacity-50` for dim text | `text-muted-foreground` | Semantic, dark-mode safe, consistent |
| `text-gray-500`, `text-zinc-400`, `text-slate-500` | `text-muted-foreground` | Same — tokens handle light/dark |
| `bg-white`, `bg-gray-50`, `bg-slate-100` | `bg-background` / `bg-card` / `bg-muted` | Tokens handle light/dark |
| `bg-black`, `bg-gray-950` | `bg-background` (or `bg-foreground` if inverted) | Same |
| `dark:bg-gray-900`, `dark:text-white` etc. | Stay on tokens — automatic dark mode | Manual dark variants are stale and break with theme switches |
| `text-orange-500`, `bg-blue-600` (any palette color) | `text-primary` / `bg-primary` | Brand color is centralized in CSS variables |
| `text-emerald-600`, `text-red-500` for status | `text-success`, `text-destructive` (or Badge variant) | Semantic status tokens |
| `style={{ color: "#ff6b35" }}` | className with semantic tokens | Inline styles bypass theme system |
| Inline gradients (`bg-gradient-to-r from-blue-500 to-purple-500`) | Single accent token, or `bg-primary` | Multi-color gradients look 2018 |

---

## Typography

| Anti-pattern | Professional alternative | Why |
|---|---|---|
| `font-thin` / `font-light` on marketing headlines | `font-bold` (display), `font-semibold` (cards), `font-medium` (labels) | Thin weights look dated and unreadable |
| `text-3xl font-normal` for hero h1 | `text-4xl sm:text-5xl lg:text-6xl font-bold tracking-tight` | Hero needs display weight + size scale |
| Headline without `tracking-tight` at `text-3xl+` | Add `tracking-tight` (or `tracking-tighter` at 6xl+) | Default tracking on display sizes looks loose |
| `tracking-wide` on body text | Default tracking | Wide tracking on body is mid-2010s ad-copy |
| Headlines without `text-balance` | Always add `text-balance` | Eliminates orphan words for free |
| `text-xl` body copy | `text-lg leading-8` (lead), `text-base` (body), `text-sm leading-relaxed` (cards) | xl body is too large; pros use a tight scale |
| Italic quotes in testimonials | Roman, `text-base leading-relaxed` | Italic looks dated |
| Uppercase footer section headers (`uppercase tracking-wider`) | Sentence case `text-sm font-semibold` | Sentence case is the modern footer idiom |
| ALL CAPS HEADLINES | Sentence case headlines | All caps is shouty and dated |
| `text-2xl` for hero h1 | `text-4xl sm:text-5xl lg:text-6xl` | Heroes need to be big |
| Same headline size on mobile and desktop | Always include `sm:`, `lg:` breakpoints | Mobile-first scale |

---

## Spacing & Layout

| Anti-pattern | Professional alternative | Why |
|---|---|---|
| `py-8` for marketing sections | `py-24 sm:py-32` (hero) or `py-16 sm:py-24` (mid-page) | Sections must breathe |
| `pt-8 pb-8` between hero and next section | Each section has its own `pt-* pb-*` | Padding is per-section, not between |
| `max-w-5xl` outer container | `max-w-7xl` outer (constrain inner separately) | 7xl is the marketing standard |
| `max-w-7xl` for centered text headers | `max-w-2xl` (or `max-w-3xl`) for text content | Long lines are unreadable |
| `p-4` cards | `p-6` (or `p-6 sm:p-8` featured) | p-4 looks cramped |
| `gap-2` between feature cards | `gap-6` to `gap-8` | Feature cards need breathing room |
| Random spacing values: `mt-7`, `gap-5`, `pt-13` | 4-multiples only: `{1,2,3,4,6,8,10,12,16,20,24,32}` | Tailwind's scale is 4px-based |
| `space-y-8` on a section's children | Compose with explicit `mt-*` per element | Vertical rhythm should be intentional |
| `space-y-*` / `space-x-*` for layout | `flex` + `gap-*` | gap is more reliable across edge cases |
| `py-4 px-6` instead of physical props | `pt-4 pb-4 pl-6 pr-6` | Physical props let `pt-0` override cleanly with twMerge |
| `w-10 h-10` (equal w/h) | `size-10` | Cleaner |

---

## Borders, Shadows, Radius

| Anti-pattern | Professional alternative | Why |
|---|---|---|
| Heavy borders (`border-2`, `border-4`) | `border` (1px hairline) | Heavy borders are amateur |
| Decorative double borders | Single hairline `border` | Clean is the look |
| `shadow-xl` on every card | `shadow-sm` at rest, `hover:shadow-md` if interactive | Flatness; escalate sparingly |
| `shadow-2xl` on regular cards | `shadow-lg` reserved for featured/hero only | Same |
| Mixed radii in one block (`rounded` + `rounded-2xl`) | Pick one: `rounded-lg` standard, `rounded-xl` hero | Consistency reads as polish |
| Square corners (`rounded-none`) on cards | `rounded-lg` | Square is brutalist; cards have soft corners |
| `rounded-full` on text content | `rounded-full` only for pills, avatars, icons | Text shouldn't be in pills |

---

## Component Choice

| Anti-pattern | Professional alternative | Why |
|---|---|---|
| `<hr>` or `<div className="border-t">` | `<Separator />` | Component handles dark mode + spacing |
| `<div className="animate-pulse bg-gray-200 h-4 rounded">` | `<Skeleton className="h-4 w-3/4" />` | Use the component |
| `<span className="rounded-full bg-green-100 text-green-800 px-2 py-1">+20%</span>` | `<Badge variant="secondary">+20%</Badge>` | Use Badge |
| Custom modal with absolute positioning | `<Dialog>` / `<Sheet>` / `<Drawer>` | Built-ins handle a11y, focus trap, animations |
| `<button>` with manual styling | `<Button variant="...">` | Use the component |
| `<button>` with manual `active`/`hover` styling for tabs | `<Tabs>` + `<TabsList>` + `<TabsTrigger>` | Built-in keyboard nav + ARIA |
| Looping `<Button>` for radio-like selection | `<RadioGroup>` or `<ToggleGroup>` | Built-in semantics |
| Custom emoji or character for checkmark | `<HugeiconsIcon icon={Tick01Icon} />` | Consistent icon system |
| Switch component for billing-period toggle | `<Tabs>` with `grid grid-cols-2` | Tabs is more accessible for 2-3 mutually exclusive options |
| Empty state as centered text in a div | `<Empty>` composition | Use the component |
| `<div className="absolute -top-2 right-2 bg-red-500 rounded-full w-2 h-2">` for notification dot | `<AvatarBadge>` or composed Badge | Use the component |

---

## Block Structure

| Anti-pattern | Professional alternative | Why |
|---|---|---|
| 5-tier pricing table | 3 tiers (rarely 4) | 3 is the strong norm; 5 dilutes the choice |
| 4-column footer with 4 narrow link columns | 4-col with `2fr_1fr_1fr_1fr` (logo wider) | Logo column needs more space |
| Outlined social icon buttons in footer | `<Button variant="ghost" size="icon">` | Outlined boxes look heavy |
| Center-aligned attribution in card-grid testimonials | Left-aligned attribution; only featured single-quote uses center | Center alignment in cards looks crowded |
| Two h1s on one page | One h1 per page (hero); section heads are h2; cards use h3 | A11y + SEO |
| Multi-color icons (each card a different color) | Single accent color via `bg-primary/10 text-primary` | Multi-color icon palettes look 2018 |
| Emojis in headlines, buttons, badges | HugeIcons (`Tick01Icon`, `ArrowRight01Icon`, etc.) | Emojis don't theme |
| Hero with no eyebrow + no visual mockup | Add Badge eyebrow OR a mockup image to anchor | Pure-text heroes feel empty |
| FAQ as long static list of `<h3>` + `<p>` | `<Accordion type="single" collapsible>` | Saves scroll space, scannable |

---

## Motion & Interaction

| Anti-pattern | Professional alternative | Why |
|---|---|---|
| Bouncy spring animations | `transition-colors`, `transition-all duration-200` | Bounce is amateur |
| `scale-110` on hover | Subtle `translate-y-px` shift or shadow lift | Big scale jumps look cheap and overflow grid cells |
| Rotate on hover | Don't | Rotates are 2014 |
| Manual `z-index` on Dialog/Popover/Tooltip | Components handle their own stacking | Don't fight the component |
| `transition-all` everywhere | `transition-colors` (most common) | Targeted transitions |

---

## Jac-specific (compile errors)

These produce broken UIs because they don't compile, not because they look wrong.

| Anti-pattern | Professional alternative | Why |
|---|---|---|
| `{/* JSX comments */}` | Remove comments from JSX entirely | Jac compiler error |
| Destructured props (`def Comp({variant = "default"})`) | `props.variant or "default"` | Jac doesn't support destructuring |
| Nested `def` inside `def` | Define helpers at module level | Jac compiler limitation |
| `new Date()`, `new WebSocket(url)` | `Reflect.construct(Date, [])`, `Reflect.construct(WebSocket, [url])` | `new` is invalid Jac |
| `true`, `false`, `null` | `True`, `False`, `None` | Python-style booleans |
| `const x = 5` at module level | `glob _x: int = 5` | Jac uses glob |
| `useState` directly | `has count: int = 0` | Jac compiles `has` to useState |
| `React.forwardRef` | Apply styles directly to Radix triggers | Not needed in Jac |
| `items.map(lambda(item) { formatter(item); })` (function param in lambda) | `fmt = formatter; items.map(lambda(item) { fmt.call(None, item); })` | Compile bug — `formatter(item)` becomes `new formatter(item)` |
| `<p>Terms & Conditions</p>` (raw `&` in JSX) | `<p>{"Terms & Conditions"}</p>` | Jac JSX needs special chars wrapped |
| `<p>Ready?</p>` (raw `?` in JSX) | `<p>{"Ready?"}</p>` | Same |
| `"\n"` in `.cl.jac` | `String.fromCharCode(10)` | `"\n"` compiles to literal `\n` (2 chars) |
| `a, b = func()` (tuple unpacking) | `result = func(); a = result[0]; b = result[1];` | Jac doesn't support tuple unpacking |
| `if cond { x = 1 } ... use x` (var first assigned in if/for) | Declare `x = 0;` before the if/for block | Compiled JS has block scope, hits ReferenceError |
| `'{path}'` quoting in f-strings | `"\"" + path + "\""` (concat with double quotes) | Jac strips single quotes around interpolated vars |

---

## How to use this list

Before producing UI code, mentally scan these tables. After producing UI code, scan again for any rows you violated.

This list is **not exhaustive** — it's the highest-frequency Claude mistakes. When in doubt, defer to:

1. [blocks.md](./blocks.md) for positive block-level rules
2. [styling.md](./styling.md) for component-level styling rules
3. [composition.md](./composition.md) for component composition rules
4. [jac-patterns.md](./jac-patterns.md) for Jac compiler constraints
5. [icons.md](./icons.md) for icon usage
6. [forms.md](./forms.md) for form patterns

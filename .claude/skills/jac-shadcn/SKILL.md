---
name: jac-shadcn
description: Build professional UI in .cl.jac files using jac-shadcn components — hero/pricing/features/testimonial/footer/CTA/FAQ/auth/dashboard/navbar/empty-state blocks, single components, or full pages. Use for ANY UI work in projects with .cl.jac files, components/ui/ directories, or [jac-shadcn] in jac.toml — including requests like "build a landing page", "add a pricing section", "design a dashboard", "make this prettier", "create a sign-in form". Enforces semantic components over raw divs and professional block patterns over amateur Tailwind. Apply BEFORE writing any JSX or Tailwind classes.
user-invocable: false
allowed-tools: Bash(jac add *), Bash(jac remove *), Bash(jac create *), Bash(ls components/ui*), Read
---

# jac-shadcn

A framework for building UI components and design systems in Jac. Components are added as source code (`.cl.jac` files) to the user's project via the CLI. Components use Radix UI primitives, Tailwind CSS v4, and the `cn()` utility (clsx + tailwind-merge).

> **IMPORTANT:** Run all CLI commands using: `jac add --shadcn`, `jac remove --shadcn`, or `jac create --use jac-shadcn`. The Jac virtual environment must be activated first: `source /home/ahzan/.jacvenv/bin/activate`.

---

## Workflow — DO NOT skip steps

This is a mandatory pre-flight before producing UI code. Every step has a payoff that prevents a class of bug or amateur output.

### Step 1 — Inspect project context

Before writing JSX, know what's actually in the project:

- `ls components/ui/` — see installed components (don't import what isn't there)
- Read `jac.toml` → `[jac-shadcn]` section — note `style` (nova/vega/maia/lyra/mira) + theme
- Confirm `lib/utils.cl.jac` exports `cn()` — every component className must route through it
- Skim 1–2 existing `.cl.jac` files to learn the project's import style (`cl import from ...components.ui.button { Button }` vs string-form) and any project-level component conventions

> **Running the dev server (jac-builder / jac-ide style projects only).** If `jac.toml` has `[plugins.scale.microservices]` enabled, the gateway spawns subprocesses that don't inherit the user's bash env. Always start with `set -a; source .env; set +a; jac start main.jac` — without `REDIS_URL` in the environment the `builder_sv` subprocess crashes silently at `kvstore()` init and the gateway just reports "service UNHEALTHY" with no stack trace (use `jac scale logs builder_sv` to see the real error). Skip this if the project doesn't use jac-scale microservice mode.

### Step 2 — Identify what kind of UI you're building

| Request shape | Treat as |
|---|---|
| "Build a sign-in page", "login form", "signup form" | **Registry block first** — check `examples/login-01.cl.jac`, `examples/login-03.cl.jac`, `examples/signup-01.cl.jac` (direct conversions from shadcn/ui v4 registry). Fall back to `blocks/auth.md` only if you need a layout the registry doesn't cover. |
| "Build a dashboard", "app shell", "admin panel", "with sidebar nav" | **Registry block first** — check `examples/dashboard-01.cl.jac` and `examples/sidebar-07.cl.jac`. Use `blocks/dashboard.md` only for lighter alternatives. |
| "Build a landing page", "make a hero section", "pricing page", "features", "testimonials", "footer", "CTA", "FAQ", "navbar/header", "empty state" | **Block** — open `blocks/<type>.md` and use a template (these are marketing patterns, not in the official registry). |
| "Add a button/dialog/dropdown", "edit this card", "fix this form" | **Component** — use Component Selection table below |
| "Make this prettier", "improve the UI", "polish this" | **Block-level polish** — read `rules/blocks.md` + `rules/anti-patterns.md` and apply systematically |

> **⚠ jac-shadcn `Sidebar*` className spread bug.** Every `Sidebar*` primitive has a known bug where `{...props}` spreads *after* the computed `className`, so any `className` you pass overrides the base styles (positioning, sizing, flex). **Never pass `className` to `SidebarMenuButton`, `SidebarMenuAction`, `SidebarGroup`, `SidebarMenuItem`, `SidebarTrigger`, etc.** Wrap with a `<div>` for layout overrides, or use a regular `<Button>` when you need cva variants the sidebar one doesn't expose. See `rules/registry-blocks.md` for the working pattern.

### Step 3 — Reach for components, NOT divs

If you find yourself typing `<div className="...">`, **stop**. Ask:

- Visual divider? → `<Separator />` not `<hr>` or `<div className="border-t">`
- Status pill / count badge? → `<Badge>` not styled `<span>`
- Loading state? → `<Skeleton>` not `<div className="animate-pulse">`
- Avatar / fallback initials? → `<Avatar><AvatarFallback>` not styled circle div
- Form field group? → `<Field>` + `<FieldLabel>` not `<div className="space-y-2">`
- Dropdown / popover content? → `<DropdownMenu>` / `<Popover>` not absolutely-positioned div
- Hint / callout? → `<Alert>` not custom styled box
- Empty state / no-data? → `<Empty>` not centered text div

See `rules/components.md` for the full vocabulary table (54 components, their purpose, their legal child grammar) and `rules/composition.md` for composition rules. **`rules/components.md` is the single most important file in this skill** — open it whenever you're unsure whether a primitive exists for what you're building.

### Step 4 — Apply professional polish

See `rules/blocks.md` for the full ruleset. The non-negotiables for every block:

- **Container**: `mx-auto max-w-7xl px-4 sm:px-6 lg:px-8`
- **Section padding**: `py-24 sm:py-32` (hero, top CTA), `py-16 sm:py-24` (mid-page sections), `py-12` (compact strips)
- **Hero h1**: `text-4xl sm:text-5xl lg:text-6xl font-bold tracking-tight` + `text-balance`
- **Section h2**: `text-3xl sm:text-4xl font-bold tracking-tight` + `text-balance`
- **Lead paragraph**: `text-lg leading-8 text-muted-foreground`
- **Body**: `text-base` or `text-sm leading-relaxed text-muted-foreground`
- **Cards**: `p-6` (never `p-4`); `shadow-sm` at rest, `hover:shadow-md` if interactive
- **Borders**: `border` (1px hairline) only — never `border-2` for layout
- **Gaps**: 4-multiples only (`gap-{2,4,6,8}`, `mt-{4,6,8,10,12,16}`)

### Step 5 — Check the anti-pattern blacklist

See `rules/anti-patterns.md`. Quick recall list — these are the most common Claude failures:

- `opacity-70` for dim text → `text-muted-foreground`
- `text-gray-500`, `text-zinc-400` → `text-muted-foreground`
- `bg-white` / `bg-gray-50` → `bg-background` / `bg-card` / `bg-muted`
- `text-orange-500` → `text-primary`
- `font-thin` / `font-light` headlines → `font-bold` / `font-semibold`
- `py-8` for marketing → `py-24 sm:py-32`
- `p-4` cards → `p-6`
- `shadow-xl` everywhere → `shadow-sm` rest, `hover:shadow-md`
- Italic testimonial quotes → roman, `text-base leading-relaxed`
- Uppercase footer headers → sentence case, `text-sm font-semibold`
- 5-tier pricing → 3 tiers (rarely 4)
- Switch for billing toggle → `Tabs` with `grid grid-cols-2`
- Random spacing (`mt-7`, `gap-5`) → 4-multiples
- Headlines without `text-balance` → always add `text-balance`

### Step 5.5 — Handler completeness audit

Before presenting, walk through every interactive element you wrote and confirm it has a handler that does something visible:

- Every `<Button>` mentioned in the user's spec → must have `onClick` (or be inside a form with `type="submit"`, or be a `DropdownMenuTrigger asChild` child where the trigger handles the click).
- Every `<Input>` with controlled value → must have `onChange` and a state binding.
- Every menu item, tab, accordion item → must have `onSelect` / `onValueChange` / `onClick` if the spec implied interaction.
- Bare `<Button>...</Button>` with no handler is a bug, not a placeholder — the user clicks it expecting *something* to happen, even in a demo. At minimum wire it to a state toggle that opens a `Sheet` saying "Demo only."

This is a frequent skill miss: Claude renders every button visually but forgets the handler on top-bar / hero-CTA buttons. Catch it here before the page ships.

### Step 6 — Apply Jac patterns

See `rules/jac-patterns.md` for the full set. Reflexively:

- `has` = useState (not `useState`)
- `glob _name` = module-level constants (not `const`)
- No destructuring in props — `props.variant or "default"`
- No nested `def` inside `def`
- No JSX comments (`{/* */}` is invalid)
- `True` / `False` / `None` capitalized
- `Reflect.construct(Date, [])` not `new Date()`
- Lambda callbacks: store in local var, use `.call(None, args)`
- Special chars in JSX must wrap: `{"Terms & Conditions"}`, `{"?"}`

---

## Principles (the why)

1. **Use existing components first.** Check what's available in `components/ui/` before writing custom UI.
2. **Compose, don't reinvent.** Settings page = Tabs + Card + form controls. Dashboard = Sidebar + Card + Chart + Table.
3. **Use built-in variants before custom styles.** `variant="outline"`, `size="sm"`, etc.
4. **Use semantic colors.** `bg-primary`, `text-muted-foreground` — never raw values like `bg-blue-500`.
5. **Follow Jac patterns.** No destructuring, `has` = `useState`, `glob` for module-level constants.

---

## Critical Rules

These rules are **always enforced**. Each links to a file with Incorrect/Correct code pairs.

### Block-level Polish → [blocks.md](./rules/blocks.md)

- Container, vertical rhythm, type scale, tracking, text-balance, hairline borders, shadow restraint, gap discipline, color discipline, dark/light symmetry.

### Anti-Patterns → [anti-patterns.md](./rules/anti-patterns.md)

- 30+ amateur-LLM mistakes mapped to professional alternatives. **Run this list before producing UI.**

### Styling & Tailwind → [styling.md](./rules/styling.md)

- **`className` for layout, not styling.** Never override component colors or typography.
- **No `space-x-*` or `space-y-*`.** Use `flex` with `gap-*`. For vertical stacks, `flex flex-col gap-*`.
- **Use `size-*` when width and height are equal.** `size-10` not `w-10 h-10`.
- **Use physical CSS properties.** `pt-4 pb-4` not `py-4` — ensures `pt-0` overrides cleanly with `twMerge`.
- **No manual `dark:` color overrides.** Use semantic tokens (`bg-background`, `text-muted-foreground`).
- **Use `cn()` for conditional classes.** Import from `lib/utils.cl.jac`.
- **No manual `z-index` on overlay components.** Dialog, Sheet, Popover, etc. handle their own stacking.

### Forms & Inputs → [forms.md](./rules/forms.md)

- **Use `Field` + `Label` for form layout.** Never raw `div` with `space-y-*`.
- **Buttons inside inputs use `InputGroup` + `InputGroupAddon`.**
- **Option sets (2–5 choices) use `ToggleGroup`.** Don't loop `Button` with manual active state.

### Component Structure → [composition.md](./rules/composition.md)

- **Items always inside their Group.** `SelectItem` → `SelectGroup`. `DropdownMenuItem` → `DropdownMenuGroup`.
- **Dialog, Sheet, and Drawer always need a Title.** Required for accessibility. Use `className="sr-only"` if visually hidden.
- **Use full Card composition.** `CardHeader`/`CardTitle`/`CardDescription`/`CardContent`/`CardFooter`.
- **`TabsTrigger` must be inside `TabsList`.**
- **`Avatar` always needs `AvatarFallback`.**
- **ButtonGroup uses nested groups for gaps.** Use nested `<ButtonGroup>` for visible gaps between sections, `<ButtonGroupSeparator>` for subtle 1px dividers only.

### Jac Language Patterns → [jac-patterns.md](./rules/jac-patterns.md)

- **No tuple unpacking.** `a, b = func()` is invalid.
- **No nested `def` inside `def`.** Define all helpers at module level.
- **No JSX comments.** Remove all `{/* */}` from JSX return blocks.
- **`True`/`False`/`None` capitalized.** Python-style.
- **`has` = `useState`.** `has theme: str = "light"` → `const [theme, setTheme] = useState("light")`.
- **`glob` for module-level constants.** Not `const`.
- **No `forwardRef`.** Apply styles directly to Radix triggers.

### Icons → [icons.md](./rules/icons.md)

- **Use HugeIcons.** Import from `@hugeicons/react` + `@hugeicons/core-free-icons`.
- **Use `HugeiconsIcon` component.** `<HugeiconsIcon icon={SearchIcon} />`.
- **Icons in components use `strokeWidth` and `className` for sizing.**

---

## Block Recipes → [blocks/](./blocks/)

Open the matching file and use the template. Each has 2–4 layout variants, full Jac snippets, and block-specific common mistakes.

| Block | File | Use for |
|---|---|---|
| Hero | [blocks/hero.md](./blocks/hero.md) | Top of landing page — primary headline + CTA pair |
| Pricing | [blocks/pricing.md](./blocks/pricing.md) | 3-tier pricing with "Most Popular" treatment |
| Features | [blocks/features.md](./blocks/features.md) | 3-col icon grid, bento, alternating image/text |
| Testimonial | [blocks/testimonial.md](./blocks/testimonial.md) | Card grid, featured quote, marquee wall |
| Footer | [blocks/footer.md](./blocks/footer.md) | 4-col with logo + bottom legal bar |
| CTA | [blocks/cta.md](./blocks/cta.md) | Single-section conversion panel (inverted Card) |
| FAQ | [blocks/faq.md](./blocks/faq.md) | Accordion-driven Q&A |
| Auth | [blocks/auth.md](./blocks/auth.md) | Login + signup forms with Field + InputGroup |
| Dashboard | [blocks/dashboard.md](./blocks/dashboard.md) | Sidebar + stat cards + Chart layout |
| Navbar | [blocks/navbar.md](./blocks/navbar.md) | Sticky header with NavigationMenu + Sheet (mobile) |
| Empty State | [blocks/empty-state.md](./blocks/empty-state.md) | `Empty` composition for "no data" surfaces |

---

## Working Examples → [examples/](./examples/)

Six fully-working `.cl.jac` block files, validated against the Jac compiler. Read these to see what professional jac-shadcn output looks like end-to-end.

- [examples/landing_hero.cl.jac](./examples/landing_hero.cl.jac)
- [examples/pricing_section.cl.jac](./examples/pricing_section.cl.jac)
- [examples/feature_grid.cl.jac](./examples/feature_grid.cl.jac)
- [examples/footer_section.cl.jac](./examples/footer_section.cl.jac)
- [examples/dashboard_shell.cl.jac](./examples/dashboard_shell.cl.jac)
- [examples/auth_login.cl.jac](./examples/auth_login.cl.jac)

---

## Key Patterns

```jac
# Component definition — props extraction, no destructuring
def:pub MyComponent(props: Any) -> JsxElement {
    variant = props.variant or "default";
    return <div className={cn("bg-card", props.className)}>{props.children}</div>;
}

# State management — has = useState
has count: int = 0;

# Module-level constants — glob
glob _variants: Any = cva("base-classes", {"variants": {...}});

# Conditional classes — cn()
computedClass = cn("flex items-center", isActive and "bg-primary" or "bg-muted");

# Icons — HugeIcons
<HugeiconsIcon icon={SearchIcon} strokeWidth={2} className="size-4" />

# Radix trigger styling — apply buttonVariants directly
<DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "ghost", "size": "icon"})}>
```

---

## Component Selection

| Need                       | Use                                                                     |
| -------------------------- | ----------------------------------------------------------------------- |
| Button/action              | `Button` with appropriate variant                                       |
| Form inputs                | `Input`, `Select`, `Combobox`, `Switch`, `Checkbox`, `RadioGroup`, `Textarea`, `InputOTP`, `Slider` |
| Toggle between 2–5 options | `ToggleGroup` + `ToggleGroupItem`                                       |
| Data display               | `Table`, `Card`, `Badge`, `Avatar`                                      |
| Navigation                 | `Sidebar`, `NavigationMenu`, `Breadcrumb`, `Tabs`, `Pagination`         |
| Overlays                   | `Dialog` (modal), `Sheet` (side panel), `Drawer` (bottom sheet), `AlertDialog` (confirmation) |
| Feedback                   | `Alert`, `Progress`, `Skeleton`, `Spinner`, `Empty`                     |
| Charts                     | `Chart` (wraps Recharts)                                                |
| Layout                     | `Card`, `Separator`, `Resizable`, `ScrollArea`, `Accordion`, `Collapsible` |
| Menus                      | `DropdownMenu`, `ContextMenu`, `Menubar`                                |
| Tooltips/info              | `Tooltip`, `HoverCard`, `Popover`                                       |
| Button sections with gaps  | Nested `ButtonGroup` (not flat with `ButtonGroupSeparator`)             |

---

## CLI

```bash
# Activate venv first
source /home/ahzan/.jacvenv/bin/activate

# Add components (auto-resolves peer dependencies)
jac add --shadcn button card dialog

# Remove components
jac remove --shadcn button

# Create new project from jac-shadcn template
jac create --use jac-shadcn

# Start dev server
jac start main.jac
```

---

## Project Configuration

The `[jac-shadcn]` section in `jac.toml` configures the plugin:

```toml
[jac-shadcn]
style = "nova"          # nova, vega,  maia, lyra, mira
registry = "https://jac-shadcn.jaseci.org"
```

---

## cn-* Token System

Components in the **registry project** use style-agnostic placeholder classes (`cn-button`, `cn-card`). These are resolved per-style via CSS files (`styles/style-nova.css`, etc.). When components are installed in user projects via `jac add --shadcn`, cn-* tokens are **already resolved** to concrete Tailwind classes. Users never see cn-* tokens.

> **Registry developers only:** When adding new components to the registry, define cn-* tokens in all 5 style files. See [the registry CLAUDE.md](https://jac-shadcn.jaseci.org) for details.

---

## Detailed References

### Rules
- [rules/components.md](./rules/components.md) — **Component vocabulary cheat-sheet.** All 54 components: purpose, primitive (radix/base/cmdk/embla/atom), legal child grammar. Read this BEFORE writing JSX so you know what primitives exist and don't fabricate from `<div>`.
- [rules/base-vs-radix.md](./rules/base-vs-radix.md) — jac-shadcn is Radix-flavored. Translation rules from upstream `render={...}` (base) to `asChild={True}` + child (radix). Plus per-component API quirks: Select, ToggleGroup, Slider, Accordion. Combobox is the one base exception.
- [rules/registry-blocks.md](./rules/registry-blocks.md) — When official shadcn registry blocks exist (login-01, sidebar-07, dashboard-01...), use them first. Convert from `bases/radix/blocks/`, not `bases/base/blocks/`. Documents the jac-shadcn `Sidebar*` className spread bug and the workaround.
- [rules/blocks.md](./rules/blocks.md) — Block-level polish: container, rhythm, type scale, tracking, text-balance, borders, shadows, gaps, color discipline
- [rules/anti-patterns.md](./rules/anti-patterns.md) — Amateur → pro mapping table; mandatory pre-submit checklist
- [rules/styling.md](./rules/styling.md) — Semantic colors, variants, className, spacing, size, dark mode, cn()
- [rules/forms.md](./rules/forms.md) — Field, Label, InputGroup, ToggleGroup, validation
- [rules/composition.md](./rules/composition.md) — Groups, overlays, Card, Tabs, Avatar, Alert, Separator, Skeleton, Badge, ButtonGroup
- [rules/icons.md](./rules/icons.md) — HugeIcons, HugeiconsIcon component, sizing
- [rules/jac-patterns.md](./rules/jac-patterns.md) — Jac compiler gotchas, has/glob/def patterns, JSX rules

### Blocks
- [blocks/hero.md](./blocks/hero.md) · [blocks/pricing.md](./blocks/pricing.md) · [blocks/features.md](./blocks/features.md) · [blocks/testimonial.md](./blocks/testimonial.md) · [blocks/footer.md](./blocks/footer.md)
- [blocks/cta.md](./blocks/cta.md) · [blocks/faq.md](./blocks/faq.md) · [blocks/auth.md](./blocks/auth.md) · [blocks/dashboard.md](./blocks/dashboard.md) · [blocks/navbar.md](./blocks/navbar.md) · [blocks/empty-state.md](./blocks/empty-state.md)

### Examples
- [examples/](./examples/) — 6 fully-working `.cl.jac` block files

### Reference
- [cli.md](./cli.md) — Commands, flags, project config
- [customization.md](./customization.md) — Theming, CSS variables, extending components

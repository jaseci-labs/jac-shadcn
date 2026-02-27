# jac-shadcn: Project Status

## What Is This Project?

**jac-shadcn** is a port of the [shadcn/ui "create" page](https://ui.shadcn.com) — the interactive theme customizer — from TypeScript/React into the **Jac programming language** (`.cl.jac` client-side files). It serves as both a **design system showcase** and a **proof-of-concept** that complex, production-grade React UI can be written entirely in Jac.

The app runs with `jac start main.jac` and serves at `http://localhost:8000`.

---

## What Was Built

### Architecture

```
DesignSystemProvider (React Context)
├── config: { style, baseColor, theme, font, radius, menuAccent, menuColor }
├── setConfig: updates state → triggers live CSS variable + class changes
│
├── Customizer (left panel)
│   ├── StylePicker          → 5 visual styles
│   ├── BaseColorPicker      → 4 base grays
│   ├── ThemeColorPicker     → 21 accent colors with color circles
│   ├── FontPicker           → 12 variable fonts
│   ├── RadiusPicker         → 5 border radius options
│   ├── MenuAccentPicker     → subtle / bold
│   ├── MenuColorPicker      → default / inverted
│   ├── Random button (R)    → randomizes all settings
│   └── Reset button         → returns to defaults
│
└── ComponentExample (right panel)
    ├── CardExample          → image card + alert dialog + badge
    └── FormExample          → inputs, select, combobox, textarea, dropdown menu
```

### Source File Inventory

#### Entry Point (19 lines)

| File | Purpose |
|------|---------|
| `main.jac` | App entry — wraps `Customizer` + `ComponentExample` in `DesignSystemProvider` |

#### Design System Library — `lib/` (1,399 lines)

| File | Lines | What It Does |
|------|-------|--------------|
| `themes.cl.jac` | 849 | 21 color themes (4 base + 17 accent) in OKLCH color space. Each has light + dark CSS variable maps with 28+ color properties. |
| `config.cl.jac` | 259 | Default config, 5 presets, lookup functions (`getTheme`, `getFont`, `getRadius`, etc.), `buildRegistryTheme()` that merges base + accent + menu accent + radius into final CSS vars. |
| `design-system-provider.cl.jac` | 134 | React Context provider. Applies theme changes live via `useLayoutEffect`: body classes for style/baseColor, inline `style.setProperty()` for CSS variables, direct `fontFamily` on html+body. |
| `fonts.cl.jac` | 109 | 12 font definitions — name, value, CSS family string, type (sans/mono). Maps to `@fontsource-variable` packages. |
| `styles.cl.jac` | 38 | 5 visual style definitions — name, title, description. References `styles/*.css` files. |
| `utils.cl.jac` | 10 | `cn()` utility — merges classnames with `clsx` + `tailwind-merge`. |

#### UI Component Library — `components/ui/` (1,036 lines)

| Component | Lines | Description |
|-----------|-------|-------------|
| `combobox.cl.jac` | 214 | Searchable select with chips. Uses `@base-ui/react` Combobox primitives. Sub-components: `Combobox`, `ComboboxInput`, `ComboboxContent`, `ComboboxEmpty`, `ComboboxList`, `ComboboxItem`. |
| `field.cl.jac` | 149 | Form field wrapper with label, description, error. Supports horizontal/vertical orientation. Sub-components: `Field`, `FieldGroup`, `FieldLabel`. |
| `dropdown-menu.cl.jac` | 133 | Full dropdown menu system. Checkbox items, radio groups, nested submenus, keyboard shortcuts. Uses Radix UI primitives. 16 sub-components exported. |
| `select.cl.jac` | 116 | Dropdown select. Sub-components: `Select`, `SelectTrigger`, `SelectValue`, `SelectContent`, `SelectGroup`, `SelectItem`. |
| `input-group.cl.jac` | 115 | Input with optional prefix/suffix addon slots. |
| `alert-dialog.cl.jac` | 102 | Modal alert dialog. Sub-components: `AlertDialog`, `AlertDialogTrigger`, `AlertDialogContent`, `AlertDialogHeader`, `AlertDialogTitle`, `AlertDialogDescription`, `AlertDialogFooter`, `AlertDialogMedia`, `AlertDialogAction`, `AlertDialogCancel`. |
| `button.cl.jac` | 80 | CVA-based button. 6 variants (default, outline, secondary, ghost, destructive, link), 5 sizes (xs, sm, default, lg, icon). Supports `asChild` via Radix Slot. Exports `buttonVariants()`. |
| `badge.cl.jac` | 42 | Inline label. 4 variants (default, secondary, outline, muted). Supports `asChild`. |
| `card.cl.jac` | 32 | Container card. 6 sub-components: `Card`, `CardHeader`, `CardTitle`, `CardDescription`, `CardContent`, `CardFooter`, `CardAction`. |
| `separator.cl.jac` | 19 | Horizontal/vertical divider. Wraps Radix Separator. |
| `label.cl.jac` | 12 | Form label element. |
| `input.cl.jac` | 11 | Text input with standard styling. |
| `textarea.cl.jac` | 11 | Multi-line text input. |

#### Customizer & Showcase — `components/` (760 lines)

| File | Lines | What It Does |
|------|-------|--------------|
| `customizer.cl.jac` | 379 | Left panel. 7 picker sub-components (each a dropdown), `ColorCircle` helper, `randomizeConfig()` with style-aware constraints (Lyra forces mono font + no radius), reset to defaults. Keyboard shortcut: `R` for random. |
| `component-example.cl.jac` | 346 | Right panel. `CardExample` — image card with color overlay, alert dialog trigger, badge. `FormExample` — full form (input, select, combobox, textarea) + deeply nested dropdown menu (3 levels, with checkboxes, radio groups, keyboard shortcuts). |
| `example.cl.jac` | 35 | Layout wrappers. `ExampleWrapper` — responsive 2-column grid. `Example` — titled section with dashed border. |

#### Style CSS — `styles/` (6,773 lines)

| File | Lines | Description |
|------|-------|-------------|
| `style-vega.css` | 1,356 | Classic shadcn/ui look. Clean, neutral, familiar. |
| `style-nova.css` | 1,360 | Reduced padding/margins for compact layouts. |
| `style-maia.css` | 1,360 | Soft & rounded, generous spacing. |
| `style-lyra.css` | 1,335 | Boxy & sharp. Pairs well with monospace fonts. |
| `style-mira.css` | 1,362 | Dense interfaces. Minimal spacing. |

Each file defines `.style-{name} .cn-*` rules that restyle every component (button, card, input, badge, dropdown, etc.) using Tailwind `@apply` directives. Activated by adding `style-{name}` class to `<body>`.

#### Configuration & Styling

| File | Lines | Purpose |
|------|-------|---------|
| `global.css` | 146 | Imports: Tailwind, tw-animate-css, shadcn plugin, 12 font packages, 5 style CSS files. Defines `:root` and `.dark` CSS variables. `@theme inline` block maps variables to Tailwind. |
| `jac.toml` | 48 | Project config. NPM dependencies (radix-ui, CVA, clsx, tailwind-merge, shadcn, hugeicons, base-ui, 12 font packages). Vite plugin config for Tailwind. |

### Total Codebase

| Category | Files | Lines |
|----------|-------|-------|
| Design system library (`lib/`) | 6 | 1,399 |
| UI components (`components/ui/`) | 13 | 1,036 |
| Customizer + showcase (`components/`) | 3 | 760 |
| Style CSS (`styles/`) | 5 | 6,773 |
| Config + entry (`main.jac`, `global.css`, `jac.toml`) | 3 | 213 |
| Documentation (`docs/`) | 2 | ~1,560 |
| **Total** | **32** | **~11,741** |

---

## Design System Capabilities

### 21 Color Themes

**4 Base Colors** (neutral grays):
Neutral, Stone, Zinc, Gray

**17 Accent Themes** (available with any base color):
Red, Orange, Amber, Yellow, Lime, Green, Emerald, Teal, Cyan, Blue, Indigo, Violet, Purple, Fuchsia, Pink, Rose, Custom Accent

All colors defined in **OKLCH color space** for perceptual uniformity. Each theme provides light + dark mode CSS variables for 28+ properties (background, foreground, primary, secondary, muted, accent, destructive, border, input, ring, chart-1 through chart-5, sidebar variants).

### 5 Visual Styles

| Style | Character | Best For |
|-------|-----------|----------|
| **Vega** | Classic shadcn/ui | Standard web apps |
| **Nova** | Compact padding | Dashboards, admin panels |
| **Maia** | Soft & rounded | Consumer apps, friendly UIs |
| **Lyra** | Boxy & sharp | Developer tools, code editors |
| **Mira** | Dense spacing | Data-heavy interfaces |

### 12 Variable Fonts

**Sans-serif** (10): Geist, Inter, Noto Sans, Nunito Sans, Figtree, Roboto, Raleway, DM Sans, Public Sans, Outfit

**Monospace** (2): JetBrains Mono, Geist Mono

All loaded via `@fontsource-variable` packages (variable font format, smaller file sizes).

### Other Options

- **Border Radius**: None (0), Small (0.45rem), Medium (0.625rem), Large (0.875rem), Default
- **Menu Accent**: Subtle (standard), Bold (primary color on accent/sidebar-accent)
- **Menu Color**: Default, Inverted (adds `.dark` class to `.cn-menu-target` elements)

---

## Key Technical Decisions & Bugs Solved

### 1. The forwardRef Problem

**Problem**: Jac compiles all components as plain function components — no `React.forwardRef()`. React 18 (pinned by `jac-client-node`) doesn't support ref-as-prop. When `asChild={True}` is used on a Radix trigger wrapping a Jac `<Button>`, the ref is silently dropped. Floating UI can't measure position → dropdown appears at `translate(0px, -200%)`.

**Solution**: Remove `asChild` from triggers. Apply button styles directly using `buttonVariants()` CSS classes:
```jac
# Instead of: <DropdownMenuTrigger asChild={True}><Button variant="outline">...</Button></DropdownMenuTrigger>
# Use:        <DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "outline"})}>...</DropdownMenuTrigger>
```

### 2. The `\n` Compilation Bug

**Problem**: Jac's `"\n"` compiles to JavaScript `"\\n"` (literal backslash-n, not actual newline). When used in dynamically generated CSS strings, this produces invalid CSS — `\n` is a CSS escape sequence that breaks property names.

**Solution**: Never use `"\n"` in CSS strings. Use spaces, or better, avoid CSS string building entirely and use `document.documentElement.style.setProperty()`.

### 3. CSS Specificity with Tailwind v4's `@theme inline`

**Problem**: Dynamically injected `<style>` elements with `:root {}` rules have lower specificity than Tailwind v4's `@theme inline` block. Theme variable overrides were being ignored.

**Solution**: Use `document.documentElement.style.setProperty("--var", value)` — inline styles have the highest CSS specificity and always override `@theme inline`.

### 4. Logical vs Physical CSS Properties

**Problem**: Tailwind v4 generates `padding-block` (logical) for `py-4` but `padding-top` (physical) for `pt-0`. These are different CSS properties that don't reliably override each other. A Card with `py-4` base + `pt-0` override showed a gray gap above the image.

**Solution**: Use physical properties in component base classes: `pt-4 pb-4` instead of `py-4`. This ensures `pt-0` overrides cleanly via `tailwind-merge`.

### 5. Font Switching Not Taking Effect

**Problem**: Setting `--font-sans` CSS variable alone didn't change the visible font. Tailwind v4's `@theme inline` declaration had specificity that prevented the variable from cascading.

**Solution**: Set font-family in three places:
```jac
document.documentElement.style.setProperty("--font-sans", fontFamily);
document.documentElement.style.fontFamily = fontFamily;
document.body.style.fontFamily = fontFamily;
```

### 6. @fontsource-variable Version Mismatch

**Problem**: Pinning `"^5.2.10"` for all font packages failed — different packages have different version ranges.

**Solution**: Use `"*"` (wildcard) for font package versions in `jac.toml`.

---

## NPM Dependencies

### Runtime
- `jac-client-node` (1.0.4) — Jac runtime + React 18
- `radix-ui` (^1.4.3) — Unstyled accessible primitives (DropdownMenu, Select, AlertDialog, Separator)
- `@base-ui/react` (^1.2.0) — Base UI primitives (Combobox)
- `class-variance-authority` (^0.7.1) — Component variant management
- `clsx` (^2.1.1) — Conditional classname utility
- `tailwind-merge` (^3.5.0) — Tailwind class deduplication
- `tw-animate-css` (^1.4.0) — Animation utility classes
- `shadcn` (^3.8.5) — shadcn Tailwind CSS plugin
- `@hugeicons/react` + `@hugeicons/core-free-icons` — Icon library
- 12x `@fontsource-variable/*` — Variable font packages

### Dev
- `tailwindcss` (latest) — Tailwind v4
- `@tailwindcss/vite` (latest) — Vite plugin

---

## What the Original shadcn "Create" Page Has That We Don't (Yet)

| Feature | Original | jac-shadcn | Status |
|---------|----------|---------|--------|
| Theme customizer panel | 7 pickers + random/reset | 7 pickers + random/reset | Done |
| Live component showcase | ~15+ component examples | 2 examples (Card + Form) | Partial |
| Dark mode toggle | Yes | No | Not started |
| Copy theme code | Exports CSS/config | No | Not started |
| More presets | ~10 presets | 5 presets | Partial |
| Responsive customizer | Collapsible sidebar | Fixed sidebar | Not started |
| Charts example | Chart components | No | Not started |
| Sidebar example | Sidebar layout | No | Not started |
| Tabs example | Tab component | No | Not started |
| Table/DataTable | Data table component | No | Not started |

---

## How to Run

```bash
source /home/ahzan/.jacvenv/bin/activate
cd /home/ahzan/Documents/jaseci/jacCN/jac-shadcn
jac start main.jac
# Open http://localhost:8000
```

---

## Documentation

| Doc | Location | Content |
|-----|----------|---------|
| TSX-to-Jac Conversion Guide | `docs/tsx-to-jac-conversion-guide.md` | 1,556 lines. Complete reference for converting shadcn/ui TSX components to Jac. Covers imports, props, CVA, forwardRef workarounds, Tailwind v4 gotchas, dynamic theming, font loading, browser API patterns, and 15+ troubleshooting entries. |
| Project Status (this file) | `docs/project-status.md` | What was built, architecture, file inventory, decisions made, bugs solved, what's remaining. |

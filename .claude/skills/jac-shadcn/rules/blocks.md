# Block-level Polish

Rules that turn a wall of components into a section that looks like it was shipped by a design team. This is the difference between "Claude used jac-shadcn" and "Claude built shadcnblocks.com-quality output."

> **Use this file alongside [anti-patterns.md](./anti-patterns.md).** This file is the positive ruleset (what to do); anti-patterns is the negative ruleset (what to avoid).

## Contents

- The container shell
- Vertical rhythm (section padding)
- Type scale (h1 → h2 → h3 → lead → body → label → legal)
- Tracking and `text-balance`
- Color discipline
- Hairline borders, restrained shadows, rounded corners
- Gap discipline (4-multiples only)
- Inner content constraints (`max-w-*`)
- Dark/light symmetry
- The section header pattern
- Card padding standard

---

## The container shell

Every full-width section uses the same outer + inner pattern.

**Outer (`<section>`)**: full-width, holds the section padding.
**Inner (the container)**: caps width, adds responsive horizontal padding.

```jac
<section className="pt-24 pb-24 sm:pt-32 sm:pb-32">
    <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
        {props.children}
    </div>
</section>
```

> Note: physical CSS properties (`pt-24 pb-24`, `pl-4 pr-4`) instead of `py-24 px-4`. See [styling.md](./styling.md).

---

## Vertical rhythm — section padding

| Section type | Padding |
|---|---|
| Hero (top of page) | `pt-24 pb-24 sm:pt-32 sm:pb-32` |
| Top CTA / final CTA | `pt-24 pb-24 sm:pt-32 sm:pb-32` |
| Mid-page section (features, pricing, testimonials, FAQ) | `pt-16 pb-16 sm:pt-24 sm:pb-24` |
| Compact strip (logo bar, trust strip) | `pt-12 pb-12` |
| Footer | `pt-16 pb-16` |

**Incorrect — sections feel cramped:**

```jac
<section className="pt-8 pb-8">
    <div className="mx-auto max-w-7xl pl-4 pr-4">
        <h2 className="text-2xl">Features</h2>
    </div>
</section>
```

**Correct:**

```jac
<section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
    <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
        <h2 className="text-3xl font-bold tracking-tight sm:text-4xl">Features</h2>
    </div>
</section>
```

The single biggest "feels cheap" tell in amateur LLM output is `py-8` everywhere. **Empty space IS the design.**

---

## Type scale

The mobile → desktop ladder:

| Element | Classes |
|---|---|
| Hero h1 | `text-4xl font-bold tracking-tight sm:text-5xl lg:text-6xl` |
| Hero h1 (display) | `text-5xl font-bold tracking-tighter sm:text-6xl lg:text-7xl` |
| Section h2 | `text-3xl font-bold tracking-tight sm:text-4xl` |
| Card / feature h3 | `text-lg font-semibold` (body cards) or `text-xl font-semibold` (feature cards) |
| Hero lead paragraph | `text-lg leading-8 text-muted-foreground` |
| Section description | `text-lg text-muted-foreground` |
| Body | `text-base` |
| Card description | `text-sm leading-relaxed text-muted-foreground` |
| Label / eyebrow | `text-sm font-semibold` or `Badge variant="outline"` |
| Footer / legal | `text-xs text-muted-foreground` |

**Incorrect — display headline too small, no font weight:**

```jac
<h1 className="text-3xl font-normal">The headline goes here</h1>
```

**Correct:**

```jac
<h1 className="text-balance text-4xl font-bold tracking-tight sm:text-5xl lg:text-6xl">
    The headline goes here
</h1>
```

---

## Tracking and `text-balance`

- **`tracking-tight`** on display sizes (`text-3xl` and up).
- **`tracking-tighter`** only on huge headlines (`text-6xl+`).
- **Default tracking on body.** Never `tracking-wide` on body.
- **`text-balance`** on every headline and any short paragraph (under ~2 lines). Eliminates orphan words automatically.
- **`leading-relaxed`** or **`leading-8`** on body for readability.

```jac
<h1 className="text-balance text-4xl font-bold tracking-tight sm:text-5xl lg:text-6xl">
    Ship beautiful UIs without designing from scratch
</h1>
<p className="mt-6 text-balance text-lg leading-8 text-muted-foreground">
    A copy-paste component library for Jac, with 53 accessible primitives.
</p>
```

---

## Color discipline

**Always use semantic tokens.** Never hardcoded hex, rgba, or raw Tailwind palette colors (`text-blue-500`, `bg-orange-50`).

| Surface | Token |
|---|---|
| Page background | `bg-background` |
| Card / elevated surface | `bg-card` |
| Subtle bg, hover surface | `bg-muted` |
| Popover / dropdown | `bg-popover` |
| Hover accent | `bg-accent` |

| Text | Token |
|---|---|
| Default text | `text-foreground` (or omit — it's the default) |
| Dim / secondary text | `text-muted-foreground` |
| Accent emphasis (sparingly) | `text-primary` |

| Borders | Token |
|---|---|
| Default border | `border` (resolves to `border-border`) |
| Form inputs | `border-input` |

| Status | Token |
|---|---|
| Success / positive | `text-success` / `bg-success` (+ `-foreground`) |
| Warning | `text-warning` / `bg-warning` |
| Info | `text-info` / `bg-info` |
| Error / destructive | `text-destructive` / `bg-destructive` |

**Tints via opacity modifiers, not raw colors:**

```jac
className="bg-primary/10 text-primary border-primary/30"
className="bg-success/10 text-success border-success/30"
```

**Incorrect:**

```jac
<div className="bg-orange-500 text-white">CTA</div>
<span className="text-emerald-600">+20.1%</span>
```

**Correct:**

```jac
<div className="bg-primary text-primary-foreground">CTA</div>
<Badge variant="secondary">+20.1%</Badge>
```

---

## Hairline borders, restrained shadows, rounded corners

### Borders — 1px hairline only

- Use `border` (1px) for separation between surfaces.
- **Never** `border-2`, `border-4` for layout. Heavy borders look amateur.
- `border-2` is acceptable only for focus rings (and even then, prefer `ring-2`).

### Shadows — flatness is the look

| Card state | Shadow |
|---|---|
| Card at rest | `shadow-sm` |
| Card on hover (interactive) | `shadow-md` |
| Featured / "Most Popular" card | `shadow-lg` |
| Hero mockup floating over page | `shadow-2xl` |
| Default modals/popovers | already handled by component |

**Never `shadow-xl` on every card.** Use `shadow-sm` and only escalate where it earns its weight.

### Rounded corners

| Surface | Radius |
|---|---|
| Cards, buttons | `rounded-lg` |
| Large surfaces, hero mockup | `rounded-xl` |
| Inputs, small elements | `rounded-md` |
| Pills, avatars | `rounded-full` |

**Be consistent within a block** — don't mix `rounded` + `rounded-2xl` in the same section.

---

## Gap discipline — 4-multiples only

Tailwind's spacing scale uses 4px increments. Stick to it.

**Allowed values for `gap-*`, `mt-*`, `pt-*`, etc.:**
`{1, 2, 3, 4, 6, 8, 10, 12, 16, 20, 24, 32}`

**Common patterns:**

| Use | Gap |
|---|---|
| Inline icons + text in button | `gap-2` |
| Form field label → input | `gap-2` |
| Form field stack | `gap-4` |
| Footer link list | `gap-3` (`space-y-3` equivalent via flex-col) |
| Card grid (small) | `gap-4` or `gap-6` |
| Card grid (lg breakpoint) | `gap-8` |
| Major split-section | `gap-12` |

**Vertical rhythm inside a hero:**

```
Eyebrow Badge → mt-0
h1            → mt-0 (start)
p (subhead)   → mt-6
CTA pair      → mt-10
Visual        → mt-16
```

**Incorrect — random spacing:**

```jac
<h1>Headline</h1>
<p className="mt-7">Subhead</p>
<div className="mt-9 gap-5">CTAs</div>
```

**Correct — 4-multiples only:**

```jac
<h1>Headline</h1>
<p className="mt-6">Subhead</p>
<div className="mt-10 flex gap-4">CTAs</div>
```

---

## Inner content constraints — `max-w-*`

Outer container = `max-w-7xl`. Inner content gets further constrained per content type:

| Content | Max width |
|---|---|
| Centered text-only header (eyebrow + h2 + lead) | `max-w-2xl mx-auto text-center` |
| Centered hero text | `max-w-3xl mx-auto text-center` |
| Article / FAQ section | `max-w-3xl mx-auto` |
| Card grid (3 cards) | `max-w-5xl` or `max-w-6xl` |
| Full-bleed feature grid | no inner constraint (uses outer max-w-7xl) |
| Long-form prose | `max-w-prose` |

**Why:** keeps line lengths at ~75 characters. Anything wider is hard to read.

**Incorrect — text headline goes full container width:**

```jac
<div className="mx-auto max-w-7xl pl-4 pr-4">
    <h2 className="text-3xl">Long headline that wraps awkwardly across the entire screen width</h2>
</div>
```

**Correct:**

```jac
<div className="mx-auto max-w-7xl pl-4 pr-4">
    <div className="mx-auto max-w-2xl text-center">
        <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
            Long headline that wraps awkwardly across the entire screen width
        </h2>
    </div>
</div>
```

---

## Dark/light symmetry — automatic via tokens

If you stay on semantic tokens, dark mode works automatically. **Never write `dark:` color classes** in block code.

**Incorrect:**

```jac
<div className="bg-white text-gray-900 dark:bg-gray-950 dark:text-gray-50">
    <p className="text-gray-600 dark:text-gray-400">Description</p>
</div>
```

**Correct:**

```jac
<div className="bg-background text-foreground">
    <p className="text-muted-foreground">Description</p>
</div>
```

The only legitimate `dark:` usage is for *images* (e.g., showing a dark logo in light mode and a light logo in dark mode). Color tokens never need it.

---

## The section header pattern

Every marketing section above the content grid has the same header structure:

```jac
<div className="mx-auto max-w-2xl text-center">
    <Badge variant="outline" className="mb-4">Features</Badge>
    <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
        Everything you need to ship
    </h2>
    <p className="mt-4 text-balance text-lg text-muted-foreground">
        Description of what the section delivers.
    </p>
</div>
```

**Vertical rhythm**: `mb-4` (badge → h2), `mt-4` (h2 → description). The grid below this header sits at `mt-12` or `mt-16`.

**Variants**:
- Drop the Badge if the page is short.
- Replace Badge with all-caps eyebrow `text-sm font-semibold text-primary uppercase tracking-wider` (sparingly — tracks-wide on body is dated, but tracks-wider on a small caps eyebrow is OK).
- Left-align (`text-left`) for split-section layouts.

---

## Card padding standard

| Card type | Padding |
|---|---|
| Default card | `p-6` |
| Featured card (pricing tier, hero card) | `p-6 sm:p-8` |
| Compact card (data table cell, list item) | `p-4` (only when card itself is small) |
| Empty state card | `pt-12 pb-12 pl-6 pr-6` |

**Never `p-4` for default cards.** It looks cramped. Use `CardHeader` / `CardContent` / `CardFooter` (which have `p-6` baked in) instead of putting everything in one container.

---

## Putting it together — the section template

Every block follows this skeleton. Customize only the content inside the `text-center` div and the grid.

```jac
<section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
    <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
        <div className="mx-auto max-w-2xl text-center">
            <Badge variant="outline" className="mb-4">Eyebrow</Badge>
            <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                Section headline
            </h2>
            <p className="mt-4 text-balance text-lg text-muted-foreground">
                Section description.
            </p>
        </div>

        <div className="mx-auto mt-16 grid max-w-6xl grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-3">
            {props.children}
        </div>
    </div>
</section>
```

This skeleton, applied consistently, produces output that visually matches Tailwind UI / shadcnblocks / blocks.so quality.

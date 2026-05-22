# Block recipes

Block-level patterns for jac-shadcn — open the matching file and use its templates. Every block has 2–4 layout variants and concrete Jac snippets.

## Marketing-page blocks

| Block | File | One-liner |
|---|---|---|
| Hero | [hero.md](./hero.md) | Top-of-page headline + CTA pair (centered, split, with social proof, with logo bar) |
| Features | [features.md](./features.md) | 3-col icon grid, bento, alternating image/text |
| Pricing | [pricing.md](./pricing.md) | 3-tier with "Most Popular" treatment, billing toggle via Tabs |
| Testimonial | [testimonial.md](./testimonial.md) | Card grid, featured single quote, marquee wall |
| Footer | [footer.md](./footer.md) | 4-col with logo column + bottom legal bar |
| CTA | [cta.md](./cta.md) | Inverted Card panel for conversion at section end |
| FAQ | [faq.md](./faq.md) | Accordion-driven Q&A |
| Navbar | [navbar.md](./navbar.md) | Sticky header with NavigationMenu + Sheet (mobile) |

## App-shell blocks

| Block | File | One-liner |
|---|---|---|
| Dashboard | [dashboard.md](./dashboard.md) | Sidebar + stat cards + chart layout |
| Auth | [auth.md](./auth.md) | Login / signup / reset forms with Field + InputGroup |
| Empty State | [empty-state.md](./empty-state.md) | `Empty` composition for "no data" surfaces |

## How to choose a block

Match on the user's request shape, not the words they used:

- **"Make a landing page"** → start with `hero.md`, then compose downward (see below).
- **"Add a pricing section / pricing page"** → `pricing.md`.
- **"Show our features"**, "what we do", "value props" → `features.md`.
- **"Add testimonials / social proof / quotes / reviews"** → `testimonial.md`.
- **"Footer"**, "site footer", legal/links bar → `footer.md`.
- **"Call to action"**, "sign up section", "get started block" mid-page → `cta.md`.
- **"FAQ"**, "frequently asked", "questions section" → `faq.md`.
- **"Navbar / header / top nav"** → `navbar.md`.
- **"Sign in / sign up / login / register / reset password"** → `auth.md`.
- **"Dashboard"**, "admin layout", "app shell with sidebar" → `dashboard.md`.
- **"No results / nothing here / placeholder when empty"** → `empty-state.md`.

If two blocks could plausibly fit, prefer the **more specific** file (e.g. `cta.md` over `hero.md` for a mid-page conversion panel). If still unsure, open both and pick the variant closest to the request.

## How to use a block recipe

1. Match user request → open `blocks/<type>.md`.
2. Pick variant (default if not specified).
3. Copy snippet, adapt content (text, icons, links — never the structure).
4. Cross-check against [`rules/blocks.md`](../rules/blocks.md) and [`rules/anti-patterns.md`](../rules/anti-patterns.md).

## Composing multiple blocks for a full page

A typical landing page stacks blocks in this order:

```
navbar  →  hero  →  features  →  testimonial  →  pricing  →  faq  →  cta  →  footer
```

Drop any section the user didn't ask for. Keep section padding consistent (`pt-16 pb-16 sm:pt-24 sm:pb-24` mid-page; `pt-24 pb-24 sm:pt-32 sm:pb-32` for hero and final CTA). Don't double-pad — the section owns its rhythm, the page just stacks them.

## When NOT to use a block

Blocks are marketing-and-shell patterns. For app-internal surfaces, switch tools:

- **Dashboards / admin tooling** → [dashboard.md](./dashboard.md), then compose with components from `rules/composition.md`.
- **Forms inside an app** (settings, edit dialogs, wizards) → [`rules/forms.md`](../rules/forms.md), not `auth.md`.
- **"No data" / first-run states** → [empty-state.md](./empty-state.md).
- **Single component edits** ("fix this button", "add a dropdown") → use the Component Selection table in [SKILL.md](../SKILL.md), not a block.

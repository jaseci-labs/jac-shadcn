# Feature blocks

## When to use

"Features", "What you get", "How it works", "Why X" sections — communicating product capabilities under the hero. Surface 3–6 concrete benefits, not a kitchen-sink list. With more than 6, split into two sections or use a Bento grid that lets one item be the hero.

## Components used

- `Badge` — eyebrow above the section h2 (`variant="outline"`)
- `Card`, `CardHeader`, `CardTitle`, `CardDescription` — only when each feature is a Card (Variant 4)
- `HugeiconsIcon` — feature icons (always — never emoji)
- Image / mockup `<img>` or placeholder `<div className="bg-muted">` — for Variant 3

---

## Variant 1: 3-col icon grid (default — most common)

### Layout intent

Centered section header, then a 3-column grid of left-aligned feature items. Each item is an icon tile + title + description. This is the workhorse — reach for it first unless the design calls for something else.

### Jac code

```jac
import from ..components.ui.badge { Badge }
import from "@hugeicons/react" { HugeiconsIcon }
import from "@hugeicons/core-free-icons" { ZapIcon, Shield01Icon, GitBranchIcon }

cl {
    def:pub FeaturesGrid(props: Any) -> JsxElement {
        return <section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-2xl text-center">
                    <Badge variant="outline" className="mb-4">Features</Badge>
                    <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                        Everything you need to ship
                    </h2>
                    <p className="mt-4 text-balance text-lg text-muted-foreground">
                        Built for teams that want to move fast without breaking the design system.
                    </p>
                </div>

                <div className="mx-auto mt-16 grid max-w-6xl grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-3">
                    <div className="flex flex-col gap-4">
                        <div className="flex size-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
                            <HugeiconsIcon icon={ZapIcon} strokeWidth={2} className="size-5" />
                        </div>
                        <h3 className="text-lg font-semibold">Lightning fast</h3>
                        <p className="text-sm text-muted-foreground leading-relaxed">
                            Hot reload in under 50ms. No build step between you and the pixel.
                        </p>
                    </div>

                    <div className="flex flex-col gap-4">
                        <div className="flex size-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
                            <HugeiconsIcon icon={Shield01Icon} strokeWidth={2} className="size-5" />
                        </div>
                        <h3 className="text-lg font-semibold">Type-safe by default</h3>
                        <p className="text-sm text-muted-foreground leading-relaxed">
                            Walker contracts and graph schemas catch mistakes before they ship.
                        </p>
                    </div>
                </div>
            </div>
        </section>;
    }
}
```

> Repeat the feature `<div>` for the third (and any additional) cells — same icon container, same `text-lg font-semibold` title, same `text-sm text-muted-foreground` description.

---

## Variant 2: Bento grid

### Layout intent

6 cells with varied col-span / row-span — one big hero feature, one wide feature, three small. The asymmetry signals "modern product page" and lets you give the most important capability visual weight without burying the rest. Use when you want to highlight one capability above the others.

### Jac code

```jac
import from ..components.ui.card { Card }
import from "@hugeicons/react" { HugeiconsIcon }
import from "@hugeicons/core-free-icons" { ZapIcon, Shield01Icon, CodeIcon }

cl {
    def:pub FeaturesBento(props: Any) -> JsxElement {
        return <section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-2xl text-center">
                    <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                        One platform, every primitive
                    </h2>
                    <p className="mt-4 text-balance text-lg text-muted-foreground">
                        From walker to deploy without leaving the editor.
                    </p>
                </div>

                <div className="mx-auto mt-16 grid max-w-6xl grid-cols-1 gap-4 md:grid-cols-3 md:auto-rows-[18rem]">
                    <Card className="md:col-span-2 md:row-span-2 p-6 flex flex-col gap-4">
                        <div className="flex size-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
                            <HugeiconsIcon icon={ZapIcon} strokeWidth={2} className="size-6" />
                        </div>
                        <h3 className="text-lg font-semibold">Live preview, every keystroke</h3>
                        <p className="text-sm text-muted-foreground leading-relaxed">
                            Edit and see the running app side-by-side. No build, no refresh.
                        </p>
                    </Card>

                    <Card className="p-6 flex flex-col gap-4">
                        <div className="flex size-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
                            <HugeiconsIcon icon={Shield01Icon} strokeWidth={2} className="size-5" />
                        </div>
                        <h3 className="text-lg font-semibold">JWT-scoped graph</h3>
                        <p className="text-sm text-muted-foreground leading-relaxed">Every user gets an isolated root.</p>
                    </Card>

                    <Card className="md:col-span-2 p-6 flex flex-col gap-4">
                        <div className="flex size-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
                            <HugeiconsIcon icon={CodeIcon} strokeWidth={2} className="size-5" />
                        </div>
                        <h3 className="text-lg font-semibold">AI agent with project context</h3>
                        <p className="text-sm text-muted-foreground leading-relaxed">
                            JacCoder reads your graph, walkers, imports — and ships working diffs.
                        </p>
                    </Card>
                </div>
            </div>
        </section>;
    }
}
```

---

## Variant 3: Alternating image/text rows

### Layout intent

2-column split where the image side alternates per row (image-left, text-right; then text-left, image-right). Good for "How it works" walkthroughs where each step deserves a screenshot or animation. Each row is its own self-contained pitch — the rhythm of the alternation does the visual work.

### Jac code

```jac
import from ..components.ui.badge { Badge }

cl {
    def:pub FeaturesAlternating(props: Any) -> JsxElement {
        return <section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-2xl text-center">
                    <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                        How it works
                    </h2>
                </div>

                <div className="mx-auto mt-16 flex max-w-6xl flex-col gap-24">
                    <div className="grid items-center gap-12 lg:grid-cols-2">
                        <div>
                            <Badge variant="outline" className="mb-4">Step 1</Badge>
                            <h3 className="text-balance text-3xl font-bold tracking-tight">
                                Start from a template
                            </h3>
                            <p className="mt-4 text-lg text-muted-foreground leading-relaxed">
                                Pick a curated starter or import a JacPack. Your project is live in seconds.
                            </p>
                        </div>
                        <div className="overflow-hidden rounded-xl border bg-muted aspect-video" />
                    </div>

                    <div className="grid items-center gap-12 lg:grid-cols-2">
                        <div className="overflow-hidden rounded-xl border bg-muted aspect-video lg:order-1" />
                        <div className="lg:order-2">
                            <Badge variant="outline" className="mb-4">Step 2</Badge>
                            <h3 className="text-balance text-3xl font-bold tracking-tight">
                                Edit with AI in the loop
                            </h3>
                            <p className="mt-4 text-lg text-muted-foreground leading-relaxed">
                                JacCoder reads your project graph and ships diffs you can review inline.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>;
    }
}
```

> Note: the `lg:order-1` / `lg:order-2` flip is what makes the image swap sides at the `lg` breakpoint — under that, both rows stack image-on-top.

---

## Variant 4: Card grid (Card-based features)

### Layout intent

Same 3-column rhythm as Variant 1 but each item is a `<Card>` with a hairline border and `shadow-sm`. Use when features are interactive (clickable to a detail page), or when the surrounding page has no other Cards and you want the features to feel like discrete units.

### Jac code

```jac
import from ..components.ui.card { Card, CardHeader, CardTitle, CardDescription, CardContent }
import from "@hugeicons/react" { HugeiconsIcon }
import from "@hugeicons/core-free-icons" { ZapIcon, Shield01Icon, GitBranchIcon }

cl {
    def:pub FeaturesCardGrid(props: Any) -> JsxElement {
        return <section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-2xl text-center">
                    <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                        Built for builders
                    </h2>
                    <p className="mt-4 text-balance text-lg text-muted-foreground">
                        Three primitives. Everything else composes from them.
                    </p>
                </div>

                <div className="mx-auto mt-16 grid max-w-6xl grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
                    <Card>
                        <CardHeader>
                            <div className="flex size-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
                                <HugeiconsIcon icon={ZapIcon} strokeWidth={2} className="size-5" />
                            </div>
                            <CardTitle className="mt-4 text-lg">Walkers</CardTitle>
                            <CardDescription className="text-sm leading-relaxed">
                                JWT-scoped HTTP endpoints that traverse your graph.
                            </CardDescription>
                        </CardHeader>
                    </Card>
                </div>
            </div>
        </section>;
    }
}
```

> Repeat the `<Card>` pattern above for each remaining feature — same icon container, same `CardTitle` / `CardDescription` rhythm. No `CardContent` / `CardFooter` needed unless you have action buttons or stats.

---

## Common mistakes specific to feature blocks

- **Multi-color icons** (each card a different color) — looks amateur. Use one accent: `bg-primary/10 text-primary` on every icon container.
- **`text-xl text-primary` for feature titles** — competes with the section h2. Use `text-lg font-semibold` (default foreground).
- **Full `bg-primary` on the icon container** — at full opacity the icon disappears. Always `bg-primary/10` with `text-primary` for the icon.
- **Centered text per feature** — only the section header is centered. Feature items stay left-aligned; centering each one breaks scan rhythm.
- **Random icon sizes per card** — `size-5` for grid variants, `size-6` only for the bento hero cell. Mixing sizes reads as inconsistency.
- **Emojis instead of HugeIcons** — emojis ignore stroke weight and break in dark mode. Always `<HugeiconsIcon icon={X} strokeWidth={2} className="size-5" />`.
- **`gap-2` between feature cards** — too tight. Use `gap-8` at lg, `gap-6` smaller, `gap-4` for Bento (larger cells).
- **Forgetting `text-balance` on the section h2** — leaves orphan words on wide viewports.
- **`py-*` / `px-*` shorthand** — codebase rule is physical CSS only (`pt-16 pb-16`, `pl-4 pr-4`).
- **Joining classNames with `+`** — always `cn(...)`. String concat defeats `tailwind-merge`.
- **JSX comments** (`{/* ... */}` or `#` inside the return) — Jac compiler errors. Strip them.

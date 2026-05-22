# Hero blocks

## When to use

The first section above the fold on a landing page. One per page — pairs the primary headline with a single CTA pair (and optionally a mockup, social proof, or logo bar) to communicate the promise in under three seconds.

## Components used

- `Badge` (`variant="outline"`) — eyebrow tag above the headline
- `Button` (sizes `default` / `lg`, variants `default` / `outline`) — primary + secondary CTA
- `HugeiconsIcon` — eyebrow dot/icon, button arrows, social-proof stars, logo-bar fallbacks
- `Avatar` + `AvatarFallback` — avatar stack for social proof variant
- (Variant 2 only) plain `<img>` for the product screenshot in the split layout

## Variant 1: Centered hero (default — most common)

### Layout intent

Centered single column. `max-w-3xl` text inside a `max-w-7xl` container. Eyebrow Badge → h1 → lead → CTA pair → optional mockup at `mt-16`. This is the default — reach for split or social-proof variants only when you have the asset to justify it.

### Jac code

```jac
cl import from ..ui.badge { Badge }
cl import from ..ui.button { Button }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon }

cl {
    def:pub HeroCentered(props: Any) -> JsxElement {
        return <section className="pt-24 pb-24 sm:pt-32 sm:pb-32">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-3xl text-center">
                    <Badge variant="outline" className="mb-6 gap-1.5">
                        <span className="size-1.5 rounded-full bg-primary" />
                        {"New: v2.0 is here"}
                    </Badge>
                    <h1 className="text-balance text-4xl font-bold tracking-tight sm:text-5xl lg:text-6xl">
                        Ship beautiful UIs without designing from scratch
                    </h1>
                    <p className="mt-6 mx-auto max-w-2xl text-balance text-lg leading-8 text-muted-foreground">
                        A copy-paste component library for Jac, with 53 accessible primitives ready for your next project.
                    </p>
                    <div className="mt-10 flex flex-wrap items-center justify-center gap-4">
                        <Button size="lg">
                            Get started
                            <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="size-4" />
                        </Button>
                        <Button size="lg" variant="outline">View components</Button>
                    </div>
                </div>
                <div className="mt-16 overflow-hidden rounded-xl border bg-card shadow-2xl">
                    <img src="/hero-mockup.png" alt="Product preview" className="w-full" />
                </div>
            </div>
        </section>;
    }
}
```

## Variant 2: Split hero (text + image, 2-col)

### Layout intent

`grid lg:grid-cols-2 gap-12 items-center`. Text left, screenshot right. Stacks on mobile (image below text). Use when you have a product visual strong enough to earn half the screen.

### Jac code

```jac
cl import from ..ui.badge { Badge }
cl import from ..ui.button { Button }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon }

cl {
    def:pub HeroSplit(props: Any) -> JsxElement {
        return <section className="pt-24 pb-24 sm:pt-32 sm:pb-32">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="grid grid-cols-1 gap-12 items-center lg:grid-cols-2">
                    <div>
                        <Badge variant="outline" className="mb-6 gap-1.5">
                            <span className="size-1.5 rounded-full bg-primary" />
                            {"For modern teams"}
                        </Badge>
                        <h1 className="text-balance text-4xl font-bold tracking-tight sm:text-5xl lg:text-6xl">
                            The platform built for shipping fast
                        </h1>
                        <p className="mt-6 max-w-xl text-balance text-lg leading-8 text-muted-foreground">
                            Replace your stack with a single tool. Designed for teams that ship every day and need their UI to keep up.
                        </p>
                        <div className="mt-10 flex flex-wrap items-center gap-4">
                            <Button size="lg">
                                Start free trial
                                <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="size-4" />
                            </Button>
                            <Button size="lg" variant="outline">Book a demo</Button>
                        </div>
                    </div>
                    <div className="overflow-hidden rounded-xl border bg-card shadow-2xl">
                        <img src="/hero-split.png" alt="Dashboard preview" className="w-full" />
                    </div>
                </div>
            </div>
        </section>;
    }
}
```

## Variant 3: Centered with social proof

### Layout intent

Variant 1 plus a trust row below the CTAs: avatar stack (`-space-x-2`), 5-star row, and "Loved by 10,000+ teams" caption — sits at `mt-10`. Drop the mockup; social proof is the visual.

### Jac code

```jac
cl import from ..ui.badge { Badge }
cl import from ..ui.button { Button }
cl import from ..ui.avatar { Avatar, AvatarFallback }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon, StarIcon }

cl {
    def:pub HeroSocialProof(props: Any) -> JsxElement {
        return <section className="pt-24 pb-24 sm:pt-32 sm:pb-32">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-3xl text-center">
                    <Badge variant="outline" className="mb-6 gap-1.5">
                        <span className="size-1.5 rounded-full bg-primary" />
                        {"Trusted by builders"}
                    </Badge>
                    <h1 className="text-balance text-4xl font-bold tracking-tight sm:text-5xl lg:text-6xl">
                        The component library teams actually love
                    </h1>
                    <p className="mt-6 mx-auto max-w-2xl text-balance text-lg leading-8 text-muted-foreground">
                        Composable, accessible, and copy-paste ready. Stop fighting your design system.
                    </p>
                    <div className="mt-10 flex flex-wrap items-center justify-center gap-4">
                        <Button size="lg">
                            Get started
                            <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="size-4" />
                        </Button>
                        <Button size="lg" variant="outline">View on GitHub</Button>
                    </div>
                    <div className="mt-10 flex flex-wrap items-center justify-center gap-4">
                        <div className="flex -space-x-2">
                            <Avatar className="size-8 border-2 border-background"><AvatarFallback>JD</AvatarFallback></Avatar>
                            <Avatar className="size-8 border-2 border-background"><AvatarFallback>AL</AvatarFallback></Avatar>
                            <Avatar className="size-8 border-2 border-background"><AvatarFallback>MK</AvatarFallback></Avatar>
                            <Avatar className="size-8 border-2 border-background"><AvatarFallback>SR</AvatarFallback></Avatar>
                        </div>
                        <div className="flex items-center gap-0.5 text-primary">
                            <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                            <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                            <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                            <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                            <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                        </div>
                        <p className="text-sm text-muted-foreground">{"Loved by 10,000+ teams"}</p>
                    </div>
                </div>
            </div>
        </section>;
    }
}
```

## Variant 4: With logo bar below

### Layout intent

Variant 1 plus a "Trusted by" line and grayscale logo row at `mt-16`. Tightens the sell with named-customer credibility. Real logos as `<img>` with `h-8 w-auto opacity-60 grayscale`; `<HugeiconsIcon>` works as a placeholder.

### Jac code

```jac
cl import from ..ui.badge { Badge }
cl import from ..ui.button { Button }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon }

cl {
    def:pub HeroWithLogos(props: Any) -> JsxElement {
        return <section className="pt-24 pb-24 sm:pt-32 sm:pb-32">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-3xl text-center">
                    <Badge variant="outline" className="mb-6 gap-1.5">
                        <span className="size-1.5 rounded-full bg-primary" />
                        {"Now in public beta"}
                    </Badge>
                    <h1 className="text-balance text-4xl font-bold tracking-tight sm:text-5xl lg:text-6xl">
                        The infrastructure layer for AI products
                    </h1>
                    <p className="mt-6 mx-auto max-w-2xl text-balance text-lg leading-8 text-muted-foreground">
                        From prototype to production in a single afternoon. Built for engineers who ship.
                    </p>
                    <div className="mt-10 flex flex-wrap items-center justify-center gap-4">
                        <Button size="lg">
                            Start building
                            <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="size-4" />
                        </Button>
                        <Button size="lg" variant="outline">Read the docs</Button>
                    </div>
                </div>
                <div className="mt-16">
                    <p className="text-center text-sm font-semibold text-muted-foreground">Trusted by teams at</p>
                    <div className="mt-6 flex flex-wrap items-center justify-center gap-x-8 gap-y-4">
                        <img src="/logos/acme.svg" alt="Acme" className="h-8 w-auto opacity-60 grayscale" />
                        <img src="/logos/globex.svg" alt="Globex" className="h-8 w-auto opacity-60 grayscale" />
                        <img src="/logos/initech.svg" alt="Initech" className="h-8 w-auto opacity-60 grayscale" />
                        <img src="/logos/umbrella.svg" alt="Umbrella" className="h-8 w-auto opacity-60 grayscale" />
                        <img src="/logos/hooli.svg" alt="Hooli" className="h-8 w-auto opacity-60 grayscale" />
                    </div>
                </div>
            </div>
        </section>;
    }
}
```

## Common mistakes specific to hero blocks

- `text-3xl font-normal` on the h1. Heroes need `text-4xl font-bold tracking-tight sm:text-5xl lg:text-6xl` — anything smaller reads as a section header.
- Forgetting `text-balance` on headline and lead. Orphan words on the last line wreck the optical balance.
- `text-xl` for the lead paragraph. The standard is `text-lg leading-8 text-muted-foreground` — `text-xl` competes with the headline.
- Section padding of `py-8` or `py-12`. Heroes need `pt-24 pb-24 sm:pt-32 sm:pb-32`. Empty space is the design.
- Multi-color icons in the star row. All five stars use `text-primary` with `fill-current` — never mix colors or use raw `text-yellow-400`.
- Emojis in place of icons. Use `HugeiconsIcon` with `strokeWidth={2} className="size-4"`.
- Wrapping the hero in `max-w-5xl`. Outer container is always `max-w-7xl`; constrain *text* with `max-w-3xl mx-auto text-center`.
- Two `<h1>` tags on one page. The hero owns the only `<h1>`; section headers below are `<h2>`.
- `py-24` instead of `pt-24 pb-24`. Physical CSS properties only.
- Hardcoded `text-orange-500` or `bg-white`. Always semantic tokens — `text-primary`, `bg-background`, `text-muted-foreground`.
- Forgetting `{"+"}` or `{"&"}` wrapping in JSX. `{"Loved by 10,000+ teams"}` must be wrapped to compile.

# Testimonial blocks

## When to use

"Loved by teams", "What customers say", "Trusted by builders" — any social proof section that surfaces user quotes between hero and pricing. Use a card grid for breadth (5+ short quotes), a featured single quote when one customer carries the page, and a marquee wall when you have many short quotes and want continuous motion.

## Components used

- `Card` (used as a plain bordered container — no `CardHeader`/`CardContent` here, just `Card` with `p-6`)
- `Avatar` + `AvatarImage` + `AvatarFallback`
- `HugeiconsIcon` with `StarIcon` for the rating row
- `Badge` (optional — for the section eyebrow or company-name pills)

## Variant 1: Card grid 3-col (default)

### Layout intent

Section header (eyebrow + h2 + lead) centered at `max-w-2xl`. A 1 / 2 / 3-column grid below at `mt-16` with `gap-6`. Each card has a 5-star row at top, the quote in body copy weight (NOT italic), and a left-aligned attribution row (Avatar + name + title) at the bottom.

### Jac code

```jac
cl import from ...lib.utils { cn }
cl import from ..ui.card { Card }
cl import from ..ui.avatar { Avatar, AvatarImage, AvatarFallback }
cl import from ..ui.badge { Badge }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { StarIcon }

glob _testimonials: list = [
    {"quote": "Cut our build time in half. The team ships features we used to put off for months.", "name": "Sarah Chen", "title": "Engineering Lead, Acme", "avatar": "/avatars/01.png", "fallback": "SC"},
    {"quote": "The cleanest API I've worked with this year. Onboarding took an afternoon, not a week.", "name": "Marcus Webb", "title": "CTO, Northwind", "avatar": "/avatars/02.png", "fallback": "MW"},
    {"quote": "Replaced three internal tools. Our PMs ship dashboards now without bothering us.", "name": "Priya Patel", "title": "Director of Platform, Lumen", "avatar": "/avatars/03.png", "fallback": "PP"}
];

cl {
    def:pub TestimonialCardGrid(props: Any) -> JsxElement {
        items = props.items or _testimonials;
        return <section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-2xl text-center">
                    <Badge variant="outline" className="mb-4">Testimonials</Badge>
                    <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                        Loved by builders
                    </h2>
                    <p className="mt-4 text-balance text-lg text-muted-foreground">
                        Teams across the world ship faster with us.
                    </p>
                </div>
                <div className="mt-16 grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3">
                    {items.map(lambda(t: Any) -> Any {
                        return <Card key={t.name} className="p-6">
                            <div className="flex items-center gap-0.5 text-primary">
                                <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                                <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                                <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                                <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                                <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                            </div>
                            <p className="mt-4 text-base leading-relaxed">{t.quote}</p>
                            <div className="mt-6 flex items-center gap-3">
                                <Avatar>
                                    <AvatarImage src={t.avatar} alt={t.name} />
                                    <AvatarFallback>{t.fallback}</AvatarFallback>
                                </Avatar>
                                <div>
                                    <div className="text-sm font-semibold">{t.name}</div>
                                    <div className="text-xs text-muted-foreground">{t.title}</div>
                                </div>
                            </div>
                        </Card>;
                    })}
                </div>
            </div>
        </section>;
    }
}
```

## Variant 2: Featured single quote

### Layout intent

One large quote, centered, no card chrome. `max-w-3xl` figure, oversized type (`text-2xl sm:text-3xl`), `font-medium` (NOT bold, NOT italic). Avatar `size-12` and attribution sit below the quote, centered as a row but with the name/title block left-aligned within the row.

### Jac code

```jac
cl import from ..ui.avatar { Avatar, AvatarImage, AvatarFallback }
cl import from ..ui.badge { Badge }

cl {
    def:pub TestimonialFeatured(props: Any) -> JsxElement {
        quote = props.quote or "We replaced a six-figure tool stack in a weekend. The team hasn't stopped shipping since.";
        name = props.name or "Eliza Romero";
        title = props.title or "VP Engineering, Northgate";
        avatarSrc = props.avatar or "/avatars/featured.png";
        fallback = props.fallback or "ER";
        return <section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <figure className="mx-auto max-w-3xl text-center">
                    <Badge variant="outline" className="mb-6">Customer story</Badge>
                    <blockquote className="text-balance text-2xl font-medium leading-relaxed sm:text-3xl">
                        {quote}
                    </blockquote>
                    <figcaption className="mt-8 flex items-center justify-center gap-4">
                        <Avatar className="size-12">
                            <AvatarImage src={avatarSrc} alt={name} />
                            <AvatarFallback>{fallback}</AvatarFallback>
                        </Avatar>
                        <div className="text-left">
                            <div className="font-semibold">{name}</div>
                            <div className="text-sm text-muted-foreground">{title}</div>
                        </div>
                    </figcaption>
                </figure>
            </div>
        </section>;
    }
}
```

## Variant 3: Marquee wall (scrolling row)

### Layout intent

A continuously scrolling horizontal row of testimonial cards. Outer wrapper is `relative flex overflow-hidden` so cards bleed off-screen. Inner row uses an `animate-marquee` keyframe that translates from `0` to `-50%`, with the card list duplicated so the loop is seamless. Each card carries `min-w-[20rem]` so it doesn't collapse to content width.

> **Setup**: Tailwind v4 doesn't ship a `marquee` keyframe. Add this to `global.css` once:
>
> ```css
> @keyframes marquee {
>     0% { transform: translateX(0); }
>     100% { transform: translateX(-50%); }
> }
> ```

### Jac code

```jac
cl import from ...lib.utils { cn }
cl import from ..ui.card { Card }
cl import from ..ui.avatar { Avatar, AvatarImage, AvatarFallback }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { StarIcon }

glob _marqueeItems: list = [
    {"quote": "Shipped our v2 in three weeks. Wild.", "name": "Devon Park", "title": "Founder, Slate", "avatar": "/avatars/04.png", "fallback": "DP"},
    {"quote": "Best dev experience I've had in years.", "name": "Aisha Kone", "title": "Staff Engineer, Helio", "avatar": "/avatars/05.png", "fallback": "AK"},
    {"quote": "We stopped writing internal tooling overnight.", "name": "Ren Tanaka", "title": "Eng Manager, Drift", "avatar": "/avatars/06.png", "fallback": "RT"},
    {"quote": "It's the first thing I install on every new project.", "name": "Mira Soto", "title": "Solo dev", "avatar": "/avatars/07.png", "fallback": "MS"}
];

cl {
    def:pub TestimonialMarquee(props: Any) -> JsxElement {
        items = props.items or _marqueeItems;
        doubled = items.concat(items);
        return <section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
            <div className="mx-auto max-w-2xl pl-4 pr-4 text-center sm:pl-6 sm:pr-6">
                <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                    What customers are saying
                </h2>
            </div>
            <div className="relative mt-16 flex overflow-hidden">
                <div className="flex shrink-0 gap-4 pl-4 pr-4 [animation:marquee_30s_linear_infinite]">
                    {doubled.map(lambda(t: Any, i: int) -> Any {
                        return <Card key={i} className="min-w-[20rem] p-6">
                            <div className="flex items-center gap-0.5 text-primary">
                                <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                                <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                                <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                                <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                                <HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />
                            </div>
                            <p className="mt-4 text-base leading-relaxed">{t.quote}</p>
                            <div className="mt-6 flex items-center gap-3">
                                <Avatar>
                                    <AvatarImage src={t.avatar} alt={t.name} />
                                    <AvatarFallback>{t.fallback}</AvatarFallback>
                                </Avatar>
                                <div>
                                    <div className="text-sm font-semibold">{t.name}</div>
                                    <div className="text-xs text-muted-foreground">{t.title}</div>
                                </div>
                            </div>
                        </Card>;
                    })}
                </div>
            </div>
        </section>;
    }
}
```

## Common mistakes specific to testimonial blocks

- **Italic quotes.** `italic` on the quote body looks dated and cheapens the layout. Use upright `text-base leading-relaxed` (cards) or `text-2xl/3xl font-medium` (featured).
- **Emoji stars (`★`).** Use `<HugeiconsIcon icon={StarIcon} strokeWidth={2} className="size-4 fill-current" />` in a `flex items-center gap-0.5 text-primary` row. Emojis render inconsistently across OSes.
- **Hardcoded yellow stars (`text-yellow-500`).** Always `text-primary` so the rating inherits the brand accent and dark/light mode flips for free.
- **`text-primary` on the name.** The name is `font-semibold` body color; the title is `text-xs/text-sm text-muted-foreground`. Coloring the name fights the quote for attention.
- **Centered attribution inside grid cards.** Cards are narrow — center alignment looks cramped. Use the left-aligned `flex items-center gap-3` row. Center alignment is reserved for the **featured** variant.
- **`p-4` cards.** Default testimonial cards use `p-6`. `p-4` reads as a list item, not a card.
- **Avatar without `AvatarFallback`.** If `AvatarImage` 404s (offline build, broken CDN link), an unset Avatar renders as a visible gap. Always provide a 2-letter fallback.
- **Forgetting `AvatarImage` entirely.** A bare `<Avatar><AvatarFallback>JD</AvatarFallback></Avatar>` is fine if you have no photos, but most designs lose impact without faces.
- **Bold quotes.** `font-bold` on the quote body shouts. Cards stay at default weight; the featured quote is `font-medium`, never `font-bold`.
- **Marquee without doubled items.** A single copy of the list snaps when it loops. Concat the array onto itself so the `-50%` translate lands on an identical frame.
- **Marquee cards without `min-w-[20rem]`.** Without an explicit min-width, cards collapse to content width and the row jitters as quotes vary in length.

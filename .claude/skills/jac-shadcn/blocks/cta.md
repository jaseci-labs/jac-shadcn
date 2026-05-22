# CTA blocks (call-to-action)

## When to use

The single conversion section of the page — usually the last block before the footer. A CTA block exists to drive one action: signup, contact sales, start trial, or subscribe. Use exactly one final CTA per page; pages with three "Get started" sections dilute conversion. Reach for an inverted-card variant on long pages where the visitor has scrolled past features/pricing — the shift in surface tone marks the page's payoff. Use the plain centered variant on short pages where a full inverted panel would feel oversized.

## Components used

- `Card` — for inverted-bg variant (panel sits on `bg-primary`)
- `Button` — `size="lg"` always; `variant="secondary"` and `variant="outline"` on inverted bg
- `Input` — newsletter variant only
- `HugeiconsIcon` — `ArrowRight` on the primary CTA

```jac
cl import from ..ui.card { Card }
cl import from ..ui.button { Button }
cl import from ..ui.input { Input }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon }
```

---

## Variant 1: Inverted Card panel (default — high contrast)

### Layout intent

A `Card` with `bg-primary text-primary-foreground` containing a 2-column grid: headline + lead on the left, primary + secondary CTA on the right. On mobile the columns stack. This is the highest-converting layout for marketing pages because the surface change (page bg → primary panel) makes the section unmissable, and the CTA pair sits on its own column instead of buried under the headline.

### Jac code

```jac
cl {
    def:pub FinalCta(props: Any) -> JsxElement {
        return <section className="pt-24 pb-24 sm:pt-32 sm:pb-32">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <Card className="overflow-hidden bg-primary text-primary-foreground">
                    <div className="grid gap-8 pt-8 pb-8 pl-8 pr-8 sm:pt-12 sm:pb-12 sm:pl-12 sm:pr-12 lg:grid-cols-[1fr_auto] lg:items-center">
                        <div>
                            <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                                Ready to ship faster?
                            </h2>
                            <p className="mt-4 text-lg opacity-90">
                                Start building with jac-shadcn today. No credit card required.
                            </p>
                        </div>
                        <div className="flex flex-wrap gap-3">
                            <Button size="lg" variant="secondary">
                                Get started
                                <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="size-4" />
                            </Button>
                            <Button size="lg" variant="outline" className="border-primary-foreground/20 text-primary-foreground hover:bg-primary-foreground/10">
                                Talk to sales
                            </Button>
                        </div>
                    </div>
                </Card>
            </div>
        </section>;
    }
}
```

---

## Variant 2: Plain centered CTA

### Layout intent

No card, no inverted surface — just a centered headline, lead paragraph, and CTA pair on the page background. Use when the page is short enough that an inverted panel would feel like overkill, or when an earlier section already used the primary color heavily and a second hit would feel repetitive.

### Jac code

```jac
cl {
    def:pub CenteredCta(props: Any) -> JsxElement {
        return <section className="pt-24 pb-24 sm:pt-32 sm:pb-32">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-3xl text-center">
                    <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                        Start building today
                    </h2>
                    <p className="mt-4 text-balance text-lg text-muted-foreground">
                        Join thousands of teams shipping production-grade Jac applications.
                    </p>
                    <div className="mt-10 flex flex-wrap justify-center gap-3">
                        <Button size="lg">
                            Get started
                            <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="size-4" />
                        </Button>
                        <Button size="lg" variant="outline">
                            Learn more
                        </Button>
                    </div>
                </div>
            </div>
        </section>;
    }
}
```

---

## Variant 3: Split with image

### Layout intent

A 2-column split: image on one side (product screenshot, illustration, or photo) and headline + lead + CTA pair on the other. Stacks on mobile. Use when the visual itself is part of the pitch — e.g. a product mockup that reinforces the headline. Image gets `rounded-xl` for the larger surface treatment.

### Jac code

```jac
cl {
    def:pub SplitCta(props: Any) -> JsxElement {
        return <section className="pt-24 pb-24 sm:pt-32 sm:pb-32">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="grid gap-8 lg:grid-cols-2 lg:items-center lg:gap-12">
                    <div className="overflow-hidden rounded-xl border">
                        <img src={props.imageSrc or "/cta-image.png"} alt="" className="size-full object-cover" />
                    </div>
                    <div>
                        <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                            See it in action
                        </h2>
                        <p className="mt-4 text-balance text-lg text-muted-foreground">
                            Watch a 2-minute walkthrough or jump straight into the playground.
                        </p>
                        <div className="mt-10 flex flex-wrap gap-3">
                            <Button size="lg">
                                Open playground
                                <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="size-4" />
                            </Button>
                            <Button size="lg" variant="outline">
                                Watch demo
                            </Button>
                        </div>
                    </div>
                </div>
            </div>
        </section>;
    }
}
```

---

## Variant 4: Newsletter signup CTA

### Layout intent

Same outer shell as Variant 1 (inverted card on primary), but the action area is an inline email input + subscribe button. Stacks on mobile (`flex-col`), goes inline on `sm` and up (`sm:flex-row`). Use this only when the page goal is genuinely email capture — never disguise a signup flow as a newsletter form.

### Jac code

```jac
cl {
    def:pub NewsletterCta(props: Any) -> JsxElement {
        has email: str = "";
        return <section className="pt-24 pb-24 sm:pt-32 sm:pb-32">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <Card className="overflow-hidden bg-primary text-primary-foreground">
                    <div className="grid gap-8 pt-8 pb-8 pl-8 pr-8 sm:pt-12 sm:pb-12 sm:pl-12 sm:pr-12 lg:grid-cols-[1fr_auto] lg:items-center">
                        <div>
                            <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                                Stay in the loop
                            </h2>
                            <p className="mt-4 text-lg opacity-90">
                                Monthly digest of new components, patterns, and case studies.
                            </p>
                        </div>
                        <div className="flex flex-col gap-3 sm:flex-row">
                            <Input
                                placeholder="Enter your email"
                                type="email"
                                value={email}
                                onChange={lambda(e: Any) -> None { email = e.target.value; }}
                                className="flex-1 bg-primary-foreground/10 text-primary-foreground placeholder:text-primary-foreground/60"
                            />
                            <Button size="lg" variant="secondary">
                                Subscribe
                            </Button>
                        </div>
                    </div>
                </Card>
            </div>
        </section>;
    }
}
```

---

## Common mistakes specific to CTA blocks

- **Using `text-muted-foreground` on inverted bg.** Semantic dim tokens are tuned for `bg-background`, not `bg-primary`. They render close to the surface color and read as washed-out. Use `opacity-90` on the lead paragraph instead — it clamps contrast cleanly against any solid bg.
- **`variant="default"` for the primary CTA on inverted bg.** Default button variant is `bg-primary`, which now matches the panel — the button disappears. Use `variant="secondary"` (light surface) so the CTA pops against the dark panel.
- **Forgetting `border-primary-foreground/20` on the outline button against inverted bg.** The default outline border is `border-border`, which is a low-contrast token tuned for `bg-background`. On `bg-primary` it vanishes. Override with `border-primary-foreground/20 text-primary-foreground hover:bg-primary-foreground/10`.
- **Tiny CTA buttons.** A final CTA must be `size="lg"` — this is the biggest button on the page. Default-size buttons here read as a low-priority form action.
- **Single CTA only.** A pair (primary action + secondary "Talk to sales" or "Learn more") consistently outperforms a single button. Visitors who aren't ready to convert still have somewhere to click.
- **`bg-gradient-to-r from-blue-500 to-purple-500` cheesy gradients.** Plain `bg-primary` looks more confident than a marketing-deck gradient. If you reach for `bg-gradient-*` on the CTA, you've already lost.
- **`pt-12 pb-12` section padding.** A final CTA is a major page moment — it needs `pt-24 pb-24 sm:pt-32 sm:pb-32`. Half-padding makes the section feel like a footer afterthought.
- **Hardcoded color overrides** like `text-white` or `bg-orange-600`. Use `text-primary-foreground` and `bg-primary` — the token system handles dark mode automatically and stays in palette.
- **Headline without `text-balance`.** Two-word orphans on the second line look amateur. Always balance the headline.
- **Newsletter input without contrast.** A bare `<Input />` on `bg-primary` inherits an invisible border. On the inverted panel, override with `bg-primary-foreground/10 text-primary-foreground placeholder:text-primary-foreground/60`.

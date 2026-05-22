# Pricing blocks

## When to use

Pricing/plans section on a marketing or product page. Built around a 3-tier comparison with one tier visually emphasized to anchor the buyer toward the recommended plan. Conversion-focused: every tier ends in a CTA, every feature row reinforces the choice. Use as a mid-page section on landing pages, or as the primary block on a dedicated `/pricing` route.

## Components used

- `Card` + `CardHeader` + `CardTitle` + `CardDescription` + `CardContent` + `CardFooter`
- `Button` (`variant="default"` for the featured tier, `variant="outline"` for the others)
- `Badge` (`variant="secondary"` for "Most Popular" or savings labels)
- `Tabs` + `TabsList` + `TabsTrigger` + `TabsContent` (monthly/yearly billing-period toggle)
- `HugeiconsIcon` with `Tick01Icon` for feature checkmarks

---

## Variant 1: 3-tier with "Most Popular" highlight (default)

### Layout intent

Section header (centered, `max-w-2xl`) → 3-column card grid (`max-w-5xl`) → middle card highlighted with primary border, ring, and shadow. Cards use `flex flex-col` so feature lists stretch and the CTA buttons sit flush at the bottom of every card. Stack to a single column on mobile.

### Jac code

```jac
glob _tiers: list = [
    {
        "name": "Starter",
        "price": "0",
        "description": "For hobby projects and trying things out.",
        "features": ["Up to 3 projects", "Community support", "Basic analytics"],
        "cta": "Get started",
        "popular": False
    },
    {
        "name": "Builder",
        "price": "15",
        "description": "Everything you need to ship a real product.",
        "features": ["Unlimited projects", "Email support", "Advanced analytics", "Custom domains"],
        "cta": "Start building",
        "popular": True
    },
    {
        "name": "Pro",
        "price": "25",
        "description": "For teams that need scale and SLAs.",
        "features": ["Everything in Builder", "Priority support", "SSO + audit logs", "99.9% SLA"],
        "cta": "Contact sales",
        "popular": False
    }
];

cl {
    def:pub PricingSection(props: Any) -> JsxElement {
        return <section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-2xl text-center">
                    <Badge variant="outline" className="mb-4">Pricing</Badge>
                    <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                        Simple pricing that scales with you
                    </h2>
                    <p className="mt-4 text-balance text-lg text-muted-foreground">
                        Start free. Upgrade when you need more.
                    </p>
                </div>

                <div className="mx-auto mt-12 grid max-w-5xl grid-cols-1 gap-6 lg:grid-cols-3 lg:gap-8">
                    {_tiers.map(lambda(tier: Any) -> Any { return <PricingCard tier={tier} key={tier.name} />; })}
                </div>
            </div>
        </section>;
    }

    def:pub PricingCard(props: Any) -> JsxElement {
        tier = props.tier;
        isPopular = tier.popular;
        return <Card className={cn(
            "relative flex flex-col",
            isPopular and "border-primary shadow-lg ring-1 ring-primary" or ""
        )}>
            {isPopular and <Badge className="absolute -top-3 left-1/2 -translate-x-1/2">Most Popular</Badge> or None}
            <CardHeader>
                <CardTitle className="text-xl">{tier.name}</CardTitle>
                <CardDescription>{tier.description}</CardDescription>
                <div className="mt-4 flex items-baseline gap-1">
                    <span className="text-4xl font-bold tracking-tight">{"$" + tier.price}</span>
                    <span className="text-sm text-muted-foreground">/month</span>
                </div>
            </CardHeader>
            <CardContent className="flex-1">
                <ul className="flex flex-col gap-3 text-sm">
                    {tier.features.map(lambda(feature: str) -> Any { return <li className="flex items-start gap-2" key={feature}>
                        <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="mt-0.5 size-4 shrink-0 text-primary" />
                        <span>{feature}</span>
                    </li>; })}
                </ul>
            </CardContent>
            <CardFooter>
                <Button className="w-full" variant={isPopular and "default" or "outline"}>{tier.cta}</Button>
            </CardFooter>
        </Card>;
    }
}
```

---

## Variant 2: With monthly/yearly Tabs toggle

### Layout intent

Same card grid as Variant 1, with a `Tabs` toggle centered between the section header and the grid. The toggle uses `TabsList` with `grid grid-cols-2` so both options have equal width. **Use Tabs, not Switch** — Tabs is more accessible, label-clear, and keyboard-navigable. Yearly typically shows a savings `Badge variant="secondary"` (e.g. "Save 20%") inline with the trigger label.

### Jac code

```jac
cl {
    def:pub PricingSectionWithToggle(props: Any) -> JsxElement {
        has billing: str = "monthly";
        setBilling = lambda(v: str) -> None { billing = v; };
        priceFor = lambda(tier: Any) -> str { return billing == "yearly" and tier.yearlyPrice or tier.price; };
        periodLabel = billing == "yearly" and "/year" or "/month";

        return <section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-2xl text-center">
                    <Badge variant="outline" className="mb-4">Pricing</Badge>
                    <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                        Simple pricing that scales with you
                    </h2>
                    <p className="mt-4 text-balance text-lg text-muted-foreground">
                        Start free. Upgrade when you need more.
                    </p>
                </div>

                <div className="mt-8 flex justify-center">
                    <Tabs value={billing} onValueChange={setBilling} className="w-fit">
                        <TabsList className="grid grid-cols-2">
                            <TabsTrigger value="monthly">Monthly</TabsTrigger>
                            <TabsTrigger value="yearly">
                                <span className="flex items-center gap-2">
                                    Yearly
                                    <Badge variant="secondary" className="text-xs">Save 20%</Badge>
                                </span>
                            </TabsTrigger>
                        </TabsList>
                    </Tabs>
                </div>

                <div className="mx-auto mt-12 grid max-w-5xl grid-cols-1 gap-6 lg:grid-cols-3 lg:gap-8">
                    {_tiers.map(lambda(tier: Any) -> Any { return <Card className={cn(
                        "relative flex flex-col",
                        tier.popular and "border-primary shadow-lg ring-1 ring-primary" or ""
                    )} key={tier.name}>
                        {tier.popular and <Badge className="absolute -top-3 left-1/2 -translate-x-1/2">Most Popular</Badge> or None}
                        <CardHeader>
                            <CardTitle className="text-xl">{tier.name}</CardTitle>
                            <CardDescription>{tier.description}</CardDescription>
                            <div className="mt-4 flex items-baseline gap-1">
                                <span className="text-4xl font-bold tracking-tight">{"$" + priceFor.call(None, tier)}</span>
                                <span className="text-sm text-muted-foreground">{periodLabel}</span>
                            </div>
                        </CardHeader>
                        <CardContent className="flex-1">
                            <ul className="flex flex-col gap-3 text-sm">
                                {tier.features.map(lambda(feature: str) -> Any { return <li className="flex items-start gap-2" key={feature}>
                                    <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="mt-0.5 size-4 shrink-0 text-primary" />
                                    <span>{feature}</span>
                                </li>; })}
                            </ul>
                        </CardContent>
                        <CardFooter>
                            <Button className="w-full" variant={tier.popular and "default" or "outline"}>{tier.cta}</Button>
                        </CardFooter>
                    </Card>; })}
                </div>
            </div>
        </section>;
    }
}
```

---

## Variant 3: 4-tier with featured center

### Layout intent

Same skeleton as Variant 1, but with 4 columns on `lg`. The featured tier sits at index 2 (third position, third quarter from the left). `max-w-6xl` instead of `max-w-5xl` to give 4 cards breathing room. Use this only when there's a genuine reason for a 4th tier (e.g. Free / Builder / Pro / Enterprise) — otherwise stay on 3.

### Jac code

```jac
glob _tiersFour: list = [
    {"name": "Free", "price": "0", "description": "Try it out.", "features": ["1 project", "Community support"], "cta": "Get started", "popular": False},
    {"name": "Builder", "price": "15", "description": "Ship real products.", "features": ["Unlimited projects", "Email support", "Custom domains"], "cta": "Start building", "popular": False},
    {"name": "Pro", "price": "25", "description": "For growing teams.", "features": ["Everything in Builder", "Priority support", "SSO", "Audit logs"], "cta": "Upgrade to Pro", "popular": True},
    {"name": "Enterprise", "price": "Custom", "description": "Bespoke and on-prem.", "features": ["Custom contracts", "Dedicated support", "On-prem deployment"], "cta": "Contact sales", "popular": False}
];

cl {
    def:pub PricingSectionFour(props: Any) -> JsxElement {
        return <section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <div className="mx-auto max-w-2xl text-center">
                    <Badge variant="outline" className="mb-4">Pricing</Badge>
                    <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                        Plans for every stage
                    </h2>
                    <p className="mt-4 text-balance text-lg text-muted-foreground">
                        From hobby to enterprise.
                    </p>
                </div>

                <div className="mx-auto mt-12 grid max-w-6xl grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4 lg:gap-8">
                    {_tiersFour.map(lambda(tier: Any) -> Any { return <PricingCard tier={tier} key={tier.name} />; })}
                </div>
            </div>
        </section>;
    }
}
```

For the `Custom` price tier, the `{"$" + tier.price}` template still works ("$Custom") but you can branch in `PricingCard` to skip the dollar sign when `tier.price == "Custom"`.

---

## Common mistakes specific to pricing blocks

- **5 tiers.** Decision fatigue kills conversion. Stay at 3; allow 4 only when the fourth is clearly Enterprise/Custom.
- **2 tiers.** Without a "good/better/best" anchor, neither option feels like the recommended choice. If you only have two plans, design as a single hero card with feature comparison instead.
- **Switch instead of Tabs for the billing toggle.** A `Switch` is for single boolean settings ("Notifications: on/off"). For a labeled choice between *named options* ("Monthly" vs "Yearly"), use `Tabs` — it's keyboard-accessible, labels are visible to screen readers, and the active state is unambiguous.
- **Don't use `lg:scale-105` to emphasize the featured tier.** It overflows the grid cell and gets clipped in containers narrower than full viewport. `border-primary + shadow-lg + ring-1 ring-primary` plus the "Most Popular" badge is enough emphasis.
- **Forgetting `w-full` on the CTA Button.** Buttons that don't span the card's content width look like they're floating; full-width CTAs read as "the action for this card."
- **Missing `flex-1` on `CardContent`.** Without it, cards with shorter feature lists collapse and their footers float midway, breaking the "buttons aligned at the bottom" rhythm. `flex flex-col` on the Card + `flex-1` on the content is the lockstep pair.
- **Hardcoded green for savings labels.** `text-green-500` or `bg-emerald-100` violates the semantic-token rule and looks off-theme. Use `Badge variant="secondary"` (or `Badge variant="outline" className="text-success border-success/30"` if you want a green tint via tokens).
- **Currency at the same size as the number.** Pricing numerals are display type — `text-4xl font-bold tracking-tight`. The `/month` period must be smaller and dimmer (`text-sm text-muted-foreground`), aligned with `flex items-baseline gap-1` so the baseline reads as "$15 per month," not "$15 / month."
- **`py-16` instead of `pt-16 pb-16`.** Use physical CSS properties only.
- **JSX comments inside the card body.** No `{/* ... */}` and no `# comment` — both crash the Jac compiler.
- **Bare `True`/`False` lowercase.** Jac uses capitalized `True`/`False`/`None`.
- **Using `+` to merge classNames instead of `cn()`.** Always `cn("base", condition and "extra" or "")`.
- **Raw Tailwind palette anywhere** (`bg-orange-500`, `text-blue-600`). Stay on semantic tokens — `bg-primary`, `text-primary`, `border-primary`, with `/10`, `/30` opacity modifiers for tints.

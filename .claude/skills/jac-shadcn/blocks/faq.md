# FAQ blocks

## When to use

Frequently asked questions section, support pages, dispel objections before signup. FAQs work best near the bottom of marketing pages (above the final CTA), on pricing pages (to handle billing/refund concerns), and on dedicated `/help` or `/support` pages.

## Components used

- `Accordion` + `AccordionItem` + `AccordionTrigger` + `AccordionContent` (default — use `type="single" collapsible`)
- Optional: `Card`, `Tabs` (for categorized FAQ)

---

## Variant 1: Single-column Accordion (default)

### Layout intent

Narrow `max-w-3xl` container so answer lines don't sprawl. Centered section header, then a single `<Accordion type="single" collapsible>` below — only one question open at a time keeps the scan focused. Reach for this unless you have 10+ questions.

### Jac code

```jac
<section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
    <div className="mx-auto max-w-3xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
        <div className="text-center">
            <Badge variant="outline" className="mb-4">FAQ</Badge>
            <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                {"Frequently asked questions"}
            </h2>
            <p className="mt-4 text-lg text-muted-foreground">
                Everything you need to know before getting started.
            </p>
        </div>

        <Accordion type="single" collapsible className="mt-12">
            <AccordionItem value="q1">
                <AccordionTrigger className="text-left text-base font-medium">
                    Is there a free trial?
                </AccordionTrigger>
                <AccordionContent className="text-muted-foreground leading-relaxed">
                    Yes. All paid plans include a 14-day free trial. No credit card required.
                </AccordionContent>
            </AccordionItem>
            <AccordionItem value="q2">
                <AccordionTrigger className="text-left text-base font-medium">
                    Can I cancel anytime?
                </AccordionTrigger>
                <AccordionContent className="text-muted-foreground leading-relaxed">
                    Yes. Cancel from settings. Access continues through the end of the billing period.
                </AccordionContent>
            </AccordionItem>
            <AccordionItem value="q3">
                <AccordionTrigger className="text-left text-base font-medium">
                    Do you offer student discounts?
                </AccordionTrigger>
                <AccordionContent className="text-muted-foreground leading-relaxed">
                    Yes. Students with a valid `.edu` email get 50% off all paid plans.
                </AccordionContent>
            </AccordionItem>
        </Accordion>
    </div>
</section>
```

---

## Variant 2: 2-column Accordion grid

### Layout intent

For longer FAQ lists (8+ questions). Switch container to `max-w-6xl` and split items into two side-by-side `<Accordion type="multiple">` blocks. Each Accordion manages its own state, so split the items list manually. Use `type="multiple"` here — when items are spread horizontally, locking to single-open feels punitive.

### Jac code

```jac
<section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
    <div className="mx-auto max-w-6xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
        <div className="mx-auto max-w-2xl text-center">
            <Badge variant="outline" className="mb-4">FAQ</Badge>
            <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                {"Frequently asked questions"}
            </h2>
            <p className="mt-4 text-lg text-muted-foreground">
                Answers to the questions our customers ask most.
            </p>
        </div>

        <div className="mt-12 grid gap-6 md:grid-cols-2">
            <Accordion type="multiple">
                <AccordionItem value="q1">
                    <AccordionTrigger className="text-left text-base font-medium">
                        How does billing work?
                    </AccordionTrigger>
                    <AccordionContent className="text-muted-foreground leading-relaxed">
                        Monthly or annual. Annual saves two months.
                    </AccordionContent>
                </AccordionItem>
                <AccordionItem value="q2">
                    <AccordionTrigger className="text-left text-base font-medium">
                        Is my data secure?
                    </AccordionTrigger>
                    <AccordionContent className="text-muted-foreground leading-relaxed">
                        Encrypted at rest and in transit. SOC 2 Type II certified.
                    </AccordionContent>
                </AccordionItem>
            </Accordion>

            <Accordion type="multiple">
                <AccordionItem value="q3">
                    <AccordionTrigger className="text-left text-base font-medium">
                        Do you offer refunds?
                    </AccordionTrigger>
                    <AccordionContent className="text-muted-foreground leading-relaxed">
                        Full refund within 30 days, no questions asked.
                    </AccordionContent>
                </AccordionItem>
                <AccordionItem value="q4">
                    <AccordionTrigger className="text-left text-base font-medium">
                        Can I export my data?
                    </AccordionTrigger>
                    <AccordionContent className="text-muted-foreground leading-relaxed">
                        Yes. Export everything as JSON or CSV from settings.
                    </AccordionContent>
                </AccordionItem>
            </Accordion>
        </div>
    </div>
</section>
```

---

## Variant 3: Categorized FAQ with Tabs

### Layout intent

When questions span distinct domains (Billing, Security, Setup), Tabs let users skip to their concern. Centered TabsList capped at `max-w-md`, then a single-collapsible Accordion inside each TabsContent. Same narrow `max-w-3xl` outer container as Variant 1.

### Jac code

```jac
<section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
    <div className="mx-auto max-w-3xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
        <div className="text-center">
            <Badge variant="outline" className="mb-4">FAQ</Badge>
            <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                {"How can we help?"}
            </h2>
            <p className="mt-4 text-lg text-muted-foreground">
                Browse by category to find what you need.
            </p>
        </div>

        <Tabs defaultValue="general" className="mt-12">
            <TabsList className="mx-auto grid w-full max-w-md grid-cols-3">
                <TabsTrigger value="general">General</TabsTrigger>
                <TabsTrigger value="billing">Billing</TabsTrigger>
                <TabsTrigger value="security">Security</TabsTrigger>
            </TabsList>

            <TabsContent value="general" className="mt-8">
                <Accordion type="single" collapsible>
                    <AccordionItem value="g1">
                        <AccordionTrigger className="text-left text-base font-medium">
                            What is this product?
                        </AccordionTrigger>
                        <AccordionContent className="text-muted-foreground leading-relaxed">
                            A web-based IDE for the Jac language with live preview, AI assist, and git built in.
                        </AccordionContent>
                    </AccordionItem>
                </Accordion>
            </TabsContent>

            <TabsContent value="billing" className="mt-8">
                <Accordion type="single" collapsible>
                    <AccordionItem value="b1">
                        <AccordionTrigger className="text-left text-base font-medium">
                            How does billing work?
                        </AccordionTrigger>
                        <AccordionContent className="text-muted-foreground leading-relaxed">
                            Monthly or annual. Annual saves two months. All major cards accepted.
                        </AccordionContent>
                    </AccordionItem>
                </Accordion>
            </TabsContent>

            <TabsContent value="security" className="mt-8">
                <Accordion type="single" collapsible>
                    <AccordionItem value="s1">
                        <AccordionTrigger className="text-left text-base font-medium">
                            Where is my data stored?
                        </AccordionTrigger>
                        <AccordionContent className="text-muted-foreground leading-relaxed">
                            AWS us-east-2. Encrypted at rest with KMS, in transit with TLS 1.3.
                        </AccordionContent>
                    </AccordionItem>
                </Accordion>
            </TabsContent>
        </Tabs>
    </div>
</section>
```

---

## Variant 4: With contact CTA below

### Layout intent

Same single-column Accordion as Variant 1, with a polite escape hatch underneath: an inline link, NOT a Button. A Button under an FAQ feels pushy and competes with the answer text — an underlined inline link is the editorial-feel default.

### Jac code

```jac
<section className="pt-16 pb-16 sm:pt-24 sm:pb-24">
    <div className="mx-auto max-w-3xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
        <div className="text-center">
            <Badge variant="outline" className="mb-4">FAQ</Badge>
            <h2 className="text-balance text-3xl font-bold tracking-tight sm:text-4xl">
                {"Frequently asked questions"}
            </h2>
            <p className="mt-4 text-lg text-muted-foreground">
                Everything you need to know before getting started.
            </p>
        </div>

        <Accordion type="single" collapsible className="mt-12">
            <AccordionItem value="q1">
                <AccordionTrigger className="text-left text-base font-medium">
                    Is there a free trial?
                </AccordionTrigger>
                <AccordionContent className="text-muted-foreground leading-relaxed">
                    Yes. 14 days, no credit card required.
                </AccordionContent>
            </AccordionItem>
            <AccordionItem value="q2">
                <AccordionTrigger className="text-left text-base font-medium">
                    Can I bring my own LLM key?
                </AccordionTrigger>
                <AccordionContent className="text-muted-foreground leading-relaxed">
                    Yes. Add your OpenAI or Anthropic key in settings. We never log key contents.
                </AccordionContent>
            </AccordionItem>
        </Accordion>

        <div className="mt-16 text-center">
            <p className="text-lg text-muted-foreground">
                {"Can't find what you're looking for? "}
                <a href="/contact" className="font-medium text-foreground underline-offset-4 hover:underline">
                    Contact support
                </a>
                .
            </p>
        </div>
    </div>
</section>
```

---

## Common mistakes specific to FAQ blocks

- **Using a wide container (`max-w-7xl`) for FAQ.** Answer lines wrap to 150+ characters and become unreadable. Cap at `max-w-3xl` for single-column; `max-w-6xl` only for the 2-column grid.
- **Accordion `type="multiple"` for short FAQs.** Under ~8 questions, `type="single" collapsible` is cleaner. Multiple-open only earns its weight on long lists.
- **Bold or oversized trigger text** (`text-lg font-bold`). The chevron already provides visual weight — triggers stay at `text-base font-medium`.
- **Default `text-foreground` on AccordionContent.** Answers should be `text-muted-foreground` so the question wins the visual hierarchy.
- **Using a `Button` for "Contact support" instead of an inline link.** A primary Button under an FAQ feels like a sales push. Inline `<a>` styled `font-medium text-foreground underline-offset-4 hover:underline` is the editorial default.
- **Forgetting `collapsible` on `type="single"`.** Without it, the user can't close the currently-open item.
- **Rolling a custom `<details><summary>` instead of Accordion.** You lose Radix's ARIA wiring, animation, and keyboard nav.
- **Wrapping each Q&A in a Card.** Accordion already provides separation via 1px dividers. Cards add noise and waste space.
- **Missing `text-balance` on the section h2.** Headlines look amateur when the last word orphans onto its own line.
- **Forgetting `{"..."}` wrapping around strings with `?` or `'`.** Bare `Frequently asked questions?` or `Can't find what you're looking for?` in JSX breaks the parser. Wrap as `{"..."}`.

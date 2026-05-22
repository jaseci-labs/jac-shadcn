# Footer blocks

## When to use

Bottom of every marketing page — link sections + legal/copyright bar. Use one footer per page, after the final CTA section. Footers are reference architecture: visitors scan them for sitemap-level navigation, legal compliance, and social proof. Keep them dense with links but visually quiet (hairline border, no heavy background) so they don't compete with the page content above.

## Components used

- `Button` (variant `ghost` size `icon` for socials)
- `Separator` (between main content and bottom bar)
- `Input` (newsletter variant only)
- `HugeiconsIcon` (social icons, logo mark)

Imports:

```jac
cl import from ..ui.button { Button }
cl import from ..ui.separator { Separator }
cl import from ..ui.input { Input }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" {
    GithubIcon, TwitterIcon, Linkedin01Icon, YoutubeIcon, CubeIcon
}
cl import from ...lib.utils { cn }
```

## Variant 1: 4-column with logo + bottom bar (default)

### Layout intent

Logo column (wider) anchors the left side with brand mark, tagline, and social icons. Three equal-width link columns to the right group product, company, and resources links. Single hairline `border-t` separates the footer from the page above. After the main grid, a `Separator` and bottom bar carry copyright (left) and legal links (right). On mobile everything stacks; on `lg` the four-column grid kicks in with the logo column at `2fr` and link columns at `1fr` each.

### Jac code

```jac
cl {
    def:pub FooterFourColumn(props: Any) -> JsxElement {
        return <footer className="border-t">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8 pt-16 pb-16">
                <div className="grid gap-8 lg:grid-cols-[2fr_1fr_1fr_1fr]">
                    <div>
                        <div className="flex items-center gap-2">
                            <HugeiconsIcon icon={CubeIcon} strokeWidth={2} className="size-6 text-primary" />
                            <span className="text-base font-semibold">Acme</span>
                        </div>
                        <p className="mt-4 max-w-xs text-sm text-muted-foreground">
                            Ship beautiful UIs without designing from scratch.
                        </p>
                        <div className="mt-6 flex gap-2">
                            <Button variant="ghost" size="icon" aria-label="GitHub">
                                <HugeiconsIcon icon={GithubIcon} strokeWidth={2} className="size-4" />
                            </Button>
                            <Button variant="ghost" size="icon" aria-label="Twitter">
                                <HugeiconsIcon icon={TwitterIcon} strokeWidth={2} className="size-4" />
                            </Button>
                            <Button variant="ghost" size="icon" aria-label="LinkedIn">
                                <HugeiconsIcon icon={Linkedin01Icon} strokeWidth={2} className="size-4" />
                            </Button>
                            <Button variant="ghost" size="icon" aria-label="YouTube">
                                <HugeiconsIcon icon={YoutubeIcon} strokeWidth={2} className="size-4" />
                            </Button>
                        </div>
                    </div>
                    <div>
                        <h3 className="text-sm font-semibold">Product</h3>
                        <ul className="mt-4 flex flex-col gap-3">
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Features</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Pricing</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Changelog</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Roadmap</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 className="text-sm font-semibold">Company</h3>
                        <ul className="mt-4 flex flex-col gap-3">
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">About</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Blog</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Careers</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Contact</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 className="text-sm font-semibold">Resources</h3>
                        <ul className="mt-4 flex flex-col gap-3">
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Docs</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Guides</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Support</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Status</a></li>
                        </ul>
                    </div>
                </div>
                <Separator className="mt-8 mb-8" />
                <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <p className="text-xs text-muted-foreground">
                        {"© 2026 Acme, Inc. All rights reserved."}
                    </p>
                    <div className="flex gap-6">
                        <a href="#" className="text-xs text-muted-foreground transition-colors hover:text-foreground">Privacy</a>
                        <a href="#" className="text-xs text-muted-foreground transition-colors hover:text-foreground">Terms</a>
                        <a href="#" className="text-xs text-muted-foreground transition-colors hover:text-foreground">Cookies</a>
                    </div>
                </div>
            </div>
        </footer>;
    }
}
```

## Variant 2: 3-column compact

### Layout intent

For shorter marketing pages (single product, landing page, microsite). Same shell as Variant 1 — `border-t`, container, separator, bottom bar — but only logo column + two link columns. Grid switches to `md:grid-cols-3` (kicks in earlier than `lg` because we have less to fit). Logo column is no longer disproportionately wide — all three columns share equal weight at `md` and up.

### Jac code

```jac
cl {
    def:pub FooterThreeColumn(props: Any) -> JsxElement {
        return <footer className="border-t">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8 pt-16 pb-16">
                <div className="grid gap-8 md:grid-cols-3">
                    <div>
                        <div className="flex items-center gap-2">
                            <HugeiconsIcon icon={CubeIcon} strokeWidth={2} className="size-6 text-primary" />
                            <span className="text-base font-semibold">Acme</span>
                        </div>
                        <p className="mt-4 max-w-xs text-sm text-muted-foreground">
                            One tool for the whole team.
                        </p>
                        <div className="mt-6 flex gap-2">
                            <Button variant="ghost" size="icon" aria-label="GitHub">
                                <HugeiconsIcon icon={GithubIcon} strokeWidth={2} className="size-4" />
                            </Button>
                            <Button variant="ghost" size="icon" aria-label="Twitter">
                                <HugeiconsIcon icon={TwitterIcon} strokeWidth={2} className="size-4" />
                            </Button>
                        </div>
                    </div>
                    <div>
                        <h3 className="text-sm font-semibold">Product</h3>
                        <ul className="mt-4 flex flex-col gap-3">
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Features</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Pricing</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Docs</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 className="text-sm font-semibold">Company</h3>
                        <ul className="mt-4 flex flex-col gap-3">
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">About</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Blog</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Contact</a></li>
                        </ul>
                    </div>
                </div>
                <Separator className="mt-8 mb-8" />
                <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <p className="text-xs text-muted-foreground">
                        {"© 2026 Acme, Inc."}
                    </p>
                    <div className="flex gap-6">
                        <a href="#" className="text-xs text-muted-foreground transition-colors hover:text-foreground">Privacy</a>
                        <a href="#" className="text-xs text-muted-foreground transition-colors hover:text-foreground">Terms</a>
                    </div>
                </div>
            </div>
        </footer>;
    }
}
```

## Variant 3: With newsletter signup

### Layout intent

Same 4-column shell as Variant 1, but the logo column gets a newsletter form sandwiched between the tagline and the social icons. Form is a stacked `flex flex-col gap-3` on mobile that switches to inline `sm:flex-row` at sm and up, capped at `sm:max-w-md` so the input doesn't sprawl. The handler keeps state via `has email` and a small submit lambda — keep validation light here, the block is a layout reference, not a full integration.

### Jac code

```jac
cl {
    def:pub FooterNewsletter(props: Any) -> JsxElement {
        has email: str = "";
        return <footer className="border-t">
            <div className="mx-auto max-w-7xl pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8 pt-16 pb-16">
                <div className="grid gap-8 lg:grid-cols-[2fr_1fr_1fr_1fr]">
                    <div>
                        <div className="flex items-center gap-2">
                            <HugeiconsIcon icon={CubeIcon} strokeWidth={2} className="size-6 text-primary" />
                            <span className="text-base font-semibold">Acme</span>
                        </div>
                        <p className="mt-4 max-w-xs text-sm text-muted-foreground">
                            Get product updates in your inbox once a month.
                        </p>
                        <form className="mt-6 flex flex-col gap-3 sm:flex-row sm:max-w-md"
                              onSubmit={lambda(e: Any) -> None { e.preventDefault(); email = ""; }}>
                            <Input
                                type="email"
                                placeholder="Enter your email"
                                value={email}
                                onChange={lambda(e: Any) -> None { email = e.target.value; }}
                            />
                            <Button type="submit">Subscribe</Button>
                        </form>
                        <div className="mt-6 flex gap-2">
                            <Button variant="ghost" size="icon" aria-label="GitHub">
                                <HugeiconsIcon icon={GithubIcon} strokeWidth={2} className="size-4" />
                            </Button>
                            <Button variant="ghost" size="icon" aria-label="Twitter">
                                <HugeiconsIcon icon={TwitterIcon} strokeWidth={2} className="size-4" />
                            </Button>
                            <Button variant="ghost" size="icon" aria-label="LinkedIn">
                                <HugeiconsIcon icon={Linkedin01Icon} strokeWidth={2} className="size-4" />
                            </Button>
                        </div>
                    </div>
                    <div>
                        <h3 className="text-sm font-semibold">Product</h3>
                        <ul className="mt-4 flex flex-col gap-3">
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Features</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Pricing</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Changelog</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 className="text-sm font-semibold">Company</h3>
                        <ul className="mt-4 flex flex-col gap-3">
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">About</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Blog</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Careers</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 className="text-sm font-semibold">Resources</h3>
                        <ul className="mt-4 flex flex-col gap-3">
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Docs</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Support</a></li>
                            <li><a href="#" className="text-sm text-muted-foreground transition-colors hover:text-foreground">Status</a></li>
                        </ul>
                    </div>
                </div>
                <Separator className="mt-8 mb-8" />
                <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <p className="text-xs text-muted-foreground">
                        {"© 2026 Acme, Inc. All rights reserved."}
                    </p>
                    <div className="flex gap-6">
                        <a href="#" className="text-xs text-muted-foreground transition-colors hover:text-foreground">Privacy</a>
                        <a href="#" className="text-xs text-muted-foreground transition-colors hover:text-foreground">Terms</a>
                        <a href="#" className="text-xs text-muted-foreground transition-colors hover:text-foreground">Cookies</a>
                    </div>
                </div>
            </div>
        </footer>;
    }
}
```

## Common mistakes specific to footer blocks

- **Uppercase section headers with `tracking-wider`** — `text-xs uppercase tracking-wider` on column heads is a 2018 pattern that reads as dated. Use sentence case with `text-sm font-semibold` instead.
- **Outlined social icon buttons** — `variant="outline"` for socials creates heavy boxes that fight the rest of the footer. Use `variant="ghost" size="icon"` so the buttons read as a quiet row.
- **Heavy background color on the footer** — `bg-muted`, `bg-card`, `bg-secondary` make the footer feel like a separate page. The convention is `border-t` only (a single hairline), letting the footer share `bg-background` with the page.
- **`<hr>` or `<div className="border-t">` as the divider above the bottom bar** — these are markup hacks. Use `<Separator />` (the rules in `composition.md` explicitly call this out).
- **Same text size for copyright and nav links** — copyright + legal must be `text-xs` so they read as legal microtext, not as a third row of nav.
- **Equal-width columns under a logo column** — the logo column carries a paragraph, socials (and maybe a newsletter), so it needs more horizontal room. Use `lg:grid-cols-[2fr_1fr_1fr_1fr]`, never `lg:grid-cols-4`.
- **Missing `transition-colors` on link hover** — without the transition, hover snaps and feels cheap. Always pair `hover:text-foreground` with `transition-colors`.
- **Forgetting `text-foreground` on hover** — leaving the hover state at the same `text-muted-foreground` makes links look broken. The hover must brighten the text.
- **JSX comments inside the footer markup** — neither `{/* */}` nor `# comment` is valid inside JSX returns; the Jac compiler errors out. Move any commentary to a `#` line above the `return`.
- **Using `©` directly in JSX text** — wrap special characters: `{"© 2026 Acme, Inc."}`. Same rule as `?` and `&` from the global Jac patterns.
- **`py-16` instead of `pt-16 pb-16`** — physical CSS only. Logical/shorthand utilities are banned by the styling rules.

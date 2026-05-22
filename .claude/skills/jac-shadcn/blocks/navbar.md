# Navbar / Header blocks

## When to use

Top of every marketing page — primary navigation, brand mark, primary CTA pair. Sticks to the viewport top so it stays visible while users scroll. App nav (post-auth dashboards, IDEs) uses `Sidebar` instead — see `blocks/dashboard.md`.

## Components used

- `NavigationMenu` + `NavigationMenuList` + `NavigationMenuItem` + `NavigationMenuLink` + `NavigationMenuTrigger` + `NavigationMenuContent`
- `Sheet` + `SheetTrigger` + `SheetContent` + `SheetTitle` (mobile menu drawer)
- `Button` (CTA pair + mobile menu trigger)
- `Input` (Variant 4, inline search)
- `HugeiconsIcon` (`Menu01Icon` for mobile, brand logo)

---

## Variant 1: Simple sticky header (default)

### Layout intent

Logo on the left, desktop nav links in the center-left, CTA pair (`Sign in` ghost + `Get started` default) on the right. Sticky at top with a hairline border below and frosted-glass semi-transparent background. Mobile collapses everything into a `Sheet` drawer triggered by a hamburger button.

### Jac code

```jac
cl import from ..ui.button { Button }
cl import from ..ui.sheet { Sheet, SheetTrigger, SheetContent, SheetTitle }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { Menu01Icon, Rocket01Icon }
cl import from ...lib.utils { cn }

cl {
    def:pub SiteHeader(props: Any) -> JsxElement {
        has mobileOpen: bool = False;
        return <header className="sticky top-0 z-40 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
            <div className="mx-auto max-w-7xl flex h-16 items-center justify-between pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <a href="/" className="flex items-center gap-2 font-semibold">
                    <HugeiconsIcon icon={Rocket01Icon} strokeWidth={2} className="size-5 text-primary" />
                    <span>Acme</span>
                </a>
                <nav className="hidden lg:flex lg:items-center lg:gap-6">
                    <a href="/features" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">Features</a>
                    <a href="/pricing" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">Pricing</a>
                    <a href="/docs" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">Docs</a>
                    <a href="/blog" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">Blog</a>
                </nav>
                <div className="flex items-center gap-2">
                    <Button variant="ghost" size="sm" className="hidden lg:inline-flex">Sign in</Button>
                    <Button size="sm" className="hidden lg:inline-flex">Get started</Button>
                    <Sheet open={mobileOpen} onOpenChange={lambda(v: bool) -> None { mobileOpen = v; }}>
                        <SheetTrigger asChild={True}>
                            <Button variant="ghost" size="icon" className="lg:hidden">
                                <HugeiconsIcon icon={Menu01Icon} strokeWidth={2} className="size-5" />
                            </Button>
                        </SheetTrigger>
                        <SheetContent side="right" className="w-72">
                            <SheetTitle className="sr-only">Navigation</SheetTitle>
                            <nav className="flex flex-col gap-4 pt-8">
                                <a href="/features" className="text-base font-medium text-foreground">Features</a>
                                <a href="/pricing" className="text-base font-medium text-foreground">Pricing</a>
                                <a href="/docs" className="text-base font-medium text-foreground">Docs</a>
                                <a href="/blog" className="text-base font-medium text-foreground">Blog</a>
                                <Button variant="outline" className="mt-4">Sign in</Button>
                                <Button>Get started</Button>
                            </nav>
                        </SheetContent>
                    </Sheet>
                </div>
            </div>
        </header>;
    }
}
```

---

## Variant 2: With dropdown mega-menu

### Layout intent

Replace the plain `<nav>` with a `NavigationMenu`. The "Products" item opens a 2-column grid of feature link cards on hover. Other items remain as flat links. Same outer shell, sticky behavior, and mobile fallback as Variant 1.

### Jac code

```jac
cl import from ..ui.navigation-menu {
    NavigationMenu, NavigationMenuList, NavigationMenuItem,
    NavigationMenuTrigger, NavigationMenuContent, NavigationMenuLink
}

cl {
    def:pub SiteHeaderWithMegaMenu(props: Any) -> JsxElement {
        return <header className="sticky top-0 z-40 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
            <div className="mx-auto max-w-7xl flex h-16 items-center justify-between pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <a href="/" className="flex items-center gap-2 font-semibold">
                    <HugeiconsIcon icon={Rocket01Icon} strokeWidth={2} className="size-5 text-primary" />
                    <span>Acme</span>
                </a>
                <NavigationMenu className="hidden lg:flex">
                    <NavigationMenuList>
                        <NavigationMenuItem>
                            <NavigationMenuTrigger>Products</NavigationMenuTrigger>
                            <NavigationMenuContent>
                                <ul className="grid gap-3 pt-4 pb-4 pl-4 pr-4 md:w-[400px] md:grid-cols-2">
                                    <li>
                                        <NavigationMenuLink href="/products/editor" className="block rounded-md pt-3 pb-3 pl-3 pr-3 hover:bg-accent">
                                            <div className="text-sm font-medium">Editor</div>
                                            <p className="text-xs text-muted-foreground">Rich code editing surface.</p>
                                        </NavigationMenuLink>
                                    </li>
                                    <li>
                                        <NavigationMenuLink href="/products/agent" className="block rounded-md pt-3 pb-3 pl-3 pr-3 hover:bg-accent">
                                            <div className="text-sm font-medium">Agent</div>
                                            <p className="text-xs text-muted-foreground">Autonomous coding workflows.</p>
                                        </NavigationMenuLink>
                                    </li>
                                </ul>
                            </NavigationMenuContent>
                        </NavigationMenuItem>
                        <NavigationMenuItem>
                            <NavigationMenuLink href="/pricing" className="text-sm font-medium text-muted-foreground hover:text-foreground">Pricing</NavigationMenuLink>
                        </NavigationMenuItem>
                        <NavigationMenuItem>
                            <NavigationMenuLink href="/docs" className="text-sm font-medium text-muted-foreground hover:text-foreground">Docs</NavigationMenuLink>
                        </NavigationMenuItem>
                    </NavigationMenuList>
                </NavigationMenu>
                <div className="flex items-center gap-2">
                    <Button variant="ghost" size="sm" className="hidden lg:inline-flex">Sign in</Button>
                    <Button size="sm" className="hidden lg:inline-flex">Get started</Button>
                </div>
            </div>
        </header>;
    }
}
```

---

## Variant 3: Centered nav (logo center, links flanking)

### Layout intent

A 3-column grid: nav links on the left, logo dead center, CTA on the right. Less common but distinctive — fits portfolio sites, agencies, and editorial brands. Use sparingly; the asymmetry makes scannability worse than Variant 1.

### Jac code

```jac
cl {
    def:pub SiteHeaderCentered(props: Any) -> JsxElement {
        return <header className="sticky top-0 z-40 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
            <div className="mx-auto max-w-7xl grid grid-cols-3 h-16 items-center pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <nav className="hidden lg:flex lg:items-center lg:gap-6">
                    <a href="/work" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">Work</a>
                    <a href="/studio" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">Studio</a>
                    <a href="/journal" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">Journal</a>
                </nav>
                <a href="/" className="flex items-center justify-center gap-2 font-semibold">
                    <HugeiconsIcon icon={Rocket01Icon} strokeWidth={2} className="size-5 text-primary" />
                    <span>Acme</span>
                </a>
                <div className="flex items-center justify-end gap-2">
                    <Button variant="ghost" size="sm" className="hidden lg:inline-flex">Contact</Button>
                    <Button size="sm">Hire us</Button>
                </div>
            </div>
        </header>;
    }
}
```

---

## Variant 4: With search input inline

### Layout intent

Same skeleton as Variant 1, with an `Input` placed between the nav links and the CTA pair on `md+`. Useful for docs sites and content-heavy products. The search collapses on mobile to keep the bar at `h-16`.

### Jac code

```jac
cl import from ..ui.input { Input }

cl {
    def:pub SiteHeaderWithSearch(props: Any) -> JsxElement {
        return <header className="sticky top-0 z-40 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
            <div className="mx-auto max-w-7xl flex h-16 items-center justify-between pl-4 pr-4 sm:pl-6 sm:pr-6 lg:pl-8 lg:pr-8">
                <a href="/" className="flex items-center gap-2 font-semibold">
                    <HugeiconsIcon icon={Rocket01Icon} strokeWidth={2} className="size-5 text-primary" />
                    <span>Acme</span>
                </a>
                <nav className="hidden lg:flex lg:items-center lg:gap-6">
                    <a href="/docs" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">Docs</a>
                    <a href="/api" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">API</a>
                    <a href="/changelog" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">Changelog</a>
                </nav>
                <div className="hidden md:flex md:flex-1 md:max-w-sm md:mx-8">
                    <Input placeholder="Search docs..." className="h-9" />
                </div>
                <div className="flex items-center gap-2">
                    <Button variant="ghost" size="sm" className="hidden lg:inline-flex">Sign in</Button>
                    <Button size="sm">Get started</Button>
                </div>
            </div>
        </header>;
    }
}
```

---

## Common mistakes specific to navbar blocks

- **`h-20` / `h-24` header.** Eats real estate on small viewports. Use `h-16` — every modern marketing site lands here.
- **Solid `bg-card` instead of frosted glass.** Looks dated. Use `bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60`.
- **`position: fixed` instead of `sticky top-0`.** `fixed` requires a body offset and breaks anchor scrolling. `sticky` reflows correctly.
- **Missing `z-40`.** Header gets covered by hero gradients, mockup shadows, or modals. Always set the stacking context.
- **Heavy `shadow-md` or `shadow-lg` under the header.** Use a `border-b` hairline. Shadows belong on cards, not chrome.
- **Dialog or custom drawer for mobile menu.** Use `Sheet` — it has the correct slide-in animation and accessibility wiring.
- **Mobile and desktop nav both visible.** Always pair `hidden lg:flex` (desktop nav) with `lg:hidden` (mobile trigger). Forgetting either shows both.
- **Missing `SheetTitle`.** Sheets require a title for accessibility — wrap in `<SheetTitle className="sr-only">Navigation</SheetTitle>` if visually hidden (see `composition.md`).
- **Bold heavy nav links.** Should be `text-sm font-medium text-muted-foreground hover:text-foreground` — quiet by default, brighten on hover.
- **No `transition-colors` on hover.** Causes a jarring color flash. Add `transition-colors` to every nav link.
- **Single CTA on the right.** A `Sign in` (ghost) + `Get started` (default) pair is the standard. Single CTAs read as cramped.
- **Switch component for theme toggle.** Switches imply a binary preference state — use a `Button variant="ghost" size="icon"` with a sun/moon icon instead.
- **Hardcoded colors (`bg-white`, `text-gray-900`).** Always use semantic tokens — see `rules/blocks.md` color discipline.
- **JSX comments inside the header.** `{/* ... */}` and `# ...` both break the Jac compiler — see `rules/jac-patterns.md`.
- **`new` instead of `Reflect.construct`.** If you wire up scroll listeners (`new IntersectionObserver(...)`), use `Reflect.construct(IntersectionObserver, [cb])`.
- **Lowercase `True` / `False` / `None`.** `has mobileOpen: bool = false;` will not compile — use capitalized `False`.

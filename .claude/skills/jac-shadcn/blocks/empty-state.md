# Empty state blocks

## When to use

- List/grid views that have loaded successfully but contain zero items.
- Search or filter results that returned nothing for the current query.
- First-run experiences (new project, new workspace, new account) where the user has not yet created data.
- Error states for failed network requests, unauthorized access, or missing permissions.

Empty states are not the same as loading states (use `Skeleton`) or error toasts (use `notify()`). Reach for `Empty` whenever the surface would otherwise show nothing meaningful.

## Components used

- `Empty` + `EmptyHeader` + `EmptyMedia` + `EmptyTitle` + `EmptyDescription` + `EmptyContent`
- `Button` (primary action) + optional secondary
- `HugeiconsIcon` (the empty-state icon)
- `Card` + `CardContent` (only when embedding the empty state inside an existing card or table surface)

The `Empty` composition handles centering, vertical padding, icon framing, and typography. Do not re-implement these with raw `<div>` markup.

---

## Variant 1: Simple icon-led empty state (default)

### Layout intent

Centered icon in a muted ring, short title, one-line description, single primary CTA. Use this for first-run experiences where the user has not created any data yet.

### Jac code

```jac
cl import from ...ui.empty { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription, EmptyContent }
cl import from ...ui.button { Button }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { FolderIcon, PlusSignIcon }

cl {
    def:pub ProjectsEmpty(props: Any) -> JsxElement {
        onCreate = props.onCreate;
        return <div className="flex min-h-[400px] items-center justify-center">
            <Empty>
                <EmptyHeader>
                    <EmptyMedia variant="icon">
                        <HugeiconsIcon icon={FolderIcon} strokeWidth={2} />
                    </EmptyMedia>
                    <EmptyTitle>No projects yet</EmptyTitle>
                    <EmptyDescription>
                        Get started by creating your first project.
                    </EmptyDescription>
                </EmptyHeader>
                <EmptyContent>
                    <Button onClick={onCreate}>
                        <HugeiconsIcon icon={PlusSignIcon} strokeWidth={2} className="size-4" />
                        Create project
                    </Button>
                </EmptyContent>
            </Empty>
        </div>;
    }
}
```

---

## Variant 2: With illustration

### Layout intent

Larger custom illustration (or a prominent icon) replaces the small framed icon. Use when the empty state owns the entire viewport (a full-page route) and you want the surface to feel more crafted than a single utility icon.

### Jac code

```jac
cl import from ...ui.empty { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription, EmptyContent }
cl import from ...ui.button { Button }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { CubeIcon, ArrowRight02Icon }

cl {
    def:pub WorkspaceEmpty(props: Any) -> JsxElement {
        onStart = props.onStart;
        return <div className="flex min-h-[480px] items-center justify-center">
            <Empty>
                <EmptyHeader>
                    <EmptyMedia>
                        <div className="flex size-32 items-center justify-center rounded-full bg-muted">
                            <HugeiconsIcon icon={CubeIcon} strokeWidth={2} className="size-12 text-muted-foreground" />
                        </div>
                    </EmptyMedia>
                    <EmptyTitle>Your workspace is empty</EmptyTitle>
                    <EmptyDescription>
                        Spin up a starter template to see how walkers, nodes, and the IDE fit together.
                    </EmptyDescription>
                </EmptyHeader>
                <EmptyContent>
                    <Button onClick={onStart}>
                        Browse templates
                        <HugeiconsIcon icon={ArrowRight02Icon} strokeWidth={2} className="size-4" />
                    </Button>
                </EmptyContent>
            </Empty>
        </div>;
    }
}
```

A `<img src="/illustrations/empty-workspace.svg" className="size-32" alt="" />` can replace the muted ring when a real illustration asset is available.

---

## Variant 3: Search "no results"

### Layout intent

Same `Empty` composition, but the description echoes the search term back to the user so they understand what was searched. The CTA clears the filter rather than creating new data.

### Jac code

```jac
cl import from ...ui.empty { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription, EmptyContent }
cl import from ...ui.button { Button }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { Search01Icon }

cl {
    def:pub SearchEmpty(props: Any) -> JsxElement {
        searchTerm = props.searchTerm or "";
        clearSearch = props.onClear;
        return <div className="flex min-h-[320px] items-center justify-center">
            <Empty>
                <EmptyHeader>
                    <EmptyMedia variant="icon">
                        <HugeiconsIcon icon={Search01Icon} strokeWidth={2} />
                    </EmptyMedia>
                    <EmptyTitle>No results found</EmptyTitle>
                    <EmptyDescription>
                        {"We couldn't find anything matching "}
                        <span className="font-medium text-foreground">{searchTerm}</span>
                        {". Try a different search term."}
                    </EmptyDescription>
                </EmptyHeader>
                <EmptyContent>
                    <Button variant="outline" onClick={clearSearch}>
                        Clear search
                    </Button>
                </EmptyContent>
            </Empty>
        </div>;
    }
}
```

---

## Variant 4: Error state (network failure / unauthorized)

### Layout intent

Same composition, but the icon is tinted with `text-destructive` to signal failure. Two CTAs: primary `Retry` and a secondary escape hatch (contact support, sign in, go home). Keep the description neutral and actionable, never panicked.

### Jac code

```jac
cl import from ...ui.empty { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription, EmptyContent }
cl import from ...ui.button { Button }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { Alert02Icon, RefreshIcon }

cl {
    def:pub ProjectsErrorEmpty(props: Any) -> JsxElement {
        retry = props.onRetry;
        return <div className="flex min-h-[400px] items-center justify-center">
            <Empty>
                <EmptyHeader>
                    <EmptyMedia variant="icon">
                        <HugeiconsIcon icon={Alert02Icon} strokeWidth={2} className="text-destructive" />
                    </EmptyMedia>
                    <EmptyTitle>Something went wrong</EmptyTitle>
                    <EmptyDescription>
                        {"We couldn't load your projects. Check your connection and try again."}
                    </EmptyDescription>
                </EmptyHeader>
                <EmptyContent>
                    <div className="flex flex-wrap items-center justify-center gap-3">
                        <Button onClick={retry}>
                            <HugeiconsIcon icon={RefreshIcon} strokeWidth={2} className="size-4" />
                            Retry
                        </Button>
                        <Button variant="ghost" asChild={True}>
                            <a href="/support">Contact support</a>
                        </Button>
                    </div>
                </EmptyContent>
            </Empty>
        </div>;
    }
}
```

---

## Embedded inside a Card

When the empty state replaces the body of an existing `Card` (a dashboard widget, a table, a settings panel), drop the page-level `min-h-[...]` wrapper and rely on `CardContent` padding instead. The card already provides chrome; do not nest two surfaces.

```jac
<Card>
    <CardHeader>
        <CardTitle>Recent activity</CardTitle>
        <CardDescription>The last 30 days of project events.</CardDescription>
    </CardHeader>
    <CardContent className="pt-12 pb-12">
        <Empty>
            <EmptyHeader>
                <EmptyMedia variant="icon">
                    <HugeiconsIcon icon={ClockIcon} strokeWidth={2} />
                </EmptyMedia>
                <EmptyTitle>No activity yet</EmptyTitle>
                <EmptyDescription>Events will appear here once you start a preview.</EmptyDescription>
            </EmptyHeader>
        </Empty>
    </CardContent>
</Card>
```

`CardContent` defaults to `p-6` — bump vertical padding to `pt-12 pb-12` so the empty state has room to breathe. If the page already uses card-style chrome elsewhere, render `Empty` directly without another `Card` wrapper.

---

## Common mistakes specific to empty-state blocks

- **Reaching for raw `<div>` instead of `Empty`.** You will re-implement centering, padding, and the muted icon ring incorrectly. Always compose with `Empty` + `EmptyHeader` + `EmptyMedia` + `EmptyTitle` + `EmptyDescription` + `EmptyContent`.
- **"Oops!" or exclamation marks in `EmptyTitle`.** Sounds amateur. Use a calm, sentence-case statement: `No projects yet`, `No results found`, `Something went wrong`.
- **Five buttons in `EmptyContent`.** One primary CTA, optionally one secondary. More than two and the user has nothing to anchor on.
- **Sizing the icon manually.** `EmptyMedia variant="icon"` already handles the size and the muted ring. Do not pass `className="size-16"` to the inner `HugeiconsIcon` — let the variant do its job.
- **Hardcoding error colors.** `text-red-500` is wrong. Use `text-destructive` (and its `/10`, `/30` opacity variants for tints).
- **Embedding `Empty` in a card with no vertical room.** A `CardContent` at default `p-6` crushes the composition. Use `pt-12 pb-12` minimum on the wrapper or skip the `Card` entirely.
- **Skipping `EmptyDescription`.** A title alone leaves the user guessing what to do. The description carries the recovery action.
- **Generic "No data" copy.** Be specific: `No projects yet`, `No commits on this branch`, `No deployments in the last 30 days`. Specificity is the difference between a placeholder and a real product.
- **CTA button without an icon.** A leading `HugeiconsIcon` at `size-4` aids recognition and makes the button feel intentional. Pair create actions with `PlusSignIcon`, retry with `RefreshIcon`, navigation with `ArrowRight02Icon`.
- **Forgetting the page-level `min-h-[...]` wrapper.** Without it, page-level empty states sit flush at the top of the route and feel like a layout bug. Use `<div className="flex min-h-[400px] items-center justify-center">` for full-route emptiness.
- **Search empty state without the search term.** If the user typed `walker`, the description should echo `walker` back. Otherwise they wonder if the search even ran.
- **JSX comments or apostrophes that break the parser.** No `{/* ... */}` blocks. Wrap any string with an apostrophe in braces: `{"We couldn't find anything"}`.

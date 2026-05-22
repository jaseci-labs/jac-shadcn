# Dashboard blocks

> **First, check `examples/` for the official shadcn registry blocks.** `examples/dashboard-01/` and `examples/sidebar-07/` are direct conversions of the canonical app-shell blocks from the shadcn/ui v4 registry — fully working, no hallucinated patterns. Use those as the reference implementation. The variants below describe lighter alternatives for cases where the registry block is too heavy.

## When to use

App-shell pages, admin panels, analytics dashboards, internal tools, settings hubs — anything inside an authenticated product surface. Dashboard blocks are dense, action-oriented, and persistent (the user lives here).

**NOT for marketing pages.** Marketing uses generous vertical rhythm (`pt-24 pb-24`), centered narrow content, and large display headlines. Dashboards use tighter rhythm (`pt-6 pb-6`), full-width content, and a fixed shell. Mixing the two patterns produces output that feels neither marketing nor app — just lost.

## ⚠ jac-shadcn `Sidebar*` className spread bug

`jac-shadcn`'s Sidebar primitives have a known bug where `{...props}` is spread *after* the computed `className`, so any `className` you pass overrides the base styles (including `absolute top-1.5 right-1` on `SidebarMenuAction`, `flex w-full` on `SidebarMenuButton`, etc.). **Do not pass `className` to any `Sidebar*` component.** Use a wrapping `<div>` for layout overrides, or a regular `<Button>` instead of `<SidebarMenuButton>` when you need cva variants the sidebar one doesn't expose.

## Components used

- `SidebarProvider` + `Sidebar` + `SidebarContent` + `SidebarHeader` + `SidebarFooter` + `SidebarMenu` + `SidebarMenuItem` + `SidebarMenuButton` + `SidebarTrigger` + `SidebarInset` (the app shell)
- `Card` + `CardHeader` + `CardTitle` + `CardDescription` + `CardContent` (stat and chart cards)
- `Badge` (percentage deltas, status pills); `Skeleton` (loading state)
- `Chart` / `ChartContainer` / `ChartTooltip` (Recharts wrapper); `Tabs` (period selectors on chart cards)
- `Table` + `TableHeader` + `TableBody` + `TableRow` + `TableHead` + `TableCell` (data tables)
- `Separator` + `Breadcrumb` family (header dividers and trail)
- `DropdownMenu` + `Avatar` + `AvatarImage` + `AvatarFallback` (user menu in sidebar footer)
- `HugeiconsIcon` (sidebar nav icons, stat card icons, table actions)

---

## Variant 1: Sidebar shell + stat cards + chart (default app dashboard)

### Layout intent

The canonical app shell. Fixed sidebar on the left (collapsible), top bar with sidebar trigger + breadcrumb + actions, main content scrolls. Inside the main area: a 4-column stat grid, then a 3-column row where the primary chart spans 2 columns and a secondary widget takes 1.

### Jac code

```jac
cl import from ...lib.utils { cn }
cl import from ..ui.sidebar { SidebarProvider, Sidebar, SidebarContent, SidebarHeader, SidebarFooter, SidebarMenu, SidebarMenuItem, SidebarMenuButton, SidebarTrigger, SidebarInset, SidebarGroup, SidebarGroupLabel }
cl import from ..ui.card { Card, CardHeader, CardTitle, CardDescription, CardContent }
cl import from ..ui.badge { Badge }
cl import from ..ui.separator { Separator }
cl import from ..ui.breadcrumb { Breadcrumb, BreadcrumbList, BreadcrumbItem, BreadcrumbLink, BreadcrumbPage, BreadcrumbSeparator }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { DashboardSquare01Icon, ChartLineData01Icon, UserGroupIcon, ArrowUpRight01Icon, ArrowDownRight01Icon }

cl {
    def:pub DashboardShell(props: Any) -> JsxElement {
        has activeRoute: str = props.activeRoute or "overview";

        navItems = [
            {"id": "overview", "label": "Overview", "icon": DashboardSquare01Icon},
            {"id": "analytics", "label": "Analytics", "icon": ChartLineData01Icon},
            {"id": "customers", "label": "Customers", "icon": UserGroupIcon}
        ];

        return <SidebarProvider>
            <Sidebar>
                <SidebarHeader>
                    <div className="flex items-center gap-2 pl-2 pr-2 pt-2">
                        <div className="flex size-8 items-center justify-center rounded-md bg-primary text-primary-foreground">
                            <HugeiconsIcon icon={DashboardSquare01Icon} strokeWidth={2} className="size-4" />
                        </div>
                        <span className="text-sm font-semibold">Acme Inc</span>
                    </div>
                </SidebarHeader>
                <SidebarContent>
                    <SidebarGroup>
                        <SidebarGroupLabel>Platform</SidebarGroupLabel>
                        <SidebarMenu>
                            {navItems.map(lambda(item: Any) -> Any {
                                isActive = item.id == activeRoute;
                                return <SidebarMenuItem key={item.id}>
                                    <SidebarMenuButton asChild={True} isActive={isActive}>
                                        <a href={"#" + item.id}>
                                            <HugeiconsIcon icon={item.icon} strokeWidth={2} className="size-4" />
                                            <span>{item.label}</span>
                                        </a>
                                    </SidebarMenuButton>
                                </SidebarMenuItem>;
                            })}
                        </SidebarMenu>
                    </SidebarGroup>
                </SidebarContent>
                <SidebarFooter>
                    <div className="flex items-center gap-2 pl-2 pr-2 pb-2">
                        <div className="flex size-8 items-center justify-center rounded-full bg-muted text-xs font-medium">JD</div>
                        <span className="text-sm font-medium">Jane Doe</span>
                    </div>
                </SidebarFooter>
            </Sidebar>
            <SidebarInset>
                <header className="flex h-14 items-center gap-2 border-b pl-4 pr-4">
                    <SidebarTrigger />
                    <Separator orientation="vertical" className="mr-2 h-4" />
                    <Breadcrumb>
                        <BreadcrumbList>
                            <BreadcrumbItem>
                                <BreadcrumbLink href="#">Dashboard</BreadcrumbLink>
                            </BreadcrumbItem>
                            <BreadcrumbSeparator />
                            <BreadcrumbItem>
                                <BreadcrumbPage>Overview</BreadcrumbPage>
                            </BreadcrumbItem>
                        </BreadcrumbList>
                    </Breadcrumb>
                </header>
                <main className="flex flex-1 flex-col gap-6 pt-6 pb-6 pl-6 pr-6">
                    <div className="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-4">
                        {props.stats.map(lambda(s: Any) -> Any {
                            isUp = s.trend == "up";
                            arrow = isUp and ArrowUpRight01Icon or ArrowDownRight01Icon;
                            return <Card key={s.label}>
                                <CardHeader>
                                    <CardDescription>{s.label}</CardDescription>
                                    <CardTitle className="text-3xl font-semibold tabular-nums">{s.value}</CardTitle>
                                    <Badge variant="outline" className="mt-2">
                                        <HugeiconsIcon icon={arrow} strokeWidth={2} className="size-3" />
                                        <span className="tabular-nums">{s.change}</span>
                                    </Badge>
                                </CardHeader>
                                <CardContent>
                                    <div className="text-sm text-muted-foreground">{s.caption}</div>
                                </CardContent>
                            </Card>;
                        })}
                    </div>
                    <div className="grid grid-cols-1 gap-4 lg:grid-cols-3">
                        <Card className="lg:col-span-2">
                            <CardHeader>
                                <CardTitle>Total Visitors</CardTitle>
                                <CardDescription>Last 3 months</CardDescription>
                            </CardHeader>
                            <CardContent>
                                {props.chart}
                            </CardContent>
                        </Card>
                        <Card>
                            <CardHeader>
                                <CardTitle>Recent Activity</CardTitle>
                                <CardDescription>Latest events from your team</CardDescription>
                            </CardHeader>
                            <CardContent>
                                {props.activity}
                            </CardContent>
                        </Card>
                    </div>
                </main>
            </SidebarInset>
        </SidebarProvider>;
    }
}
```

---

## Variant 2: Stats grid only (4 cards in a row)

### Layout intent

A standalone stats strip that drops into any existing layout. No shell, no chart — four `Card`s in a responsive grid (1/2/4 cols across mobile/tablet/desktop). Use inside an existing `SidebarInset` main area or above a table view.

### Jac code

```jac
cl import from ..ui.card { Card, CardHeader, CardTitle, CardDescription, CardContent }
cl import from ..ui.badge { Badge }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowUpRight01Icon, ArrowDownRight01Icon, DollarCircleIcon, ChartLineData01Icon }

cl {
    def:pub StatsGrid(props: Any) -> JsxElement {
        stats = props.stats or [
            {"label": "Total Revenue", "value": "$45,231.89", "change": "+20.1%", "trend": "up", "icon": DollarCircleIcon},
            {"label": "Active Now", "value": "+573", "change": "-2.4%", "trend": "down", "icon": ChartLineData01Icon}
        ];

        return <div className="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-4">
            {stats.map(lambda(stat: Any) -> Any {
                isUp = stat.trend == "up";
                arrowIcon = isUp and ArrowUpRight01Icon or ArrowDownRight01Icon;
                return <Card key={stat.label}>
                    <CardHeader>
                        <div className="flex items-center justify-between">
                            <CardDescription>{stat.label}</CardDescription>
                            <HugeiconsIcon icon={stat.icon} strokeWidth={2} className="size-4 text-muted-foreground" />
                        </div>
                        <CardTitle className="text-3xl font-semibold tabular-nums">{stat.value}</CardTitle>
                        <Badge variant="outline" className="mt-2">
                            <HugeiconsIcon icon={arrowIcon} strokeWidth={2} className="size-3" />
                            <span className="tabular-nums">{stat.change}</span>
                        </Badge>
                    </CardHeader>
                    <CardContent>
                        <div className="text-sm text-muted-foreground">vs previous period</div>
                    </CardContent>
                </Card>;
            })}
        </div>;
    }
}
```

---

## Variant 3: Sidebar + table view

### Layout intent

The "list of records" shell — same outer skeleton as Variant 1, but the main area is a single `Card` containing a `Table`. Used for users, orders, transactions, projects — any time the dashboard is mostly tabular data. Keep the header, breadcrumb, and main padding identical to Variant 1.

### Jac code

```jac
cl import from ...lib.utils { cn }
cl import from ..ui.sidebar { SidebarProvider, Sidebar, SidebarContent, SidebarHeader, SidebarMenu, SidebarMenuItem, SidebarMenuButton, SidebarTrigger, SidebarInset }
cl import from ..ui.card { Card, CardHeader, CardTitle, CardDescription, CardContent }
cl import from ..ui.table { Table, TableHeader, TableBody, TableRow, TableHead, TableCell }
cl import from ..ui.badge { Badge }
cl import from ..ui.separator { Separator }
cl import from ..ui.button { Button, buttonVariants }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { UserGroupIcon, MoreHorizontalIcon, Add01Icon }

cl {
    def:pub CustomersTablePage(props: Any) -> JsxElement {
        rows = props.rows or [];

        return <SidebarProvider>
            <Sidebar>
                <SidebarHeader>
                    <div className="pl-2 pr-2 pt-2 text-sm font-semibold">Acme Inc</div>
                </SidebarHeader>
                <SidebarContent>
                    <SidebarMenu>
                        <SidebarMenuItem>
                            <SidebarMenuButton isActive={True}>
                                <HugeiconsIcon icon={UserGroupIcon} strokeWidth={2} className="size-4" />
                                <span>Customers</span>
                            </SidebarMenuButton>
                        </SidebarMenuItem>
                    </SidebarMenu>
                </SidebarContent>
            </Sidebar>
            <SidebarInset>
                <header className="flex h-14 items-center gap-2 border-b pl-4 pr-4">
                    <SidebarTrigger />
                    <Separator orientation="vertical" className="mr-2 h-4" />
                    <span className="text-sm font-medium">Customers</span>
                    <div className="flex-1" />
                    <Button size="sm">
                        <HugeiconsIcon icon={Add01Icon} strokeWidth={2} className="size-4" />
                        Add customer
                    </Button>
                </header>
                <main className="flex flex-1 flex-col gap-6 pt-6 pb-6 pl-6 pr-6">
                    <Card>
                        <CardHeader>
                            <CardTitle>Customers</CardTitle>
                            <CardDescription>Manage your customer accounts and their subscription status.</CardDescription>
                        </CardHeader>
                        <CardContent>
                            <Table>
                                <TableHeader>
                                    <TableRow>
                                        <TableHead>Name</TableHead>
                                        <TableHead>Email</TableHead>
                                        <TableHead>Status</TableHead>
                                        <TableHead className="text-right">Amount</TableHead>
                                        <TableHead className="w-12" />
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {rows.map(lambda(row: Any) -> Any {
                                        statusVariant = row.status == "active" and "secondary" or "outline";
                                        return <TableRow key={row.id}>
                                            <TableCell className="font-medium">{row.name}</TableCell>
                                            <TableCell className="text-muted-foreground">{row.email}</TableCell>
                                            <TableCell>
                                                <Badge variant={statusVariant}>{row.status}</Badge>
                                            </TableCell>
                                            <TableCell className="text-right tabular-nums">{row.amount}</TableCell>
                                            <TableCell>
                                                <Button variant="ghost" size="icon-sm">
                                                    <HugeiconsIcon icon={MoreHorizontalIcon} strokeWidth={2} className="size-4" />
                                                </Button>
                                            </TableCell>
                                        </TableRow>;
                                    })}
                                </TableBody>
                            </Table>
                        </CardContent>
                    </Card>
                </main>
            </SidebarInset>
        </SidebarProvider>;
    }
}
```

---

## Variant 4: Header-driven dashboard (no sidebar)

### Layout intent

For embedded dashboards (iframe widgets, analytics inside another product), simple apps with 1-2 routes, or single-purpose tools. Top nav holds branding + primary nav links + user menu. Main content is centered in a `max-w-7xl` container — this is the **only** dashboard variant that uses `max-w-7xl`, because there is no sidebar to constrain width.

### Jac code

```jac
cl import from ...lib.utils { cn }
cl import from ..ui.card { Card, CardHeader, CardTitle, CardDescription, CardContent }
cl import from ..ui.badge { Badge }
cl import from ..ui.button { Button }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { DashboardSquare01Icon, ArrowUpRight01Icon, Notification01Icon }

cl {
    def:pub HeaderDashboard(props: Any) -> JsxElement {
        return <div className="flex min-h-screen flex-col bg-background">
            <header className="border-b">
                <div className="mx-auto flex h-14 max-w-7xl items-center pl-4 pr-4">
                    <div className="flex items-center gap-2">
                        <div className="flex size-7 items-center justify-center rounded-md bg-primary text-primary-foreground">
                            <HugeiconsIcon icon={DashboardSquare01Icon} strokeWidth={2} className="size-4" />
                        </div>
                        <span className="text-sm font-semibold">Acme</span>
                    </div>
                    <nav className="ml-8 flex items-center gap-6">
                        <a href="#" className="text-sm font-medium">Overview</a>
                        <a href="#" className="text-sm font-medium text-muted-foreground hover:text-foreground">Reports</a>
                        <a href="#" className="text-sm font-medium text-muted-foreground hover:text-foreground">Settings</a>
                    </nav>
                    <div className="flex-1" />
                    <Button variant="ghost" size="icon-sm">
                        <HugeiconsIcon icon={Notification01Icon} strokeWidth={2} className="size-4" />
                    </Button>
                    <div className="ml-2 flex size-8 items-center justify-center rounded-full bg-muted text-xs font-medium">JD</div>
                </div>
            </header>
            <main className="mx-auto w-full max-w-7xl pt-6 pb-6 pl-4 pr-4">
                <div className="flex items-center justify-between">
                    <h1 className="text-2xl font-semibold tracking-tight">Overview</h1>
                    <Button>Export<HugeiconsIcon icon={ArrowUpRight01Icon} strokeWidth={2} className="size-4" /></Button>
                </div>
                <div className="mt-6 grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-4">
                    <Card>
                        <CardHeader>
                            <CardDescription>Revenue</CardDescription>
                            <CardTitle className="text-3xl font-semibold tabular-nums">$45,231</CardTitle>
                            <Badge variant="outline" className="mt-2">
                                <HugeiconsIcon icon={ArrowUpRight01Icon} strokeWidth={2} className="size-3" />
                                <span className="tabular-nums">+20.1%</span>
                            </Badge>
                        </CardHeader>
                        <CardContent>
                            <div className="text-sm text-muted-foreground">vs last month</div>
                        </CardContent>
                    </Card>
                    {props.children}
                </div>
            </main>
        </div>;
    }
}
```

---

## Common mistakes specific to dashboard blocks

- **Marketing-style section padding.** `pt-24 pb-24` belongs on landing pages. Dashboards use `pt-6 pb-6 pl-6 pr-6` on `<main>` and `h-14` on the header. App pages have a tighter rhythm because the user is doing work, not reading copy.
- **`max-w-7xl` inside a `SidebarInset` layout.** The sidebar already constrains the viewport. Wrapping inset content in `mx-auto max-w-7xl` produces an awkward double-narrow layout. Only Variant 4 (no sidebar) uses `max-w-7xl`.
- **Stat numbers without `tabular-nums`.** Default fonts have proportional digits, so the layout jumps when a value updates from `$1,000` to `$8,888`. `font-semibold tabular-nums` locks digit width. Apply it to percentages too.
- **Raw color classes for change indicators.** `text-green-500` / `text-red-500` / `text-emerald-600` break dark mode and theme overrides. Use `Badge variant="outline"` with a HugeIcon arrow, or `text-success` / `text-destructive` semantic tokens.
- **Hand-rolled loading skeletons.** `<div className="animate-pulse h-4 bg-gray-200 rounded">` is the LLM tell. Use `<Skeleton className="h-4 w-3/4" />` — it handles theming, animation timing, and rounded corners consistently.
- **Manual sidebar implementation or hardcoded width.** A bespoke `<aside className="w-64 border-r">` breaks collapse, mobile sheet, keyboard nav, and theme tokens. Always use `SidebarProvider` + `Sidebar` + `SidebarMenu` — the component computes its own width from `--sidebar-width` / `--sidebar-width-icon`. Use `useSidebar()` for `state` / `open` / `toggleSidebar()`.
- **Wrong card heading hierarchy.** Stat cards read top-down: `CardDescription` (small label) → `CardTitle` (`text-3xl font-semibold tabular-nums` number) → `Badge` (delta) → `CardContent` (caption). Don't put `text-lg font-bold` on the title — that's a marketing card pattern.
- **Multi-color sidebar nav icons.** Icons follow text color — `text-muted-foreground` inactive, inherited foreground active. Don't pick a different palette color per icon.
- **Chart card without `lg:col-span-2`.** A chart taking only 1 of 3 columns looks starved next to the secondary widget. Primary charts should be `<Card className="lg:col-span-2">`.
- **Passing `className` to `Sidebar*` components.** jac-shadcn's spread-ordering bug wipes the base styles. Wrap with a `<div>` instead, or use a regular `<Button>` when you need styling the cva doesn't expose. (See registry block conversions in `examples/sidebar-07/` and `examples/dashboard-01/` for the working pattern.)
- **Forgetting the header vertical separator.** `<Separator orientation="vertical" className="mr-2 h-4" />` between `SidebarTrigger` and the breadcrumb ties the header together; without it the trigger feels orphaned.

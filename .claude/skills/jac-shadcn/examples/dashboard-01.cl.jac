"""Dashboard-01 — official shadcn registry block. Inset-sidebar dashboard with section cards.

Chart and data-table are stubbed (recharts + tanstack/react-table not yet ported to Jac).
NOTE on jac-shadcn className spread bug (see rules/registry-blocks.md): do not pass
className to any Sidebar* primitive. Wrap with <div> for layout overrides instead.
"""

cl import from ..ui.sidebar {
    Sidebar, SidebarContent, SidebarFooter, SidebarGroup, SidebarGroupContent,
    SidebarGroupLabel, SidebarHeader, SidebarInset, SidebarMenu, SidebarMenuAction,
    SidebarMenuButton, SidebarMenuItem, SidebarProvider, SidebarTrigger
}
cl import from ..ui.card { Card, CardAction, CardDescription, CardFooter, CardHeader, CardTitle }
cl import from ..ui.badge { Badge }
cl import from ..ui.button { Button }
cl import from ..ui.separator { Separator }
cl import from ..ui.avatar { Avatar, AvatarFallback, AvatarImage }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" {
    CommandIcon, DashboardSquare01Icon, Menu01Icon, ChartHistogramIcon,
    Folder01Icon, UserGroupIcon, Database01Icon, Analytics01Icon, File01Icon,
    Settings05Icon, HelpCircleIcon, SearchIcon,
    PlusSignCircleIcon, Mail01Icon,
    ChartUpIcon, ChartDownIcon,
    MoreHorizontalCircle01Icon, MoreVerticalCircle01Icon
}

glob _navMain: list = [
    {"title": "Dashboard", "url": "#", "icon": DashboardSquare01Icon},
    {"title": "Lifecycle", "url": "#", "icon": Menu01Icon},
    {"title": "Analytics", "url": "#", "icon": ChartHistogramIcon},
    {"title": "Projects", "url": "#", "icon": Folder01Icon},
    {"title": "Team", "url": "#", "icon": UserGroupIcon}
];

glob _navDocuments: list = [
    {"name": "Data Library", "url": "#", "icon": Database01Icon},
    {"name": "Reports", "url": "#", "icon": Analytics01Icon},
    {"name": "Word Assistant", "url": "#", "icon": File01Icon}
];

glob _navSecondary: list = [
    {"title": "Settings", "url": "#", "icon": Settings05Icon},
    {"title": "Get Help", "url": "#", "icon": HelpCircleIcon},
    {"title": "Search", "url": "#", "icon": SearchIcon}
];

glob _user: dict = {
    "name": "shadcn", "email": "m@example.com", "avatar": "/avatars/shadcn.jpg"
};

glob _stats: list = [
    {"label": "Total Revenue", "value": "$1,250.00", "change": "+12.5%", "positive": True, "headline": "Trending up this month", "caption": "Visitors for the last 6 months"},
    {"label": "New Customers", "value": "1,234", "change": "-20%", "positive": False, "headline": "Down 20% this period", "caption": "Acquisition needs attention"},
    {"label": "Active Accounts", "value": "45,678", "change": "+12.5%", "positive": True, "headline": "Strong user retention", "caption": "Engagement exceed targets"},
    {"label": "Growth Rate", "value": "4.5%", "change": "+4.5%", "positive": True, "headline": "Steady performance increase", "caption": "Meets growth projections"}
];

cl {
    def:pub NavMain(props: Any) -> JsxElement {
        items = props.items;
        return <SidebarGroup>
            <SidebarGroupContent>
                <SidebarMenu>
                    <SidebarMenuItem>
                        <div className="flex items-center gap-2 pl-2 pr-2 pb-2">
                            <Button className="flex-1 justify-start gap-2" size="sm">
                                <HugeiconsIcon icon={PlusSignCircleIcon} strokeWidth={2} className="size-4" />
                                <span>Quick Create</span>
                            </Button>
                            <Button size="icon" variant="outline" className="size-8 shrink-0">
                                <HugeiconsIcon icon={Mail01Icon} strokeWidth={2} className="size-4" />
                                <span className="sr-only">Inbox</span>
                            </Button>
                        </div>
                    </SidebarMenuItem>
                </SidebarMenu>
                <SidebarMenu>
                    {items.map(lambda(item: Any) -> Any {
                        itemIcon = item.icon;
                        return <SidebarMenuItem key={item.title}>
                            <SidebarMenuButton tooltip={item.title}>
                                <HugeiconsIcon icon={itemIcon} strokeWidth={2} className="size-4" />
                                <span>{item.title}</span>
                            </SidebarMenuButton>
                        </SidebarMenuItem>;
                    })}
                </SidebarMenu>
            </SidebarGroupContent>
        </SidebarGroup>;
    }

    def:pub NavDocuments(props: Any) -> JsxElement {
        items = props.items;
        return <SidebarGroup>
            <SidebarGroupLabel>Documents</SidebarGroupLabel>
            <SidebarMenu>
                {items.map(lambda(item: Any) -> Any {
                    docIcon = item.icon;
                    return <SidebarMenuItem key={item.name}>
                        <SidebarMenuButton asChild={True}>
                            <a href={item.url}>
                                <HugeiconsIcon icon={docIcon} strokeWidth={2} className="size-4" />
                                <span>{item.name}</span>
                            </a>
                        </SidebarMenuButton>
                        <SidebarMenuAction showOnHover={True}>
                            <HugeiconsIcon icon={MoreHorizontalCircle01Icon} strokeWidth={2} className="size-4" />
                            <span className="sr-only">More</span>
                        </SidebarMenuAction>
                    </SidebarMenuItem>;
                })}
                <SidebarMenuItem>
                    <SidebarMenuButton>
                        <HugeiconsIcon icon={MoreHorizontalCircle01Icon} strokeWidth={2} className="size-4" />
                        <span>More</span>
                    </SidebarMenuButton>
                </SidebarMenuItem>
            </SidebarMenu>
        </SidebarGroup>;
    }

    def:pub NavSecondary(props: Any) -> JsxElement {
        items = props.items;
        return <SidebarGroup>
            <SidebarGroupContent>
                <SidebarMenu>
                    {items.map(lambda(item: Any) -> Any {
                        secIcon = item.icon;
                        return <SidebarMenuItem key={item.title}>
                            <SidebarMenuButton asChild={True}>
                                <a href={item.url}>
                                    <HugeiconsIcon icon={secIcon} strokeWidth={2} className="size-4" />
                                    <span>{item.title}</span>
                                </a>
                            </SidebarMenuButton>
                        </SidebarMenuItem>;
                    })}
                </SidebarMenu>
            </SidebarGroupContent>
        </SidebarGroup>;
    }

    def:pub NavUser(props: Any) -> JsxElement {
        user = props.user;
        return <SidebarMenu>
            <SidebarMenuItem>
                <SidebarMenuButton size="lg">
                    <Avatar className="size-8 rounded-lg grayscale">
                        <AvatarImage src={user.avatar} alt={user.name} />
                        <AvatarFallback className="rounded-lg">CN</AvatarFallback>
                    </Avatar>
                    <div className="grid flex-1 text-left text-sm leading-tight">
                        <span className="truncate font-medium">{user.name}</span>
                        <span className="truncate text-xs text-foreground/70">{user.email}</span>
                    </div>
                    <HugeiconsIcon icon={MoreVerticalCircle01Icon} strokeWidth={2} className="ml-auto size-4" />
                </SidebarMenuButton>
            </SidebarMenuItem>
        </SidebarMenu>;
    }

    def:pub AppSidebar(props: Any) -> JsxElement {
        return <Sidebar collapsible="offcanvas" variant="inset">
            <SidebarHeader>
                <SidebarMenu>
                    <SidebarMenuItem>
                        <SidebarMenuButton asChild={True}>
                            <a href="#">
                                <HugeiconsIcon icon={CommandIcon} strokeWidth={2} className="size-5" />
                                <span className="text-base font-semibold">Acme Inc.</span>
                            </a>
                        </SidebarMenuButton>
                    </SidebarMenuItem>
                </SidebarMenu>
            </SidebarHeader>
            <SidebarContent>
                <NavMain items={_navMain} />
                <NavDocuments items={_navDocuments} />
                <NavSecondary items={_navSecondary} />
            </SidebarContent>
            <SidebarFooter>
                <NavUser user={_user} />
            </SidebarFooter>
        </Sidebar>;
    }

    def:pub StatCard(props: Any) -> JsxElement {
        stat = props.stat;
        arrowIcon = (stat.positive and ChartUpIcon) or ChartDownIcon;
        return <Card className="@container/card">
            <CardHeader>
                <CardDescription>{stat.label}</CardDescription>
                <CardTitle className="text-2xl font-semibold tabular-nums @[250px]/card:text-3xl">
                    {stat.value}
                </CardTitle>
                <CardAction>
                    <Badge variant="outline">
                        <HugeiconsIcon icon={arrowIcon} strokeWidth={2} className="size-3" />
                        {stat.change}
                    </Badge>
                </CardAction>
            </CardHeader>
            <CardFooter className="flex-col items-start gap-1.5 text-sm">
                <div className="line-clamp-1 flex gap-2 font-medium">
                    {stat.headline}
                    <HugeiconsIcon icon={arrowIcon} strokeWidth={2} className="size-4" />
                </div>
                <div className="text-muted-foreground">{stat.caption}</div>
            </CardFooter>
        </Card>;
    }

    def:pub SectionCards(props: Any) -> JsxElement {
        stats = _stats;
        renderCard = StatCard;
        return <div className="grid grid-cols-1 gap-4 pl-4 pr-4 lg:pl-6 lg:pr-6 @xl/main:grid-cols-2 @5xl/main:grid-cols-4">
            {stats.map(lambda(stat: Any) -> Any {
                return renderCard.call(None, {"stat": stat, "key": stat.label});
            })}
        </div>;
    }

    def:pub ChartPlaceholder(props: Any) -> JsxElement {
        return <Card className="@container/card">
            <CardHeader>
                <CardTitle>Total Visitors</CardTitle>
                <CardDescription>For the last 6 months</CardDescription>
            </CardHeader>
            <div className="pl-6 pr-6 pb-6">
                <div className="aspect-[16/6] w-full rounded-lg border border-dashed bg-muted/30 flex items-center justify-center">
                    <span className="text-sm text-muted-foreground">{"<ChartAreaInteractive />  (recharts not yet ported)"}</span>
                </div>
            </div>
        </Card>;
    }

    def:pub TablePlaceholder(props: Any) -> JsxElement {
        return <div className="pl-4 pr-4 lg:pl-6 lg:pr-6">
            <Card>
                <CardHeader>
                    <CardTitle>Documents</CardTitle>
                    <CardDescription>{"<DataTable />  (tanstack/react-table not yet ported)"}</CardDescription>
                </CardHeader>
                <div className="pl-6 pr-6 pb-6">
                    <div className="rounded-md border">
                        <table className="w-full text-sm">
                            <thead className="border-b bg-muted/40">
                                <tr>
                                    <th className="pt-2 pb-2 pl-3 pr-3 text-left font-medium">Header</th>
                                    <th className="pt-2 pb-2 pl-3 pr-3 text-left font-medium">Section Type</th>
                                    <th className="pt-2 pb-2 pl-3 pr-3 text-left font-medium">Status</th>
                                    <th className="pt-2 pb-2 pl-3 pr-3 text-left font-medium">Target</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr className="border-b">
                                    <td className="pt-2 pb-2 pl-3 pr-3">Cover Page</td>
                                    <td className="pt-2 pb-2 pl-3 pr-3 text-muted-foreground">Cover page</td>
                                    <td className="pt-2 pb-2 pl-3 pr-3"><Badge variant="outline">Done</Badge></td>
                                    <td className="pt-2 pb-2 pl-3 pr-3 tabular-nums">18</td>
                                </tr>
                                <tr>
                                    <td className="pt-2 pb-2 pl-3 pr-3">Executive Summary</td>
                                    <td className="pt-2 pb-2 pl-3 pr-3 text-muted-foreground">Narrative</td>
                                    <td className="pt-2 pb-2 pl-3 pr-3"><Badge variant="outline">Done</Badge></td>
                                    <td className="pt-2 pb-2 pl-3 pr-3 tabular-nums">10</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </Card>
        </div>;
    }

    def:pub SiteHeader(props: Any) -> JsxElement {
        return <header className="flex h-12 shrink-0 items-center gap-2 border-b transition-[width,height] ease-linear group-has-data-[collapsible=icon]/sidebar-wrapper:h-12">
            <div className="flex w-full items-center gap-1 pl-4 pr-4 lg:gap-2 lg:pl-6 lg:pr-6">
                <SidebarTrigger />
                <Separator
                    orientation="vertical"
                    className="ml-2 mr-2 h-4 data-vertical:self-auto"
                />
                <h1 className="text-base font-medium">Documents</h1>
            </div>
        </header>;
    }

    def:pub Dashboard01Page(props: Any) -> JsxElement {
        return <SidebarProvider>
            <AppSidebar />
            <SidebarInset>
                <SiteHeader />
                <div className="flex flex-1 flex-col">
                    <div className="@container/main flex flex-1 flex-col gap-2">
                        <div className="flex flex-col gap-4 pt-4 pb-4 md:gap-6 md:pt-6 md:pb-6">
                            <SectionCards />
                            <div className="pl-4 pr-4 lg:pl-6 lg:pr-6">
                                <ChartPlaceholder />
                            </div>
                            <TablePlaceholder />
                        </div>
                    </div>
                </div>
            </SidebarInset>
        </SidebarProvider>;
    }
}

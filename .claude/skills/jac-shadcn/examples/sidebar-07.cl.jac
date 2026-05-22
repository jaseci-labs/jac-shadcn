"""Sidebar-07 — official shadcn registry block. Canonical app shell with team switcher,
collapsible nav groups, project list with action menus, and user dropdown.

NOTE on jac-shadcn className spread bug (see rules/registry-blocks.md): do not pass
className to any Sidebar* primitive. Wrap with <div> for layout overrides instead.
"""

cl import from react { useState }
cl import from ..ui.sidebar {
    Sidebar,
    SidebarContent,
    SidebarFooter,
    SidebarGroup,
    SidebarGroupLabel,
    SidebarHeader,
    SidebarInset,
    SidebarMenu,
    SidebarMenuAction,
    SidebarMenuButton,
    SidebarMenuItem,
    SidebarMenuSub,
    SidebarMenuSubButton,
    SidebarMenuSubItem,
    SidebarProvider,
    SidebarRail,
    SidebarTrigger,
    useSidebar
}
cl import from ..ui.collapsible { Collapsible, CollapsibleContent, CollapsibleTrigger }
cl import from "..ui.dropdown-menu" {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuGroup,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuShortcut,
    DropdownMenuTrigger
}
cl import from ..ui.avatar { Avatar, AvatarFallback, AvatarImage }
cl import from ..ui.breadcrumb {
    Breadcrumb, BreadcrumbItem, BreadcrumbLink, BreadcrumbList,
    BreadcrumbPage, BreadcrumbSeparator
}
cl import from ..ui.separator { Separator }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" {
    LayoutBottomIcon, AudioWave01Icon, CommandIcon,
    ComputerTerminalIcon, RoboticIcon, BookOpen02Icon, Settings05Icon,
    CropIcon, PieChartIcon, MapsIcon,
    ArrowRight01Icon, MoreHorizontalCircle01Icon,
    FolderIcon, Delete02Icon, UnfoldMoreIcon,
    SparklesIcon, CheckmarkBadgeIcon, CreditCardIcon, NotificationIcon,
    LogoutIcon, PlusSignIcon
}

glob _teams: list = [
    {"name": "Acme Inc", "logo": LayoutBottomIcon, "plan": "Enterprise"},
    {"name": "Acme Corp.", "logo": AudioWave01Icon, "plan": "Startup"},
    {"name": "Evil Corp.", "logo": CommandIcon, "plan": "Free"}
];

glob _navMain: list = [
    {
        "title": "Playground", "url": "#", "icon": ComputerTerminalIcon, "isActive": True,
        "items": [
            {"title": "History", "url": "#"},
            {"title": "Starred", "url": "#"},
            {"title": "Settings", "url": "#"}
        ]
    },
    {
        "title": "Models", "url": "#", "icon": RoboticIcon, "isActive": False,
        "items": [
            {"title": "Genesis", "url": "#"},
            {"title": "Explorer", "url": "#"},
            {"title": "Quantum", "url": "#"}
        ]
    },
    {
        "title": "Documentation", "url": "#", "icon": BookOpen02Icon, "isActive": False,
        "items": [
            {"title": "Introduction", "url": "#"},
            {"title": "Get Started", "url": "#"},
            {"title": "Tutorials", "url": "#"},
            {"title": "Changelog", "url": "#"}
        ]
    },
    {
        "title": "Settings", "url": "#", "icon": Settings05Icon, "isActive": False,
        "items": [
            {"title": "General", "url": "#"},
            {"title": "Team", "url": "#"},
            {"title": "Billing", "url": "#"},
            {"title": "Limits", "url": "#"}
        ]
    }
];

glob _projects: list = [
    {"name": "Design Engineering", "url": "#", "icon": CropIcon},
    {"name": "Sales & Marketing", "url": "#", "icon": PieChartIcon},
    {"name": "Travel", "url": "#", "icon": MapsIcon}
];

glob _user: dict = {
    "name": "shadcn", "email": "m@example.com", "avatar": "/avatars/shadcn.jpg"
};

cl {
    def:pub TeamSwitcher(props: Any) -> JsxElement {
        teams = props.teams;
        has activeIdx: int = 0;
        sidebar = useSidebar();
        isMobile = sidebar.isMobile or False;
        activeTeam = teams[activeIdx];
        activeLogo = activeTeam.logo;
        setActive = lambda(idx: int) { activeIdx = idx; };

        return <SidebarMenu>
            <SidebarMenuItem>
                <DropdownMenu>
                    <DropdownMenuTrigger asChild={True}>
                        <SidebarMenuButton size="lg">
                            <div className="flex aspect-square size-8 items-center justify-center rounded-lg bg-sidebar-primary text-sidebar-primary-foreground">
                                <HugeiconsIcon icon={activeLogo} strokeWidth={2} className="size-4" />
                            </div>
                            <div className="grid flex-1 text-left text-sm leading-tight">
                                <span className="truncate font-medium">{activeTeam.name}</span>
                                <span className="truncate text-xs">{activeTeam.plan}</span>
                            </div>
                            <HugeiconsIcon icon={UnfoldMoreIcon} strokeWidth={2} className="ml-auto size-4" />
                        </SidebarMenuButton>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent
                        className="min-w-56 rounded-lg"
                        align="start"
                        side={isMobile and "bottom" or "right"}
                        sideOffset={4}
                    >
                        <DropdownMenuGroup>
                            <DropdownMenuLabel className="text-xs text-muted-foreground">Teams</DropdownMenuLabel>
                            {teams.map(lambda(team: Any, index: int) -> Any {
                                teamLogo = team.logo;
                                teamIdx = index;
                                return <DropdownMenuItem
                                    key={team.name}
                                    onClick={lambda { setActive.call(None, teamIdx); }}
                                    className="gap-2 pt-2 pb-2 pl-2 pr-2"
                                >
                                    <div className="flex size-6 items-center justify-center rounded-md border">
                                        <HugeiconsIcon icon={teamLogo} strokeWidth={2} className="size-3.5" />
                                    </div>
                                    {team.name}
                                    <DropdownMenuShortcut>{"⌘" + String(index + 1)}</DropdownMenuShortcut>
                                </DropdownMenuItem>;
                            })}
                        </DropdownMenuGroup>
                        <DropdownMenuSeparator />
                        <DropdownMenuGroup>
                            <DropdownMenuItem className="gap-2 pt-2 pb-2 pl-2 pr-2">
                                <div className="flex size-6 items-center justify-center rounded-md border bg-transparent">
                                    <HugeiconsIcon icon={PlusSignIcon} strokeWidth={2} className="size-4" />
                                </div>
                                <div className="font-medium text-muted-foreground">Add team</div>
                            </DropdownMenuItem>
                        </DropdownMenuGroup>
                    </DropdownMenuContent>
                </DropdownMenu>
            </SidebarMenuItem>
        </SidebarMenu>;
    }

    def:pub NavMain(props: Any) -> JsxElement {
        items = props.items;
        return <SidebarGroup>
            <SidebarGroupLabel>Platform</SidebarGroupLabel>
            <SidebarMenu>
                {items.map(lambda(item: Any) -> Any {
                    itemIcon = item.icon;
                    subItems = item.items or [];
                    return <Collapsible
                        key={item.title}
                        defaultOpen={item.isActive or False}
                        className="group/collapsible"
                        asChild={True}
                    >
                        <SidebarMenuItem>
                            <CollapsibleTrigger asChild={True}>
                                <SidebarMenuButton tooltip={item.title}>
                                    <HugeiconsIcon icon={itemIcon} strokeWidth={2} className="size-4" />
                                    <span>{item.title}</span>
                                    <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="ml-auto size-4 transition-transform duration-200 group-data-open/collapsible:rotate-90" />
                                </SidebarMenuButton>
                            </CollapsibleTrigger>
                            <CollapsibleContent>
                                <SidebarMenuSub>
                                    {subItems.map(lambda(subItem: Any) -> Any {
                                        return <SidebarMenuSubItem key={subItem.title}>
                                            <SidebarMenuSubButton asChild={True}>
                                                <a href={subItem.url}>
                                                    <span>{subItem.title}</span>
                                                </a>
                                            </SidebarMenuSubButton>
                                        </SidebarMenuSubItem>;
                                    })}
                                </SidebarMenuSub>
                            </CollapsibleContent>
                        </SidebarMenuItem>
                    </Collapsible>;
                })}
            </SidebarMenu>
        </SidebarGroup>;
    }

    def:pub NavProjects(props: Any) -> JsxElement {
        projects = props.projects;
        sidebar = useSidebar();
        isMobile = sidebar.isMobile or False;

        return <SidebarGroup>
            <SidebarGroupLabel>Projects</SidebarGroupLabel>
            <SidebarMenu>
                {projects.map(lambda(item: Any) -> Any {
                    projectIcon = item.icon;
                    return <SidebarMenuItem key={item.name}>
                        <SidebarMenuButton asChild={True}>
                            <a href={item.url}>
                                <HugeiconsIcon icon={projectIcon} strokeWidth={2} className="size-4" />
                                <span>{item.name}</span>
                            </a>
                        </SidebarMenuButton>
                        <DropdownMenu>
                            <DropdownMenuTrigger asChild={True}>
                                <SidebarMenuAction showOnHover={True}>
                                    <HugeiconsIcon icon={MoreHorizontalCircle01Icon} strokeWidth={2} className="size-4" />
                                    <span className="sr-only">More</span>
                                </SidebarMenuAction>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent
                                className="w-48 rounded-lg"
                                side={isMobile and "bottom" or "right"}
                                align={isMobile and "end" or "start"}
                            >
                                <DropdownMenuItem>
                                    <HugeiconsIcon icon={FolderIcon} strokeWidth={2} className="size-4 text-muted-foreground" />
                                    <span>View Project</span>
                                </DropdownMenuItem>
                                <DropdownMenuItem>
                                    <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="size-4 text-muted-foreground" />
                                    <span>Share Project</span>
                                </DropdownMenuItem>
                                <DropdownMenuSeparator />
                                <DropdownMenuItem>
                                    <HugeiconsIcon icon={Delete02Icon} strokeWidth={2} className="size-4 text-muted-foreground" />
                                    <span>Delete Project</span>
                                </DropdownMenuItem>
                            </DropdownMenuContent>
                        </DropdownMenu>
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

    def:pub NavUser(props: Any) -> JsxElement {
        user = props.user;
        sidebar = useSidebar();
        isMobile = sidebar.isMobile or False;

        return <SidebarMenu>
            <SidebarMenuItem>
                <DropdownMenu>
                    <DropdownMenuTrigger asChild={True}>
                        <SidebarMenuButton size="lg">
                            <Avatar>
                                <AvatarImage src={user.avatar} alt={user.name} />
                                <AvatarFallback>CN</AvatarFallback>
                            </Avatar>
                            <div className="grid flex-1 text-left text-sm leading-tight">
                                <span className="truncate font-medium">{user.name}</span>
                                <span className="truncate text-xs">{user.email}</span>
                            </div>
                            <HugeiconsIcon icon={UnfoldMoreIcon} strokeWidth={2} className="ml-auto size-4" />
                        </SidebarMenuButton>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent
                        className="min-w-56 rounded-lg"
                        side={isMobile and "bottom" or "right"}
                        align="end"
                        sideOffset={4}
                    >
                        <DropdownMenuGroup>
                            <DropdownMenuLabel className="pl-0 pr-0 pt-0 pb-0 font-normal">
                                <div className="flex items-center gap-2 pl-1 pr-1 pt-1.5 pb-1.5 text-left text-sm">
                                    <Avatar>
                                        <AvatarImage src={user.avatar} alt={user.name} />
                                        <AvatarFallback>CN</AvatarFallback>
                                    </Avatar>
                                    <div className="grid flex-1 text-left text-sm leading-tight">
                                        <span className="truncate font-medium">{user.name}</span>
                                        <span className="truncate text-xs">{user.email}</span>
                                    </div>
                                </div>
                            </DropdownMenuLabel>
                        </DropdownMenuGroup>
                        <DropdownMenuSeparator />
                        <DropdownMenuGroup>
                            <DropdownMenuItem>
                                <HugeiconsIcon icon={SparklesIcon} strokeWidth={2} className="size-4" />
                                Upgrade to Pro
                            </DropdownMenuItem>
                        </DropdownMenuGroup>
                        <DropdownMenuSeparator />
                        <DropdownMenuGroup>
                            <DropdownMenuItem>
                                <HugeiconsIcon icon={CheckmarkBadgeIcon} strokeWidth={2} className="size-4" />
                                Account
                            </DropdownMenuItem>
                            <DropdownMenuItem>
                                <HugeiconsIcon icon={CreditCardIcon} strokeWidth={2} className="size-4" />
                                Billing
                            </DropdownMenuItem>
                            <DropdownMenuItem>
                                <HugeiconsIcon icon={NotificationIcon} strokeWidth={2} className="size-4" />
                                Notifications
                            </DropdownMenuItem>
                        </DropdownMenuGroup>
                        <DropdownMenuSeparator />
                        <DropdownMenuItem>
                            <HugeiconsIcon icon={LogoutIcon} strokeWidth={2} className="size-4" />
                            Log out
                        </DropdownMenuItem>
                    </DropdownMenuContent>
                </DropdownMenu>
            </SidebarMenuItem>
        </SidebarMenu>;
    }

    def:pub AppSidebar(props: Any) -> JsxElement {
        return <Sidebar collapsible="icon">
            <SidebarHeader>
                <TeamSwitcher teams={_teams} />
            </SidebarHeader>
            <SidebarContent>
                <NavMain items={_navMain} />
                <NavProjects projects={_projects} />
            </SidebarContent>
            <SidebarFooter>
                <NavUser user={_user} />
            </SidebarFooter>
            <SidebarRail />
        </Sidebar>;
    }

    def:pub Sidebar07Page(props: Any) -> JsxElement {
        return <SidebarProvider>
            <AppSidebar />
            <SidebarInset>
                <header className="flex h-16 shrink-0 items-center gap-2 transition-[width,height] ease-linear group-has-data-[collapsible=icon]/sidebar-wrapper:h-12">
                    <div className="flex items-center gap-2 pl-4 pr-4">
                        <SidebarTrigger />
                        <Separator
                            orientation="vertical"
                            className="mr-2 data-vertical:h-4 data-vertical:self-auto"
                        />
                        <Breadcrumb>
                            <BreadcrumbList>
                                <BreadcrumbItem className="hidden md:block">
                                    <BreadcrumbLink href="#">Build Your Application</BreadcrumbLink>
                                </BreadcrumbItem>
                                <BreadcrumbSeparator className="hidden md:block" />
                                <BreadcrumbItem>
                                    <BreadcrumbPage>Data Fetching</BreadcrumbPage>
                                </BreadcrumbItem>
                            </BreadcrumbList>
                        </Breadcrumb>
                    </div>
                </header>
                <div className="flex flex-1 flex-col gap-4 pl-4 pr-4 pb-4 pt-0">
                    <div className="grid auto-rows-min gap-4 md:grid-cols-3">
                        <div className="aspect-video rounded-xl bg-muted/50" />
                        <div className="aspect-video rounded-xl bg-muted/50" />
                        <div className="aspect-video rounded-xl bg-muted/50" />
                    </div>
                    <div className="min-h-[100vh] flex-1 rounded-xl bg-muted/50 md:min-h-min" />
                </div>
            </SidebarInset>
        </SidebarProvider>;
    }
}

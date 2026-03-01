cl import from ..ui.button { Button, buttonVariants }
cl import from ..ui.label { Label }
cl import from ..ui.separator { Separator }
cl import from ..ui.checkbox { Checkbox }
cl import from ..ui.tabs { Tabs, TabsList, TabsTrigger, TabsContent }
cl import from "..ui.radio-group" { RadioGroup, RadioGroupItem }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon, ArrowDownIcon, ArrowUpIcon, PlusSignIcon, DownloadIcon, MailIcon, SearchIcon, SettingsIcon, UserIcon, Copy01Icon, Tick01Icon, TextAlignLeftIcon, TextAlignCenterIcon, TextAlignRightIcon, TextBoldIcon, TextItalicIcon, TextUnderlineIcon }
cl import from ..ui.accordion { Accordion, AccordionItem, AccordionTrigger, AccordionContent }
cl import from ..ui.breadcrumb { Breadcrumb, BreadcrumbList, BreadcrumbItem, BreadcrumbLink, BreadcrumbPage, BreadcrumbSeparator, BreadcrumbEllipsis }
cl import from ..ui.collapsible { Collapsible, CollapsibleTrigger, CollapsibleContent }
cl import from ..ui.menubar { Menubar, MenubarMenu, MenubarTrigger, MenubarContent, MenubarItem, MenubarSeparator, MenubarShortcut, MenubarCheckboxItem, MenubarRadioGroup, MenubarRadioItem, MenubarLabel }
cl import from "..ui.navigation-menu" { NavigationMenu, NavigationMenuList, NavigationMenuItem, NavigationMenuTrigger, NavigationMenuContent, NavigationMenuLink, NavigationMenuViewport, navigationMenuTriggerStyle }
cl import from ..ui.pagination { Pagination, PaginationContent, PaginationItem, PaginationLink, PaginationNext, PaginationPrevious, PaginationEllipsis }
cl import from ..ui.item { Item, ItemGroup, ItemMedia, ItemContent, ItemTitle, ItemDescription, ItemActions, ItemSeparator }
cl import from ..ui.sidebar { Sidebar, SidebarContent, SidebarFooter, SidebarGroup, SidebarGroupContent, SidebarGroupLabel, SidebarHeader, SidebarInset, SidebarMenu, SidebarMenuButton, SidebarMenuItem, SidebarProvider, SidebarTrigger }
cl import from "recharts" { Bar, BarChart, CartesianGrid, XAxis, YAxis, Line, LineChart, Area, AreaChart, Pie, PieChart, RadialBar, RadialBarChart }
cl import from ".shared" { ShowcaseSection, ShowcaseHeader }

glob _codeExamples: dict = {
    "accordion": "cl import from .ui.accordion {\n    Accordion, AccordionItem,\n    AccordionTrigger, AccordionContent\n}\n\n<Accordion type='single' collapsible={True}>\n    <AccordionItem value='item-1'>\n        <AccordionTrigger>Is it accessible?</AccordionTrigger>\n        <AccordionContent>\n            Yes. It follows WAI-ARIA guidelines.\n        </AccordionContent>\n    </AccordionItem>\n</Accordion>",
    "accordion-multiple": "cl import from .ui.accordion {\n    Accordion, AccordionItem,\n    AccordionTrigger, AccordionContent\n}\n\n<Accordion type='multiple'>\n    <AccordionItem value='item-1'>\n        <AccordionTrigger>\n            Can I open multiple?\n        </AccordionTrigger>\n        <AccordionContent>\n            Yes. Use type='multiple' to allow\n            multiple items open at once.\n        </AccordionContent>\n    </AccordionItem>\n    <AccordionItem value='item-2'>\n        <AccordionTrigger>\n            What about single mode?\n        </AccordionTrigger>\n        <AccordionContent>\n            Use type='single' for one at a time.\n        </AccordionContent>\n    </AccordionItem>\n</Accordion>",
    "breadcrumb": "cl import from .ui.breadcrumb {\n    Breadcrumb, BreadcrumbList,\n    BreadcrumbItem, BreadcrumbLink,\n    BreadcrumbPage, BreadcrumbSeparator\n}\n\n<Breadcrumb>\n    <BreadcrumbList>\n        <BreadcrumbItem>\n            <BreadcrumbLink href='#'>Home</BreadcrumbLink>\n        </BreadcrumbItem>\n        <BreadcrumbSeparator />\n        <BreadcrumbItem>\n            <BreadcrumbPage>Current</BreadcrumbPage>\n        </BreadcrumbItem>\n    </BreadcrumbList>\n</Breadcrumb>",
    "breadcrumb-ellipsis": "cl import from .ui.breadcrumb {\n    Breadcrumb, BreadcrumbList,\n    BreadcrumbItem, BreadcrumbLink,\n    BreadcrumbPage, BreadcrumbSeparator,\n    BreadcrumbEllipsis\n}\n\n<Breadcrumb>\n    <BreadcrumbList>\n        <BreadcrumbItem>\n            <BreadcrumbLink href='#'>Home</BreadcrumbLink>\n        </BreadcrumbItem>\n        <BreadcrumbSeparator />\n        <BreadcrumbItem>\n            <BreadcrumbEllipsis />\n        </BreadcrumbItem>\n        <BreadcrumbSeparator />\n        <BreadcrumbItem>\n            <BreadcrumbPage>Current</BreadcrumbPage>\n        </BreadcrumbItem>\n    </BreadcrumbList>\n</Breadcrumb>",
    "collapsible": "cl import from .ui.collapsible {\n    Collapsible, CollapsibleTrigger,\n    CollapsibleContent\n}\n\nhas open: bool = False;\n\n<Collapsible open={open}\n    onOpenChange={lambda(v: bool) -> None {\n        open = v;\n    }}>\n    <CollapsibleTrigger>Toggle</CollapsibleTrigger>\n    <CollapsibleContent>\n        <p>Collapsible content here.</p>\n    </CollapsibleContent>\n</Collapsible>",
    "menubar": "cl import from .ui.menubar {\n    Menubar, MenubarMenu, MenubarTrigger,\n    MenubarContent, MenubarItem, MenubarSeparator\n}\n\n<Menubar>\n    <MenubarMenu>\n        <MenubarTrigger>File</MenubarTrigger>\n        <MenubarContent>\n            <MenubarItem>New Tab</MenubarItem>\n            <MenubarItem>New Window</MenubarItem>\n            <MenubarSeparator />\n            <MenubarItem>Print</MenubarItem>\n        </MenubarContent>\n    </MenubarMenu>\n</Menubar>",
    "navigation-menu": "cl import from '.ui.navigation-menu' {\n    NavigationMenu, NavigationMenuList,\n    NavigationMenuItem, NavigationMenuTrigger,\n    NavigationMenuContent, NavigationMenuLink\n}\n\n<NavigationMenu>\n    <NavigationMenuList>\n        <NavigationMenuItem>\n            <NavigationMenuTrigger>Getting started</NavigationMenuTrigger>\n            <NavigationMenuContent>\n                <ul className='grid gap-3 p-4'>\n                    <li>\n                        <NavigationMenuLink href='#'>\n                            Introduction\n                        </NavigationMenuLink>\n                    </li>\n                </ul>\n            </NavigationMenuContent>\n        </NavigationMenuItem>\n    </NavigationMenuList>\n</NavigationMenu>",
    "pagination": "cl import from .ui.pagination {\n    Pagination, PaginationContent,\n    PaginationItem, PaginationLink,\n    PaginationNext, PaginationPrevious\n}\n\n<Pagination>\n    <PaginationContent>\n        <PaginationItem>\n            <PaginationPrevious href='#' />\n        </PaginationItem>\n        <PaginationItem>\n            <PaginationLink href='#' isActive={True}>1</PaginationLink>\n        </PaginationItem>\n        <PaginationItem>\n            <PaginationLink href='#'>2</PaginationLink>\n        </PaginationItem>\n        <PaginationItem>\n            <PaginationNext href='#' />\n        </PaginationItem>\n    </PaginationContent>\n</Pagination>",
    "sidebar": "cl import from .ui.sidebar {\n    Sidebar, SidebarContent, SidebarGroup,\n    SidebarGroupLabel, SidebarGroupContent,\n    SidebarMenu, SidebarMenuItem,\n    SidebarMenuButton, SidebarProvider\n}\n\n<SidebarProvider>\n    <Sidebar>\n        <SidebarContent>\n            <SidebarGroup>\n                <SidebarGroupLabel>Nav</SidebarGroupLabel>\n                <SidebarGroupContent>\n                    <SidebarMenu>\n                        <SidebarMenuItem>\n                            <SidebarMenuButton>\n                                Home\n                            </SidebarMenuButton>\n                        </SidebarMenuItem>\n                    </SidebarMenu>\n                </SidebarGroupContent>\n            </SidebarGroup>\n        </SidebarContent>\n    </Sidebar>\n</SidebarProvider>",
    "tabs": "cl import from .ui.tabs {\n    Tabs, TabsList, TabsTrigger, TabsContent\n}\n\n<Tabs defaultValue='account'>\n    <TabsList>\n        <TabsTrigger value='account'>Account</TabsTrigger>\n        <TabsTrigger value='password'>Password</TabsTrigger>\n    </TabsList>\n    <TabsContent value='account'>\n        Account settings here.\n    </TabsContent>\n    <TabsContent value='password'>\n        Password settings here.\n    </TabsContent>\n</Tabs>",
    "tabs-disabled": "<Tabs defaultValue='active'>\n    <TabsList>\n        <TabsTrigger value='active'>Active</TabsTrigger>\n        <TabsTrigger value='disabled'\n            disabled={True}>Disabled</TabsTrigger>\n        <TabsTrigger value='other'>Other</TabsTrigger>\n    </TabsList>\n</Tabs>",
    "tabs-line": "cl import from .ui.tabs {\n    Tabs, TabsList, TabsTrigger, TabsContent\n}\n\n<Tabs defaultValue='general'>\n    <TabsList variant='line'>\n        <TabsTrigger value='general'>General</TabsTrigger>\n        <TabsTrigger value='security'>Security</TabsTrigger>\n    </TabsList>\n    <TabsContent value='general'>\n        General settings.\n    </TabsContent>\n    <TabsContent value='security'>\n        Security settings.\n    </TabsContent>\n</Tabs>",
};

cl {
    def:pub TabsShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Tabs"
                description="A set of layered sections of content, known as tab panels, that are displayed one at a time."
                name="tabs"
            />
            <ShowcaseSection title="Default Variant" code={_codeExamples["tabs"]}>
                <Tabs defaultValue="account" className="w-full max-w-md">
                    <TabsList className="w-full">
                        <TabsTrigger value="account">Account</TabsTrigger>
                        <TabsTrigger value="password">Password</TabsTrigger>
                        <TabsTrigger value="settings">Settings</TabsTrigger>
                    </TabsList>
                    <TabsContent value="account">
                        <div className="rounded-lg border p-4 mt-2">
                            <p className="text-sm text-muted-foreground">Make changes to your account here.</p>
                        </div>
                    </TabsContent>
                    <TabsContent value="password">
                        <div className="rounded-lg border p-4 mt-2">
                            <p className="text-sm text-muted-foreground">Change your password here.</p>
                        </div>
                    </TabsContent>
                    <TabsContent value="settings">
                        <div className="rounded-lg border p-4 mt-2">
                            <p className="text-sm text-muted-foreground">Manage your settings here.</p>
                        </div>
                    </TabsContent>
                </Tabs>
            </ShowcaseSection>
            <ShowcaseSection title="Line Variant" code={_codeExamples["tabs-line"]}>
                <Tabs defaultValue="general" className="w-full max-w-md">
                    <TabsList variant="line" className="w-full">
                        <TabsTrigger value="general">General</TabsTrigger>
                        <TabsTrigger value="notifications">Notifications</TabsTrigger>
                        <TabsTrigger value="security">Security</TabsTrigger>
                    </TabsList>
                    <TabsContent value="general">
                        <div className="rounded-lg border p-4 mt-2">
                            <p className="text-sm text-muted-foreground">General settings and preferences.</p>
                        </div>
                    </TabsContent>
                    <TabsContent value="notifications">
                        <div className="rounded-lg border p-4 mt-2">
                            <p className="text-sm text-muted-foreground">Notification preferences.</p>
                        </div>
                    </TabsContent>
                    <TabsContent value="security">
                        <div className="rounded-lg border p-4 mt-2">
                            <p className="text-sm text-muted-foreground">Security and privacy settings.</p>
                        </div>
                    </TabsContent>
                </Tabs>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled Tab" code={_codeExamples["tabs-disabled"]}>
                <Tabs defaultValue="active" className="w-full max-w-md">
                    <TabsList className="w-full">
                        <TabsTrigger value="active">Active</TabsTrigger>
                        <TabsTrigger value="disabled" disabled={True}>Disabled</TabsTrigger>
                        <TabsTrigger value="other">Other</TabsTrigger>
                    </TabsList>
                </Tabs>
            </ShowcaseSection>
        </div>;
    }

    def:pub AccordionShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Accordion" description="A vertically stacked set of interactive headings." name="accordion" />
            <ShowcaseSection title="Single" code={_codeExamples["accordion"]}>
                <Accordion type="single" collapsible={True} className="w-full max-w-md">
                    <AccordionItem value="item-1">
                        <AccordionTrigger>Is it accessible?</AccordionTrigger>
                        <AccordionContent>Yes. It adheres to the WAI-ARIA design pattern.</AccordionContent>
                    </AccordionItem>
                    <AccordionItem value="item-2">
                        <AccordionTrigger>Is it styled?</AccordionTrigger>
                        <AccordionContent>Yes. It comes with default styles that match the other components.</AccordionContent>
                    </AccordionItem>
                    <AccordionItem value="item-3">
                        <AccordionTrigger>Is it animated?</AccordionTrigger>
                        <AccordionContent>Yes. It is animated by default, but you can disable it if you prefer.</AccordionContent>
                    </AccordionItem>
                </Accordion>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Multiple" code={_codeExamples["accordion-multiple"]}>
                <Accordion type="multiple" className="w-full max-w-md">
                    <AccordionItem value="item-1">
                        <AccordionTrigger>Can I open multiple?</AccordionTrigger>
                        <AccordionContent>Yes. Use type="multiple" to allow multiple items open at once.</AccordionContent>
                    </AccordionItem>
                    <AccordionItem value="item-2">
                        <AccordionTrigger>What about single mode?</AccordionTrigger>
                        <AccordionContent>Use type="single" to allow only one item open at a time.</AccordionContent>
                    </AccordionItem>
                </Accordion>
            </ShowcaseSection>
        </div>;
    }

    def:pub BreadcrumbShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Breadcrumb" description="Displays the path to the current resource using a hierarchy of links." name="breadcrumb" />
            <ShowcaseSection title="Default" code={_codeExamples["breadcrumb"]}>
                <Breadcrumb>
                    <BreadcrumbList>
                        <BreadcrumbItem>
                            <BreadcrumbLink href="#">Home</BreadcrumbLink>
                        </BreadcrumbItem>
                        <BreadcrumbSeparator />
                        <BreadcrumbItem>
                            <BreadcrumbLink href="#">Components</BreadcrumbLink>
                        </BreadcrumbItem>
                        <BreadcrumbSeparator />
                        <BreadcrumbItem>
                            <BreadcrumbPage>Breadcrumb</BreadcrumbPage>
                        </BreadcrumbItem>
                    </BreadcrumbList>
                </Breadcrumb>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="With Ellipsis" code={_codeExamples["breadcrumb-ellipsis"]}>
                <Breadcrumb>
                    <BreadcrumbList>
                        <BreadcrumbItem>
                            <BreadcrumbLink href="#">Home</BreadcrumbLink>
                        </BreadcrumbItem>
                        <BreadcrumbSeparator />
                        <BreadcrumbItem>
                            <BreadcrumbEllipsis />
                        </BreadcrumbItem>
                        <BreadcrumbSeparator />
                        <BreadcrumbItem>
                            <BreadcrumbPage>Breadcrumb</BreadcrumbPage>
                        </BreadcrumbItem>
                    </BreadcrumbList>
                </Breadcrumb>
            </ShowcaseSection>
        </div>;
    }

    def:pub PaginationShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Pagination" description="Pagination with page navigation, next and previous links." name="pagination" />
            <ShowcaseSection title="Default" code={_codeExamples["pagination"]}>
                <Pagination>
                    <PaginationContent>
                        <PaginationItem>
                            <PaginationPrevious href="#" />
                        </PaginationItem>
                        <PaginationItem>
                            <PaginationLink href="#">1</PaginationLink>
                        </PaginationItem>
                        <PaginationItem>
                            <PaginationLink href="#" isActive={True}>2</PaginationLink>
                        </PaginationItem>
                        <PaginationItem>
                            <PaginationLink href="#">3</PaginationLink>
                        </PaginationItem>
                        <PaginationItem>
                            <PaginationEllipsis />
                        </PaginationItem>
                        <PaginationItem>
                            <PaginationNext href="#" />
                        </PaginationItem>
                    </PaginationContent>
                </Pagination>
            </ShowcaseSection>
        </div>;
    }

    def:pub NavigationMenuShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Navigation Menu" description="A collection of links for navigating websites." name="navigation-menu" />
            <ShowcaseSection title="Default" code={_codeExamples["navigation-menu"]}>
                <NavigationMenu>
                    <NavigationMenuList>
                        <NavigationMenuItem>
                            <NavigationMenuTrigger>Getting started</NavigationMenuTrigger>
                            <NavigationMenuContent>
                                <ul className="grid gap-3 p-4 w-48">
                                    <li>
                                        <NavigationMenuLink href="#">Introduction</NavigationMenuLink>
                                    </li>
                                    <li>
                                        <NavigationMenuLink href="#">Installation</NavigationMenuLink>
                                    </li>
                                    <li>
                                        <NavigationMenuLink href="#">Typography</NavigationMenuLink>
                                    </li>
                                </ul>
                            </NavigationMenuContent>
                        </NavigationMenuItem>
                        <NavigationMenuItem>
                            <NavigationMenuLink className={navigationMenuTriggerStyle()} href="#">Documentation</NavigationMenuLink>
                        </NavigationMenuItem>
                    </NavigationMenuList>
                </NavigationMenu>
            </ShowcaseSection>
        </div>;
    }

    def:pub MenubarShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Menubar" description="A visually persistent menu common in desktop applications." name="menubar" />
            <ShowcaseSection title="Default" code={_codeExamples["menubar"]}>
                <Menubar>
                    <MenubarMenu>
                        <MenubarTrigger>File</MenubarTrigger>
                        <MenubarContent>
                            <MenubarItem>New Tab</MenubarItem>
                            <MenubarItem>New Window</MenubarItem>
                            <MenubarSeparator />
                            <MenubarItem>Share</MenubarItem>
                            <MenubarSeparator />
                            <MenubarItem>Print</MenubarItem>
                        </MenubarContent>
                    </MenubarMenu>
                    <MenubarMenu>
                        <MenubarTrigger>Edit</MenubarTrigger>
                        <MenubarContent>
                            <MenubarItem>Undo</MenubarItem>
                            <MenubarItem>Redo</MenubarItem>
                            <MenubarSeparator />
                            <MenubarItem>Cut</MenubarItem>
                            <MenubarItem>Copy</MenubarItem>
                            <MenubarItem>Paste</MenubarItem>
                        </MenubarContent>
                    </MenubarMenu>
                    <MenubarMenu>
                        <MenubarTrigger>View</MenubarTrigger>
                        <MenubarContent>
                            <MenubarCheckboxItem checked={True}>Show Toolbar</MenubarCheckboxItem>
                            <MenubarSeparator />
                            <MenubarRadioGroup value="dark">
                                <MenubarLabel>Appearance</MenubarLabel>
                                <MenubarRadioItem value="light">Light</MenubarRadioItem>
                                <MenubarRadioItem value="dark">Dark</MenubarRadioItem>
                            </MenubarRadioGroup>
                        </MenubarContent>
                    </MenubarMenu>
                </Menubar>
            </ShowcaseSection>
        </div>;
    }

    def:pub SidebarShowcase() -> JsxElement {
        navItems = [
            {"title": "Home", "url": "#"},
            {"title": "Dashboard", "url": "#"},
            {"title": "Settings", "url": "#"}
        ];
        return <div className="space-y-8">
            <ShowcaseHeader title="Sidebar" description="A composable, themeable sidebar component." name="sidebar" />
            <ShowcaseSection title="Default" className="flex-col w-full" code={_codeExamples["sidebar"]}>
                <SidebarProvider style={{"--sidebar-width": "200px"}}>
                    <Sidebar collapsible="none" className="border">
                        <SidebarHeader className="p-2 font-semibold text-sm">My App</SidebarHeader>
                        <SidebarContent>
                            <SidebarGroup>
                                <SidebarGroupLabel>Navigation</SidebarGroupLabel>
                                <SidebarGroupContent>
                                    <SidebarMenu>
                                        {navItems.map(lambda(item: Any) -> Any {
                                            return <SidebarMenuItem key={item["title"]}>
                                                <SidebarMenuButton asChild={true}>
                                                    <a href={item["url"]}>{item["title"]}</a>
                                                </SidebarMenuButton>
                                            </SidebarMenuItem>;
                                        })}
                                    </SidebarMenu>
                                </SidebarGroupContent>
                            </SidebarGroup>
                        </SidebarContent>
                    </Sidebar>
                    <SidebarInset className="p-4 text-sm text-muted-foreground">Main content area</SidebarInset>
                </SidebarProvider>
            </ShowcaseSection>
        </div>;
    }

    def:pub CollapsibleShowcase() -> JsxElement {
        has open: bool = False;

        return <div className="space-y-8">
            <ShowcaseHeader title="Collapsible" description="An interactive component which expands/collapses a panel." name="collapsible" />
            <ShowcaseSection title="Default" code={_codeExamples["collapsible"]}>
                <Collapsible open={open} onOpenChange={lambda val: bool -> None { open = val; }} className="w-full max-w-sm space-y-2">
                    <div className="flex items-center justify-between space-x-4 px-4">
                        <h4 className="text-sm font-semibold">@peduarte starred 3 repositories</h4>
                        <CollapsibleTrigger asChild={True}>
                            <Button variant="ghost" size="sm">
                                <HugeiconsIcon icon={ArrowUpIcon if open else ArrowDownIcon} size={16} />
                            </Button>
                        </CollapsibleTrigger>
                    </div>
                    <div className="rounded-md border px-4 py-3 font-mono text-sm">@radix-ui/primitives</div>
                    <CollapsibleContent className="space-y-2">
                        <div className="rounded-md border px-4 py-3 font-mono text-sm">@radix-ui/colors</div>
                        <div className="rounded-md border px-4 py-3 font-mono text-sm">@stitches/react</div>
                    </CollapsibleContent>
                </Collapsible>
            </ShowcaseSection>
        </div>;
    }

}

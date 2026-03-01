cl import from ...lib.utils { cn }
cl import from ..ui.button { Button, buttonVariants }
cl import from ..ui.badge { Badge }
cl import from ..ui.card { Card, CardAction, CardContent, CardDescription, CardFooter, CardHeader, CardTitle }
cl import from ..ui.separator { Separator }
cl import from ..ui.avatar { Avatar, AvatarImage, AvatarFallback, AvatarBadge, AvatarGroup, AvatarGroupCount }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon, ArrowDownIcon, ArrowUpIcon, PlusSignIcon, DownloadIcon, MailIcon, SearchIcon, SettingsIcon, UserIcon, Copy01Icon, Tick01Icon, TextAlignLeftIcon, TextAlignCenterIcon, TextAlignRightIcon, TextBoldIcon, TextItalicIcon, TextUnderlineIcon }
cl import from "..ui.aspect-ratio" { AspectRatio }
cl import from ..ui.resizable { ResizablePanelGroup, ResizablePanel, ResizableHandle }
cl import from "..ui.scroll-area" { ScrollArea, ScrollBar }
cl import from ..ui.table { Table, TableHeader, TableBody, TableFooter, TableRow, TableHead, TableCell, TableCaption }
cl import from ..ui.item { Item, ItemGroup, ItemMedia, ItemContent, ItemTitle, ItemDescription, ItemActions, ItemSeparator }
cl import from ..ui.calendar { Calendar }
cl import from ..ui.carousel { Carousel, CarouselContent, CarouselItem, CarouselPrevious, CarouselNext }
cl import from ..ui.sidebar { Sidebar, SidebarContent, SidebarFooter, SidebarGroup, SidebarGroupContent, SidebarGroupLabel, SidebarHeader, SidebarInset, SidebarMenu, SidebarMenuButton, SidebarMenuItem, SidebarProvider, SidebarTrigger }
cl import from "recharts" { Bar, BarChart, CartesianGrid, XAxis, YAxis, Line, LineChart, Area, AreaChart, Pie, PieChart, RadialBar, RadialBarChart }
cl import from ".shared" { ShowcaseSection, ShowcaseHeader }

glob _codeExamples: dict = {
    "aspect-ratio": "cl import from '.ui.aspect-ratio' { AspectRatio }\n\n<AspectRatio ratio={16 / 9}>\n    <div className='flex h-full w-full items-center\n        justify-center bg-muted rounded-md'>\n        16 : 9\n    </div>\n</AspectRatio>",
    "aspect-ratio-4-3": "cl import from '.ui.aspect-ratio' { AspectRatio }\n\n<AspectRatio ratio={4 / 3}>\n    <div className='flex h-full w-full\n        items-center justify-center\n        bg-muted rounded-md'>\n        4 : 3\n    </div>\n</AspectRatio>",
    "avatar": "cl import from .ui.avatar {\n    Avatar, AvatarImage, AvatarFallback\n}\n\n<Avatar>\n    <AvatarImage src='https://github.com/shadcn.png' />\n    <AvatarFallback>CN</AvatarFallback>\n</Avatar>",
    "avatar-badge": "cl import from .ui.avatar {\n    Avatar, AvatarFallback, AvatarBadge\n}\n\n<Avatar>\n    <AvatarFallback>CN</AvatarFallback>\n    <AvatarBadge />\n</Avatar>",
    "avatar-group": "cl import from .ui.avatar {\n    Avatar, AvatarFallback,\n    AvatarGroup, AvatarGroupCount\n}\n\n<AvatarGroup>\n    <Avatar><AvatarFallback>A</AvatarFallback></Avatar>\n    <Avatar><AvatarFallback>B</AvatarFallback></Avatar>\n    <Avatar><AvatarFallback>C</AvatarFallback></Avatar>\n    <AvatarGroupCount>+3</AvatarGroupCount>\n</AvatarGroup>",
    "avatar-image": "cl import from .ui.avatar {\n    Avatar, AvatarImage, AvatarFallback\n}\n\n<Avatar>\n    <AvatarImage\n        src='https://github.com/shadcn.png'\n        alt='@shadcn' />\n    <AvatarFallback>CN</AvatarFallback>\n</Avatar>",
    "badge": "cl import from .ui.badge { Badge }\n\n<Badge>Default</Badge>\n<Badge variant='secondary'>Secondary</Badge>\n<Badge variant='destructive'>Destructive</Badge>\n<Badge variant='outline'>Outline</Badge>",
    "calendar": "cl import from .ui.calendar { Calendar }\n\n<Calendar mode='single' className='rounded-md border' />",
    "card": "cl import from .ui.card {\n    Card, CardHeader, CardTitle,\n    CardDescription, CardContent, CardFooter\n}\ncl import from .ui.button { Button }\n\n<Card className='w-full max-w-sm'>\n    <CardHeader>\n        <CardTitle>Card Title</CardTitle>\n        <CardDescription>Description</CardDescription>\n    </CardHeader>\n    <CardContent>\n        <p>Content goes here.</p>\n    </CardContent>\n    <CardFooter>\n        <Button>Action</Button>\n    </CardFooter>\n</Card>",
    "card-action": "cl import from .ui.card {\n    Card, CardHeader, CardTitle,\n    CardDescription, CardAction, CardContent\n}\n\n<Card>\n    <CardHeader>\n        <CardTitle>Notifications</CardTitle>\n        <CardDescription>3 unread messages.</CardDescription>\n        <CardAction>\n            <Button variant='outline' size='sm'>\n                View All\n            </Button>\n        </CardAction>\n    </CardHeader>\n    <CardContent>...</CardContent>\n</Card>",
    "carousel": "cl import from .ui.carousel {\n    Carousel, CarouselContent,\n    CarouselItem, CarouselPrevious,\n    CarouselNext\n}\n\n<Carousel>\n    <CarouselContent>\n        <CarouselItem>Slide 1</CarouselItem>\n        <CarouselItem>Slide 2</CarouselItem>\n        <CarouselItem>Slide 3</CarouselItem>\n    </CarouselContent>\n    <CarouselPrevious />\n    <CarouselNext />\n</Carousel>",
    "resizable": "cl import from .ui.resizable {\n    ResizablePanelGroup, ResizablePanel,\n    ResizableHandle\n}\n\n<ResizablePanelGroup direction='horizontal'>\n    <ResizablePanel defaultSize={50}>\n        <div>Sidebar</div>\n    </ResizablePanel>\n    <ResizableHandle withHandle={True} />\n    <ResizablePanel defaultSize={50}>\n        <div>Content</div>\n    </ResizablePanel>\n</ResizablePanelGroup>",
    "resizable-vertical": "cl import from .ui.resizable {\n    ResizablePanelGroup, ResizablePanel,\n    ResizableHandle\n}\n\n<ResizablePanelGroup direction='vertical'>\n    <ResizablePanel defaultSize={50}>\n        <div>Top</div>\n    </ResizablePanel>\n    <ResizableHandle withHandle={True} />\n    <ResizablePanel defaultSize={50}>\n        <div>Bottom</div>\n    </ResizablePanel>\n</ResizablePanelGroup>",
    "scroll-area": "cl import from '.ui.scroll-area' {\n    ScrollArea, ScrollBar\n}\n\n<ScrollArea className='h-48 w-64 rounded-md border'>\n    <div className='p-4'>\n        <h4 className='mb-4 font-medium'>Tags</h4>\n        {items.map(lambda(item: str) -> Any {\n            return <div key={item}>{item}</div>;\n        })}\n    </div>\n</ScrollArea>",
    "scroll-area-horizontal": "cl import from '.ui.scroll-area' {\n    ScrollArea, ScrollBar\n}\n\n<ScrollArea className='h-48 w-64 rounded-md border'>\n    <div className='flex w-max space-x-4 p-4'>\n        {items.map(lambda(tag: str) -> Any {\n            return <div key={tag}\n                className='shrink-0 w-24 rounded-md\n                    bg-muted p-2 text-xs'>\n                {tag}\n            </div>;\n        })}\n    </div>\n    <ScrollBar orientation='horizontal' />\n</ScrollArea>",
    "table": "cl import from .ui.table {\n    Table, TableHeader, TableBody,\n    TableRow, TableHead, TableCell\n}\n\n<Table>\n    <TableHeader>\n        <TableRow>\n            <TableHead>Name</TableHead>\n            <TableHead>Status</TableHead>\n        </TableRow>\n    </TableHeader>\n    <TableBody>\n        <TableRow>\n            <TableCell>Item 1</TableCell>\n            <TableCell>Active</TableCell>\n        </TableRow>\n    </TableBody>\n</Table>",
};

cl {
    def:pub CardShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Card"
                description="A container for grouped content and actions."
                name="card"
            />
            <ShowcaseSection title="Basic Card" className="flex-col" code={_codeExamples["card"]}>
                <Card className="w-full max-w-sm">
                    <CardHeader>
                        <CardTitle>Project Settings</CardTitle>
                        <CardDescription>Manage your project configuration</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <p className="text-sm text-muted-foreground">Configure your project settings, environment variables, and deployment options.</p>
                    </CardContent>
                    <CardFooter className="justify-end gap-2">
                        <Button variant="outline">Cancel</Button>
                        <Button>Save</Button>
                    </CardFooter>
                </Card>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Card with Action" className="flex-col" code={_codeExamples["card-action"]}>
                <Card className="w-full max-w-sm">
                    <CardHeader>
                        <CardTitle>Notifications</CardTitle>
                        <CardDescription>You have 3 unread messages.</CardDescription>
                        <CardAction>
                            <Button variant="outline" size="sm">View All</Button>
                        </CardAction>
                    </CardHeader>
                    <CardContent>
                        <div className="space-y-2">
                            <div className="flex items-center gap-2 rounded-md border p-3">
                                <HugeiconsIcon icon={MailIcon} strokeWidth={2} className="size-4 text-muted-foreground" />
                                <span className="text-sm">New message from team</span>
                            </div>
                            <div className="flex items-center gap-2 rounded-md border p-3">
                                <HugeiconsIcon icon={DownloadIcon} strokeWidth={2} className="size-4 text-muted-foreground" />
                                <span className="text-sm">Export completed</span>
                            </div>
                        </div>
                    </CardContent>
                </Card>
            </ShowcaseSection>
        </div>;
    }

    def:pub BadgeShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Badge"
                description="A small label for categorization or status display."
                name="badge"
            />
            <ShowcaseSection title="Variants" code={_codeExamples["badge"]}>
                <Badge>Default</Badge>
                <Badge variant="secondary">Secondary</Badge>
                <Badge variant="outline">Outline</Badge>
                <Badge variant="destructive">Destructive</Badge>
                <Badge variant="ghost">Ghost</Badge>
                <Badge variant="link">Link</Badge>
            </ShowcaseSection>
        </div>;
    }

    def:pub AvatarShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Avatar"
                description="An image element with a fallback for representing the user."
                name="avatar"
            />
            <ShowcaseSection title="Sizes" className="gap-4 items-end" code={_codeExamples["avatar"]}>
                <Avatar size="sm">
                    <AvatarFallback>SM</AvatarFallback>
                </Avatar>
                <Avatar>
                    <AvatarFallback>CN</AvatarFallback>
                </Avatar>
                <Avatar size="lg">
                    <AvatarFallback>LG</AvatarFallback>
                </Avatar>
            </ShowcaseSection>
            <ShowcaseSection title="With Image" className="gap-4 items-end" code={_codeExamples["avatar-image"]}>
                <Avatar>
                    <AvatarImage src="https://github.com/shadcn.png" alt="@shadcn" />
                    <AvatarFallback>CN</AvatarFallback>
                </Avatar>
                <Avatar>
                    <AvatarImage src="https://github.com/vercel.png" alt="@vercel" />
                    <AvatarFallback>VC</AvatarFallback>
                </Avatar>
            </ShowcaseSection>
            <ShowcaseSection title="With Badge" className="gap-4 items-end" code={_codeExamples["avatar-badge"]}>
                <Avatar>
                    <AvatarFallback>CN</AvatarFallback>
                    <AvatarBadge />
                </Avatar>
                <Avatar size="lg">
                    <AvatarFallback>LG</AvatarFallback>
                    <AvatarBadge />
                </Avatar>
            </ShowcaseSection>
            <ShowcaseSection title="Group" code={_codeExamples["avatar-group"]}>
                <AvatarGroup>
                    <Avatar>
                        <AvatarFallback>A</AvatarFallback>
                    </Avatar>
                    <Avatar>
                        <AvatarFallback>B</AvatarFallback>
                    </Avatar>
                    <Avatar>
                        <AvatarFallback>C</AvatarFallback>
                    </Avatar>
                    <AvatarGroupCount>+3</AvatarGroupCount>
                </AvatarGroup>
            </ShowcaseSection>
        </div>;
    }

    def:pub TableShowcase() -> JsxElement {
        invoices = [
            {"invoice": "INV001", "status": "Paid", "method": "Credit Card", "amount": "$250.00"},
            {"invoice": "INV002", "status": "Pending", "method": "PayPal", "amount": "$150.00"},
            {"invoice": "INV003", "status": "Unpaid", "method": "Bank Transfer", "amount": "$350.00"},
            {"invoice": "INV004", "status": "Paid", "method": "Credit Card", "amount": "$450.00"},
            {"invoice": "INV005", "status": "Paid", "method": "PayPal", "amount": "$550.00"}
        ];
        return <div className="space-y-8">
            <ShowcaseHeader title="Table" description="A responsive table component." name="table" />
            <ShowcaseSection title="Default" code={_codeExamples["table"]}>
                <Table className="max-w-2xl">
                    <TableCaption>A list of your recent invoices.</TableCaption>
                    <TableHeader>
                        <TableRow>
                            <TableHead className="w-28">Invoice</TableHead>
                            <TableHead>Status</TableHead>
                            <TableHead>Method</TableHead>
                            <TableHead className="text-right">Amount</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        {invoices.map(lambda inv: dict -> Any {
                            return <TableRow key={inv["invoice"]}>
                                <TableCell className="font-medium">{inv["invoice"]}</TableCell>
                                <TableCell>{inv["status"]}</TableCell>
                                <TableCell>{inv["method"]}</TableCell>
                                <TableCell className="text-right">{inv["amount"]}</TableCell>
                            </TableRow>;
                        })}
                    </TableBody>
                    <TableFooter>
                        <TableRow>
                            <TableCell colSpan={3}>Total</TableCell>
                            <TableCell className="text-right">$1,750.00</TableCell>
                        </TableRow>
                    </TableFooter>
                </Table>
            </ShowcaseSection>
        </div>;
    }

    def:pub CalendarShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Calendar" description="A date picker calendar component built on react-day-picker." name="calendar" />
            <ShowcaseSection title="Default" className="flex-col items-start" code={_codeExamples["calendar"]}>
                <Calendar mode="single" className="rounded-md border" />
            </ShowcaseSection>
        </div>;
    }

    def:pub CarouselShowcase() -> JsxElement {
        slides = [1, 2, 3, 4, 5];
        return <div className="space-y-8">
            <ShowcaseHeader title="Carousel" description="A carousel component with Embla Carousel." name="carousel" />
            <ShowcaseSection title="Default" code={_codeExamples["carousel"]}>
                <Carousel className="w-full max-w-xs">
                    <CarouselContent>
                        {slides.map(lambda(i: Any) -> Any {
                            return <CarouselItem key={i}>
                                <div className="p-1">
                                    <Card>
                                        <CardContent className="flex aspect-square items-center justify-center p-6">
                                            <span className="text-4xl font-semibold">{i}</span>
                                        </CardContent>
                                    </Card>
                                </div>
                            </CarouselItem>;
                        })}
                    </CarouselContent>
                    <CarouselPrevious />
                    <CarouselNext />
                </Carousel>
            </ShowcaseSection>
        </div>;
    }

    def:pub ScrollAreaShowcase() -> JsxElement {
        tags = ["v1.2.0 - Beta", "v1.1.0 - Stable", "v1.0.0 - Release", "v0.9.0 - RC", "v0.8.0 - Alpha", "v0.7.0 - Dev", "v0.6.0 - Pre-alpha", "v0.5.0 - Early", "v0.4.0 - Internal", "v0.3.0 - Draft"];
        return <div className="space-y-8">
            <ShowcaseHeader title="Scroll Area" description="Augments native scroll functionality for custom, cross-browser styling." name="scroll-area" />
            <ShowcaseSection title="Vertical" code={_codeExamples["scroll-area"]}>
                <ScrollArea className="h-48 w-64 rounded-md border">
                    <div className="p-4">
                        <h4 className="mb-4 text-sm font-medium leading-none">Tags</h4>
                        {tags.map(lambda tag: str -> Any {
                            return <div key={tag} className="text-sm py-1 border-b last:border-0">{tag}</div>;
                        })}
                    </div>
                </ScrollArea>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="With ScrollBar" code={_codeExamples["scroll-area-horizontal"]}>
                <ScrollArea className="h-48 w-64 rounded-md border">
                    <div className="flex w-max space-x-4 p-4">
                        {tags.map(lambda tag: str -> Any {
                            return <div key={tag} className="shrink-0 w-24 rounded-md bg-muted p-2 text-xs">{tag}</div>;
                        })}
                    </div>
                    <ScrollBar orientation="horizontal" />
                </ScrollArea>
            </ShowcaseSection>
        </div>;
    }

    def:pub AspectRatioShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Aspect Ratio" description="Displays content within a desired ratio." name="aspect-ratio" />
            <ShowcaseSection title="16 / 9" code={_codeExamples["aspect-ratio"]}>
                <div className="w-full max-w-sm overflow-hidden rounded-md">
                    <AspectRatio ratio={16 / 9}>
                        <div className="flex h-full w-full items-center justify-center bg-muted text-muted-foreground rounded-md">
                            16 : 9
                        </div>
                    </AspectRatio>
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="4 / 3" code={_codeExamples["aspect-ratio-4-3"]}>
                <div className="w-full max-w-xs overflow-hidden rounded-md">
                    <AspectRatio ratio={4 / 3}>
                        <div className="flex h-full w-full items-center justify-center bg-muted text-muted-foreground rounded-md">
                            4 : 3
                        </div>
                    </AspectRatio>
                </div>
            </ShowcaseSection>
        </div>;
    }

    def:pub ResizableShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Resizable" description="Accessible resizable panel groups and layouts." name="resizable" />
            <ShowcaseSection title="Horizontal" code={_codeExamples["resizable"]}>
                <ResizablePanelGroup direction="horizontal" className="max-w-md rounded-lg border">
                    <ResizablePanel defaultSize={50}>
                        <div className="flex h-32 items-center justify-center p-6">Sidebar</div>
                    </ResizablePanel>
                    <ResizableHandle withHandle={True} />
                    <ResizablePanel defaultSize={50}>
                        <div className="flex h-32 items-center justify-center p-6">Content</div>
                    </ResizablePanel>
                </ResizablePanelGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Vertical" code={_codeExamples["resizable-vertical"]}>
                <ResizablePanelGroup direction="vertical" className="max-w-md rounded-lg border" style={{"height": "200px"}}>
                    <ResizablePanel defaultSize={50}>
                        <div className="flex h-full items-center justify-center p-4">Top</div>
                    </ResizablePanel>
                    <ResizableHandle withHandle={True} />
                    <ResizablePanel defaultSize={50}>
                        <div className="flex h-full items-center justify-center p-4">Bottom</div>
                    </ResizablePanel>
                </ResizablePanelGroup>
            </ShowcaseSection>
        </div>;
    }

}

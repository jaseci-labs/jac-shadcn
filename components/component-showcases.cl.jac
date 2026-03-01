cl import from ..lib.utils { cn }
cl import from .ui.button { Button, buttonVariants }
cl import from .ui.badge { Badge }
cl import from .ui.card { Card, CardAction, CardContent, CardDescription, CardFooter, CardHeader, CardTitle }
cl import from .ui.input { Input }
cl import from ".ui.input-group" { InputGroup }
cl import from .ui.textarea { Textarea }
cl import from .ui.select { Select, SelectContent, SelectGroup, SelectItem, SelectTrigger, SelectValue }
cl import from .ui.combobox { Combobox, ComboboxContent, ComboboxEmpty, ComboboxInput, ComboboxItem, ComboboxList }
cl import from ".ui.dropdown-menu" { DropdownMenu, DropdownMenuCheckboxItem, DropdownMenuContent, DropdownMenuGroup, DropdownMenuItem, DropdownMenuLabel, DropdownMenuRadioGroup, DropdownMenuRadioItem, DropdownMenuSeparator, DropdownMenuShortcut, DropdownMenuSub, DropdownMenuSubContent, DropdownMenuSubTrigger, DropdownMenuTrigger, DropdownMenuPortal }
cl import from .ui.field { Field, FieldGroup, FieldLabel }
cl import from .ui.label { Label }
cl import from .ui.separator { Separator }
cl import from ".ui.alert-dialog" { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger }
cl import from ".ui.dialog" { Dialog, DialogClose, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger }
cl import from .ui.checkbox { Checkbox }
cl import from .ui.tabs { Tabs, TabsList, TabsTrigger, TabsContent }
cl import from .ui.switch { Switch }
cl import from .ui.tooltip { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger }
cl import from ".ui.radio-group" { RadioGroup, RadioGroupItem }
cl import from .ui.avatar { Avatar, AvatarImage, AvatarFallback, AvatarBadge, AvatarGroup, AvatarGroupCount }
cl import from .ui.progress { Progress }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon, ArrowDownIcon, ArrowUpIcon, PlusSignIcon, DownloadIcon, MailIcon, SearchIcon, SettingsIcon, UserIcon, Copy01Icon, Tick01Icon, TextAlignLeftIcon, TextAlignCenterIcon, TextAlignRightIcon, TextBoldIcon, TextItalicIcon, TextUnderlineIcon }
cl import from react { useState, useEffect }
cl import from .ui.accordion { Accordion, AccordionItem, AccordionTrigger, AccordionContent }
cl import from .ui.alert { Alert, AlertTitle, AlertDescription, AlertAction }
cl import from ".ui.aspect-ratio" { AspectRatio }
cl import from .ui.breadcrumb { Breadcrumb, BreadcrumbList, BreadcrumbItem, BreadcrumbLink, BreadcrumbPage, BreadcrumbSeparator, BreadcrumbEllipsis }
cl import from .ui.collapsible { Collapsible, CollapsibleTrigger, CollapsibleContent }
cl import from ".ui.context-menu" { ContextMenu, ContextMenuTrigger, ContextMenuContent, ContextMenuItem, ContextMenuSeparator, ContextMenuLabel, ContextMenuShortcut, ContextMenuCheckboxItem, ContextMenuRadioGroup, ContextMenuRadioItem }
cl import from .ui.drawer { Drawer, DrawerTrigger, DrawerContent, DrawerHeader, DrawerTitle, DrawerDescription, DrawerFooter, DrawerClose }
cl import from ".ui.hover-card" { HoverCard, HoverCardTrigger, HoverCardContent }
cl import from .ui.menubar { Menubar, MenubarMenu, MenubarTrigger, MenubarContent, MenubarItem, MenubarSeparator, MenubarShortcut, MenubarCheckboxItem, MenubarRadioGroup, MenubarRadioItem, MenubarLabel }
cl import from ".ui.navigation-menu" { NavigationMenu, NavigationMenuList, NavigationMenuItem, NavigationMenuTrigger, NavigationMenuContent, NavigationMenuLink, NavigationMenuViewport, navigationMenuTriggerStyle }
cl import from .ui.pagination { Pagination, PaginationContent, PaginationItem, PaginationLink, PaginationNext, PaginationPrevious, PaginationEllipsis }
cl import from .ui.popover { Popover, PopoverTrigger, PopoverContent }
cl import from .ui.resizable { ResizablePanelGroup, ResizablePanel, ResizableHandle }
cl import from ".ui.scroll-area" { ScrollArea, ScrollBar }
cl import from .ui.sheet { Sheet, SheetTrigger, SheetContent, SheetHeader, SheetTitle, SheetDescription, SheetFooter, SheetClose }
cl import from .ui.skeleton { Skeleton }
cl import from .ui.slider { Slider }
cl import from .ui.spinner { Spinner }
cl import from .ui.table { Table, TableHeader, TableBody, TableFooter, TableRow, TableHead, TableCell, TableCaption }
cl import from .ui.toggle { Toggle }
cl import from ".ui.toggle-group" { ToggleGroup, ToggleGroupItem }
cl import from ".ui.button-group" { ButtonGroup, ButtonGroupText, ButtonGroupSeparator }
cl import from .ui.empty { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription, EmptyContent }
cl import from .ui.kbd { Kbd, KbdGroup }
cl import from ".ui.native-select" { NativeSelect, NativeSelectOption }
cl import from .ui.item { Item, ItemGroup, ItemMedia, ItemContent, ItemTitle, ItemDescription, ItemActions, ItemSeparator }
cl import from .ui.calendar { Calendar }
cl import from .ui.carousel { Carousel, CarouselContent, CarouselItem, CarouselPrevious, CarouselNext }
cl import from .ui.chart { ChartContainer, ChartTooltip, ChartTooltipContent, ChartLegend, ChartLegendContent }
cl import from .ui.command { Command, CommandDialog, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList, CommandSeparator, CommandShortcut }
cl import from ".ui.otp-input" { InputOTP, InputOTPGroup, InputOTPSlot, InputOTPSeparator }
cl import from .ui.sidebar { Sidebar, SidebarContent, SidebarFooter, SidebarGroup, SidebarGroupContent, SidebarGroupLabel, SidebarHeader, SidebarInset, SidebarMenu, SidebarMenuButton, SidebarMenuItem, SidebarProvider, SidebarTrigger }
cl import from "recharts" { Bar, BarChart, CartesianGrid, XAxis, YAxis, Line, LineChart, Area, AreaChart, Pie, PieChart, RadialBar, RadialBarChart }

glob _frameworks: list = ["Next.js", "SvelteKit", "Nuxt.js", "Remix", "Astro"];

glob _codeExamples: dict = {
    "button": "cl import from .ui.button { Button }\n\n<Button>Click me</Button>\n<Button variant='secondary'>Secondary</Button>\n<Button variant='outline'>Outline</Button>\n<Button variant='destructive'>Destructive</Button>\n<Button variant='ghost'>Ghost</Button>\n<Button variant='link'>Link</Button>",
    "badge": "cl import from .ui.badge { Badge }\n\n<Badge>Default</Badge>\n<Badge variant='secondary'>Secondary</Badge>\n<Badge variant='destructive'>Destructive</Badge>\n<Badge variant='outline'>Outline</Badge>",
    "card": "cl import from .ui.card {\n    Card, CardHeader, CardTitle,\n    CardDescription, CardContent, CardFooter\n}\ncl import from .ui.button { Button }\n\n<Card className='w-full max-w-sm'>\n    <CardHeader>\n        <CardTitle>Card Title</CardTitle>\n        <CardDescription>Description</CardDescription>\n    </CardHeader>\n    <CardContent>\n        <p>Content goes here.</p>\n    </CardContent>\n    <CardFooter>\n        <Button>Action</Button>\n    </CardFooter>\n</Card>",
    "input": "cl import from .ui.input { Input }\n\n<Input placeholder='Type something...' />\n<Input type='email' placeholder='Email' />\n<Input disabled={True} />",
    "textarea": "cl import from .ui.textarea { Textarea }\n\n<Textarea placeholder='Write your message...' />\n<Textarea disabled={True} />",
    "select": "cl import from .ui.select {\n    Select, SelectContent, SelectGroup,\n    SelectItem, SelectTrigger, SelectValue\n}\n\n<Select>\n    <SelectTrigger>\n        <SelectValue placeholder='Pick an option' />\n    </SelectTrigger>\n    <SelectContent>\n        <SelectGroup>\n            <SelectItem value='opt1'>Option 1</SelectItem>\n            <SelectItem value='opt2'>Option 2</SelectItem>\n        </SelectGroup>\n    </SelectContent>\n</Select>",
    "combobox": "cl import from .ui.combobox {\n    Combobox, ComboboxContent, ComboboxEmpty,\n    ComboboxInput, ComboboxItem, ComboboxList\n}\n\nitems = ['Next.js', 'SvelteKit', 'Nuxt.js'];\n\n<Combobox items={items}>\n    <ComboboxInput placeholder='Search...' />\n    <ComboboxContent>\n        <ComboboxEmpty>No results.</ComboboxEmpty>\n        <ComboboxList>\n            {lambda(item: Any) -> Any {\n                return <ComboboxItem value={item}>\n                    {item}\n                </ComboboxItem>;\n            }}\n        </ComboboxList>\n    </ComboboxContent>\n</Combobox>",
    "dropdown-menu": "cl import from '.ui.dropdown-menu' {\n    DropdownMenu, DropdownMenuTrigger,\n    DropdownMenuContent, DropdownMenuItem\n}\n\n<DropdownMenu>\n    <DropdownMenuTrigger>Open Menu</DropdownMenuTrigger>\n    <DropdownMenuContent>\n        <DropdownMenuItem>Profile</DropdownMenuItem>\n        <DropdownMenuItem>Settings</DropdownMenuItem>\n        <DropdownMenuItem>Log out</DropdownMenuItem>\n    </DropdownMenuContent>\n</DropdownMenu>",
    "field": "cl import from .ui.field { Field, FieldGroup, FieldLabel }\ncl import from .ui.input { Input }\n\n<FieldGroup>\n    <Field>\n        <FieldLabel htmlFor='name'>Name</FieldLabel>\n        <Input id='name' placeholder='Enter name' />\n    </Field>\n    <Field>\n        <FieldLabel htmlFor='email'>Email</FieldLabel>\n        <Input id='email' type='email' />\n    </Field>\n</FieldGroup>",
    "input-group": "cl import from '.ui.input-group' { InputGroup }\ncl import from .ui.input { Input }\ncl import from .ui.button { Button }\n\n<InputGroup>\n    <Input placeholder='Search...' />\n    <Button>Go</Button>\n</InputGroup>",
    "label": "cl import from .ui.label { Label }\ncl import from .ui.input { Input }\n\n<Label htmlFor='username'>Username</Label>\n<Input id='username' placeholder='Enter username' />",
    "separator": "cl import from .ui.separator { Separator }\n\n<Separator />\n\n<div className='flex items-center gap-4 h-8'>\n    <span>Left</span>\n    <Separator orientation='vertical' />\n    <span>Right</span>\n</div>",
    "alert-dialog": "cl import from '.ui.alert-dialog' {\n    AlertDialog, AlertDialogTrigger,\n    AlertDialogContent, AlertDialogHeader,\n    AlertDialogTitle, AlertDialogDescription,\n    AlertDialogFooter, AlertDialogCancel,\n    AlertDialogAction\n}\n\n<AlertDialog>\n    <AlertDialogTrigger>Open</AlertDialogTrigger>\n    <AlertDialogContent>\n        <AlertDialogHeader>\n            <AlertDialogTitle>Confirm</AlertDialogTitle>\n            <AlertDialogDescription>\n                This action cannot be undone.\n            </AlertDialogDescription>\n        </AlertDialogHeader>\n        <AlertDialogFooter>\n            <AlertDialogCancel>Cancel</AlertDialogCancel>\n            <AlertDialogAction>Continue</AlertDialogAction>\n        </AlertDialogFooter>\n    </AlertDialogContent>\n</AlertDialog>",
    "dialog": "cl import from '.ui.dialog' {\n    Dialog, DialogTrigger, DialogContent,\n    DialogHeader, DialogTitle,\n    DialogDescription, DialogFooter\n}\n\n<Dialog>\n    <DialogTrigger asChild={True}>\n        <Button variant='outline'>Edit Profile</Button>\n    </DialogTrigger>\n    <DialogContent>\n        <DialogHeader>\n            <DialogTitle>Edit profile</DialogTitle>\n            <DialogDescription>Make changes here.</DialogDescription>\n        </DialogHeader>\n        <Input placeholder='Name' />\n        <DialogFooter>\n            <Button>Save changes</Button>\n        </DialogFooter>\n    </DialogContent>\n</Dialog>",
    "checkbox": "cl import from .ui.checkbox { Checkbox }\n\nhas checked: bool = False;\n\n<label className='flex items-center gap-2'>\n    <Checkbox\n        checked={checked}\n        onCheckedChange={lambda(v: Any) -> None {\n            checked = v;\n        }}\n    />\n    Accept terms\n</label>",
    "tabs": "cl import from .ui.tabs {\n    Tabs, TabsList, TabsTrigger, TabsContent\n}\n\n<Tabs defaultValue='account'>\n    <TabsList>\n        <TabsTrigger value='account'>Account</TabsTrigger>\n        <TabsTrigger value='password'>Password</TabsTrigger>\n    </TabsList>\n    <TabsContent value='account'>\n        Account settings here.\n    </TabsContent>\n    <TabsContent value='password'>\n        Password settings here.\n    </TabsContent>\n</Tabs>",
    "switch": "cl import from .ui.switch { Switch }\n\nhas enabled: bool = False;\n\n<label className='flex items-center gap-3'>\n    <Switch\n        checked={enabled}\n        onCheckedChange={lambda(v: Any) -> None {\n            enabled = v;\n        }}\n    />\n    Airplane Mode\n</label>",
    "tooltip": "cl import from .ui.tooltip {\n    Tooltip, TooltipContent,\n    TooltipProvider, TooltipTrigger\n}\n\n<TooltipProvider>\n    <Tooltip>\n        <TooltipTrigger>Hover me</TooltipTrigger>\n        <TooltipContent>\n            <p>Tooltip content</p>\n        </TooltipContent>\n    </Tooltip>\n</TooltipProvider>",
    "radio-group": "cl import from '.ui.radio-group' {\n    RadioGroup, RadioGroupItem\n}\n\nhas value: str = 'default';\n\n<RadioGroup value={value}\n    onValueChange={lambda(v: Any) -> None {\n        value = v;\n    }}>\n    <label className='flex items-center gap-3'>\n        <RadioGroupItem value='default' /> Default\n    </label>\n    <label className='flex items-center gap-3'>\n        <RadioGroupItem value='comfortable' /> Comfortable\n    </label>\n</RadioGroup>",
    "avatar": "cl import from .ui.avatar {\n    Avatar, AvatarImage, AvatarFallback\n}\n\n<Avatar>\n    <AvatarImage src='https://github.com/shadcn.png' />\n    <AvatarFallback>CN</AvatarFallback>\n</Avatar>",
    "progress": "cl import from .ui.progress { Progress }\n\nhas value: int = 40;\n\n<Progress value={value} />",
    "accordion": "cl import from .ui.accordion {\n    Accordion, AccordionItem,\n    AccordionTrigger, AccordionContent\n}\n\n<Accordion type='single' collapsible={True}>\n    <AccordionItem value='item-1'>\n        <AccordionTrigger>Is it accessible?</AccordionTrigger>\n        <AccordionContent>\n            Yes. It follows WAI-ARIA guidelines.\n        </AccordionContent>\n    </AccordionItem>\n</Accordion>",
    "alert": "cl import from .ui.alert {\n    Alert, AlertTitle, AlertDescription\n}\n\n<Alert>\n    <AlertTitle>Heads up!</AlertTitle>\n    <AlertDescription>\n        You can add components using the CLI.\n    </AlertDescription>\n</Alert>\n\n<Alert variant='destructive'>\n    <AlertTitle>Error</AlertTitle>\n    <AlertDescription>Session expired.</AlertDescription>\n</Alert>",
    "aspect-ratio": "cl import from '.ui.aspect-ratio' { AspectRatio }\n\n<AspectRatio ratio={16 / 9}>\n    <div className='flex h-full w-full items-center\n        justify-center bg-muted rounded-md'>\n        16 : 9\n    </div>\n</AspectRatio>",
    "breadcrumb": "cl import from .ui.breadcrumb {\n    Breadcrumb, BreadcrumbList,\n    BreadcrumbItem, BreadcrumbLink,\n    BreadcrumbPage, BreadcrumbSeparator\n}\n\n<Breadcrumb>\n    <BreadcrumbList>\n        <BreadcrumbItem>\n            <BreadcrumbLink href='#'>Home</BreadcrumbLink>\n        </BreadcrumbItem>\n        <BreadcrumbSeparator />\n        <BreadcrumbItem>\n            <BreadcrumbPage>Current</BreadcrumbPage>\n        </BreadcrumbItem>\n    </BreadcrumbList>\n</Breadcrumb>",
    "collapsible": "cl import from .ui.collapsible {\n    Collapsible, CollapsibleTrigger,\n    CollapsibleContent\n}\n\nhas open: bool = False;\n\n<Collapsible open={open}\n    onOpenChange={lambda(v: bool) -> None {\n        open = v;\n    }}>\n    <CollapsibleTrigger>Toggle</CollapsibleTrigger>\n    <CollapsibleContent>\n        <p>Collapsible content here.</p>\n    </CollapsibleContent>\n</Collapsible>",
    "context-menu": "cl import from '.ui.context-menu' {\n    ContextMenu, ContextMenuTrigger,\n    ContextMenuContent, ContextMenuItem\n}\n\n<ContextMenu>\n    <ContextMenuTrigger>\n        Right click here\n    </ContextMenuTrigger>\n    <ContextMenuContent>\n        <ContextMenuItem>Profile</ContextMenuItem>\n        <ContextMenuItem>Settings</ContextMenuItem>\n        <ContextMenuItem>Log out</ContextMenuItem>\n    </ContextMenuContent>\n</ContextMenu>",
    "drawer": "cl import from .ui.drawer {\n    Drawer, DrawerTrigger, DrawerContent,\n    DrawerHeader, DrawerTitle,\n    DrawerDescription, DrawerFooter, DrawerClose\n}\n\n<Drawer>\n    <DrawerTrigger asChild={True}>\n        <Button>Open Drawer</Button>\n    </DrawerTrigger>\n    <DrawerContent>\n        <DrawerHeader>\n            <DrawerTitle>Confirm</DrawerTitle>\n            <DrawerDescription>Are you sure?</DrawerDescription>\n        </DrawerHeader>\n        <DrawerFooter>\n            <Button>Submit</Button>\n            <DrawerClose asChild={True}>\n                <Button variant='outline'>Cancel</Button>\n            </DrawerClose>\n        </DrawerFooter>\n    </DrawerContent>\n</Drawer>",
    "hover-card": "cl import from '.ui.hover-card' {\n    HoverCard, HoverCardTrigger,\n    HoverCardContent\n}\n\n<HoverCard>\n    <HoverCardTrigger asChild={True}>\n        <Button variant='link'>@nextjs</Button>\n    </HoverCardTrigger>\n    <HoverCardContent>\n        <h4 className='font-semibold'>@nextjs</h4>\n        <p className='text-sm'>The React Framework.</p>\n    </HoverCardContent>\n</HoverCard>",
    "menubar": "cl import from .ui.menubar {\n    Menubar, MenubarMenu, MenubarTrigger,\n    MenubarContent, MenubarItem, MenubarSeparator\n}\n\n<Menubar>\n    <MenubarMenu>\n        <MenubarTrigger>File</MenubarTrigger>\n        <MenubarContent>\n            <MenubarItem>New Tab</MenubarItem>\n            <MenubarItem>New Window</MenubarItem>\n            <MenubarSeparator />\n            <MenubarItem>Print</MenubarItem>\n        </MenubarContent>\n    </MenubarMenu>\n</Menubar>",
    "navigation-menu": "cl import from '.ui.navigation-menu' {\n    NavigationMenu, NavigationMenuList,\n    NavigationMenuItem, NavigationMenuTrigger,\n    NavigationMenuContent, NavigationMenuLink\n}\n\n<NavigationMenu>\n    <NavigationMenuList>\n        <NavigationMenuItem>\n            <NavigationMenuTrigger>Getting started</NavigationMenuTrigger>\n            <NavigationMenuContent>\n                <ul className='grid gap-3 p-4'>\n                    <li>\n                        <NavigationMenuLink href='#'>\n                            Introduction\n                        </NavigationMenuLink>\n                    </li>\n                </ul>\n            </NavigationMenuContent>\n        </NavigationMenuItem>\n    </NavigationMenuList>\n</NavigationMenu>",
    "pagination": "cl import from .ui.pagination {\n    Pagination, PaginationContent,\n    PaginationItem, PaginationLink,\n    PaginationNext, PaginationPrevious\n}\n\n<Pagination>\n    <PaginationContent>\n        <PaginationItem>\n            <PaginationPrevious href='#' />\n        </PaginationItem>\n        <PaginationItem>\n            <PaginationLink href='#' isActive={True}>1</PaginationLink>\n        </PaginationItem>\n        <PaginationItem>\n            <PaginationLink href='#'>2</PaginationLink>\n        </PaginationItem>\n        <PaginationItem>\n            <PaginationNext href='#' />\n        </PaginationItem>\n    </PaginationContent>\n</Pagination>",
    "popover": "cl import from .ui.popover {\n    Popover, PopoverTrigger, PopoverContent\n}\n\n<Popover>\n    <PopoverTrigger asChild={True}>\n        <Button variant='outline'>Open</Button>\n    </PopoverTrigger>\n    <PopoverContent>\n        <h4 className='font-medium'>Settings</h4>\n        <p className='text-sm'>Adjust preferences.</p>\n    </PopoverContent>\n</Popover>",
    "resizable": "cl import from .ui.resizable {\n    ResizablePanelGroup, ResizablePanel,\n    ResizableHandle\n}\n\n<ResizablePanelGroup direction='horizontal'>\n    <ResizablePanel defaultSize={50}>\n        <div>Sidebar</div>\n    </ResizablePanel>\n    <ResizableHandle withHandle={True} />\n    <ResizablePanel defaultSize={50}>\n        <div>Content</div>\n    </ResizablePanel>\n</ResizablePanelGroup>",
    "scroll-area": "cl import from '.ui.scroll-area' {\n    ScrollArea, ScrollBar\n}\n\n<ScrollArea className='h-48 w-64 rounded-md border'>\n    <div className='p-4'>\n        <h4 className='mb-4 font-medium'>Tags</h4>\n        {items.map(lambda(item: str) -> Any {\n            return <div key={item}>{item}</div>;\n        })}\n    </div>\n</ScrollArea>",
    "sheet": "cl import from .ui.sheet {\n    Sheet, SheetTrigger, SheetContent,\n    SheetHeader, SheetTitle, SheetDescription\n}\n\n<Sheet>\n    <SheetTrigger asChild={True}>\n        <Button variant='outline'>Open Sheet</Button>\n    </SheetTrigger>\n    <SheetContent side='right'>\n        <SheetHeader>\n            <SheetTitle>Edit profile</SheetTitle>\n            <SheetDescription>Make changes here.</SheetDescription>\n        </SheetHeader>\n    </SheetContent>\n</Sheet>",
    "skeleton": "cl import from .ui.skeleton { Skeleton }\n\n<div className='flex items-center space-x-4'>\n    <Skeleton className='h-12 w-12 rounded-full' />\n    <div className='space-y-2'>\n        <Skeleton className='h-4 w-48' />\n        <Skeleton className='h-4 w-36' />\n    </div>\n</div>",
    "slider": "cl import from .ui.slider { Slider }\n\nhas value: list = [50];\n\n<Slider\n    defaultValue={[50]}\n    max={100}\n    step={1}\n    onValueChange={lambda(v: list) -> None {\n        value = v;\n    }}\n/>",
    "spinner": "cl import from .ui.spinner { Spinner }\n\n<Spinner size={16} />\n<Spinner size={24} />\n<Spinner size={32} />",
    "table": "cl import from .ui.table {\n    Table, TableHeader, TableBody,\n    TableRow, TableHead, TableCell\n}\n\n<Table>\n    <TableHeader>\n        <TableRow>\n            <TableHead>Name</TableHead>\n            <TableHead>Status</TableHead>\n        </TableRow>\n    </TableHeader>\n    <TableBody>\n        <TableRow>\n            <TableCell>Item 1</TableCell>\n            <TableCell>Active</TableCell>\n        </TableRow>\n    </TableBody>\n</Table>",
    "toggle": "cl import from .ui.toggle { Toggle }\n\n<Toggle aria-label='Bold'>\n    <HugeiconsIcon icon={TextBoldIcon} size={16} />\n</Toggle>\n<Toggle variant='outline' aria-label='Italic'>\n    <HugeiconsIcon icon={TextItalicIcon} size={16} />\n</Toggle>",
    "toggle-group": "cl import from '.ui.toggle-group' {\n    ToggleGroup, ToggleGroupItem\n}\n\n<ToggleGroup type='single' defaultValue='center'>\n    <ToggleGroupItem value='left'>Left</ToggleGroupItem>\n    <ToggleGroupItem value='center'>Center</ToggleGroupItem>\n    <ToggleGroupItem value='right'>Right</ToggleGroupItem>\n</ToggleGroup>",
    "button-group": "cl import from '.ui.button-group' {\n    ButtonGroup, ButtonGroupText\n}\ncl import from .ui.button { Button }\n\n<ButtonGroup>\n    <Button variant='outline'>Left</Button>\n    <Button variant='outline'>Center</Button>\n    <Button variant='outline'>Right</Button>\n</ButtonGroup>",
    "empty": "cl import from .ui.empty {\n    Empty, EmptyHeader, EmptyTitle,\n    EmptyDescription, EmptyContent\n}\n\n<Empty>\n    <EmptyHeader>\n        <EmptyTitle>No results found</EmptyTitle>\n        <EmptyDescription>\n            Try adjusting your search.\n        </EmptyDescription>\n    </EmptyHeader>\n    <EmptyContent>\n        <Button size='sm'>Clear filters</Button>\n    </EmptyContent>\n</Empty>",
    "kbd": "cl import from .ui.kbd { Kbd, KbdGroup }\n\n<Kbd>K</Kbd>\n\n<KbdGroup>\n    <Kbd>Ctrl</Kbd>\n    <Kbd>Shift</Kbd>\n    <Kbd>P</Kbd>\n</KbdGroup>",
    "native-select": "cl import from '.ui.native-select' {\n    NativeSelect, NativeSelectOption\n}\n\n<NativeSelect>\n    <NativeSelectOption value=''>Select...</NativeSelectOption>\n    <NativeSelectOption value='apple'>Apple</NativeSelectOption>\n    <NativeSelectOption value='banana'>Banana</NativeSelectOption>\n</NativeSelect>",
    "item": "cl import from .ui.item {\n    Item, ItemGroup, ItemContent,\n    ItemTitle, ItemDescription, ItemActions\n}\n\n<ItemGroup>\n    <Item>\n        <ItemContent>\n            <ItemTitle>Alice Johnson</ItemTitle>\n            <ItemDescription>alice@example.com</ItemDescription>\n        </ItemContent>\n        <ItemActions>\n            <Badge variant='secondary'>Admin</Badge>\n        </ItemActions>\n    </Item>\n</ItemGroup>",
    "calendar": "cl import from .ui.calendar { Calendar }\n\n<Calendar mode='single' className='rounded-md border' />",
    "carousel": "cl import from .ui.carousel {\n    Carousel, CarouselContent,\n    CarouselItem, CarouselPrevious,\n    CarouselNext\n}\n\n<Carousel>\n    <CarouselContent>\n        <CarouselItem>Slide 1</CarouselItem>\n        <CarouselItem>Slide 2</CarouselItem>\n        <CarouselItem>Slide 3</CarouselItem>\n    </CarouselContent>\n    <CarouselPrevious />\n    <CarouselNext />\n</Carousel>",
    "chart": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent\n}\ncl import from recharts { Bar, BarChart, XAxis }\n\nconfig = {\n    desktop: {\n        label: 'Desktop',\n        color: 'var(--chart-1)'\n    }\n};\n\n<ChartContainer config={config}>\n    <BarChart data={data}>\n        <XAxis dataKey='month' />\n        <ChartTooltip\n            content={<ChartTooltipContent />}\n        />\n        <Bar dataKey='desktop'\n            fill='var(--color-desktop)' />\n    </BarChart>\n</ChartContainer>",
    "command": "cl import from .ui.command {\n    Command, CommandInput, CommandList,\n    CommandEmpty, CommandGroup, CommandItem\n}\n\n<Command>\n    <CommandInput placeholder='Search...' />\n    <CommandList>\n        <CommandEmpty>No results.</CommandEmpty>\n        <CommandGroup heading='Suggestions'>\n            <CommandItem>Calendar</CommandItem>\n            <CommandItem>Search</CommandItem>\n            <CommandItem>Settings</CommandItem>\n        </CommandGroup>\n    </CommandList>\n</Command>",
    "input-otp": "cl import from '.ui.otp-input' {\n    InputOTP, InputOTPGroup,\n    InputOTPSlot, InputOTPSeparator\n}\n\n<InputOTP maxLength={6}>\n    <InputOTPGroup>\n        <InputOTPSlot index={0} />\n        <InputOTPSlot index={1} />\n        <InputOTPSlot index={2} />\n    </InputOTPGroup>\n    <InputOTPSeparator />\n    <InputOTPGroup>\n        <InputOTPSlot index={3} />\n        <InputOTPSlot index={4} />\n        <InputOTPSlot index={5} />\n    </InputOTPGroup>\n</InputOTP>",
    "sidebar": "cl import from .ui.sidebar {\n    Sidebar, SidebarContent, SidebarGroup,\n    SidebarGroupLabel, SidebarGroupContent,\n    SidebarMenu, SidebarMenuItem,\n    SidebarMenuButton, SidebarProvider\n}\n\n<SidebarProvider>\n    <Sidebar>\n        <SidebarContent>\n            <SidebarGroup>\n                <SidebarGroupLabel>Nav</SidebarGroupLabel>\n                <SidebarGroupContent>\n                    <SidebarMenu>\n                        <SidebarMenuItem>\n                            <SidebarMenuButton>\n                                Home\n                            </SidebarMenuButton>\n                        </SidebarMenuItem>\n                    </SidebarMenu>\n                </SidebarGroupContent>\n            </SidebarGroup>\n        </SidebarContent>\n    </Sidebar>\n</SidebarProvider>",
    "button-icon": "cl import from .ui.button { Button }\ncl import from '@hugeicons/react' { HugeiconsIcon }\ncl import from '@hugeicons/core-free-icons' {\n    ArrowRight01Icon\n}\n\n<Button>\n    Next\n    <HugeiconsIcon icon={ArrowRight01Icon}\n        data-icon='inline-end' />\n</Button>",
    "button-icon-left": "cl import from .ui.button { Button }\ncl import from '@hugeicons/react' { HugeiconsIcon }\ncl import from '@hugeicons/core-free-icons' { MailIcon }\n\n<Button>\n    <HugeiconsIcon icon={MailIcon}\n        data-icon='inline-start' />\n    Send Email\n</Button>",
    "button-icon-only": "cl import from .ui.button { Button }\ncl import from '@hugeicons/react' { HugeiconsIcon }\ncl import from '@hugeicons/core-free-icons' { PlusSignIcon }\n\n<Button size='icon'>\n    <HugeiconsIcon icon={PlusSignIcon} />\n</Button>\n<Button size='icon-sm' variant='outline'>\n    <HugeiconsIcon icon={PlusSignIcon} />\n</Button>",
    "button-disabled": "<Button disabled={True}>Disabled</Button>\n<Button variant='outline' disabled={True}>\n    Disabled\n</Button>",
    "card-action": "cl import from .ui.card {\n    Card, CardHeader, CardTitle,\n    CardDescription, CardAction, CardContent\n}\n\n<Card>\n    <CardHeader>\n        <CardTitle>Notifications</CardTitle>\n        <CardDescription>3 unread messages.</CardDescription>\n        <CardAction>\n            <Button variant='outline' size='sm'>\n                View All\n            </Button>\n        </CardAction>\n    </CardHeader>\n    <CardContent>...</CardContent>\n</Card>",
    "input-label": "cl import from .ui.field { Field, FieldLabel }\ncl import from .ui.input { Input }\n\n<Field>\n    <FieldLabel htmlFor='email'>Email</FieldLabel>\n    <Input id='email' type='email'\n        placeholder='you@example.com' />\n</Field>",
    "input-disabled": "<Input placeholder='Disabled' disabled={True} />",
    "textarea-label": "cl import from .ui.field { Field, FieldLabel }\ncl import from .ui.textarea { Textarea }\n\n<Field>\n    <FieldLabel htmlFor='bio'>Bio</FieldLabel>\n    <Textarea id='bio'\n        placeholder='Tell us about yourself...' />\n</Field>",
    "textarea-disabled": "<Textarea placeholder='Disabled'\n    disabled={True} />",
    "select-label": "cl import from .ui.field { Field, FieldLabel }\ncl import from .ui.select {\n    Select, SelectContent, SelectGroup,\n    SelectItem, SelectTrigger, SelectValue\n}\n\n<Field>\n    <FieldLabel>Role</FieldLabel>\n    <Select>\n        <SelectTrigger>\n            <SelectValue placeholder='Select role' />\n        </SelectTrigger>\n        <SelectContent>\n            <SelectGroup>\n                <SelectItem value='dev'>Developer</SelectItem>\n                <SelectItem value='design'>Designer</SelectItem>\n            </SelectGroup>\n        </SelectContent>\n    </Select>\n</Field>",
    "combobox-label": "cl import from .ui.field { Field, FieldLabel }\ncl import from .ui.combobox {\n    Combobox, ComboboxContent, ComboboxEmpty,\n    ComboboxInput, ComboboxItem, ComboboxList\n}\n\n<Field>\n    <FieldLabel>Framework</FieldLabel>\n    <Combobox items={items}>\n        <ComboboxInput placeholder='Select...' />\n        <ComboboxContent>\n            <ComboboxEmpty>No results.</ComboboxEmpty>\n            <ComboboxList>\n                {lambda(item: Any) -> Any {\n                    return <ComboboxItem value={item}>\n                        {item}\n                    </ComboboxItem>;\n                }}\n            </ComboboxList>\n        </ComboboxContent>\n    </Combobox>\n</Field>",
    "dropdown-submenu": "cl import from '.ui.dropdown-menu' {\n    DropdownMenu, DropdownMenuTrigger,\n    DropdownMenuContent, DropdownMenuItem,\n    DropdownMenuSub, DropdownMenuSubTrigger,\n    DropdownMenuSubContent, DropdownMenuPortal\n}\n\n<DropdownMenu>\n    <DropdownMenuTrigger>Actions</DropdownMenuTrigger>\n    <DropdownMenuContent>\n        <DropdownMenuItem>New File</DropdownMenuItem>\n        <DropdownMenuSub>\n            <DropdownMenuSubTrigger>Export</DropdownMenuSubTrigger>\n            <DropdownMenuPortal>\n                <DropdownMenuSubContent>\n                    <DropdownMenuItem>PDF</DropdownMenuItem>\n                    <DropdownMenuItem>CSV</DropdownMenuItem>\n                </DropdownMenuSubContent>\n            </DropdownMenuPortal>\n        </DropdownMenuSub>\n    </DropdownMenuContent>\n</DropdownMenu>",
    "field-horizontal": "cl import from .ui.field { Field }\ncl import from .ui.button { Button }\n\n<Field orientation='horizontal'>\n    <Button>Submit</Button>\n    <Button variant='outline'>Cancel</Button>\n</Field>",
    "input-group-email": "cl import from '.ui.input-group' { InputGroup }\ncl import from .ui.input { Input }\ncl import from .ui.button { Button }\n\n<InputGroup>\n    <Input placeholder='Enter your email'\n        type='email' />\n    <Button>Subscribe</Button>\n</InputGroup>",
    "separator-vertical": "cl import from .ui.separator { Separator }\n\n<div className='flex items-center gap-4 h-8'>\n    <span>Left</span>\n    <Separator orientation='vertical' />\n    <span>Center</span>\n    <Separator orientation='vertical' />\n    <span>Right</span>\n</div>",
    "dialog-no-close": "cl import from '.ui.dialog' {\n    Dialog, DialogTrigger, DialogContent,\n    DialogHeader, DialogTitle, DialogDescription,\n    DialogFooter, DialogClose\n}\n\n<Dialog>\n    <DialogTrigger asChild={True}>\n        <Button>Open</Button>\n    </DialogTrigger>\n    <DialogContent showCloseButton={False}>\n        <DialogHeader>\n            <DialogTitle>Title</DialogTitle>\n            <DialogDescription>No close button.</DialogDescription>\n        </DialogHeader>\n        <DialogFooter>\n            <DialogClose asChild={True}>\n                <Button variant='outline'>Close</Button>\n            </DialogClose>\n        </DialogFooter>\n    </DialogContent>\n</Dialog>",
    "dialog-sticky": "// Dialog with scrollable content\n// and a sticky footer\n<Dialog>\n    <DialogTrigger asChild={True}>\n        <Button>Open</Button>\n    </DialogTrigger>\n    <DialogContent>\n        <DialogHeader>\n            <DialogTitle>Scrollable</DialogTitle>\n        </DialogHeader>\n        <div className='max-h-[40vh] overflow-y-auto'>\n            <p>Long content here...</p>\n        </div>\n        <DialogFooter>\n            <Button>Save</Button>\n        </DialogFooter>\n    </DialogContent>\n</Dialog>",
    "checkbox-description": "cl import from .ui.checkbox { Checkbox }\n\n<label className='flex items-start gap-3'>\n    <Checkbox className='mt-0.5'\n        defaultChecked={True} />\n    <div className='space-y-1'>\n        <div className='text-sm font-medium'>\n            Accept terms\n        </div>\n        <div className='text-sm text-muted-foreground'>\n            You agree to our Terms of Service.\n        </div>\n    </div>\n</label>",
    "tabs-line": "cl import from .ui.tabs {\n    Tabs, TabsList, TabsTrigger, TabsContent\n}\n\n<Tabs defaultValue='general'>\n    <TabsList variant='line'>\n        <TabsTrigger value='general'>General</TabsTrigger>\n        <TabsTrigger value='security'>Security</TabsTrigger>\n    </TabsList>\n    <TabsContent value='general'>\n        General settings.\n    </TabsContent>\n    <TabsContent value='security'>\n        Security settings.\n    </TabsContent>\n</Tabs>",
    "tabs-disabled": "<Tabs defaultValue='active'>\n    <TabsList>\n        <TabsTrigger value='active'>Active</TabsTrigger>\n        <TabsTrigger value='disabled'\n            disabled={True}>Disabled</TabsTrigger>\n        <TabsTrigger value='other'>Other</TabsTrigger>\n    </TabsList>\n</Tabs>",
    "switch-sizes": "cl import from .ui.switch { Switch }\n\n<Switch size='sm' defaultChecked={True} />\n<Switch size='default' defaultChecked={True} />",
    "switch-disabled": "<Switch disabled={True} />\n<Switch disabled={True} checked={True} />",
    "switch-description": "cl import from .ui.switch { Switch }\n\n<div className='flex items-start gap-3'>\n    <Switch defaultChecked={True} />\n    <div className='space-y-1'>\n        <div className='text-sm font-medium'>\n            Marketing emails\n        </div>\n        <div className='text-sm text-muted-foreground'>\n            Receive emails about new products.\n        </div>\n    </div>\n</div>",
    "tooltip-sides": "cl import from .ui.tooltip {\n    Tooltip, TooltipContent,\n    TooltipProvider, TooltipTrigger\n}\n\n<TooltipProvider>\n    <Tooltip>\n        <TooltipTrigger>Top</TooltipTrigger>\n        <TooltipContent side='top'>\n            Top tooltip\n        </TooltipContent>\n    </Tooltip>\n    <Tooltip>\n        <TooltipTrigger>Right</TooltipTrigger>\n        <TooltipContent side='right'>\n            Right tooltip\n        </TooltipContent>\n    </Tooltip>\n</TooltipProvider>",
    "radio-disabled": "cl import from '.ui.radio-group' {\n    RadioGroup, RadioGroupItem\n}\n\n<RadioGroup defaultValue='option-1'>\n    <label className='flex items-center gap-3'>\n        <RadioGroupItem value='option-1' />\n        Option 1\n    </label>\n    <label className='flex items-center gap-3\n        text-muted-foreground'>\n        <RadioGroupItem value='option-2'\n            disabled={True} />\n        Option 2 (Disabled)\n    </label>\n</RadioGroup>",
    "avatar-image": "cl import from .ui.avatar {\n    Avatar, AvatarImage, AvatarFallback\n}\n\n<Avatar>\n    <AvatarImage\n        src='https://github.com/shadcn.png'\n        alt='@shadcn' />\n    <AvatarFallback>CN</AvatarFallback>\n</Avatar>",
    "avatar-badge": "cl import from .ui.avatar {\n    Avatar, AvatarFallback, AvatarBadge\n}\n\n<Avatar>\n    <AvatarFallback>CN</AvatarFallback>\n    <AvatarBadge />\n</Avatar>",
    "avatar-group": "cl import from .ui.avatar {\n    Avatar, AvatarFallback,\n    AvatarGroup, AvatarGroupCount\n}\n\n<AvatarGroup>\n    <Avatar><AvatarFallback>A</AvatarFallback></Avatar>\n    <Avatar><AvatarFallback>B</AvatarFallback></Avatar>\n    <Avatar><AvatarFallback>C</AvatarFallback></Avatar>\n    <AvatarGroupCount>+3</AvatarGroupCount>\n</AvatarGroup>",
    "progress-static": "cl import from .ui.progress { Progress }\n\n<Progress value={25} />\n<Progress value={50} />\n<Progress value={75} />\n<Progress value={100} />",
    "accordion-multiple": "cl import from .ui.accordion {\n    Accordion, AccordionItem,\n    AccordionTrigger, AccordionContent\n}\n\n<Accordion type='multiple'>\n    <AccordionItem value='item-1'>\n        <AccordionTrigger>\n            Can I open multiple?\n        </AccordionTrigger>\n        <AccordionContent>\n            Yes. Use type='multiple' to allow\n            multiple items open at once.\n        </AccordionContent>\n    </AccordionItem>\n    <AccordionItem value='item-2'>\n        <AccordionTrigger>\n            What about single mode?\n        </AccordionTrigger>\n        <AccordionContent>\n            Use type='single' for one at a time.\n        </AccordionContent>\n    </AccordionItem>\n</Accordion>",
    "alert-destructive": "cl import from .ui.alert {\n    Alert, AlertTitle, AlertDescription\n}\n\n<Alert variant='destructive'>\n    <AlertTitle>Error</AlertTitle>\n    <AlertDescription>\n        Your session has expired.\n    </AlertDescription>\n</Alert>",
    "aspect-ratio-4-3": "cl import from '.ui.aspect-ratio' { AspectRatio }\n\n<AspectRatio ratio={4 / 3}>\n    <div className='flex h-full w-full\n        items-center justify-center\n        bg-muted rounded-md'>\n        4 : 3\n    </div>\n</AspectRatio>",
    "breadcrumb-ellipsis": "cl import from .ui.breadcrumb {\n    Breadcrumb, BreadcrumbList,\n    BreadcrumbItem, BreadcrumbLink,\n    BreadcrumbPage, BreadcrumbSeparator,\n    BreadcrumbEllipsis\n}\n\n<Breadcrumb>\n    <BreadcrumbList>\n        <BreadcrumbItem>\n            <BreadcrumbLink href='#'>Home</BreadcrumbLink>\n        </BreadcrumbItem>\n        <BreadcrumbSeparator />\n        <BreadcrumbItem>\n            <BreadcrumbEllipsis />\n        </BreadcrumbItem>\n        <BreadcrumbSeparator />\n        <BreadcrumbItem>\n            <BreadcrumbPage>Current</BreadcrumbPage>\n        </BreadcrumbItem>\n    </BreadcrumbList>\n</Breadcrumb>",
    "resizable": "cl import from .ui.resizable {\n    ResizablePanelGroup, ResizablePanel,\n    ResizableHandle\n}\n\n<ResizablePanelGroup direction='horizontal'>\n    <ResizablePanel defaultSize={50}>\n        <div>Sidebar</div>\n    </ResizablePanel>\n    <ResizableHandle withHandle={True} />\n    <ResizablePanel defaultSize={50}>\n        <div>Content</div>\n    </ResizablePanel>\n</ResizablePanelGroup>",
    "resizable-vertical": "cl import from .ui.resizable {\n    ResizablePanelGroup, ResizablePanel,\n    ResizableHandle\n}\n\n<ResizablePanelGroup direction='vertical'>\n    <ResizablePanel defaultSize={50}>\n        <div>Top</div>\n    </ResizablePanel>\n    <ResizableHandle withHandle={True} />\n    <ResizablePanel defaultSize={50}>\n        <div>Bottom</div>\n    </ResizablePanel>\n</ResizablePanelGroup>",
    "scroll-area": "cl import from '.ui.scroll-area' {\n    ScrollArea, ScrollBar\n}\n\n<ScrollArea className='h-48 w-64 rounded-md border'>\n    <div className='p-4'>\n        <h4 className='mb-4 font-medium'>Tags</h4>\n        {items.map(lambda(item: str) -> Any {\n            return <div key={item}>{item}</div>;\n        })}\n    </div>\n</ScrollArea>",
    "scroll-area-horizontal": "cl import from '.ui.scroll-area' {\n    ScrollArea, ScrollBar\n}\n\n<ScrollArea className='h-48 w-64 rounded-md border'>\n    <div className='flex w-max space-x-4 p-4'>\n        {items.map(lambda(tag: str) -> Any {\n            return <div key={tag}\n                className='shrink-0 w-24 rounded-md\n                    bg-muted p-2 text-xs'>\n                {tag}\n            </div>;\n        })}\n    </div>\n    <ScrollBar orientation='horizontal' />\n</ScrollArea>",
    "sheet": "cl import from .ui.sheet {\n    Sheet, SheetTrigger, SheetContent,\n    SheetHeader, SheetTitle, SheetDescription\n}\n\n<Sheet>\n    <SheetTrigger asChild={True}>\n        <Button variant='outline'>Right</Button>\n    </SheetTrigger>\n    <SheetContent side='right'>\n        <SheetHeader>\n            <SheetTitle>Edit profile</SheetTitle>\n            <SheetDescription>\n                Make changes here.\n            </SheetDescription>\n        </SheetHeader>\n    </SheetContent>\n</Sheet>",
    "skeleton-card": "cl import from .ui.skeleton { Skeleton }\n\n<div className='flex items-center space-x-4'>\n    <Skeleton className='h-12 w-12 rounded-full' />\n    <div className='space-y-2'>\n        <Skeleton className='h-4 w-48' />\n        <Skeleton className='h-4 w-36' />\n    </div>\n</div>",
    "skeleton-table": "cl import from .ui.skeleton { Skeleton }\n\n<Skeleton className='h-8 w-full' />\n<Skeleton className='h-6 w-full' />\n<Skeleton className='h-6 w-full' />\n<Skeleton className='h-6 w-3/4' />",
    "slider-range": "cl import from .ui.slider { Slider }\n\n<Slider defaultValue={[20, 80]}\n    max={100} step={1} />",
    "slider-disabled": "<Slider defaultValue={[40]}\n    max={100} step={1} disabled={True} />",
    "spinner-text": "cl import from .ui.spinner { Spinner }\n\n<Spinner size={20} />\n<span className='text-sm text-muted-foreground'>\n    Loading...\n</span>",
    "toggle-sizes": "cl import from .ui.toggle { Toggle }\n\n<Toggle size='sm'>Sm</Toggle>\n<Toggle size='default'>Default</Toggle>\n<Toggle size='lg'>Lg</Toggle>",
    "toggle-disabled": "cl import from .ui.toggle { Toggle }\n\n<Toggle disabled={True} aria-label='Disabled'>\n    <HugeiconsIcon icon={TextUnderlineIcon}\n        size={16} />\n</Toggle>",
    "toggle-group-multiple": "cl import from '.ui.toggle-group' {\n    ToggleGroup, ToggleGroupItem\n}\n\n<ToggleGroup type='multiple'\n    defaultValue={['bold', 'italic']}>\n    <ToggleGroupItem value='bold'>B</ToggleGroupItem>\n    <ToggleGroupItem value='italic'>I</ToggleGroupItem>\n    <ToggleGroupItem value='underline'>U</ToggleGroupItem>\n</ToggleGroup>",
    "toggle-group-outline": "cl import from '.ui.toggle-group' {\n    ToggleGroup, ToggleGroupItem\n}\n\n<ToggleGroup type='single' variant='outline'\n    defaultValue='center'>\n    <ToggleGroupItem value='left'>Left</ToggleGroupItem>\n    <ToggleGroupItem value='center'>Center</ToggleGroupItem>\n    <ToggleGroupItem value='right'>Right</ToggleGroupItem>\n</ToggleGroup>",
    "button-group-addon": "cl import from '.ui.button-group' {\n    ButtonGroup, ButtonGroupText\n}\n\n<ButtonGroup>\n    <ButtonGroupText>https://</ButtonGroupText>\n    <Input placeholder='yoursite.com' />\n    <Button>Go</Button>\n</ButtonGroup>",
    "button-group-vertical": "cl import from '.ui.button-group' { ButtonGroup }\ncl import from .ui.button { Button }\n\n<ButtonGroup orientation='vertical'>\n    <Button variant='outline'>Top</Button>\n    <Button variant='outline'>Middle</Button>\n    <Button variant='outline'>Bottom</Button>\n</ButtonGroup>",
    "kbd-combinations": "cl import from .ui.kbd { Kbd, KbdGroup }\n\n<KbdGroup>\n    <Kbd>Ctrl</Kbd>\n    <Kbd>Shift</Kbd>\n    <Kbd>P</Kbd>\n</KbdGroup>",
    "native-select-small": "cl import from '.ui.native-select' {\n    NativeSelect, NativeSelectOption\n}\n\n<NativeSelect size='sm'>\n    <NativeSelectOption value=''>Small...</NativeSelectOption>\n    <NativeSelectOption value='a'>Option A</NativeSelectOption>\n    <NativeSelectOption value='b'>Option B</NativeSelectOption>\n</NativeSelect>",
    "native-select-disabled": "<NativeSelect disabled={True}>\n    <NativeSelectOption value=''>\n        Disabled select\n    </NativeSelectOption>\n</NativeSelect>",
    "item-variants": "cl import from .ui.item { Item, ItemContent, ItemTitle }\n\n<Item variant='default'>\n    <ItemContent><ItemTitle>Default</ItemTitle></ItemContent>\n</Item>\n<Item variant='muted'>\n    <ItemContent><ItemTitle>Muted</ItemTitle></ItemContent>\n</Item>\n<Item variant='outline'>\n    <ItemContent><ItemTitle>Outline</ItemTitle></ItemContent>\n</Item>",
    "chart-stacked": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent, ChartLegend,\n    ChartLegendContent\n}\ncl import from recharts { Bar, BarChart, XAxis }\n\n<ChartContainer config={multiConfig}>\n    <BarChart data={data}>\n        <XAxis dataKey='month' />\n        <ChartTooltip\n            content={<ChartTooltipContent />} />\n        <ChartLegend\n            content={<ChartLegendContent />} />\n        <Bar dataKey='desktop' stackId='a'\n            fill='var(--color-desktop)' />\n        <Bar dataKey='mobile' stackId='a'\n            fill='var(--color-mobile)' />\n    </BarChart>\n</ChartContainer>",
    "chart-line": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent, ChartLegend,\n    ChartLegendContent\n}\ncl import from recharts { Line, LineChart, XAxis }\n\n<ChartContainer config={multiConfig}>\n    <LineChart data={data}>\n        <XAxis dataKey='month' />\n        <ChartTooltip\n            content={<ChartTooltipContent />} />\n        <Line dataKey='desktop' type='monotone'\n            stroke='var(--color-desktop)' />\n        <Line dataKey='mobile' type='monotone'\n            stroke='var(--color-mobile)' />\n    </LineChart>\n</ChartContainer>",
    "chart-area": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent\n}\ncl import from recharts { Area, AreaChart, XAxis }\n\n<ChartContainer config={multiConfig}>\n    <AreaChart data={data}>\n        <XAxis dataKey='month' />\n        <ChartTooltip\n            content={<ChartTooltipContent />} />\n        <Area dataKey='desktop' type='natural'\n            fill='url(#fillDesktop)'\n            stroke='var(--color-desktop)' />\n    </AreaChart>\n</ChartContainer>",
    "chart-pie": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent\n}\ncl import from recharts { Pie, PieChart }\n\n<ChartContainer config={browserConfig}>\n    <PieChart>\n        <ChartTooltip\n            content={<ChartTooltipContent />} />\n        <Pie data={browserData}\n            dataKey='visitors'\n            nameKey='browser'\n            innerRadius={60} />\n    </PieChart>\n</ChartContainer>",
    "chart-radial": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent\n}\ncl import from recharts { RadialBar, RadialBarChart }\n\n<ChartContainer config={browserConfig}>\n    <RadialBarChart data={browserData}\n        innerRadius={30} outerRadius={110}>\n        <ChartTooltip\n            content={<ChartTooltipContent />} />\n        <RadialBar dataKey='visitors'\n            background={true} />\n    </RadialBarChart>\n</ChartContainer>"
};

# ── Helpers for code display ──

glob _BS: str = String.fromCharCode(92);
glob _NL: str = String.fromCharCode(10);
glob _BSN: str = _BS + "n";
glob _WB: str = _BS + "b";

glob _processCode: Any = lambda(raw: str) -> str {
    return raw.split(_BSN).join(_NL);
};

glob _highlightJac: Any = lambda(source: str) -> str {
    lines = source.split(_NL);
    highlighted = lines.map(lambda(line: str) -> str {
        # 1 ─ Extract single-quoted strings → placeholders
        strings = [];
        work = line.replace(RegExp("'[^']*'", "g"), lambda(m: str) -> str {
            strings.push(m);
            return "___S" + String(strings.length - 1) + "___";
        });

        # 2 ─ Extract // comments → placeholders
        comments = [];
        work = work.replace(RegExp("//.*", "g"), lambda(m: str) -> str {
            comments.push(m);
            return "___C" + String(comments.length - 1) + "___";
        });

        # 3 ─ HTML-escape
        work = work.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        # 4 ─ Keywords
        work = work.replace(
            RegExp(_WB + "(cl|import|from|def|has|return|lambda|if|else|for|in|True|False|None|and|or|not|pub|glob|type|new|let|const|var)" + _WB, "g"),
            "<span class='hl-kw'>$&</span>"
        );

        # 5 ─ JSX component names (PascalCase after &lt; or &lt;/)
        work = work.replace(
            RegExp("(&lt;/?)([A-Z][a-zA-Z0-9]*)", "g"),
            "$1<span class='hl-tag'>$2</span>"
        );

        # 6 ─ HTML element names
        work = work.replace(
            RegExp("(&lt;/?)(div|span|p|button|label|h[1-6]|a|img|input|form|ul|li|defs|stop|linearGradient)" + _WB, "g"),
            "$1<span class='hl-el'>$2</span>"
        );

        # 7 ─ Restore comments with hl-cmt
        work = comments.reduce(
            lambda(acc: str, c: str, i: int) -> str {
                escaped = c.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
                return acc.replace("___C" + String(i) + "___", "<span class='hl-cmt'>" + escaped + "</span>");
            },
            work
        );

        # 8 ─ Restore strings with hl-str
        return strings.reduce(
            lambda(acc: str, s: str, i: int) -> str {
                escaped = s.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
                return acc.replace("___S" + String(i) + "___", "<span class='hl-str'>" + escaped + "</span>");
            },
            work
        );
    });
    return highlighted.join(_NL);
};

cl {
    def:pub CopyCommand(props: Any) -> JsxElement {
        has copied: bool = False;
        cmd = "jac add --shadcn " + props.name;

        return <div className="group flex items-center gap-2 rounded-lg border border-border/60 bg-muted/30 px-3 py-2.5 font-mono text-sm transition-colors hover:bg-muted/50">
            <span className="text-muted-foreground select-none text-xs">$</span>
            <code className="flex-1 text-foreground/80 text-xs">{cmd}</code>
            <button
                onClick={lambda -> None {
                    navigator.clipboard.writeText(cmd);
                    copied = True;
                    setTimeout(lambda -> None { copied = False; }, 2000);
                }}
                className="shrink-0 rounded-md p-1 text-muted-foreground hover:text-foreground transition-colors cursor-pointer bg-transparent border-none outline-none"
            >
                {copied
                    and <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-3.5 text-green-500" />
                    or <HugeiconsIcon icon={Copy01Icon} strokeWidth={2} className="size-3.5" />}
            </button>
        </div>;
    }

    def:pub ShowcaseSection(props: Any) -> JsxElement {
        has showCode: bool = False;
        has copied: bool = False;
        code = props.code or "";
        hasCode = code.length > 0;

        # Process literal \n → actual newlines
        processedCode = _processCode(code);
        highlightedHtml = _highlightJac(processedCode);

        handleCopy = lambda -> None {
            navigator.clipboard.writeText(processedCode);
            copied = True;
            setTimeout(lambda -> None { copied = False; }, 2000);
        };

        lines = processedCode.split(_NL);
        previewHtml = _highlightJac(lines.slice(0, 3).join(_NL));

        return <div className="space-y-3">
            {props.title and <h3 className="text-sm font-medium text-muted-foreground">{props.title}</h3>}
            <div className="rounded-xl border overflow-hidden">
                <div className={cn("flex flex-wrap items-center gap-2 p-6 min-h-[120px] justify-center", props.className)}>
                    {props.children}
                </div>
                {hasCode and (
                    <div className="relative border-t bg-zinc-50 dark:bg-zinc-900">
                        {showCode and (
                            <div className="relative">
                                <button
                                    onClick={handleCopy}
                                    className="absolute right-3 top-3 inline-flex items-center justify-center rounded-md p-1.5 text-zinc-500 hover:text-zinc-900 dark:text-zinc-400 dark:hover:text-zinc-100 hover:bg-zinc-200/60 dark:hover:bg-zinc-800 transition-colors z-10 cursor-pointer border-none outline-none bg-transparent"
                                >
                                    {copied
                                        and <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-3.5 text-green-500" />
                                        or <HugeiconsIcon icon={Copy01Icon} strokeWidth={2} className="size-3.5" />
                                    }
                                </button>
                                <div className="overflow-x-auto overflow-y-auto max-h-[400px]">
                                    <pre className="p-4 pr-12 text-[13px] font-mono leading-relaxed text-zinc-800 dark:text-zinc-300">
                                        <code dangerouslySetInnerHTML={{"__html": highlightedHtml}} />
                                    </pre>
                                </div>
                                <div className="flex justify-center border-t border-zinc-200 dark:border-zinc-800 py-2">
                                    <button
                                        onClick={lambda -> None { showCode = False; }}
                                        className="text-xs text-zinc-500 hover:text-zinc-900 dark:text-zinc-400 dark:hover:text-zinc-200 transition-colors cursor-pointer border-none outline-none bg-transparent"
                                    >
                                        Collapse
                                    </button>
                                </div>
                            </div>
                        ) or (
                            <div className="relative">
                                <div className="overflow-hidden max-h-[72px]">
                                    <pre className="p-4 text-[13px] font-mono leading-relaxed text-zinc-800 dark:text-zinc-300">
                                        <code dangerouslySetInnerHTML={{"__html": previewHtml}} />
                                    </pre>
                                </div>
                                <div className="absolute inset-0 flex items-center justify-center">
                                    <div className="absolute inset-0 bg-gradient-to-t from-zinc-50 via-zinc-50/70 to-transparent dark:from-zinc-900 dark:via-zinc-900/70" />
                                    <button
                                        onClick={lambda -> None { showCode = True; }}
                                        className="relative z-10 inline-flex items-center rounded-lg border border-zinc-300 bg-white px-3 py-1.5 text-xs font-medium text-zinc-700 hover:bg-zinc-100 hover:border-zinc-400 dark:border-zinc-700 dark:bg-zinc-800 dark:text-zinc-200 dark:hover:bg-zinc-700 dark:hover:border-zinc-600 transition-colors cursor-pointer shadow-sm"
                                    >
                                        View Code
                                    </button>
                                </div>
                            </div>
                        )}
                    </div>
                )}
            </div>
        </div>;
    }

    def:pub ShowcaseHeader(props: Any) -> JsxElement {
        return <div className="space-y-3 pb-4 mb-6 border-b border-border/50">
            <div className="flex items-center gap-2">
                <h2 className="text-2xl font-semibold tracking-tight">{props.title}</h2>
            </div>
            {props.description and <p className="text-sm text-muted-foreground max-w-2xl">{props.description}</p>}
            <CopyCommand name={props.name} />
        </div>;
    }

    def:pub ButtonShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Button"
                description="A clickable element that triggers an action."
                name="button"
            />
            <ShowcaseSection title="Variants & Sizes" code={_codeExamples["button"]}>
                <div className="space-y-3 w-full">
                    {["default", "sm", "lg", "xs"].map(lambda(size: Any) -> Any {
                        return <div key={size} className="flex flex-wrap items-center gap-2">
                            <Button size={size}>Default</Button>
                            <Button variant="secondary" size={size}>Secondary</Button>
                            <Button variant="outline" size={size}>Outline</Button>
                            <Button variant="ghost" size={size}>Ghost</Button>
                            <Button variant="destructive" size={size}>Destructive</Button>
                            <Button variant="link" size={size}>Link</Button>
                        </div>;
                    })}
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Icon Right" code={_codeExamples["button-icon"]}>
                <div className="space-y-3 w-full">
                    {["default", "sm", "lg", "xs"].map(lambda(size: Any) -> Any {
                        return <div key={size} className="flex flex-wrap items-center gap-2">
                            <Button size={size}>Default <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                            <Button variant="secondary" size={size}>Secondary <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                            <Button variant="outline" size={size}>Outline <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                            <Button variant="ghost" size={size}>Ghost <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                            <Button variant="destructive" size={size}>Destructive <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                            <Button variant="link" size={size}>Link <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                        </div>;
                    })}
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Icon Left" code={_codeExamples["button-icon-left"]}>
                <div className="space-y-3 w-full">
                    <div className="flex flex-wrap items-center gap-2">
                        <Button><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Default</Button>
                        <Button variant="secondary"><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Secondary</Button>
                        <Button variant="outline"><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Outline</Button>
                        <Button variant="ghost"><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Ghost</Button>
                        <Button variant="destructive"><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Destructive</Button>
                        <Button variant="link"><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Link</Button>
                    </div>
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Icon Only" code={_codeExamples["button-icon-only"]}>
                <div className="flex flex-wrap items-center gap-2">
                    <Button size="icon"><HugeiconsIcon icon={PlusSignIcon} strokeWidth={2} /></Button>
                    <Button size="icon-sm" variant="outline"><HugeiconsIcon icon={SettingsIcon} strokeWidth={2} /></Button>
                    <Button size="icon-xs" variant="ghost"><HugeiconsIcon icon={SearchIcon} strokeWidth={2} /></Button>
                    <Button size="icon-lg" variant="secondary"><HugeiconsIcon icon={UserIcon} strokeWidth={2} /></Button>
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Disabled" code={_codeExamples["button-disabled"]}>
                <Button disabled={True}>Disabled</Button>
                <Button variant="outline" disabled={True}>Disabled</Button>
                <Button variant="secondary" disabled={True}>Disabled</Button>
                <Button variant="ghost" disabled={True}>Disabled</Button>
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

    def:pub InputShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Input"
                description="A text input field for user data entry."
                name="input"
            />
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm" code={_codeExamples["input"]}>
                <Input placeholder="Type something..." />
            </ShowcaseSection>
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm" code={_codeExamples["input-label"]}>
                <Field>
                    <FieldLabel htmlFor="email-input">Email</FieldLabel>
                    <Input id="email-input" type="email" placeholder="you@example.com" />
                </Field>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled" className="flex-col items-start max-w-sm" code={_codeExamples["input-disabled"]}>
                <Input placeholder="Disabled input" disabled={True} />
            </ShowcaseSection>
        </div>;
    }

    def:pub TextareaShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Textarea"
                description="A multi-line text input area."
                name="textarea"
            />
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm" code={_codeExamples["textarea"]}>
                <Textarea placeholder="Write your message here..." />
            </ShowcaseSection>
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm" code={_codeExamples["textarea-label"]}>
                <Field>
                    <FieldLabel htmlFor="bio-textarea">Bio</FieldLabel>
                    <Textarea id="bio-textarea" placeholder="Tell us about yourself..." />
                </Field>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled" className="flex-col items-start max-w-sm" code={_codeExamples["textarea-disabled"]}>
                <Textarea placeholder="Disabled textarea" disabled={True} />
            </ShowcaseSection>
        </div>;
    }

    def:pub SelectShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Select"
                description="A dropdown for selecting from a list of options."
                name="select"
            />
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm" code={_codeExamples["select"]}>
                <Select>
                    <SelectTrigger>
                        <SelectValue placeholder="Select a framework" />
                    </SelectTrigger>
                    <SelectContent>
                        <SelectGroup>
                            <SelectItem value="nextjs">Next.js</SelectItem>
                            <SelectItem value="svelte">SvelteKit</SelectItem>
                            <SelectItem value="nuxt">Nuxt.js</SelectItem>
                            <SelectItem value="remix">Remix</SelectItem>
                            <SelectItem value="astro">Astro</SelectItem>
                        </SelectGroup>
                    </SelectContent>
                </Select>
            </ShowcaseSection>
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm" code={_codeExamples["select-label"]}>
                <Field>
                    <FieldLabel>Role</FieldLabel>
                    <Select defaultValue="">
                        <SelectTrigger>
                            <SelectValue placeholder="Select a role" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectGroup>
                                <SelectItem value="developer">Developer</SelectItem>
                                <SelectItem value="designer">Designer</SelectItem>
                                <SelectItem value="manager">Manager</SelectItem>
                            </SelectGroup>
                        </SelectContent>
                    </Select>
                </Field>
            </ShowcaseSection>
        </div>;
    }

    def:pub ComboboxShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Combobox"
                description="An input with searchable dropdown for autocomplete."
                name="combobox"
            />
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm" code={_codeExamples["combobox"]}>
                <Combobox items={_frameworks}>
                    <ComboboxInput placeholder="Search frameworks..." />
                    <ComboboxContent>
                        <ComboboxEmpty>No frameworks found.</ComboboxEmpty>
                        <ComboboxList>
                            {lambda(item: Any) -> Any {
                                return <ComboboxItem key={item} value={item}>{item}</ComboboxItem>;
                            }}
                        </ComboboxList>
                    </ComboboxContent>
                </Combobox>
            </ShowcaseSection>
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm" code={_codeExamples["combobox-label"]}>
                <Field>
                    <FieldLabel>Framework</FieldLabel>
                    <Combobox items={_frameworks}>
                        <ComboboxInput placeholder="Select a framework" />
                        <ComboboxContent>
                            <ComboboxEmpty>No frameworks found.</ComboboxEmpty>
                            <ComboboxList>
                                {lambda(item: Any) -> Any {
                                    return <ComboboxItem key={item} value={item}>{item}</ComboboxItem>;
                                }}
                            </ComboboxList>
                        </ComboboxContent>
                    </Combobox>
                </Field>
            </ShowcaseSection>
        </div>;
    }

    def:pub DropdownMenuShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Dropdown Menu"
                description="A menu with actions, triggered by a button."
                name="dropdown-menu"
            />
            <ShowcaseSection title="Default" code={_codeExamples["dropdown-menu"]}>
                <DropdownMenu>
                    <DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "outline"})}>
                        Open Menu
                    </DropdownMenuTrigger>
                    <DropdownMenuContent className="w-48">
                        <DropdownMenuGroup>
                            <DropdownMenuLabel>Account</DropdownMenuLabel>
                            <DropdownMenuItem>
                                <HugeiconsIcon icon={UserIcon} strokeWidth={2} />
                                Profile
                                <DropdownMenuShortcut>{"⇧⌘P"}</DropdownMenuShortcut>
                            </DropdownMenuItem>
                            <DropdownMenuItem>
                                <HugeiconsIcon icon={SettingsIcon} strokeWidth={2} />
                                Settings
                            </DropdownMenuItem>
                        </DropdownMenuGroup>
                        <DropdownMenuSeparator />
                        <DropdownMenuGroup>
                            <DropdownMenuItem variant="destructive">
                                Log out
                                <DropdownMenuShortcut>{"⇧⌘Q"}</DropdownMenuShortcut>
                            </DropdownMenuItem>
                        </DropdownMenuGroup>
                    </DropdownMenuContent>
                </DropdownMenu>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="With Sub-menus" code={_codeExamples["dropdown-submenu"]}>
                <DropdownMenu>
                    <DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "outline"})}>
                        More Actions
                    </DropdownMenuTrigger>
                    <DropdownMenuContent className="w-56">
                        <DropdownMenuGroup>
                            <DropdownMenuItem>
                                <HugeiconsIcon icon={PlusSignIcon} strokeWidth={2} />
                                New File
                            </DropdownMenuItem>
                            <DropdownMenuSub>
                                <DropdownMenuSubTrigger>
                                    <HugeiconsIcon icon={DownloadIcon} strokeWidth={2} />
                                    Export
                                </DropdownMenuSubTrigger>
                                <DropdownMenuPortal>
                                    <DropdownMenuSubContent>
                                        <DropdownMenuItem>PDF</DropdownMenuItem>
                                        <DropdownMenuItem>CSV</DropdownMenuItem>
                                        <DropdownMenuItem>JSON</DropdownMenuItem>
                                    </DropdownMenuSubContent>
                                </DropdownMenuPortal>
                            </DropdownMenuSub>
                        </DropdownMenuGroup>
                    </DropdownMenuContent>
                </DropdownMenu>
            </ShowcaseSection>
        </div>;
    }

    def:pub FieldShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Field"
                description="A form field container with label and validation support."
                name="field"
            />
            <ShowcaseSection title="Field Group" className="flex-col items-start max-w-sm" code={_codeExamples["field"]}>
                <FieldGroup>
                    <Field>
                        <FieldLabel htmlFor="fg-name">Name</FieldLabel>
                        <Input id="fg-name" placeholder="Enter your name" />
                    </Field>
                    <Field>
                        <FieldLabel htmlFor="fg-email">Email</FieldLabel>
                        <Input id="fg-email" type="email" placeholder="you@example.com" />
                    </Field>
                    <Field>
                        <FieldLabel htmlFor="fg-bio">Bio</FieldLabel>
                        <Textarea id="fg-bio" placeholder="Tell us about yourself..." />
                    </Field>
                </FieldGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Horizontal" className="flex-col items-start max-w-sm" code={_codeExamples["field-horizontal"]}>
                <Field orientation="horizontal">
                    <Button>Submit</Button>
                    <Button variant="outline">Cancel</Button>
                </Field>
            </ShowcaseSection>
        </div>;
    }

    def:pub InputGroupShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Input Group"
                description="Combine inputs and buttons into a single visual group."
                name="input-group"
            />
            <ShowcaseSection title="Search" className="flex-col items-start max-w-sm" code={_codeExamples["input-group"]}>
                <InputGroup>
                    <Input placeholder="Search..." />
                    <Button>
                        <HugeiconsIcon icon={SearchIcon} strokeWidth={2} />
                    </Button>
                </InputGroup>
            </ShowcaseSection>
            <ShowcaseSection title="Email Subscribe" className="flex-col items-start max-w-sm" code={_codeExamples["input-group-email"]}>
                <InputGroup>
                    <Input placeholder="Enter your email" type="email" />
                    <Button>Subscribe</Button>
                </InputGroup>
            </ShowcaseSection>
        </div>;
    }

    def:pub LabelShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Label"
                description="A text label associated with a form control."
                name="label"
            />
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm" code={_codeExamples["label"]}>
                <Label htmlFor="label-demo">Username</Label>
                <Input id="label-demo" placeholder="Enter username" />
            </ShowcaseSection>
        </div>;
    }

    def:pub SeparatorShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Separator"
                description="A visual divider between content sections."
                name="separator"
            />
            <ShowcaseSection title="Horizontal" className="flex-col w-full max-w-sm" code={_codeExamples["separator"]}>
                <div className="w-full space-y-2">
                    <p className="text-sm">Content above</p>
                    <Separator />
                    <p className="text-sm">Content below</p>
                </div>
            </ShowcaseSection>
            <ShowcaseSection title="Vertical" code={_codeExamples["separator-vertical"]}>
                <div className="flex items-center gap-4 h-8">
                    <span className="text-sm">Left</span>
                    <Separator orientation="vertical" />
                    <span className="text-sm">Center</span>
                    <Separator orientation="vertical" />
                    <span className="text-sm">Right</span>
                </div>
            </ShowcaseSection>
        </div>;
    }

    def:pub AlertDialogShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Alert Dialog"
                description="A modal dialog for important confirmations."
                name="alert-dialog"
            />
            <ShowcaseSection title="Default" code={_codeExamples["alert-dialog"]}>
                <AlertDialog>
                    <AlertDialogTrigger className={buttonVariants().call(None, {"variant": "outline"})}>
                        Delete Account
                    </AlertDialogTrigger>
                    <AlertDialogContent>
                        <AlertDialogHeader>
                            <AlertDialogTitle>Are you sure{"?"}</AlertDialogTitle>
                            <AlertDialogDescription>
                                This action cannot be undone. This will permanently delete your account and remove your data from our servers.
                            </AlertDialogDescription>
                        </AlertDialogHeader>
                        <AlertDialogFooter>
                            <AlertDialogCancel>Cancel</AlertDialogCancel>
                            <AlertDialogAction>Continue</AlertDialogAction>
                        </AlertDialogFooter>
                    </AlertDialogContent>
                </AlertDialog>
            </ShowcaseSection>
        </div>;
    }

    def:pub DialogShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Dialog"
                description="A modal dialog that interrupts the user with important content and expects a response."
                name="dialog"
            />
            <ShowcaseSection title="With Form" className="items-center justify-center" code={_codeExamples["dialog"]}>
                <Dialog>
                    <DialogTrigger asChild={True}>
                        <Button variant="outline">Edit Profile</Button>
                    </DialogTrigger>
                    <DialogContent>
                        <DialogHeader>
                            <DialogTitle>Edit profile</DialogTitle>
                            <DialogDescription>
                                Make changes to your profile here. Click save when you are done.
                            </DialogDescription>
                        </DialogHeader>
                        <FieldGroup>
                            <Field>
                                <FieldLabel htmlFor="dialog-name">Name</FieldLabel>
                                <Input id="dialog-name" defaultValue="Pedro Duarte" />
                            </Field>
                            <Field>
                                <FieldLabel htmlFor="dialog-username">Username</FieldLabel>
                                <Input id="dialog-username" defaultValue="@peduarte" />
                            </Field>
                        </FieldGroup>
                        <DialogFooter>
                            <DialogClose asChild={True}>
                                <Button variant="outline">Cancel</Button>
                            </DialogClose>
                            <Button>Save changes</Button>
                        </DialogFooter>
                    </DialogContent>
                </Dialog>
            </ShowcaseSection>
            <ShowcaseSection title="No Close Button" className="items-center justify-center" code={_codeExamples["dialog-no-close"]}>
                <Dialog>
                    <DialogTrigger asChild={True}>
                        <Button variant="outline">No Close Button</Button>
                    </DialogTrigger>
                    <DialogContent showCloseButton={False}>
                        <DialogHeader>
                            <DialogTitle>No Close Button</DialogTitle>
                            <DialogDescription>
                                This dialog does not have a close button in the top-right corner.
                            </DialogDescription>
                        </DialogHeader>
                        <DialogFooter>
                            <DialogClose asChild={True}>
                                <Button variant="outline">Close</Button>
                            </DialogClose>
                        </DialogFooter>
                    </DialogContent>
                </Dialog>
            </ShowcaseSection>
            <ShowcaseSection title="With Sticky Footer" className="items-center justify-center" code={_codeExamples["dialog-sticky"]}>
                <Dialog>
                    <DialogTrigger asChild={True}>
                        <Button variant="outline">Sticky Footer</Button>
                    </DialogTrigger>
                    <DialogContent>
                        <DialogHeader>
                            <DialogTitle>Scrollable Content</DialogTitle>
                            <DialogDescription>
                                This is a dialog with scrollable content and a sticky footer.
                            </DialogDescription>
                        </DialogHeader>
                        <div className="max-h-[40vh] overflow-y-auto no-scrollbar -mx-4 px-4">
                            <p className="mb-4 leading-normal text-sm text-muted-foreground">
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                            </p>
                            <p className="mb-4 leading-normal text-sm text-muted-foreground">
                                Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>
                            <p className="mb-4 leading-normal text-sm text-muted-foreground">
                                Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
                            </p>
                            <p className="mb-4 leading-normal text-sm text-muted-foreground">
                                Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.
                            </p>
                            <p className="mb-4 leading-normal text-sm text-muted-foreground">
                                Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.
                            </p>
                        </div>
                        <DialogFooter>
                            <DialogClose asChild={True}>
                                <Button variant="outline">Close</Button>
                            </DialogClose>
                        </DialogFooter>
                    </DialogContent>
                </Dialog>
            </ShowcaseSection>
        </div>;
    }

    def:pub CheckboxShowcase() -> JsxElement {
        has checked1: bool = True;
        has checked2: bool = False;
        has checked3: Any = "indeterminate";
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Checkbox"
                description="A control that allows the user to toggle between checked and not checked."
                name="checkbox"
            />
            <ShowcaseSection title="States" className="gap-6" code={_codeExamples["checkbox"]}>
                <label className="flex items-center gap-2 text-sm">
                    <Checkbox checked={checked1} onCheckedChange={lambda(v: Any) -> None { checked1 = v; }} />
                    Checked
                </label>
                <label className="flex items-center gap-2 text-sm">
                    <Checkbox checked={checked2} onCheckedChange={lambda(v: Any) -> None { checked2 = v; }} />
                    Unchecked
                </label>
                <label className="flex items-center gap-2 text-sm">
                    <Checkbox disabled={True} />
                    Disabled
                </label>
                <label className="flex items-center gap-2 text-sm">
                    <Checkbox checked={True} disabled={True} />
                    Checked Disabled
                </label>
            </ShowcaseSection>
            <ShowcaseSection title="With Description" code={_codeExamples["checkbox-description"]}>
                <div className="space-y-4">
                    <label className="flex items-start gap-3">
                        <Checkbox className="mt-0.5" defaultChecked={True} />
                        <div className="space-y-1">
                            <div className="text-sm font-medium">Accept terms and conditions</div>
                            <div className="text-sm text-muted-foreground">You agree to our Terms of Service and Privacy Policy.</div>
                        </div>
                    </label>
                    <label className="flex items-start gap-3">
                        <Checkbox className="mt-0.5" />
                        <div className="space-y-1">
                            <div className="text-sm font-medium">Marketing emails</div>
                            <div className="text-sm text-muted-foreground">Receive emails about new products, features, and more.</div>
                        </div>
                    </label>
                </div>
            </ShowcaseSection>
        </div>;
    }

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

    def:pub SwitchShowcase() -> JsxElement {
        has airplaneMode: bool = False;
        has notifications: bool = True;
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Switch"
                description="A control that allows the user to toggle between on and off."
                name="switch"
            />
            <ShowcaseSection title="Default" className="gap-6" code={_codeExamples["switch"]}>
                <label className="flex items-center gap-3 text-sm">
                    <Switch checked={airplaneMode} onCheckedChange={lambda(v: Any) -> None { airplaneMode = v; }} />
                    Airplane Mode
                </label>
                <label className="flex items-center gap-3 text-sm">
                    <Switch checked={notifications} onCheckedChange={lambda(v: Any) -> None { notifications = v; }} />
                    Notifications
                </label>
            </ShowcaseSection>
            <ShowcaseSection title="Sizes" className="gap-6" code={_codeExamples["switch-sizes"]}>
                <label className="flex items-center gap-3 text-sm">
                    <Switch size="sm" defaultChecked={True} />
                    Small
                </label>
                <label className="flex items-center gap-3 text-sm">
                    <Switch size="default" defaultChecked={True} />
                    Default
                </label>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled" className="gap-6" code={_codeExamples["switch-disabled"]}>
                <label className="flex items-center gap-3 text-sm text-muted-foreground">
                    <Switch disabled={True} />
                    Disabled Off
                </label>
                <label className="flex items-center gap-3 text-sm text-muted-foreground">
                    <Switch disabled={True} checked={True} />
                    Disabled On
                </label>
            </ShowcaseSection>
            <ShowcaseSection title="With Description" code={_codeExamples["switch-description"]}>
                <div className="flex items-start gap-3">
                    <Switch defaultChecked={True} className="mt-0.5" />
                    <div className="space-y-1">
                        <div className="text-sm font-medium">Marketing emails</div>
                        <div className="text-sm text-muted-foreground">Receive emails about new products, features, and more.</div>
                    </div>
                </div>
            </ShowcaseSection>
        </div>;
    }

    def:pub TooltipShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Tooltip"
                description="A popup that displays information related to an element when it receives keyboard focus or the mouse hovers over it."
                name="tooltip"
            />
            <ShowcaseSection title="Default" className="gap-4" code={_codeExamples["tooltip"]}>
                <TooltipProvider>
                    <Tooltip>
                        <TooltipTrigger asChild={True}>
                            <button className={buttonVariants().call(None, {"variant": "outline"})}>Hover me</button>
                        </TooltipTrigger>
                        <TooltipContent>
                            <p>This is a tooltip</p>
                        </TooltipContent>
                    </Tooltip>
                </TooltipProvider>
            </ShowcaseSection>
            <ShowcaseSection title="Sides" className="gap-4" code={_codeExamples["tooltip-sides"]}>
                <TooltipProvider>
                    <Tooltip>
                        <TooltipTrigger asChild={True}>
                            <button className={buttonVariants().call(None, {"variant": "outline", "size": "sm"})}>Top</button>
                        </TooltipTrigger>
                        <TooltipContent side="top"><p>Top tooltip</p></TooltipContent>
                    </Tooltip>
                    <Tooltip>
                        <TooltipTrigger asChild={True}>
                            <button className={buttonVariants().call(None, {"variant": "outline", "size": "sm"})}>Right</button>
                        </TooltipTrigger>
                        <TooltipContent side="right"><p>Right tooltip</p></TooltipContent>
                    </Tooltip>
                    <Tooltip>
                        <TooltipTrigger asChild={True}>
                            <button className={buttonVariants().call(None, {"variant": "outline", "size": "sm"})}>Bottom</button>
                        </TooltipTrigger>
                        <TooltipContent side="bottom"><p>Bottom tooltip</p></TooltipContent>
                    </Tooltip>
                    <Tooltip>
                        <TooltipTrigger asChild={True}>
                            <button className={buttonVariants().call(None, {"variant": "outline", "size": "sm"})}>Left</button>
                        </TooltipTrigger>
                        <TooltipContent side="left"><p>Left tooltip</p></TooltipContent>
                    </Tooltip>
                </TooltipProvider>
            </ShowcaseSection>
        </div>;
    }

    def:pub RadioGroupShowcase() -> JsxElement {
        has selectedValue: str = "comfortable";
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Radio Group"
                description="A set of checkable buttons where no more than one can be checked at a time."
                name="radio-group"
            />
            <ShowcaseSection title="Default" code={_codeExamples["radio-group"]}>
                <RadioGroup value={selectedValue} onValueChange={lambda(v: Any) -> None { selectedValue = v; }} className="max-w-xs">
                    <label className="flex items-center gap-3 text-sm">
                        <RadioGroupItem value="default" />
                        Default
                    </label>
                    <label className="flex items-center gap-3 text-sm">
                        <RadioGroupItem value="comfortable" />
                        Comfortable
                    </label>
                    <label className="flex items-center gap-3 text-sm">
                        <RadioGroupItem value="compact" />
                        Compact
                    </label>
                </RadioGroup>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled" code={_codeExamples["radio-disabled"]}>
                <RadioGroup defaultValue="option-1" className="max-w-xs">
                    <label className="flex items-center gap-3 text-sm">
                        <RadioGroupItem value="option-1" />
                        Option 1
                    </label>
                    <label className="flex items-center gap-3 text-sm text-muted-foreground">
                        <RadioGroupItem value="option-2" disabled={True} />
                        Option 2 (Disabled)
                    </label>
                    <label className="flex items-center gap-3 text-sm">
                        <RadioGroupItem value="option-3" />
                        Option 3
                    </label>
                </RadioGroup>
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

    def:pub ProgressShowcase() -> JsxElement {
        has progressValue: int = 40;

        useEffect(lambda -> Any {
            timer = setInterval(lambda -> None {
                progressValue = progressValue + 10;
                if progressValue > 100 {
                    progressValue = 0;
                }
            }, 1500);
            return lambda -> None { clearInterval(timer); };
        }, []);

        return <div className="space-y-8">
            <ShowcaseHeader
                title="Progress"
                description="Displays an indicator showing the completion progress of a task."
                name="progress"
            />
            <ShowcaseSection title="Default" code={_codeExamples["progress"]}>
                <div className="w-full max-w-md space-y-2">
                    <Progress value={progressValue} />
                    <p className="text-sm text-muted-foreground text-right">{String(progressValue) + "%"}</p>
                </div>
            </ShowcaseSection>
            <ShowcaseSection title="Static Values" className="flex-col gap-4" code={_codeExamples["progress-static"]}>
                <div className="w-full max-w-md space-y-1">
                    <p className="text-sm text-muted-foreground">25%</p>
                    <Progress value={25} />
                </div>
                <div className="w-full max-w-md space-y-1">
                    <p className="text-sm text-muted-foreground">50%</p>
                    <Progress value={50} />
                </div>
                <div className="w-full max-w-md space-y-1">
                    <p className="text-sm text-muted-foreground">75%</p>
                    <Progress value={75} />
                </div>
                <div className="w-full max-w-md space-y-1">
                    <p className="text-sm text-muted-foreground">100%</p>
                    <Progress value={100} />
                </div>
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

    def:pub AlertShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Alert" description="Displays a callout for user attention." name="alert" />
            <ShowcaseSection title="Default" className="flex-col gap-4" code={_codeExamples["alert"]}>
                <Alert className="max-w-md">
                    <AlertTitle>Heads up!</AlertTitle>
                    <AlertDescription>You can add components to your app using the cli.</AlertDescription>
                </Alert>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Destructive" className="flex-col gap-4" code={_codeExamples["alert-destructive"]}>
                <Alert variant="destructive" className="max-w-md">
                    <AlertTitle>Error</AlertTitle>
                    <AlertDescription>Your session has expired. Please log in again.</AlertDescription>
                </Alert>
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

    def:pub ContextMenuShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Context Menu" description="Displays a menu on right-click." name="context-menu" />
            <ShowcaseSection title="Default" code={_codeExamples["context-menu"]}>
                <ContextMenu>
                    <ContextMenuTrigger className="flex h-32 w-64 items-center justify-center rounded-md border border-dashed text-sm">
                        Right click here
                    </ContextMenuTrigger>
                    <ContextMenuContent className="w-48">
                        <ContextMenuItem>Profile</ContextMenuItem>
                        <ContextMenuItem>Settings</ContextMenuItem>
                        <ContextMenuSeparator />
                        <ContextMenuCheckboxItem checked={True}>Show Toolbar</ContextMenuCheckboxItem>
                        <ContextMenuSeparator />
                        <ContextMenuRadioGroup value="dark">
                            <ContextMenuLabel>Theme</ContextMenuLabel>
                            <ContextMenuRadioItem value="light">Light</ContextMenuRadioItem>
                            <ContextMenuRadioItem value="dark">Dark</ContextMenuRadioItem>
                        </ContextMenuRadioGroup>
                        <ContextMenuSeparator />
                        <ContextMenuItem>Log out</ContextMenuItem>
                    </ContextMenuContent>
                </ContextMenu>
            </ShowcaseSection>
        </div>;
    }

    def:pub DrawerShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Drawer" description="A drawer component for mobile-friendly dialogs." name="drawer" />
            <ShowcaseSection title="Bottom Drawer" code={_codeExamples["drawer"]}>
                <Drawer>
                    <DrawerTrigger asChild={True}>
                        <Button variant="outline">Open Drawer</Button>
                    </DrawerTrigger>
                    <DrawerContent>
                        <DrawerHeader>
                            <DrawerTitle>Are you absolutely sure?</DrawerTitle>
                            <DrawerDescription>This action cannot be undone.</DrawerDescription>
                        </DrawerHeader>
                        <DrawerFooter>
                            <Button>Submit</Button>
                            <DrawerClose asChild={True}>
                                <Button variant="outline">Cancel</Button>
                            </DrawerClose>
                        </DrawerFooter>
                    </DrawerContent>
                </Drawer>
            </ShowcaseSection>
        </div>;
    }

    def:pub HoverCardShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Hover Card" description="For sighted users to preview content available behind a link." name="hover-card" />
            <ShowcaseSection title="Default" code={_codeExamples["hover-card"]}>
                <HoverCard>
                    <HoverCardTrigger asChild={True}>
                        <Button variant="link">@nextjs</Button>
                    </HoverCardTrigger>
                    <HoverCardContent className="w-80">
                        <div className="flex justify-between space-x-4">
                            <div className="space-y-1">
                                <h4 className="text-sm font-semibold">@nextjs</h4>
                                <p className="text-sm">The React Framework - created and maintained by @vercel.</p>
                                <div className="flex items-center pt-2">
                                    <span className="text-xs text-muted-foreground">Joined December 2021</span>
                                </div>
                            </div>
                        </div>
                    </HoverCardContent>
                </HoverCard>
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

    def:pub PopoverShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Popover" description="Displays rich content in a portal, triggered by a button." name="popover" />
            <ShowcaseSection title="Default" code={_codeExamples["popover"]}>
                <Popover>
                    <PopoverTrigger asChild={True}>
                        <Button variant="outline">Open popover</Button>
                    </PopoverTrigger>
                    <PopoverContent className="w-80">
                        <div className="grid gap-4">
                            <div className="space-y-2">
                                <h4 className="font-medium leading-none">Dimensions</h4>
                                <p className="text-sm text-muted-foreground">Set the dimensions for the layer.</p>
                            </div>
                            <div className="grid gap-2">
                                <div className="grid grid-cols-3 items-center gap-4">
                                    <Label>Width</Label>
                                    <Input defaultValue="100%" className="col-span-2 h-8" />
                                </div>
                                <div className="grid grid-cols-3 items-center gap-4">
                                    <Label>Height</Label>
                                    <Input defaultValue="25px" className="col-span-2 h-8" />
                                </div>
                            </div>
                        </div>
                    </PopoverContent>
                </Popover>
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

    def:pub SheetShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Sheet" description="Extends the Dialog component to display content that complements the main content." name="sheet" />
            <ShowcaseSection title="Sides" className="flex-wrap gap-3" code={_codeExamples["sheet"]}>
                <Sheet>
                    <SheetTrigger asChild={True}>
                        <Button variant="outline">Right</Button>
                    </SheetTrigger>
                    <SheetContent side="right">
                        <SheetHeader>
                            <SheetTitle>Edit profile</SheetTitle>
                            <SheetDescription>Make changes to your profile here.</SheetDescription>
                        </SheetHeader>
                        <div className="grid gap-4 py-4">
                            <div className="grid grid-cols-4 items-center gap-4">
                                <Label className="text-right">Name</Label>
                                <Input defaultValue="Pedro Duarte" className="col-span-3" />
                            </div>
                        </div>
                        <SheetFooter>
                            <SheetClose asChild={True}>
                                <Button type="submit">Save changes</Button>
                            </SheetClose>
                        </SheetFooter>
                    </SheetContent>
                </Sheet>
                <Sheet>
                    <SheetTrigger asChild={True}>
                        <Button variant="outline">Left</Button>
                    </SheetTrigger>
                    <SheetContent side="left">
                        <SheetHeader>
                            <SheetTitle>Navigation</SheetTitle>
                            <SheetDescription>Browse pages from here.</SheetDescription>
                        </SheetHeader>
                    </SheetContent>
                </Sheet>
                <Sheet>
                    <SheetTrigger asChild={True}>
                        <Button variant="outline">Top</Button>
                    </SheetTrigger>
                    <SheetContent side="top">
                        <SheetHeader>
                            <SheetTitle>Top Sheet</SheetTitle>
                            <SheetDescription>A sheet that slides down from the top.</SheetDescription>
                        </SheetHeader>
                    </SheetContent>
                </Sheet>
                <Sheet>
                    <SheetTrigger asChild={True}>
                        <Button variant="outline">Bottom</Button>
                    </SheetTrigger>
                    <SheetContent side="bottom">
                        <SheetHeader>
                            <SheetTitle>Bottom Sheet</SheetTitle>
                            <SheetDescription>A sheet that slides up from the bottom.</SheetDescription>
                        </SheetHeader>
                    </SheetContent>
                </Sheet>
            </ShowcaseSection>
        </div>;
    }

    def:pub SkeletonShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Skeleton" description="Use to show a placeholder while content is loading." name="skeleton" />
            <ShowcaseSection title="Card Skeleton" className="flex-col gap-4" code={_codeExamples["skeleton"]}>
                <div className="flex items-center space-x-4">
                    <Skeleton className="h-12 w-12 rounded-full" />
                    <div className="space-y-2">
                        <Skeleton className="h-4 w-48" />
                        <Skeleton className="h-4 w-36" />
                    </div>
                </div>
                <Skeleton className="h-32 w-full max-w-sm rounded-xl" />
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Table Skeleton" className="flex-col gap-2" code={_codeExamples["skeleton-table"]}>
                <Skeleton className="h-8 w-full max-w-sm" />
                <Skeleton className="h-6 w-full max-w-sm" />
                <Skeleton className="h-6 w-full max-w-sm" />
                <Skeleton className="h-6 w-3/4 max-w-sm" />
            </ShowcaseSection>
        </div>;
    }

    def:pub SliderShowcase() -> JsxElement {
        has sliderValue: list = [50];

        return <div className="space-y-8">
            <ShowcaseHeader title="Slider" description="An input where the user selects a value from within a given range." name="slider" />
            <ShowcaseSection title="Default" code={_codeExamples["slider"]}>
                <div className="w-full max-w-sm space-y-4">
                    <Slider
                        defaultValue={[50]}
                        max={100}
                        step={1}
                        className="w-full"
                        onValueChange={lambda val: list -> None { sliderValue = val; }}
                    />
                    <p className="text-sm text-muted-foreground text-center">Value: {String(sliderValue[0])}</p>
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Range" code={_codeExamples["slider-range"]}>
                <Slider defaultValue={[20, 80]} max={100} step={1} className="w-full max-w-sm" />
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Disabled" code={_codeExamples["slider-disabled"]}>
                <Slider defaultValue={[40]} max={100} step={1} disabled={True} className="w-full max-w-sm" />
            </ShowcaseSection>
        </div>;
    }

    def:pub SpinnerShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Spinner" description="An animated loading indicator." name="spinner" />
            <ShowcaseSection title="Sizes" className="flex-wrap gap-6 items-center" code={_codeExamples["spinner"]}>
                <Spinner size={16} />
                <Spinner size={24} />
                <Spinner size={32} />
                <Spinner size={48} />
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="With Text" className="gap-3 items-center" code={_codeExamples["spinner-text"]}>
                <Spinner size={20} />
                <span className="text-sm text-muted-foreground">Loading...</span>
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

    def:pub ToggleShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Toggle" description="A two-state button that can be either on or off." name="toggle" />
            <ShowcaseSection title="Variants" className="flex-wrap gap-3" code={_codeExamples["toggle"]}>
                <Toggle aria-label="Bold">
                    <HugeiconsIcon icon={TextBoldIcon} size={16} />
                </Toggle>
                <Toggle variant="outline" aria-label="Italic">
                    <HugeiconsIcon icon={TextItalicIcon} size={16} />
                </Toggle>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Sizes" className="flex-wrap gap-3" code={_codeExamples["toggle-sizes"]}>
                <Toggle size="sm" aria-label="Small">Sm</Toggle>
                <Toggle size="default" aria-label="Default">Default</Toggle>
                <Toggle size="lg" aria-label="Large">Lg</Toggle>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Disabled" code={_codeExamples["toggle-disabled"]}>
                <Toggle disabled={True} aria-label="Disabled">
                    <HugeiconsIcon icon={TextUnderlineIcon} size={16} />
                </Toggle>
            </ShowcaseSection>
        </div>;
    }

    def:pub ToggleGroupShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Toggle Group" description="A set of two-state buttons that can be toggled on or off." name="toggle-group" />
            <ShowcaseSection title="Single" code={_codeExamples["toggle-group"]}>
                <ToggleGroup type="single" defaultValue="center">
                    <ToggleGroupItem value="left" aria-label="Align left">
                        <HugeiconsIcon icon={TextAlignLeftIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="center" aria-label="Align center">
                        <HugeiconsIcon icon={TextAlignCenterIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="right" aria-label="Align right">
                        <HugeiconsIcon icon={TextAlignRightIcon} size={16} />
                    </ToggleGroupItem>
                </ToggleGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Multiple" code={_codeExamples["toggle-group-multiple"]}>
                <ToggleGroup type="multiple" defaultValue={["bold", "italic"]}>
                    <ToggleGroupItem value="bold" aria-label="Bold">
                        <HugeiconsIcon icon={TextBoldIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="italic" aria-label="Italic">
                        <HugeiconsIcon icon={TextItalicIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="underline" aria-label="Underline">
                        <HugeiconsIcon icon={TextUnderlineIcon} size={16} />
                    </ToggleGroupItem>
                </ToggleGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Outline Variant" code={_codeExamples["toggle-group-outline"]}>
                <ToggleGroup type="single" variant="outline" defaultValue="center">
                    <ToggleGroupItem value="left" aria-label="Align left">
                        <HugeiconsIcon icon={TextAlignLeftIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="center" aria-label="Align center">
                        <HugeiconsIcon icon={TextAlignCenterIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="right" aria-label="Align right">
                        <HugeiconsIcon icon={TextAlignRightIcon} size={16} />
                    </ToggleGroupItem>
                </ToggleGroup>
            </ShowcaseSection>
        </div>;
    }

    def:pub ButtonGroupShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Button Group" description="A group of buttons that are visually connected." name="button-group" />
            <ShowcaseSection title="Default" code={_codeExamples["button-group"]}>
                <ButtonGroup>
                    <Button variant="outline">Left</Button>
                    <Button variant="outline">Center</Button>
                    <Button variant="outline">Right</Button>
                </ButtonGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="With Text Addon" code={_codeExamples["button-group-addon"]}>
                <ButtonGroup>
                    <ButtonGroupText>https://</ButtonGroupText>
                    <Input placeholder="yoursite.com" className="w-48" />
                    <Button>Go</Button>
                </ButtonGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Vertical" code={_codeExamples["button-group-vertical"]}>
                <ButtonGroup orientation="vertical">
                    <Button variant="outline">Top</Button>
                    <Button variant="outline">Middle</Button>
                    <Button variant="outline">Bottom</Button>
                </ButtonGroup>
            </ShowcaseSection>
        </div>;
    }

    def:pub EmptyShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Empty" description="A component to display empty state with optional media, title, and description." name="empty" />
            <ShowcaseSection title="Default" code={_codeExamples["empty"]}>
                <div className="w-full max-w-sm border rounded-lg p-8">
                    <Empty>
                        <EmptyHeader>
                            <EmptyMedia>
                                <HugeiconsIcon icon={SearchIcon} size={32} className="text-muted-foreground" />
                            </EmptyMedia>
                            <EmptyTitle className="mt-3 text-base font-semibold">No results found</EmptyTitle>
                            <EmptyDescription className="mt-1 text-sm">Try adjusting your search or filters.</EmptyDescription>
                        </EmptyHeader>
                        <EmptyContent className="mt-4">
                            <Button size="sm">Clear filters</Button>
                        </EmptyContent>
                    </Empty>
                </div>
            </ShowcaseSection>
        </div>;
    }

    def:pub KbdShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Kbd" description="Keyboard shortcut display component." name="kbd" />
            <ShowcaseSection title="Single Keys" className="flex-wrap gap-3 items-center" code={_codeExamples["kbd"]}>
                <Kbd>⌘</Kbd>
                <Kbd>K</Kbd>
                <Kbd>Enter</Kbd>
                <Kbd>Esc</Kbd>
                <Kbd>Tab</Kbd>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Combinations" className="flex-wrap gap-4 items-center" code={_codeExamples["kbd-combinations"]}>
                <KbdGroup>
                    <Kbd>⌘</Kbd>
                    <Kbd>K</Kbd>
                </KbdGroup>
                <KbdGroup>
                    <Kbd>Ctrl</Kbd>
                    <Kbd>Shift</Kbd>
                    <Kbd>P</Kbd>
                </KbdGroup>
                <KbdGroup>
                    <Kbd>⌥</Kbd>
                    <Kbd>Enter</Kbd>
                </KbdGroup>
            </ShowcaseSection>
        </div>;
    }

    def:pub NativeSelectShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Native Select" description="A styled native HTML select element." name="native-select" />
            <ShowcaseSection title="Default" code={_codeExamples["native-select"]}>
                <NativeSelect>
                    <NativeSelectOption value="">Select a fruit...</NativeSelectOption>
                    <NativeSelectOption value="apple">Apple</NativeSelectOption>
                    <NativeSelectOption value="banana">Banana</NativeSelectOption>
                    <NativeSelectOption value="cherry">Cherry</NativeSelectOption>
                    <NativeSelectOption value="date">Date</NativeSelectOption>
                </NativeSelect>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Small" code={_codeExamples["native-select-small"]}>
                <NativeSelect size="sm">
                    <NativeSelectOption value="">Small select...</NativeSelectOption>
                    <NativeSelectOption value="a">Option A</NativeSelectOption>
                    <NativeSelectOption value="b">Option B</NativeSelectOption>
                </NativeSelect>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Disabled" code={_codeExamples["native-select-disabled"]}>
                <NativeSelect disabled={True}>
                    <NativeSelectOption value="">Disabled select</NativeSelectOption>
                </NativeSelect>
            </ShowcaseSection>
        </div>;
    }

    def:pub ItemShowcase() -> JsxElement {
        users = [
            {"name": "Alice Johnson", "email": "alice@example.com", "role": "Admin"},
            {"name": "Bob Smith", "email": "bob@example.com", "role": "Editor"},
            {"name": "Carol White", "email": "carol@example.com", "role": "Viewer"}
        ];
        return <div className="space-y-8">
            <ShowcaseHeader title="Item" description="A flexible list item component with media, content, and actions." name="item" />
            <ShowcaseSection title="Default" className="flex-col w-full max-w-sm" code={_codeExamples["item"]}>
                <ItemGroup>
                    {users.map(lambda u: dict -> Any {
                        return <Item key={u["email"]}>
                            <ItemContent>
                                <ItemTitle>{u["name"]}</ItemTitle>
                                <ItemDescription>{u["email"]}</ItemDescription>
                            </ItemContent>
                            <ItemActions>
                                <Badge variant="secondary">{u["role"]}</Badge>
                            </ItemActions>
                        </Item>;
                    })}
                </ItemGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Variants" className="flex-col gap-2 w-full max-w-sm" code={_codeExamples["item-variants"]}>
                <Item variant="default"><ItemContent><ItemTitle>Default item</ItemTitle></ItemContent></Item>
                <Item variant="muted"><ItemContent><ItemTitle>Muted item</ItemTitle></ItemContent></Item>
                <Item variant="outline"><ItemContent><ItemTitle>Outline item</ItemTitle></ItemContent></Item>
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

    def:pub ChartShowcase() -> JsxElement {
        monthData = [
            {month: "January", desktop: 186, mobile: 80},
            {month: "February", desktop: 305, mobile: 200},
            {month: "March", desktop: 237, mobile: 120},
            {month: "April", desktop: 73, mobile: 190},
            {month: "May", desktop: 209, mobile: 130},
            {month: "June", desktop: 214, mobile: 140}
        ];
        desktopConfig = {desktop: {label: "Desktop", color: "var(--chart-1)"}};
        multiConfig = {
            desktop: {label: "Desktop", color: "var(--chart-1)"},
            mobile: {label: "Mobile", color: "var(--chart-2)"}
        };
        browserData = [
            {browser: "chrome", visitors: 275, fill: "var(--color-chrome)"},
            {browser: "safari", visitors: 200, fill: "var(--color-safari)"},
            {browser: "firefox", visitors: 287, fill: "var(--color-firefox)"},
            {browser: "edge", visitors: 173, fill: "var(--color-edge)"},
            {browser: "other", visitors: 190, fill: "var(--color-other)"}
        ];
        browserConfig = {
            visitors: {label: "Visitors"},
            chrome: {label: "Chrome", color: "var(--chart-1)"},
            safari: {label: "Safari", color: "var(--chart-2)"},
            firefox: {label: "Firefox", color: "var(--chart-3)"},
            edge: {label: "Edge", color: "var(--chart-4)"},
            other: {label: "Other", color: "var(--chart-5)"}
        };
        shortMonth = lambda(v: Any) -> Any { return v.slice(0, 3); };
        return <div className="space-y-8">
            <ShowcaseHeader title="Chart" description="Beautiful charts built with Recharts." name="chart" />

            <ShowcaseSection title="Bar Chart" className="flex-col w-full" code={_codeExamples["chart"]}>
                <Card className="w-full">
                    <CardHeader>
                        <CardTitle>Bar Chart - Grouped</CardTitle>
                        <CardDescription>Desktop vs Mobile — January - June 2024</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <ChartContainer config={multiConfig} className="min-h-[200px] w-full">
                            <BarChart accessibilityLayer={true} data={monthData} margin={{left: 12, right: 12}}>
                                <CartesianGrid vertical={false} />
                                <XAxis dataKey="month" tickLine={false} axisLine={false} tickMargin={8} tickFormatter={shortMonth} />
                                <ChartTooltip cursor={false} content={<ChartTooltipContent />} />
                                <ChartLegend content={<ChartLegendContent />} />
                                <Bar dataKey="desktop" fill="var(--color-desktop)" radius={4} />
                                <Bar dataKey="mobile" fill="var(--color-mobile)" radius={4} />
                            </BarChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>

            <Separator />

            <ShowcaseSection title="Stacked Bar Chart" className="flex-col w-full" code={_codeExamples["chart-stacked"]}>
                <Card className="w-full">
                    <CardHeader>
                        <CardTitle>Bar Chart - Stacked + Legend</CardTitle>
                        <CardDescription>January - June 2024</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <ChartContainer config={multiConfig} className="min-h-[200px] w-full">
                            <BarChart accessibilityLayer={true} data={monthData}>
                                <CartesianGrid vertical={false} />
                                <XAxis dataKey="month" tickLine={false} tickMargin={10} axisLine={false} tickFormatter={shortMonth} />
                                <ChartTooltip content={<ChartTooltipContent hideLabel={true} />} />
                                <ChartLegend content={<ChartLegendContent />} />
                                <Bar dataKey="desktop" stackId="a" fill="var(--color-desktop)" radius={[0, 0, 4, 4]} />
                                <Bar dataKey="mobile" stackId="a" fill="var(--color-mobile)" radius={[4, 4, 0, 0]} />
                            </BarChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>

            <Separator />

            <ShowcaseSection title="Line Chart" className="flex-col w-full" code={_codeExamples["chart-line"]}>
                <Card className="w-full">
                    <CardHeader>
                        <CardTitle>Line Chart</CardTitle>
                        <CardDescription>January - June 2024</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <ChartContainer config={multiConfig} className="min-h-[200px] w-full">
                            <LineChart accessibilityLayer={true} data={monthData} margin={{left: 12, right: 12}}>
                                <CartesianGrid vertical={false} />
                                <XAxis dataKey="month" tickLine={false} axisLine={false} tickMargin={8} tickFormatter={shortMonth} />
                                <ChartTooltip cursor={false} content={<ChartTooltipContent />} />
                                <ChartLegend content={<ChartLegendContent />} />
                                <Line dataKey="desktop" type={"monotone"} stroke="var(--color-desktop)" strokeWidth={2} dot={{r: 4}} activeDot={{r: 6}} />
                                <Line dataKey="mobile" type={"monotone"} stroke="var(--color-mobile)" strokeWidth={2} dot={{r: 4}} activeDot={{r: 6}} />
                            </LineChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>

            <Separator />

            <ShowcaseSection title="Area Chart" className="flex-col w-full" code={_codeExamples["chart-area"]}>
                <Card className="w-full">
                    <CardHeader>
                        <CardTitle>Area Chart - Gradient</CardTitle>
                        <CardDescription>January - June 2024</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <ChartContainer config={multiConfig} className="min-h-[200px] w-full">
                            <AreaChart accessibilityLayer={true} data={monthData} margin={{left: 12, right: 12}}>
                                <CartesianGrid vertical={false} />
                                <XAxis dataKey="month" tickLine={false} axisLine={false} tickMargin={8} tickFormatter={shortMonth} />
                                <ChartTooltip cursor={false} content={<ChartTooltipContent />} />
                                <defs>
                                    <linearGradient id="fillDesktop" x1="0" y1="0" x2="0" y2="1">
                                        <stop offset="5%" stopColor="var(--color-desktop)" stopOpacity={0.8} />
                                        <stop offset="95%" stopColor="var(--color-desktop)" stopOpacity={0.1} />
                                    </linearGradient>
                                    <linearGradient id="fillMobile" x1="0" y1="0" x2="0" y2="1">
                                        <stop offset="5%" stopColor="var(--color-mobile)" stopOpacity={0.8} />
                                        <stop offset="95%" stopColor="var(--color-mobile)" stopOpacity={0.1} />
                                    </linearGradient>
                                </defs>
                                <Area dataKey="mobile" type="natural" fill="url(#fillMobile)" fillOpacity={0.4} stroke="var(--color-mobile)" stackId="a" />
                                <Area dataKey="desktop" type="natural" fill="url(#fillDesktop)" fillOpacity={0.4} stroke="var(--color-desktop)" stackId="a" />
                            </AreaChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>

            <Separator />

            <ShowcaseSection title="Pie Chart" className="flex-col w-full" code={_codeExamples["chart-pie"]}>
                <Card className="w-full">
                    <CardHeader className="items-center pb-0">
                        <CardTitle>Pie Chart - Donut</CardTitle>
                        <CardDescription>Browser market share 2024</CardDescription>
                    </CardHeader>
                    <CardContent className="flex-1 pb-0">
                        <ChartContainer config={browserConfig} className="mx-auto aspect-square max-h-[250px]">
                            <PieChart>
                                <ChartTooltip cursor={false} content={<ChartTooltipContent hideLabel={true} />} />
                                <Pie data={browserData} dataKey="visitors" nameKey="browser" innerRadius={60} strokeWidth={5} />
                            </PieChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>

            <Separator />

            <ShowcaseSection title="Radial Chart" className="flex-col w-full" code={_codeExamples["chart-radial"]}>
                <Card className="w-full">
                    <CardHeader className="items-center pb-0">
                        <CardTitle>Radial Bar Chart</CardTitle>
                        <CardDescription>Browser market share 2024</CardDescription>
                    </CardHeader>
                    <CardContent className="flex-1 pb-0">
                        <ChartContainer config={browserConfig} className="mx-auto aspect-square max-h-[250px]">
                            <RadialBarChart data={browserData} innerRadius={30} outerRadius={110}>
                                <ChartTooltip cursor={false} content={<ChartTooltipContent hideLabel={true} nameKey="browser" />} />
                                <RadialBar dataKey="visitors" background={true} />
                            </RadialBarChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>
        </div>;
    }

    def:pub CommandShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Command" description="Fast, composable command palette built on cmdk." name="command" />
            <ShowcaseSection title="Default" className="flex-col" code={_codeExamples["command"]}>
                <Command className="rounded-lg border shadow-md md:min-w-[450px]">
                    <CommandInput placeholder="Type a command or search..." />
                    <CommandList>
                        <CommandEmpty>No results found.</CommandEmpty>
                        <CommandGroup heading="Suggestions">
                            <CommandItem>Calendar</CommandItem>
                            <CommandItem>Search</CommandItem>
                            <CommandItem>Settings</CommandItem>
                        </CommandGroup>
                        <CommandSeparator />
                        <CommandGroup heading="Settings">
                            <CommandItem>Profile <CommandShortcut>⌘P</CommandShortcut></CommandItem>
                            <CommandItem>Billing <CommandShortcut>⌘B</CommandShortcut></CommandItem>
                        </CommandGroup>
                    </CommandList>
                </Command>
            </ShowcaseSection>
        </div>;
    }

    def:pub InputOTPShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Input OTP" description="Accessible one-time password component." name="input-otp" />
            <ShowcaseSection title="Default" code={_codeExamples["input-otp"]}>
                <InputOTP maxLength={6}>
                    <InputOTPGroup>
                        <InputOTPSlot index={0} />
                        <InputOTPSlot index={1} />
                        <InputOTPSlot index={2} />
                    </InputOTPGroup>
                    <InputOTPSeparator />
                    <InputOTPGroup>
                        <InputOTPSlot index={3} />
                        <InputOTPSlot index={4} />
                        <InputOTPSlot index={5} />
                    </InputOTPGroup>
                </InputOTP>
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

    def:pub ComponentShowcase(props: Any) -> JsxElement {
        name = props.name;
        if name == "button" { return <ButtonShowcase />; }
        if name == "badge" { return <BadgeShowcase />; }
        if name == "card" { return <CardShowcase />; }
        if name == "input" { return <InputShowcase />; }
        if name == "textarea" { return <TextareaShowcase />; }
        if name == "select" { return <SelectShowcase />; }
        if name == "combobox" { return <ComboboxShowcase />; }
        if name == "dropdown-menu" { return <DropdownMenuShowcase />; }
        if name == "field" { return <FieldShowcase />; }
        if name == "input-group" { return <InputGroupShowcase />; }
        if name == "label" { return <LabelShowcase />; }
        if name == "separator" { return <SeparatorShowcase />; }
        if name == "alert-dialog" { return <AlertDialogShowcase />; }
        if name == "dialog" { return <DialogShowcase />; }
        if name == "checkbox" { return <CheckboxShowcase />; }
        if name == "tabs" { return <TabsShowcase />; }
        if name == "switch" { return <SwitchShowcase />; }
        if name == "tooltip" { return <TooltipShowcase />; }
        if name == "radio-group" { return <RadioGroupShowcase />; }
        if name == "avatar" { return <AvatarShowcase />; }
        if name == "progress" { return <ProgressShowcase />; }
        if name == "accordion" { return <AccordionShowcase />; }
        if name == "alert" { return <AlertShowcase />; }
        if name == "aspect-ratio" { return <AspectRatioShowcase />; }
        if name == "breadcrumb" { return <BreadcrumbShowcase />; }
        if name == "collapsible" { return <CollapsibleShowcase />; }
        if name == "context-menu" { return <ContextMenuShowcase />; }
        if name == "drawer" { return <DrawerShowcase />; }
        if name == "hover-card" { return <HoverCardShowcase />; }
        if name == "menubar" { return <MenubarShowcase />; }
        if name == "navigation-menu" { return <NavigationMenuShowcase />; }
        if name == "pagination" { return <PaginationShowcase />; }
        if name == "popover" { return <PopoverShowcase />; }
        if name == "resizable" { return <ResizableShowcase />; }
        if name == "scroll-area" { return <ScrollAreaShowcase />; }
        if name == "sheet" { return <SheetShowcase />; }
        if name == "skeleton" { return <SkeletonShowcase />; }
        if name == "slider" { return <SliderShowcase />; }
        if name == "spinner" { return <SpinnerShowcase />; }
        if name == "table" { return <TableShowcase />; }
        if name == "toggle" { return <ToggleShowcase />; }
        if name == "toggle-group" { return <ToggleGroupShowcase />; }
        if name == "button-group" { return <ButtonGroupShowcase />; }
        if name == "empty" { return <EmptyShowcase />; }
        if name == "kbd" { return <KbdShowcase />; }
        if name == "native-select" { return <NativeSelectShowcase />; }
        if name == "item" { return <ItemShowcase />; }
        if name == "calendar" { return <CalendarShowcase />; }
        if name == "carousel" { return <CarouselShowcase />; }
        if name == "chart" { return <ChartShowcase />; }
        if name == "command" { return <CommandShowcase />; }
        if name == "input-otp" { return <InputOTPShowcase />; }
        if name == "sidebar" { return <SidebarShowcase />; }
        return <div className="text-muted-foreground text-sm">Component not found.</div>;
    }
}

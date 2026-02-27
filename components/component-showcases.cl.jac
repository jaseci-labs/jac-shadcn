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
cl import from .ui.sonner { Toaster }
cl import from sonner { toast }

glob _frameworks: list = ["Next.js", "SvelteKit", "Nuxt.js", "Remix", "Astro"];

cl {
    def:pub CopyCommand(props: Any) -> JsxElement {
        has copied: bool = False;
        cmd = "jac add --shadcn " + props.name;

        return <div className="flex items-center gap-2 rounded-lg border border-border bg-muted/40 px-3 py-2 font-mono text-sm">
            <code className="flex-1 text-foreground/80">{cmd}</code>
            <button
                onClick={lambda -> None {
                    navigator.clipboard.writeText(cmd);
                    copied = True;
                    setTimeout(lambda -> None { copied = False; }, 2000);
                }}
                className="shrink-0 rounded-md p-1 text-muted-foreground hover:text-foreground transition-colors cursor-pointer"
            >
                {copied
                    and <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-3.5 text-green-500" />
                    or <HugeiconsIcon icon={Copy01Icon} strokeWidth={2} className="size-3.5" />}
            </button>
        </div>;
    }

    def:pub ShowcaseSection(props: Any) -> JsxElement {
        return <div className="space-y-3">
            {props.title and <h3 className="text-sm font-medium text-muted-foreground">{props.title}</h3>}
            <div className={cn("flex flex-wrap items-center gap-2", props.className)}>
                {props.children}
            </div>
        </div>;
    }

    def:pub ShowcaseHeader(props: Any) -> JsxElement {
        return <div className="space-y-3 pb-2">
            <h2 className="text-xl font-semibold tracking-tight">{props.title}</h2>
            {props.description and <p className="text-sm text-muted-foreground">{props.description}</p>}
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
            <ShowcaseSection title="Variants & Sizes">
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
            <ShowcaseSection title="Icon Right">
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
            <ShowcaseSection title="Icon Left">
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
            <ShowcaseSection title="Icon Only">
                <div className="flex flex-wrap items-center gap-2">
                    <Button size="icon"><HugeiconsIcon icon={PlusSignIcon} strokeWidth={2} /></Button>
                    <Button size="icon-sm" variant="outline"><HugeiconsIcon icon={SettingsIcon} strokeWidth={2} /></Button>
                    <Button size="icon-xs" variant="ghost"><HugeiconsIcon icon={SearchIcon} strokeWidth={2} /></Button>
                    <Button size="icon-lg" variant="secondary"><HugeiconsIcon icon={UserIcon} strokeWidth={2} /></Button>
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Disabled">
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
            <ShowcaseSection title="Variants">
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
            <ShowcaseSection title="Basic Card" className="flex-col">
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
            <ShowcaseSection title="Card with Action" className="flex-col">
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
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm">
                <Input placeholder="Type something..." />
            </ShowcaseSection>
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm">
                <Field>
                    <FieldLabel htmlFor="email-input">Email</FieldLabel>
                    <Input id="email-input" type="email" placeholder="you@example.com" />
                </Field>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled" className="flex-col items-start max-w-sm">
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
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm">
                <Textarea placeholder="Write your message here..." />
            </ShowcaseSection>
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm">
                <Field>
                    <FieldLabel htmlFor="bio-textarea">Bio</FieldLabel>
                    <Textarea id="bio-textarea" placeholder="Tell us about yourself..." />
                </Field>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled" className="flex-col items-start max-w-sm">
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
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm">
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
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm">
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
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm">
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
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="With Sub-menus">
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
            <ShowcaseSection title="Field Group" className="flex-col items-start max-w-sm">
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
            <ShowcaseSection title="Horizontal" className="flex-col items-start max-w-sm">
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
            <ShowcaseSection title="Search" className="flex-col items-start max-w-sm">
                <InputGroup>
                    <Input placeholder="Search..." />
                    <Button>
                        <HugeiconsIcon icon={SearchIcon} strokeWidth={2} />
                    </Button>
                </InputGroup>
            </ShowcaseSection>
            <ShowcaseSection title="Email Subscribe" className="flex-col items-start max-w-sm">
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
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm">
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
            <ShowcaseSection title="Horizontal" className="flex-col w-full max-w-sm">
                <div className="w-full space-y-2">
                    <p className="text-sm">Content above</p>
                    <Separator />
                    <p className="text-sm">Content below</p>
                </div>
            </ShowcaseSection>
            <ShowcaseSection title="Vertical">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="With Form" className="items-center justify-center">
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
            <ShowcaseSection title="No Close Button" className="items-center justify-center">
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
            <ShowcaseSection title="With Sticky Footer" className="items-center justify-center">
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
            <ShowcaseSection title="States" className="gap-6">
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
            <ShowcaseSection title="With Description">
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
            <ShowcaseSection title="Default Variant">
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
            <ShowcaseSection title="Line Variant">
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
            <ShowcaseSection title="Disabled Tab">
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
            <ShowcaseSection title="Default" className="gap-6">
                <label className="flex items-center gap-3 text-sm">
                    <Switch checked={airplaneMode} onCheckedChange={lambda(v: Any) -> None { airplaneMode = v; }} />
                    Airplane Mode
                </label>
                <label className="flex items-center gap-3 text-sm">
                    <Switch checked={notifications} onCheckedChange={lambda(v: Any) -> None { notifications = v; }} />
                    Notifications
                </label>
            </ShowcaseSection>
            <ShowcaseSection title="Sizes" className="gap-6">
                <label className="flex items-center gap-3 text-sm">
                    <Switch size="sm" defaultChecked={True} />
                    Small
                </label>
                <label className="flex items-center gap-3 text-sm">
                    <Switch size="default" defaultChecked={True} />
                    Default
                </label>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled" className="gap-6">
                <label className="flex items-center gap-3 text-sm text-muted-foreground">
                    <Switch disabled={True} />
                    Disabled Off
                </label>
                <label className="flex items-center gap-3 text-sm text-muted-foreground">
                    <Switch disabled={True} checked={True} />
                    Disabled On
                </label>
            </ShowcaseSection>
            <ShowcaseSection title="With Description">
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
            <ShowcaseSection title="Default" className="gap-4">
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
            <ShowcaseSection title="Sides" className="gap-4">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="Disabled">
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
            <ShowcaseSection title="Sizes" className="gap-4 items-end">
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
            <ShowcaseSection title="With Image" className="gap-4 items-end">
                <Avatar>
                    <AvatarImage src="https://github.com/shadcn.png" alt="@shadcn" />
                    <AvatarFallback>CN</AvatarFallback>
                </Avatar>
                <Avatar>
                    <AvatarImage src="https://github.com/vercel.png" alt="@vercel" />
                    <AvatarFallback>VC</AvatarFallback>
                </Avatar>
            </ShowcaseSection>
            <ShowcaseSection title="With Badge" className="gap-4 items-end">
                <Avatar>
                    <AvatarFallback>CN</AvatarFallback>
                    <AvatarBadge />
                </Avatar>
                <Avatar size="lg">
                    <AvatarFallback>LG</AvatarFallback>
                    <AvatarBadge />
                </Avatar>
            </ShowcaseSection>
            <ShowcaseSection title="Group">
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
            <ShowcaseSection title="Default">
                <div className="w-full max-w-md space-y-2">
                    <Progress value={progressValue} />
                    <p className="text-sm text-muted-foreground text-right">{String(progressValue) + "%"}</p>
                </div>
            </ShowcaseSection>
            <ShowcaseSection title="Static Values" className="flex-col gap-4">
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
            <ShowcaseSection title="Single">
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
            <ShowcaseSection title="Multiple">
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
            <ShowcaseSection title="Default" className="flex-col gap-4">
                <Alert className="max-w-md">
                    <AlertTitle>Heads up!</AlertTitle>
                    <AlertDescription>You can add components to your app using the cli.</AlertDescription>
                </Alert>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Destructive" className="flex-col gap-4">
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
            <ShowcaseSection title="16 / 9">
                <div className="w-full max-w-sm overflow-hidden rounded-md">
                    <AspectRatio ratio={16 / 9}>
                        <div className="flex h-full w-full items-center justify-center bg-muted text-muted-foreground rounded-md">
                            16 : 9
                        </div>
                    </AspectRatio>
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="4 / 3">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="With Ellipsis">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="Bottom Drawer">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="Horizontal">
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
            <ShowcaseSection title="Vertical">
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
            <ShowcaseSection title="Vertical">
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
            <ShowcaseSection title="With ScrollBar">
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
            <ShowcaseSection title="Sides" className="flex-wrap gap-3">
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
            <ShowcaseSection title="Card Skeleton" className="flex-col gap-4">
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
            <ShowcaseSection title="Table Skeleton" className="flex-col gap-2">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="Range">
                <Slider defaultValue={[20, 80]} max={100} step={1} className="w-full max-w-sm" />
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Disabled">
                <Slider defaultValue={[40]} max={100} step={1} disabled={True} className="w-full max-w-sm" />
            </ShowcaseSection>
        </div>;
    }

    def:pub SonnerShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Sonner" description="An opinionated toast component for React." name="sonner" />
            <ShowcaseSection title="Toast Variants" className="flex-wrap gap-3">
                <Button variant="outline" onClick={lambda -> None { toast("Event has been created."); }}>Default</Button>
                <Button variant="outline" onClick={lambda -> None { toast.success("Profile updated."); }}>Success</Button>
                <Button variant="outline" onClick={lambda -> None { toast.error("Something went wrong."); }}>Error</Button>
                <Button variant="outline" onClick={lambda -> None { toast.warning("You are running low."); }}>Warning</Button>
                <Button variant="outline" onClick={lambda -> None { toast.info("New version available."); }}>Info</Button>
                <Button variant="outline" onClick={lambda -> None { toast.loading("Processing..."); }}>Loading</Button>
            </ShowcaseSection>
            <Toaster />
        </div>;
    }

    def:pub SpinnerShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Spinner" description="An animated loading indicator." name="spinner" />
            <ShowcaseSection title="Sizes" className="flex-wrap gap-6 items-center">
                <Spinner size={16} />
                <Spinner size={24} />
                <Spinner size={32} />
                <Spinner size={48} />
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="With Text" className="gap-3 items-center">
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
            <ShowcaseSection title="Default">
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
            <ShowcaseSection title="Variants" className="flex-wrap gap-3">
                <Toggle aria-label="Bold">
                    <HugeiconsIcon icon={TextBoldIcon} size={16} />
                </Toggle>
                <Toggle variant="outline" aria-label="Italic">
                    <HugeiconsIcon icon={TextItalicIcon} size={16} />
                </Toggle>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Sizes" className="flex-wrap gap-3">
                <Toggle size="sm" aria-label="Small">Sm</Toggle>
                <Toggle size="default" aria-label="Default">Default</Toggle>
                <Toggle size="lg" aria-label="Large">Lg</Toggle>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Disabled">
                <Toggle disabled={True} aria-label="Disabled">
                    <HugeiconsIcon icon={TextUnderlineIcon} size={16} />
                </Toggle>
            </ShowcaseSection>
        </div>;
    }

    def:pub ToggleGroupShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Toggle Group" description="A set of two-state buttons that can be toggled on or off." name="toggle-group" />
            <ShowcaseSection title="Single">
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
            <ShowcaseSection title="Multiple">
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
            <ShowcaseSection title="Outline Variant">
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
        if name == "sonner" { return <SonnerShowcase />; }
        if name == "spinner" { return <SpinnerShowcase />; }
        if name == "table" { return <TableShowcase />; }
        if name == "toggle" { return <ToggleShowcase />; }
        if name == "toggle-group" { return <ToggleGroupShowcase />; }
        return <div className="text-muted-foreground text-sm">Component not found.</div>;
    }
}

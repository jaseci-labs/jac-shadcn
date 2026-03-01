cl import from ..ui.button { Button, buttonVariants }
cl import from ..ui.card { Card, CardAction, CardContent, CardDescription, CardFooter, CardHeader, CardTitle }
cl import from ..ui.input { Input }
cl import from "..ui.dropdown-menu" { DropdownMenu, DropdownMenuCheckboxItem, DropdownMenuContent, DropdownMenuGroup, DropdownMenuItem, DropdownMenuLabel, DropdownMenuRadioGroup, DropdownMenuRadioItem, DropdownMenuSeparator, DropdownMenuShortcut, DropdownMenuSub, DropdownMenuSubContent, DropdownMenuSubTrigger, DropdownMenuTrigger, DropdownMenuPortal }
cl import from ..ui.field { Field, FieldGroup, FieldLabel }
cl import from ..ui.label { Label }
cl import from ..ui.separator { Separator }
cl import from "..ui.alert-dialog" { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger }
cl import from "..ui.dialog" { Dialog, DialogClose, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger }
cl import from ..ui.checkbox { Checkbox }
cl import from ..ui.tooltip { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger }
cl import from "..ui.radio-group" { RadioGroup, RadioGroupItem }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon, ArrowDownIcon, ArrowUpIcon, PlusSignIcon, DownloadIcon, MailIcon, SearchIcon, SettingsIcon, UserIcon, Copy01Icon, Tick01Icon, TextAlignLeftIcon, TextAlignCenterIcon, TextAlignRightIcon, TextBoldIcon, TextItalicIcon, TextUnderlineIcon }
cl import from ..ui.alert { Alert, AlertTitle, AlertDescription, AlertAction }
cl import from "..ui.context-menu" { ContextMenu, ContextMenuTrigger, ContextMenuContent, ContextMenuItem, ContextMenuSeparator, ContextMenuLabel, ContextMenuShortcut, ContextMenuCheckboxItem, ContextMenuRadioGroup, ContextMenuRadioItem }
cl import from ..ui.drawer { Drawer, DrawerTrigger, DrawerContent, DrawerHeader, DrawerTitle, DrawerDescription, DrawerFooter, DrawerClose }
cl import from "..ui.hover-card" { HoverCard, HoverCardTrigger, HoverCardContent }
cl import from ..ui.popover { Popover, PopoverTrigger, PopoverContent }
cl import from ..ui.sheet { Sheet, SheetTrigger, SheetContent, SheetHeader, SheetTitle, SheetDescription, SheetFooter, SheetClose }
cl import from ..ui.empty { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription, EmptyContent }
cl import from ..ui.item { Item, ItemGroup, ItemMedia, ItemContent, ItemTitle, ItemDescription, ItemActions, ItemSeparator }
cl import from ..ui.calendar { Calendar }
cl import from ..ui.command { Command, CommandDialog, CommandEmpty, CommandGroup, CommandInput, CommandItem, CommandList, CommandSeparator, CommandShortcut }
cl import from ".shared" { ShowcaseSection, ShowcaseHeader }

glob _codeExamples: dict = {
    "alert-dialog": "cl import from '.ui.alert-dialog' {\n    AlertDialog, AlertDialogTrigger,\n    AlertDialogContent, AlertDialogHeader,\n    AlertDialogTitle, AlertDialogDescription,\n    AlertDialogFooter, AlertDialogCancel,\n    AlertDialogAction\n}\n\n<AlertDialog>\n    <AlertDialogTrigger>Open</AlertDialogTrigger>\n    <AlertDialogContent>\n        <AlertDialogHeader>\n            <AlertDialogTitle>Confirm</AlertDialogTitle>\n            <AlertDialogDescription>\n                This action cannot be undone.\n            </AlertDialogDescription>\n        </AlertDialogHeader>\n        <AlertDialogFooter>\n            <AlertDialogCancel>Cancel</AlertDialogCancel>\n            <AlertDialogAction>Continue</AlertDialogAction>\n        </AlertDialogFooter>\n    </AlertDialogContent>\n</AlertDialog>",
    "command": "cl import from .ui.command {\n    Command, CommandInput, CommandList,\n    CommandEmpty, CommandGroup, CommandItem\n}\n\n<Command>\n    <CommandInput placeholder='Search...' />\n    <CommandList>\n        <CommandEmpty>No results.</CommandEmpty>\n        <CommandGroup heading='Suggestions'>\n            <CommandItem>Calendar</CommandItem>\n            <CommandItem>Search</CommandItem>\n            <CommandItem>Settings</CommandItem>\n        </CommandGroup>\n    </CommandList>\n</Command>",
    "context-menu": "cl import from '.ui.context-menu' {\n    ContextMenu, ContextMenuTrigger,\n    ContextMenuContent, ContextMenuItem\n}\n\n<ContextMenu>\n    <ContextMenuTrigger>\n        Right click here\n    </ContextMenuTrigger>\n    <ContextMenuContent>\n        <ContextMenuItem>Profile</ContextMenuItem>\n        <ContextMenuItem>Settings</ContextMenuItem>\n        <ContextMenuItem>Log out</ContextMenuItem>\n    </ContextMenuContent>\n</ContextMenu>",
    "dialog": "cl import from '.ui.dialog' {\n    Dialog, DialogTrigger, DialogContent,\n    DialogHeader, DialogTitle,\n    DialogDescription, DialogFooter\n}\n\n<Dialog>\n    <DialogTrigger asChild={True}>\n        <Button variant='outline'>Edit Profile</Button>\n    </DialogTrigger>\n    <DialogContent>\n        <DialogHeader>\n            <DialogTitle>Edit profile</DialogTitle>\n            <DialogDescription>Make changes here.</DialogDescription>\n        </DialogHeader>\n        <Input placeholder='Name' />\n        <DialogFooter>\n            <Button>Save changes</Button>\n        </DialogFooter>\n    </DialogContent>\n</Dialog>",
    "dialog-no-close": "cl import from '.ui.dialog' {\n    Dialog, DialogTrigger, DialogContent,\n    DialogHeader, DialogTitle, DialogDescription,\n    DialogFooter, DialogClose\n}\n\n<Dialog>\n    <DialogTrigger asChild={True}>\n        <Button>Open</Button>\n    </DialogTrigger>\n    <DialogContent showCloseButton={False}>\n        <DialogHeader>\n            <DialogTitle>Title</DialogTitle>\n            <DialogDescription>No close button.</DialogDescription>\n        </DialogHeader>\n        <DialogFooter>\n            <DialogClose asChild={True}>\n                <Button variant='outline'>Close</Button>\n            </DialogClose>\n        </DialogFooter>\n    </DialogContent>\n</Dialog>",
    "dialog-sticky": "// Dialog with scrollable content\n// and a sticky footer\n<Dialog>\n    <DialogTrigger asChild={True}>\n        <Button>Open</Button>\n    </DialogTrigger>\n    <DialogContent>\n        <DialogHeader>\n            <DialogTitle>Scrollable</DialogTitle>\n        </DialogHeader>\n        <div className='max-h-[40vh] overflow-y-auto'>\n            <p>Long content here...</p>\n        </div>\n        <DialogFooter>\n            <Button>Save</Button>\n        </DialogFooter>\n    </DialogContent>\n</Dialog>",
    "drawer": "cl import from .ui.drawer {\n    Drawer, DrawerTrigger, DrawerContent,\n    DrawerHeader, DrawerTitle,\n    DrawerDescription, DrawerFooter, DrawerClose\n}\n\n<Drawer>\n    <DrawerTrigger asChild={True}>\n        <Button>Open Drawer</Button>\n    </DrawerTrigger>\n    <DrawerContent>\n        <DrawerHeader>\n            <DrawerTitle>Confirm</DrawerTitle>\n            <DrawerDescription>Are you sure?</DrawerDescription>\n        </DrawerHeader>\n        <DrawerFooter>\n            <Button>Submit</Button>\n            <DrawerClose asChild={True}>\n                <Button variant='outline'>Cancel</Button>\n            </DrawerClose>\n        </DrawerFooter>\n    </DrawerContent>\n</Drawer>",
    "dropdown-menu": "cl import from '.ui.dropdown-menu' {\n    DropdownMenu, DropdownMenuTrigger,\n    DropdownMenuContent, DropdownMenuItem\n}\n\n<DropdownMenu>\n    <DropdownMenuTrigger>Open Menu</DropdownMenuTrigger>\n    <DropdownMenuContent>\n        <DropdownMenuItem>Profile</DropdownMenuItem>\n        <DropdownMenuItem>Settings</DropdownMenuItem>\n        <DropdownMenuItem>Log out</DropdownMenuItem>\n    </DropdownMenuContent>\n</DropdownMenu>",
    "dropdown-submenu": "cl import from '.ui.dropdown-menu' {\n    DropdownMenu, DropdownMenuTrigger,\n    DropdownMenuContent, DropdownMenuItem,\n    DropdownMenuSub, DropdownMenuSubTrigger,\n    DropdownMenuSubContent, DropdownMenuPortal\n}\n\n<DropdownMenu>\n    <DropdownMenuTrigger>Actions</DropdownMenuTrigger>\n    <DropdownMenuContent>\n        <DropdownMenuItem>New File</DropdownMenuItem>\n        <DropdownMenuSub>\n            <DropdownMenuSubTrigger>Export</DropdownMenuSubTrigger>\n            <DropdownMenuPortal>\n                <DropdownMenuSubContent>\n                    <DropdownMenuItem>PDF</DropdownMenuItem>\n                    <DropdownMenuItem>CSV</DropdownMenuItem>\n                </DropdownMenuSubContent>\n            </DropdownMenuPortal>\n        </DropdownMenuSub>\n    </DropdownMenuContent>\n</DropdownMenu>",
    "hover-card": "cl import from '.ui.hover-card' {\n    HoverCard, HoverCardTrigger,\n    HoverCardContent\n}\n\n<HoverCard>\n    <HoverCardTrigger asChild={True}>\n        <Button variant='link'>@nextjs</Button>\n    </HoverCardTrigger>\n    <HoverCardContent>\n        <h4 className='font-semibold'>@nextjs</h4>\n        <p className='text-sm'>The React Framework.</p>\n    </HoverCardContent>\n</HoverCard>",
    "popover": "cl import from .ui.popover {\n    Popover, PopoverTrigger, PopoverContent\n}\n\n<Popover>\n    <PopoverTrigger asChild={True}>\n        <Button variant='outline'>Open</Button>\n    </PopoverTrigger>\n    <PopoverContent>\n        <h4 className='font-medium'>Settings</h4>\n        <p className='text-sm'>Adjust preferences.</p>\n    </PopoverContent>\n</Popover>",
    "sheet": "cl import from .ui.sheet {\n    Sheet, SheetTrigger, SheetContent,\n    SheetHeader, SheetTitle, SheetDescription\n}\n\n<Sheet>\n    <SheetTrigger asChild={True}>\n        <Button variant='outline'>Right</Button>\n    </SheetTrigger>\n    <SheetContent side='right'>\n        <SheetHeader>\n            <SheetTitle>Edit profile</SheetTitle>\n            <SheetDescription>\n                Make changes here.\n            </SheetDescription>\n        </SheetHeader>\n    </SheetContent>\n</Sheet>",
    "tooltip": "cl import from .ui.tooltip {\n    Tooltip, TooltipContent,\n    TooltipProvider, TooltipTrigger\n}\n\n<TooltipProvider>\n    <Tooltip>\n        <TooltipTrigger>Hover me</TooltipTrigger>\n        <TooltipContent>\n            <p>Tooltip content</p>\n        </TooltipContent>\n    </Tooltip>\n</TooltipProvider>",
    "tooltip-sides": "cl import from .ui.tooltip {\n    Tooltip, TooltipContent,\n    TooltipProvider, TooltipTrigger\n}\n\n<TooltipProvider>\n    <Tooltip>\n        <TooltipTrigger>Top</TooltipTrigger>\n        <TooltipContent side='top'>\n            Top tooltip\n        </TooltipContent>\n    </Tooltip>\n    <Tooltip>\n        <TooltipTrigger>Right</TooltipTrigger>\n        <TooltipContent side='right'>\n            Right tooltip\n        </TooltipContent>\n    </Tooltip>\n</TooltipProvider>",
};

cl {
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

}

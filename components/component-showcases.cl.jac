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
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon, PlusSignIcon, DownloadIcon, MailIcon, SearchIcon, SettingsIcon, UserIcon, Copy01Icon, Tick01Icon }
cl import from react { useState, useEffect }

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
        return <div className="text-muted-foreground text-sm">Component not found.</div>;
    }
}

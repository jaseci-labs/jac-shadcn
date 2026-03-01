"""Homepage — hero section + rich 4-column component masonry grid like shadcn/ui."""
cl import from ..lib.utils { cn }
cl import from .ui.badge { Badge }
cl import from .ui.button { Button, buttonVariants }
cl import from ".ui.button-group" { ButtonGroup, ButtonGroupText, ButtonGroupSeparator }
cl import from .ui.card { Card, CardAction, CardContent, CardDescription, CardFooter, CardHeader, CardTitle }
cl import from .ui.checkbox { Checkbox }
cl import from .ui.input { Input }
cl import from ".ui.input-group" { InputGroup }
cl import from .ui.label { Label }
cl import from .ui.progress { Progress }
cl import from .ui.select { Select, SelectContent, SelectGroup, SelectItem, SelectTrigger, SelectValue }
cl import from .ui.separator { Separator }
cl import from .ui.slider { Slider }
cl import from .ui.spinner { Spinner }
cl import from .ui.switch { Switch }
cl import from .ui.tabs { Tabs, TabsList, TabsTrigger, TabsContent }
cl import from .ui.textarea { Textarea }
cl import from .ui.toggle { Toggle }
cl import from ".ui.toggle-group" { ToggleGroup, ToggleGroupItem }
cl import from .ui.avatar { Avatar, AvatarImage, AvatarFallback, AvatarBadge, AvatarGroup, AvatarGroupCount }
cl import from .ui.field { Field, FieldGroup, FieldLabel }
cl import from .ui.combobox { Combobox, ComboboxContent, ComboboxEmpty, ComboboxInput, ComboboxItem, ComboboxList }
cl import from .ui.item { Item, ItemGroup, ItemMedia, ItemContent, ItemTitle, ItemDescription, ItemActions }
cl import from .ui.empty { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription, EmptyContent }
cl import from ".ui.radio-group" { RadioGroup, RadioGroupItem }
cl import from .ui.kbd { Kbd, KbdGroup }
cl import from ".ui.alert-dialog" { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger }
cl import from ".ui.dropdown-menu" { DropdownMenu, DropdownMenuContent, DropdownMenuGroup, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuShortcut, DropdownMenuTrigger }
cl import from .ui.tooltip { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger }
cl import from .ui.skeleton { Skeleton }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { PlusSignIcon, SearchIcon, MailIcon, SettingsIcon, UserIcon, ArrowRight01Icon, Tick01Icon, Copy01Icon, WifiIcon, BluetoothIcon, AirplaneModeIcon, NotificationIcon, ShieldIcon, KeyboardIcon, ArrowUpIcon, ArrowDownIcon, TextBoldIcon, TextItalicIcon, TextUnderlineIcon, TextAlignLeftIcon, TextAlignCenterIcon, TextAlignRightIcon }
cl import from react { useState }

glob _frameworks: list = ["Next.js", "SvelteKit", "Nuxt.js", "Remix", "Astro"];

cl {
    """Hero section — centered heading with description and CTA buttons."""
    def:pub HeroSection(props: Any) -> JsxElement {
        onGetStarted = props.onGetStarted;

        return <div className="relative overflow-hidden border-b border-border/50">
            <div className="bg-grid-pattern absolute inset-0 opacity-40" />
            <div className="relative mx-auto max-w-4xl px-6 py-16 text-center sm:py-20 lg:py-24">
                <Badge variant="secondary" className="mb-4 inline-flex">
                    <span className="text-primary mr-1">{"●"}</span>
                    Built with Jac
                </Badge>
                <h1 className="text-foreground text-3xl font-bold tracking-tight sm:text-4xl lg:text-5xl">
                    The Foundation for your
                    <span className="text-primary"> Design System</span>
                </h1>
                <p className="text-muted-foreground mx-auto mt-4 max-w-2xl text-base sm:text-lg">
                    A set of beautifully designed components that you can customize, extend, and build on. Powered by Jac and Radix UI primitives.
                </p>
                <div className="mt-8 flex flex-wrap items-center justify-center gap-3">
                    <Button size="sm" onClick={lambda -> None { onGetStarted and onGetStarted.call(None, "button"); }}>
                        Get Started
                        <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" />
                    </Button>
                    <a href="https://docs.jaseci.org" target="_blank" rel="noopener noreferrer" className="no-underline">
                        <Button variant="outline" size="sm">
                            Documentation
                        </Button>
                    </a>
                </div>
            </div>
        </div>;
    }

    """Column 1 — Payment form card (like shadcn/ui)."""
    def:pub PaymentFormDemo() -> JsxElement {
        return <Card className="w-full">
            <CardHeader>
                <CardTitle>Payment Method</CardTitle>
                <CardDescription>All transactions are secure and encrypted</CardDescription>
            </CardHeader>
            <CardContent>
                <form>
                    <FieldGroup>
                        <Field>
                            <FieldLabel htmlFor="card-name">Name on Card</FieldLabel>
                            <Input id="card-name" placeholder="John Doe" />
                        </Field>
                        <div className="grid grid-cols-3 gap-3">
                            <Field className="col-span-2">
                                <FieldLabel htmlFor="card-number">Card Number</FieldLabel>
                                <Input id="card-number" placeholder="1234 5678 9012 3456" />
                                <p className="text-xs text-muted-foreground mt-1">Enter your 16-digit number.</p>
                            </Field>
                            <Field>
                                <FieldLabel htmlFor="card-cvv">CVV</FieldLabel>
                                <Input id="card-cvv" placeholder="123" />
                            </Field>
                        </div>
                        <div className="grid grid-cols-2 gap-3">
                            <Field>
                                <FieldLabel>Month</FieldLabel>
                                <Select>
                                    <SelectTrigger>
                                        <SelectValue placeholder="MM" />
                                    </SelectTrigger>
                                    <SelectContent>
                                        <SelectGroup>
                                            <SelectItem value="01">January</SelectItem>
                                            <SelectItem value="02">February</SelectItem>
                                            <SelectItem value="03">March</SelectItem>
                                            <SelectItem value="04">April</SelectItem>
                                            <SelectItem value="05">May</SelectItem>
                                            <SelectItem value="06">June</SelectItem>
                                            <SelectItem value="07">July</SelectItem>
                                            <SelectItem value="08">August</SelectItem>
                                            <SelectItem value="09">September</SelectItem>
                                            <SelectItem value="10">October</SelectItem>
                                            <SelectItem value="11">November</SelectItem>
                                            <SelectItem value="12">December</SelectItem>
                                        </SelectGroup>
                                    </SelectContent>
                                </Select>
                            </Field>
                            <Field>
                                <FieldLabel>Year</FieldLabel>
                                <Select>
                                    <SelectTrigger>
                                        <SelectValue placeholder="YYYY" />
                                    </SelectTrigger>
                                    <SelectContent>
                                        <SelectGroup>
                                            <SelectItem value="2026">2026</SelectItem>
                                            <SelectItem value="2027">2027</SelectItem>
                                            <SelectItem value="2028">2028</SelectItem>
                                            <SelectItem value="2029">2029</SelectItem>
                                            <SelectItem value="2030">2030</SelectItem>
                                        </SelectGroup>
                                    </SelectContent>
                                </Select>
                            </Field>
                        </div>
                        <Separator />
                        <div>
                            <p className="text-sm font-medium mb-3">Billing Address</p>
                            <p className="text-xs text-muted-foreground mb-3">The billing address associated with your payment method</p>
                            <div className="flex items-center gap-2 mb-4">
                                <Checkbox id="same-address" defaultChecked={True} />
                                <Label htmlFor="same-address" className="text-sm">Same as shipping address</Label>
                            </div>
                        </div>
                        <Field>
                            <FieldLabel htmlFor="payment-comments">Comments</FieldLabel>
                            <Textarea id="payment-comments" placeholder="Add any additional comments" />
                        </Field>
                        <Field orientation="horizontal">
                            <Button type="submit">Submit</Button>
                            <Button variant="outline" type="button">Cancel</Button>
                        </Field>
                    </FieldGroup>
                </form>
            </CardContent>
        </Card>;
    }

    """Column 2 — Team members empty state + badges + slider."""
    def:pub TeamEmptyStateDemo() -> JsxElement {
        return <Card className="w-full">
            <CardContent className="flex flex-col items-center gap-3 py-6">
                <AvatarGroup>
                    <Avatar className="size-10 border-2 border-background">
                        <AvatarFallback>JM</AvatarFallback>
                    </Avatar>
                    <Avatar className="size-10 border-2 border-background">
                        <AvatarFallback>SK</AvatarFallback>
                    </Avatar>
                    <Avatar className="size-10 border-2 border-background">
                        <AvatarFallback>
                            <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-4" />
                        </AvatarFallback>
                    </Avatar>
                </AvatarGroup>
                <div className="text-center">
                    <p className="text-sm font-semibold">No Team Members</p>
                    <p className="text-xs text-muted-foreground">Invite your team to collaborate on this project.</p>
                </div>
                <Button size="sm">
                    <HugeiconsIcon icon={PlusSignIcon} strokeWidth={2} data-icon="inline-start" />
                    Invite Members
                </Button>
            </CardContent>
        </Card>;
    }

    def:pub BadgeSpinnerDemo() -> JsxElement {
        return <div className="flex flex-wrap items-center gap-2">
            <Badge variant="secondary">
                <Spinner size="xs" className="mr-1" />
                Syncing
            </Badge>
            <Badge variant="secondary">
                <Spinner size="xs" className="mr-1" />
                Updating
            </Badge>
            <Badge variant="outline">
                <Spinner size="xs" className="mr-1" />
                Loading
            </Badge>
        </div>;
    }

    def:pub SliderDemo() -> JsxElement {
        return <div className="w-full space-y-3">
            <div className="flex items-center justify-between">
                <p className="text-sm font-medium">Price Range</p>
                <p className="text-xs text-muted-foreground">{"$200 - $800"}</p>
            </div>
            <Slider defaultValue={[200, 800]} max={1000} step={10} />
        </div>;
    }

    def:pub InputGroupDemo() -> JsxElement {
        return <div className="w-full space-y-3">
            <InputGroup>
                <HugeiconsIcon icon={SearchIcon} strokeWidth={2} className="text-muted-foreground" />
                <Input placeholder="Search..." className="border-0 shadow-none" />
                <span className="text-xs text-muted-foreground whitespace-nowrap">12 results</span>
            </InputGroup>
            <InputGroup>
                <span className="text-sm text-muted-foreground">https://</span>
                <Input placeholder="example.com" className="border-0 shadow-none" />
            </InputGroup>
        </div>;
    }

    """Column 3 — Settings items + toggles."""
    def:pub ItemSettingsDemo() -> JsxElement {
        has twoFactor: bool = False;

        return <Card className="w-full">
            <CardContent className="p-0">
                <ItemGroup>
                    <Item>
                        <ItemMedia>
                            <div className="flex size-8 items-center justify-center rounded-md bg-primary/10">
                                <HugeiconsIcon icon={ShieldIcon} strokeWidth={2} className="size-4 text-primary" />
                            </div>
                        </ItemMedia>
                        <ItemContent>
                            <ItemTitle>Two-factor authentication</ItemTitle>
                            <ItemDescription>Verify via email or phone number.</ItemDescription>
                        </ItemContent>
                        <ItemActions>
                            <Button size="sm" variant={twoFactor and "default" or "outline"} onClick={lambda -> None { twoFactor = not twoFactor; }}>
                                {twoFactor and "Enabled" or "Enable"}
                            </Button>
                        </ItemActions>
                    </Item>
                    <Item>
                        <ItemMedia>
                            <div className="flex size-8 items-center justify-center rounded-md bg-green-500/10">
                                <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-4 text-green-600" />
                            </div>
                        </ItemMedia>
                        <ItemContent>
                            <ItemTitle>Your profile has been verified.</ItemTitle>
                        </ItemContent>
                        <ItemActions>
                            <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} className="size-4 text-muted-foreground" />
                        </ItemActions>
                    </Item>
                </ItemGroup>
            </CardContent>
        </Card>;
    }

    def:pub AppearanceSettingsDemo() -> JsxElement {
        has gpuCount: int = 8;
        has wallpaperTinting: bool = True;

        return <div className="w-full space-y-4">
            <div>
                <p className="text-sm font-medium mb-1">Compute Environment</p>
                <p className="text-xs text-muted-foreground mb-3">Select the compute environment for your cluster.</p>
                <RadioGroup defaultValue="kubernetes" className="gap-3">
                    <label className="flex items-start gap-3 rounded-lg border border-border p-3 cursor-pointer has-[:checked]:border-primary has-[:checked]:bg-primary/5">
                        <RadioGroupItem value="kubernetes" className="mt-0.5" />
                        <div>
                            <p className="text-sm font-medium">Kubernetes</p>
                            <p className="text-xs text-muted-foreground">Run GPU workloads on a K8s configured cluster. This is the default.</p>
                        </div>
                    </label>
                    <label className="flex items-start gap-3 rounded-lg border border-border p-3 cursor-pointer has-[:checked]:border-primary has-[:checked]:bg-primary/5 opacity-60">
                        <RadioGroupItem value="vm" className="mt-0.5" disabled={True} />
                        <div>
                            <p className="text-sm font-medium">Virtual Machine</p>
                            <p className="text-xs text-muted-foreground">Access a VM configured cluster to run workloads. (Coming soon)</p>
                        </div>
                    </label>
                </RadioGroup>
            </div>
            <Separator />
            <div className="flex items-center justify-between">
                <div>
                    <p className="text-sm font-medium">Number of GPUs</p>
                    <p className="text-xs text-muted-foreground">You can add more later.</p>
                </div>
                <div className="flex items-center gap-2">
                    <Button variant="outline" size="icon" className="size-7" onClick={lambda -> None { if gpuCount > 1 { gpuCount = gpuCount - 1; } }}>
                        <span className="text-sm">{"−"}</span>
                    </Button>
                    <span className="w-8 text-center text-sm font-medium">{gpuCount}</span>
                    <Button variant="outline" size="icon" className="size-7" onClick={lambda -> None { gpuCount = gpuCount + 1; }}>
                        <HugeiconsIcon icon={PlusSignIcon} strokeWidth={2} className="size-3" />
                    </Button>
                </div>
            </div>
            <Separator />
            <div className="flex items-center justify-between">
                <div>
                    <p className="text-sm font-medium">Wallpaper Tinting</p>
                    <p className="text-xs text-muted-foreground">Allow the wallpaper to be tinted.</p>
                </div>
                <Switch checked={wallpaperTinting} onCheckedChange={lambda(v: Any) -> None { wallpaperTinting = v; }} />
            </div>
        </div>;
    }

    """Column 4 — Toolbar + survey + loading."""
    def:pub ToolbarDemo() -> JsxElement {
        return <div className="w-full space-y-3">
            <div className="flex items-center gap-1">
                <ButtonGroup>
                    <Button variant="outline" size="icon" className="size-8">
                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m15 18-6-6 6-6"/></svg>
                    </Button>
                    <ButtonGroupSeparator />
                    <Button variant="outline" size="sm" className="text-xs">Archive</Button>
                    <Button variant="outline" size="sm" className="text-xs">Report</Button>
                    <Button variant="outline" size="sm" className="text-xs">Snooze</Button>
                    <ButtonGroupSeparator />
                    <DropdownMenu>
                        <DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "outline", "size": "icon", "className": "size-8"})}>
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="1"/><circle cx="19" cy="12" r="1"/><circle cx="5" cy="12" r="1"/></svg>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                            <DropdownMenuItem>Mark as Read</DropdownMenuItem>
                            <DropdownMenuItem>Add to Calendar</DropdownMenuItem>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem>Label As...</DropdownMenuItem>
                        </DropdownMenuContent>
                    </DropdownMenu>
                </ButtonGroup>
            </div>
        </div>;
    }

    def:pub FormattingToolbarDemo() -> JsxElement {
        return <div className="w-full">
            <ToggleGroup type="multiple" className="justify-start">
                <ToggleGroupItem value="bold" aria-label="Bold">
                    <HugeiconsIcon icon={TextBoldIcon} strokeWidth={2} className="size-4" />
                </ToggleGroupItem>
                <ToggleGroupItem value="italic" aria-label="Italic">
                    <HugeiconsIcon icon={TextItalicIcon} strokeWidth={2} className="size-4" />
                </ToggleGroupItem>
                <ToggleGroupItem value="underline" aria-label="Underline">
                    <HugeiconsIcon icon={TextUnderlineIcon} strokeWidth={2} className="size-4" />
                </ToggleGroupItem>
            </ToggleGroup>
        </div>;
    }

    def:pub CheckboxTermsDemo() -> JsxElement {
        return <div className="flex items-center gap-2 rounded-lg border border-border p-3">
            <Checkbox id="terms-agree" defaultChecked={True} />
            <Label htmlFor="terms-agree" className="text-sm">I agree to the terms and conditions</Label>
        </div>;
    }

    def:pub PaginationDemo() -> JsxElement {
        has currentPage: int = 1;

        return <div className="flex items-center gap-3">
            <ButtonGroup>
                <Button variant={currentPage == 1 and "default" or "outline"} size="sm" className="size-8 text-xs" onClick={lambda -> None { currentPage = 1; }}>1</Button>
                <ButtonGroupSeparator />
                <Button variant={currentPage == 2 and "default" or "outline"} size="sm" className="size-8 text-xs" onClick={lambda -> None { currentPage = 2; }}>2</Button>
                <ButtonGroupSeparator />
                <Button variant={currentPage == 3 and "default" or "outline"} size="sm" className="size-8 text-xs" onClick={lambda -> None { currentPage = 3; }}>3</Button>
                <ButtonGroupSeparator />
                <Button variant="outline" size="icon" className="size-8">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m15 18-6-6 6-6"/></svg>
                </Button>
                <ButtonGroupSeparator />
                <Button variant="outline" size="icon" className="size-8">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m9 18 6-6-6-6"/></svg>
                </Button>
            </ButtonGroup>
        </div>;
    }

    def:pub SurveyDemo() -> JsxElement {
        has selected: list = ["social"];

        toggleOption = lambda(val: Any) -> None {
            newSelected = [];
            found = False;
            for item in selected {
                if item == val {
                    found = True;
                } else {
                    newSelected.push(item);
                }
            }
            if not found {
                newSelected.push(val);
            }
            selected = newSelected;
        };

        isSelected = lambda(val: Any) -> bool {
            for item in selected {
                if item == val {
                    return True;
                }
            }
            return False;
        };

        return <Card className="w-full">
            <CardHeader>
                <CardTitle className="text-sm">{"How did you hear about us?"}</CardTitle>
                <CardDescription>Select the option that best describes how you...</CardDescription>
            </CardHeader>
            <CardContent>
                <div className="flex flex-wrap gap-2">
                    <button
                        onClick={lambda -> None { toggleOption("social"); }}
                        className={cn(
                            "inline-flex items-center gap-1.5 rounded-full border px-3 py-1.5 text-xs font-medium transition-colors cursor-pointer bg-transparent outline-none",
                            isSelected("social") and "border-primary bg-primary/10 text-primary" or "border-border text-muted-foreground hover:bg-muted"
                        )}
                    >
                        {isSelected("social") and <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-3" />}
                        Social Media
                    </button>
                    <button
                        onClick={lambda -> None { toggleOption("search"); }}
                        className={cn(
                            "inline-flex items-center gap-1.5 rounded-full border px-3 py-1.5 text-xs font-medium transition-colors cursor-pointer bg-transparent outline-none",
                            isSelected("search") and "border-primary bg-primary/10 text-primary" or "border-border text-muted-foreground hover:bg-muted"
                        )}
                    >
                        {isSelected("search") and <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-3" />}
                        Search Engine
                    </button>
                    <button
                        onClick={lambda -> None { toggleOption("referral"); }}
                        className={cn(
                            "inline-flex items-center gap-1.5 rounded-full border px-3 py-1.5 text-xs font-medium transition-colors cursor-pointer bg-transparent outline-none",
                            isSelected("referral") and "border-primary bg-primary/10 text-primary" or "border-border text-muted-foreground hover:bg-muted"
                        )}
                    >
                        {isSelected("referral") and <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-3" />}
                        Referral
                    </button>
                    <button
                        onClick={lambda -> None { toggleOption("other"); }}
                        className={cn(
                            "inline-flex items-center gap-1.5 rounded-full border px-3 py-1.5 text-xs font-medium transition-colors cursor-pointer bg-transparent outline-none",
                            isSelected("other") and "border-primary bg-primary/10 text-primary" or "border-border text-muted-foreground hover:bg-muted"
                        )}
                    >
                        {isSelected("other") and <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-3" />}
                        Other
                    </button>
                </div>
            </CardContent>
        </Card>;
    }

    def:pub LoadingStateDemo() -> JsxElement {
        return <Empty>
            <EmptyMedia>
                <Spinner size="lg" />
            </EmptyMedia>
            <EmptyHeader>
                <EmptyTitle>Processing your request</EmptyTitle>
                <EmptyDescription>Please wait while we process your request. Do not refresh the page.</EmptyDescription>
            </EmptyHeader>
            <EmptyContent>
                <Button variant="outline" size="sm">Cancel</Button>
            </EmptyContent>
        </Empty>;
    }

    def:pub SkeletonCardDemo() -> JsxElement {
        return <Card className="w-full">
            <CardContent className="p-4 space-y-3">
                <div className="flex items-center gap-3">
                    <Skeleton className="size-10 rounded-full" />
                    <div className="flex-1 space-y-2">
                        <Skeleton className="h-4 w-3/4" />
                        <Skeleton className="h-3 w-1/2" />
                    </div>
                </div>
                <Skeleton className="h-20 w-full" />
                <div className="flex items-center gap-2">
                    <Skeleton className="h-8 w-20" />
                    <Skeleton className="h-8 w-16" />
                </div>
            </CardContent>
        </Card>;
    }

    def:pub ProgressDemo() -> JsxElement {
        return <div className="w-full space-y-2">
            <div className="flex items-center justify-between text-xs">
                <span className="text-muted-foreground">Upload progress</span>
                <span className="font-medium">68%</span>
            </div>
            <Progress value={68} />
        </div>;
    }

    """Root component grid — 4-column masonry layout like shadcn/ui."""
    def:pub RootComponentGrid(props: Any) -> JsxElement {
        return <div className="mx-auto grid gap-6 py-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 xl:gap-5">
            <div className="flex flex-col gap-6 *:w-full">
                <PaymentFormDemo />
            </div>

            <div className="flex flex-col gap-6 *:w-full">
                <TeamEmptyStateDemo />
                <BadgeSpinnerDemo />
                <SliderDemo />
                <InputGroupDemo />
                <ProgressDemo />
            </div>

            <div className="flex flex-col gap-6 *:w-full">
                <ItemSettingsDemo />
                <Separator className="my-0" />
                <AppearanceSettingsDemo />
            </div>

            <div className="flex flex-col gap-6 *:w-full order-first lg:hidden xl:order-last xl:flex">
                <ToolbarDemo />
                <CheckboxTermsDemo />
                <PaginationDemo />
                <FormattingToolbarDemo />
                <SurveyDemo />
                <LoadingStateDemo />
            </div>
        </div>;
    }

    """Full homepage — hero + grid."""
    def:pub HomePage(props: Any) -> JsxElement {
        onSelectItem = props.onSelectItem;

        return <div className="w-full">
            <HeroSection onGetStarted={onSelectItem} />
            <div className="mx-auto w-full max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
                <RootComponentGrid />
            </div>
        </div>;
    }
}

cl import from ".form-controls" { ButtonShowcase, CheckboxShowcase, SwitchShowcase, RadioGroupShowcase, SliderShowcase }
cl import from ".form-inputs" { InputShowcase, TextareaShowcase, SelectShowcase, ComboboxShowcase, FieldShowcase, InputGroupShowcase, LabelShowcase, NativeSelectShowcase, InputOTPShowcase }
cl import from ".overlay" { DialogShowcase, AlertDialogShowcase, SheetShowcase, DrawerShowcase, PopoverShowcase, HoverCardShowcase, TooltipShowcase, DropdownMenuShowcase, ContextMenuShowcase, CommandShowcase }
cl import from ".navigation" { TabsShowcase, AccordionShowcase, BreadcrumbShowcase, PaginationShowcase, NavigationMenuShowcase, MenubarShowcase, SidebarShowcase, CollapsibleShowcase }
cl import from ".display" { CardShowcase, BadgeShowcase, AvatarShowcase, TableShowcase, CalendarShowcase, CarouselShowcase, ScrollAreaShowcase, AspectRatioShowcase, ResizableShowcase }
cl import from ".feedback" { AlertShowcase, ProgressShowcase, SkeletonShowcase, SpinnerShowcase, EmptyShowcase }
cl import from ".utility" { SeparatorShowcase, ToggleShowcase, ToggleGroupShowcase, ButtonGroupShowcase, KbdShowcase, ItemShowcase }
cl import from ".chart" { ChartShowcase }

cl {
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

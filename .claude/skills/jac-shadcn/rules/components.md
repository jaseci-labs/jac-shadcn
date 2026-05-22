# Component vocabulary

54 components live in `components/ui/`. This file is the lookup table — purpose, the underlying primitive, and the legal child grammar for every one.

> **Read this BEFORE writing JSX.** The most common failure mode is Claude not knowing a primitive exists and fabricating one from `<div>` (custom Combobox, custom drawer, custom kbd). When in doubt, scan this table — if a row matches the need, use that component. Don't invent.

## Primitive legend

- **radix** — wraps a `radix-ui` primitive. Uses `asChild={True}` for composition.
- **base** — wraps `@base-ui/react`. Only one in the project: **Combobox**. Different API — see `rules/base-vs-radix.md`.
- **cmdk** — wraps `cmdk` library. Just **Command**.
- **embla** — wraps `embla-carousel-react`. Just **Carousel**.
- **input-otp** — wraps `input-otp` library. Just **InputOTP**.
- **atom** — styled HTML, no underlying primitive. Lighter and Jac-native.

## Pick-by-need table

| Need | Component(s) |
|---|---|
| Click action | `Button` (variants: default / outline / secondary / ghost / link / destructive; sizes: default / sm / lg / icon / xs / icon-sm / icon-xs / icon-lg) |
| Multiple buttons attached as one bar | `ButtonGroup` + buttons + optional `ButtonGroupSeparator` / `ButtonGroupText` |
| Text input (single line) | `Input` |
| Text input with addon (icon, button, suffix) | `InputGroup` + `InputGroupInput` + `InputGroupAddon` (left/right) |
| Multi-line text | `Textarea` |
| Password input with reveal toggle | `PasswordInput` |
| One-time code | `InputOTP` + `InputOTPGroup` + `InputOTPSlot` (+ `InputOTPSeparator` for chunks) |
| Dropdown picker (predefined options) | `Select` (Radix-style nesting — see `base-vs-radix.md`) |
| Native HTML select (no JS, no Radix) | `NativeSelect` + `NativeSelectOption` (+ `NativeSelectOptGroup`) |
| Searchable dropdown / autocomplete | `Combobox` (base-flavored — see exception note in `base-vs-radix.md`) |
| Boolean toggle | `Switch` (settings) or `Checkbox` (forms with submit) |
| Single choice from a few options | `RadioGroup` + `RadioGroupItem` |
| Toggle between 2–7 mutually-exclusive options inline | `ToggleGroup` + `ToggleGroupItem` (`type="single"` or `type="multiple"`) |
| Single icon-toggle | `Toggle` |
| Numeric value via drag | `Slider` (array-shaped — see `base-vs-radix.md`) |
| Form structure (label + control + description + error) | `Field` + `FieldLabel` + `FieldDescription` + `FieldError` inside `FieldGroup` |
| Group of related fields under a heading | `FieldSet` + `FieldLegend` + `FieldGroup` |
| Visual divider in a form | `FieldSeparator` (with optional inline label) |
| Date picker | `Calendar` (single component — wrap in `Popover` + `Button` for picker UX) |
| Color/data display block | `Card` + `CardHeader` + `CardTitle` + `CardDescription` + `CardAction` + `CardContent` + `CardFooter` |
| Status pill | `Badge` (variants: default / secondary / destructive / outline) |
| Visual divider (non-form) | `Separator` (`orientation="horizontal"` / `"vertical"`) |
| Loading placeholder | `Skeleton` (size yourself with `className`) |
| In-place loader / spinner | `Spinner` |
| Progress fill | `Progress` (`value={0..100}`) |
| Avatar with image + initials fallback | `Avatar` + `AvatarImage` + `AvatarFallback` (+ `AvatarBadge` for status dots, `AvatarGroup` + `AvatarGroupCount` for stacks) |
| Aspect-locked image / video container | `AspectRatio` (`ratio={16/9}`) |
| Empty state ("No projects yet") | `Empty` + `EmptyHeader` + `EmptyMedia` + `EmptyTitle` + `EmptyDescription` + `EmptyContent` |
| Callout / inline notice | `Alert` + `AlertTitle` + `AlertDescription` (+ optional `AlertAction`) |
| Toast / transient notification | `toast()` from `sonner` (NOT a component — see `utils/toast.cl.jac`) |
| Keyboard shortcut display | `Kbd` (single key) or `KbdGroup` (combo with separators) |
| Focused task that needs input (modal) | `Dialog` family — see Dialog grammar below |
| Destructive confirmation | `AlertDialog` family — has Cancel / Action built-in |
| Side panel (drawer from edge) | `Sheet` family (`side="left"` / `"right"` / `"top"` / `"bottom"`) |
| Mobile-first bottom sheet | `Drawer` family (uses `vaul`, has snap points) |
| Quick info on hover | `HoverCard` |
| Click-to-open small contextual content | `Popover` |
| Tooltip on hover/focus | `Tooltip` (must be inside `TooltipProvider`) |
| Right-click menu | `ContextMenu` family |
| Click-trigger menu | `DropdownMenu` family |
| App-bar menubar (File / Edit / View) | `Menubar` family |
| Command palette (Ctrl+K) | `Command` family — usually inside `CommandDialog` |
| Top-of-page nav with mega-menu support | `NavigationMenu` family |
| Side nav for app shells | `Sidebar` family — see Sidebar grammar (the biggest system, 23 sub-parts) |
| Trail / hierarchy display | `Breadcrumb` + `BreadcrumbList` + `BreadcrumbItem` + `BreadcrumbPage` (current) / `BreadcrumbLink` + `BreadcrumbSeparator` (+ `BreadcrumbEllipsis` for truncation) |
| Page-number nav | `Pagination` + `PaginationContent` + `PaginationItem` + `PaginationLink` / `PaginationPrevious` / `PaginationNext` (+ `PaginationEllipsis`) |
| Tabs | `Tabs` + `TabsList` + `TabsTrigger` + `TabsContent` |
| Expandable single panel | `Collapsible` + `CollapsibleTrigger` + `CollapsibleContent` |
| Multiple expandable panels | `Accordion` + `AccordionItem` + `AccordionTrigger` + `AccordionContent` (`type="single"` or `"multiple"` — see `base-vs-radix.md`) |
| Carousel / slideshow | `Carousel` + `CarouselContent` + `CarouselItem` (+ `CarouselPrevious` / `CarouselNext`) |
| Drag-resizable panels | `ResizablePanelGroup` + `ResizablePanel` + `ResizableHandle` |
| Long content with custom scrollbar | `ScrollArea` + `ScrollBar` (BUT see ScrollArea gotcha below) |
| Chart (recharts wrapper) | `ChartContainer` + `ChartTooltip` + `ChartTooltipContent` + `ChartLegend` + `ChartLegendContent` |
| Tabular data | `Table` + `TableHeader` + `TableBody` + `TableFooter` + `TableRow` + `TableHead` (cell in header) + `TableCell` (cell in body) (+ `TableCaption`) |
| Generic list-with-icon row | `Item` + `ItemMedia` + `ItemContent` + `ItemTitle` + `ItemDescription` + `ItemActions` (+ `ItemHeader`/`ItemFooter`/`ItemSeparator` in `ItemGroup`) |

## Composition rules — items always inside their group

This is the single biggest source of "looks weird, no errors" bugs. Every menu/select/list item has a required parent group:

| Item component | Required parent | Notes |
|---|---|---|
| `SelectItem`, `SelectLabel` | `SelectGroup` (inside `SelectContent`) | Use `SelectSeparator` between groups |
| `DropdownMenuItem`, `DropdownMenuLabel`, `DropdownMenuCheckboxItem`, `DropdownMenuSub`, `DropdownMenuRadioItem` | `DropdownMenuGroup` (inside `DropdownMenuContent`) | Radio items also need a `DropdownMenuRadioGroup` wrapper |
| `MenubarItem`, `MenubarLabel`, `MenubarCheckboxItem` | `MenubarGroup` (inside `MenubarContent`) | Radio items need `MenubarRadioGroup` |
| `ContextMenuItem`, `ContextMenuLabel` | `ContextMenuGroup` (inside `ContextMenuContent`) | |
| `CommandItem` | `CommandGroup` (inside `CommandList`) | `CommandEmpty` is a sibling of `CommandGroup` |
| `ComboboxItem` | `ComboboxGroup` (inside `ComboboxList`) | Combobox is base-flavored — also accepts `items` prop |
| `RadioGroupItem` | `RadioGroup` | The wrapper drives `value` / `onValueChange` |
| `ToggleGroupItem` | `ToggleGroup` | Wrapper drives `type` and `value` |
| `TabsTrigger` | `TabsList` (inside `Tabs`) | Never put `TabsTrigger` directly under `Tabs` |
| `AccordionItem` | `Accordion` | Each item must have a unique `value="..."` |
| `BreadcrumbItem` | `BreadcrumbList` (inside `Breadcrumb`) | Use `BreadcrumbPage` for the current page (no link), `BreadcrumbLink` for ancestors |
| `PaginationItem` | `PaginationContent` (inside `Pagination`) | |
| `CarouselItem` | `CarouselContent` (inside `Carousel`) | |
| `ResizablePanel`, `ResizableHandle` | `ResizablePanelGroup` | Direction: `direction="horizontal"` / `"vertical"` |
| `Item` (the generic list row) | `ItemGroup` | Use `ItemSeparator` between rows |

## System-level grammars (the big ones)

### Card

Always use the full composition. Don't dump everything in `CardContent`.

```jac
<Card>
    <CardHeader>
        <CardTitle>Title</CardTitle>
        <CardDescription>Subtitle</CardDescription>
        <CardAction><Button size="sm">Action</Button></CardAction>
    </CardHeader>
    <CardContent>{/* body */}</CardContent>
    <CardFooter>{/* CTAs */}</CardFooter>
</Card>
```

`CardAction` lives inside `CardHeader` and floats to the top-right of the header — that's where settings buttons / kebabs go. Don't manually `absolute right-4`.

### Dialog / Sheet / Drawer / AlertDialog

Same shape, different transitions. **All four require a `*Title` for accessibility** — use `className="sr-only"` to hide it visually if your design has no title.

```jac
<Dialog open={open} onOpenChange={setOpen}>
    <DialogTrigger asChild={True}>
        <Button>Open</Button>
    </DialogTrigger>
    <DialogContent>
        <DialogHeader>
            <DialogTitle>Edit profile</DialogTitle>
            <DialogDescription>Update your details.</DialogDescription>
        </DialogHeader>
        {/* body */}
        <DialogFooter>
            <DialogClose asChild={True}><Button variant="outline">Cancel</Button></DialogClose>
            <Button onClick={handleSave}>Save</Button>
        </DialogFooter>
    </DialogContent>
</Dialog>
```

`AlertDialog` is the same skeleton with `AlertDialogAction` (primary, the destructive confirm) and `AlertDialogCancel` (outline, the back-out) instead of arbitrary footer buttons. Don't use a regular `Dialog` for "Are you sure?" — use `AlertDialog`.

`Sheet` adds a `side="left" | "right" | "top" | "bottom"` to `SheetContent`. `Drawer` is bottom-sheet by default (mobile-first) and supports snap points.

### Field family (forms)

**Always wrap controls in `Field` + `FieldLabel`. Never `<div className="space-y-2"><Label>...</Label><Input/></div>`.**

```jac
<form>
    <FieldGroup>
        <Field>
            <FieldLabel htmlFor="email">Email</FieldLabel>
            <Input id="email" type="email" required={True} />
            <FieldDescription>We'll never share your email.</FieldDescription>
        </Field>
        <Field data-invalid={True}>
            <FieldLabel htmlFor="password">Password</FieldLabel>
            <Input id="password" type="password" aria-invalid={True} />
            <FieldError>Must be at least 8 characters.</FieldError>
        </Field>
    </FieldGroup>
</form>
```

Validation uses `data-invalid` on `Field` + `aria-invalid` on the control. For grouped checkboxes/radios under a heading: `FieldSet` + `FieldLegend` + `FieldGroup` (don't use a `<div>` with an `<h3>`).

For settings-style two-column layouts: pass `orientation="horizontal"` to `Field`.

### Sidebar (the largest system, 23 sub-parts)

**Always inside `SidebarProvider`.** Sidebar uses CSS variables and context that won't work without it.

```jac
<SidebarProvider>
    <Sidebar collapsible="icon">      # or "offcanvas" | "none"
        <SidebarHeader>{/* logo, team switcher */}</SidebarHeader>
        <SidebarContent>
            <SidebarGroup>
                <SidebarGroupLabel>Platform</SidebarGroupLabel>
                <SidebarMenu>
                    <SidebarMenuItem>
                        <SidebarMenuButton asChild={True} tooltip="Home">
                            <a href="#"><HugeiconsIcon icon={Home01Icon} /><span>Home</span></a>
                        </SidebarMenuButton>
                        <SidebarMenuAction showOnHover={True}>{/* dropdown trigger */}</SidebarMenuAction>
                        <SidebarMenuBadge>3</SidebarMenuBadge>
                    </SidebarMenuItem>
                    {/* nested submenu */}
                    <SidebarMenuItem>
                        <SidebarMenuButton>Settings</SidebarMenuButton>
                        <SidebarMenuSub>
                            <SidebarMenuSubItem>
                                <SidebarMenuSubButton asChild={True}><a href="#">General</a></SidebarMenuSubButton>
                            </SidebarMenuSubItem>
                        </SidebarMenuSub>
                    </SidebarMenuItem>
                </SidebarMenu>
            </SidebarGroup>
        </SidebarContent>
        <SidebarFooter>{/* user menu */}</SidebarFooter>
        <SidebarRail />              # optional drag-to-collapse rail
    </Sidebar>
    <SidebarInset>{/* main page content; SidebarInset positions correctly next to the sidebar */}</SidebarInset>
</SidebarProvider>
```

**⚠ Critical rule for jac-shadcn**: do **not** pass `className=` to any Sidebar primitive. The current jac-shadcn implementation has a `{...props}` spread bug that wipes the base classes (positioning, sizing, flex). See `rules/registry-blocks.md` for the workaround. For working examples: `examples/sidebar-07.cl.jac` and `examples/dashboard-01.cl.jac`.

### Select

```jac
<Select value={value} onValueChange={setValue}>
    <SelectTrigger>
        <SelectValue placeholder="Pick one" />
    </SelectTrigger>
    <SelectContent>
        <SelectGroup>
            <SelectLabel>Fruits</SelectLabel>
            <SelectItem value="apple">Apple</SelectItem>
            <SelectItem value="banana">Banana</SelectItem>
        </SelectGroup>
    </SelectContent>
</Select>
```

`SelectValue` lives inside `SelectTrigger`. `placeholder` goes on `SelectValue`. Items must be in `SelectGroup`. `Select` does not support `multiple` — use `Combobox` for that.

### NavigationMenu

Top-of-page mega-menu. Trigger reveals a content panel that aligns to the trigger.

```jac
<NavigationMenu>
    <NavigationMenuList>
        <NavigationMenuItem>
            <NavigationMenuTrigger>Products</NavigationMenuTrigger>
            <NavigationMenuContent>
                <ul className="grid gap-3 pt-4 pb-4 pl-4 pr-4 md:w-[400px] md:grid-cols-2">
                    <li>
                        <NavigationMenuLink asChild={True}>
                            <a href="/features">Features</a>
                        </NavigationMenuLink>
                    </li>
                </ul>
            </NavigationMenuContent>
        </NavigationMenuItem>
    </NavigationMenuList>
</NavigationMenu>
```

`NavigationMenuLink` should be `asChild={True}` wrapping an `<a>` so router behavior is preserved.

### Command

Search-as-you-type list. Almost always inside `CommandDialog` for the Ctrl+K palette UX.

```jac
<CommandDialog open={open} onOpenChange={setOpen}>
    <CommandInput placeholder="Type a command..." />
    <CommandList>
        <CommandEmpty>No results found.</CommandEmpty>
        <CommandGroup heading="Suggestions">
            <CommandItem onSelect={lambda { runFoo(); }}>
                <HugeiconsIcon icon={SearchIcon} /> Search files
                <CommandShortcut>⌘P</CommandShortcut>
            </CommandItem>
        </CommandGroup>
        <CommandSeparator />
        <CommandGroup heading="Settings">
            <CommandItem>Profile</CommandItem>
        </CommandGroup>
    </CommandList>
</CommandDialog>
```

### DropdownMenu / ContextMenu / Menubar (same grammar)

```jac
<DropdownMenu>
    <DropdownMenuTrigger asChild={True}>
        <Button variant="outline">Open</Button>
    </DropdownMenuTrigger>
    <DropdownMenuContent>
        <DropdownMenuLabel>Account</DropdownMenuLabel>
        <DropdownMenuGroup>
            <DropdownMenuItem>Profile</DropdownMenuItem>
            <DropdownMenuItem>
                Settings
                <DropdownMenuShortcut>⌘,</DropdownMenuShortcut>
            </DropdownMenuItem>
            <DropdownMenuSub>
                <DropdownMenuSubTrigger>More</DropdownMenuSubTrigger>
                <DropdownMenuSubContent>
                    <DropdownMenuItem>Even more</DropdownMenuItem>
                </DropdownMenuSubContent>
            </DropdownMenuSub>
        </DropdownMenuGroup>
        <DropdownMenuSeparator />
        <DropdownMenuItem>Log out</DropdownMenuItem>
    </DropdownMenuContent>
</DropdownMenu>
```

`ContextMenu` is the same with `ContextMenu*` names + a `ContextMenuTrigger` that wraps the right-click target. `Menubar` is the same again with a top-level `<MenubarMenu>` per menu (File / Edit / View).

### Tabs

```jac
<Tabs defaultValue="account" value={tab} onValueChange={setTab}>
    <TabsList>
        <TabsTrigger value="account">Account</TabsTrigger>
        <TabsTrigger value="security">Security</TabsTrigger>
    </TabsList>
    <TabsContent value="account">{/* account body */}</TabsContent>
    <TabsContent value="security">{/* security body */}</TabsContent>
</Tabs>
```

`TabsTrigger` and `TabsContent` are matched by `value`. Triggers are always inside `TabsList`.

### Avatar

```jac
<Avatar>
    <AvatarImage src={user.avatar} alt={user.name} />
    <AvatarFallback>JD</AvatarFallback>
</Avatar>

# With status dot
<Avatar>
    <AvatarImage src={user.avatar} alt={user.name} />
    <AvatarFallback>JD</AvatarFallback>
    <AvatarBadge variant="success" />     # variants: success | warning | destructive | info
</Avatar>

# Stack of overlapping avatars
<AvatarGroup>
    <Avatar>...</Avatar>
    <Avatar>...</Avatar>
    <Avatar>...</Avatar>
    <AvatarGroupCount>+12</AvatarGroupCount>
</AvatarGroup>
```

`AvatarFallback` is **not optional** — without it the component crashes when the image 404s.

### InputGroup

The right way to put a button or icon inside an input field. Don't `absolute right-2 top-2` a button on top of an `<Input>`.

```jac
<InputGroup>
    <InputGroupAddon align="start"><HugeiconsIcon icon={SearchIcon} /></InputGroupAddon>
    <InputGroupInput placeholder="Search..." />
    <InputGroupAddon align="end">
        <InputGroupButton size="sm" onClick={runSearch}>Go</InputGroupButton>
    </InputGroupAddon>
</InputGroup>
```

**Use `InputGroupInput` / `InputGroupTextarea` inside the group, not raw `Input` / `Textarea`** — the addons need the group's special rendering.

### Carousel

```jac
<Carousel>
    <CarouselContent>
        <CarouselItem>{/* slide 1 */}</CarouselItem>
        <CarouselItem>{/* slide 2 */}</CarouselItem>
    </CarouselContent>
    <CarouselPrevious />
    <CarouselNext />
</Carousel>
```

The previous/next buttons are absolutely positioned — they rely on the parent being positioned. Don't move them outside `<Carousel>`.

### Resizable

```jac
<ResizablePanelGroup direction="horizontal">
    <ResizablePanel defaultSize={25}>{/* left */}</ResizablePanel>
    <ResizableHandle withHandle={True} />
    <ResizablePanel defaultSize={75}>{/* right */}</ResizablePanel>
</ResizablePanelGroup>
```

`defaultSize` is a percentage (0–100). For nested splits, nest another `<ResizablePanelGroup direction="vertical">` inside one of the panels.

### Pagination

```jac
<Pagination>
    <PaginationContent>
        <PaginationItem><PaginationPrevious href="#" /></PaginationItem>
        <PaginationItem><PaginationLink href="#" isActive={True}>1</PaginationLink></PaginationItem>
        <PaginationItem><PaginationLink href="#">2</PaginationLink></PaginationItem>
        <PaginationItem><PaginationEllipsis /></PaginationItem>
        <PaginationItem><PaginationLink href="#">10</PaginationLink></PaginationItem>
        <PaginationItem><PaginationNext href="#" /></PaginationItem>
    </PaginationContent>
</Pagination>
```

### Empty

Use this **instead of** writing your own "No results" state.

```jac
<Empty>
    <EmptyHeader>
        <EmptyMedia>
            <HugeiconsIcon icon={FolderIcon} strokeWidth={2} className="size-12 text-muted-foreground" />
        </EmptyMedia>
        <EmptyTitle>No projects yet</EmptyTitle>
        <EmptyDescription>Get started by creating your first project.</EmptyDescription>
    </EmptyHeader>
    <EmptyContent>
        <Button>Create project</Button>
    </EmptyContent>
</Empty>
```

### Item (generic icon-row list)

For "list with icon, title, description, actions" rows that aren't menu items.

```jac
<ItemGroup>
    <Item>
        <ItemMedia><HugeiconsIcon icon={FolderIcon} /></ItemMedia>
        <ItemContent>
            <ItemTitle>Documents</ItemTitle>
            <ItemDescription>42 files</ItemDescription>
        </ItemContent>
        <ItemActions>
            <Button size="icon-sm" variant="ghost"><HugeiconsIcon icon={MoreHorizontalCircle01Icon} /></Button>
        </ItemActions>
    </Item>
    <ItemSeparator />
    <Item>...</Item>
</ItemGroup>
```

This is the right choice when you want list rows but not full menu/dropdown semantics. Don't fabricate from `flex items-center gap-3 pt-3 pb-3` divs.

### ScrollArea ⚠ gotcha

Radix `ScrollArea` **does not respect `max-h-*` on itself**. To get a scrollable container with a max height:

```jac
# WRONG — ScrollArea ignores the max-h, content overflows the parent.
<ScrollArea className="max-h-96">{/* long content */}</ScrollArea>

# RIGHT — wrap in a sized div, ScrollArea fills 100%.
<div className="max-h-96 overflow-hidden">
    <ScrollArea className="h-full">{/* long content */}</ScrollArea>
</div>

# OR just use a plain div with overflow-y-auto when you don't need the custom scrollbar.
<div className="max-h-96 overflow-y-auto">{/* long content */}</div>
```

This bites repeatedly — for plain "scroll if too tall" cases, prefer `<div className="overflow-y-auto">`. Only use `ScrollArea` when you explicitly want the styled custom scrollbar.

### Chart

`ChartContainer` wraps Recharts. The standard pattern:

```jac
import from "recharts" { Bar, BarChart, CartesianGrid, XAxis }

glob _config: dict = {
    "visitors": {"label": "Visitors", "color": "var(--chart-1)"}
};

<ChartContainer config={_config} className="h-[200px] w-full">
    <BarChart data={data}>
        <CartesianGrid vertical={False} />
        <XAxis dataKey="month" tickLine={False} axisLine={False} />
        <ChartTooltip content={<ChartTooltipContent />} />
        <Bar dataKey="visitors" fill="var(--color-visitors)" radius={4} />
    </BarChart>
</ChartContainer>
```

Required: `config` prop with one entry per data series. Color tokens come from CSS variables in `:root` (`--chart-1`...`--chart-5`). Don't hardcode hex colors.

## Atoms — single-element components

These are simple wrappers around HTML elements. No composition rules to remember beyond their props.

| Component | Element | Notable props |
|---|---|---|
| `Input` | `<input>` | `type`, `placeholder`, `disabled`, `aria-invalid` |
| `Textarea` | `<textarea>` | `rows`, `placeholder` |
| `PasswordInput` | `<input type="password">` with reveal icon | same as Input |
| `Label` | `<label>` (Radix wrapper for accessibility) | `htmlFor` |
| `Button` | `<button>` | `variant`, `size`, `asChild`, `disabled` |
| `Badge` | `<span>` | `variant` |
| `Skeleton` | `<div className="bg-muted animate-pulse">` | size via className |
| `Spinner` | rotating icon | `className` |
| `Separator` | `<div role="separator">` | `orientation` |
| `Progress` | filled bar | `value` (0–100) |
| `Slider` | thumb + track | `value` is array, `onValueChange(v[])` |
| `Switch` | bool toggle | `checked`, `onCheckedChange` |
| `Checkbox` | bool with check | same as Switch |
| `Toggle` | press-able icon button | `pressed`, `onPressedChange` |
| `AspectRatio` | wrapper that locks aspect | `ratio={16/9}` etc. |
| `Calendar` | grid date picker | `mode="single"` / `"multiple"` / `"range"`, `selected`, `onSelect` |
| `Kbd` | `<kbd>` | wrap shortcut text |
| `KbdGroup` | row of `Kbd` with separators | put `<Kbd>⌘</Kbd> <Kbd>K</Kbd>` inside |

## What NOT to do — at a glance

- **Don't fabricate components from `<div>`.** If the request has a recognizable name (combobox, drawer, kbd, accordion, calendar), check this table — it almost certainly exists.
- **Don't put items directly under content containers.** They need their group wrapper. See the "Items always inside their group" table above.
- **Don't pass `className` to Sidebar primitives.** Wraps the className spread bug. Use a `<div>` wrapper instead.
- **Don't use `Select` for searchable dropdowns** — use `Combobox`. Don't use `Combobox` for predefined non-searchable lists — use `Select`.
- **Don't use `Dialog` for "Are you sure?"** — use `AlertDialog`.
- **Don't use raw `<hr>` / `border-t` divs** — use `Separator`.
- **Don't use raw `animate-pulse` divs for loading** — use `Skeleton`.
- **Don't use raw `<span className="rounded-full bg-...">` for status pills** — use `Badge`.
- **Don't wrap an `<Input>` and a `<Button>` with `absolute` positioning** — use `InputGroup`.
- **Don't loop `<Button>` with manual active state for 2–7 options** — use `ToggleGroup`.
- **Don't pass scalar `value={50}` to `Slider`** — it expects `[50]`.
- **Don't pass `multiple` to `ToggleGroup`** — it's `type="multiple"`.

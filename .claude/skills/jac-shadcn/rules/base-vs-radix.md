# Base vs Radix — jac-shadcn is Radix-flavored

Real shadcn/ui v4 ships in two flavors — `base` (built on `@base-ui/react`) and `radix` (built on `radix-ui`). They share component names and class strings, but **diverge on a few APIs**: composition (`render` vs `asChild`), Select, ToggleGroup, Slider, Accordion.

**jac-shadcn is Radix.** Across the 54 installed primitives:

- **32 wrap `radix-ui`** — Accordion, AlertDialog, AspectRatio, Avatar, Badge, Breadcrumb, Button, ButtonGroup, Checkbox, Collapsible, ContextMenu, Dialog, DropdownMenu, HoverCard, Item, Label, Menubar, NavigationMenu, Popover, Progress, RadioGroup, ScrollArea, Select, Separator, Sheet, Sidebar (Slot only), Slider, Switch, Tabs, Toggle, ToggleGroup, Tooltip.
- **1 wraps `@base-ui/react`** — `Combobox` only. Radix doesn't ship a Combobox primitive, so this one had to come from base.
- **Atomic** components (Input, Textarea, Card, Field, Skeleton, Spinner, Calendar, Empty, Item, Pagination, Resizable, Table, etc.) don't use either — they're styled HTML.
- **Third-party** for the rest: `cmdk` (Command), `embla-carousel-react` (Carousel), `input-otp` (InputOTP).

So whenever you read upstream shadcn `.tsx` source and the only API divergence is composition, **the radix flavor maps directly onto jac-shadcn**.

---

## Translation rule #1 — `render` (base) → `asChild={True}` + child (radix)

When you see this in upstream base source:

```tsx
<DropdownMenuTrigger render={<SidebarMenuAction showOnHover />}>
  <MoreHorizontalIcon />
  <span className="sr-only">More</span>
</DropdownMenuTrigger>
```

…the radix-flavored equivalent — and the right pattern for jac-shadcn — is:

```jac
<DropdownMenuTrigger asChild={True}>
    <SidebarMenuAction showOnHover={True}>
        <HugeiconsIcon icon={MoreHorizontalCircle01Icon} strokeWidth={2} className="size-4" />
        <span className="sr-only">More</span>
    </SidebarMenuAction>
</DropdownMenuTrigger>
```

Two things move:
- The element passed to `render={<X props />}` becomes a literal child of the trigger.
- Whatever was already a child of the trigger now nests inside that element.

**Where this matters most**: any `Trigger` or `Close` component. `DialogTrigger`, `SheetTrigger`, `AlertDialogTrigger`, `PopoverTrigger`, `TooltipTrigger`, `HoverCardTrigger`, `DropdownMenuTrigger`, `ContextMenuTrigger`, `MenubarTrigger`, `CollapsibleTrigger`, `NavigationMenuTrigger`, `AccordionTrigger`, `DialogClose`, `SheetClose`, `AlertDialogCancel/Action`. Plus pass-through wrappers `SidebarMenuButton`, `SidebarMenuSubButton`, `BreadcrumbLink`, `PaginationLink`, `Button`, `Badge`, `Item` — they all support `asChild={True}` to render as a non-button element (typically `<a>`).

**Always pass `asChild={True}` unconditionally** when the trigger renders as a custom element. There used to be a "common mistake" entry recommending `asChild={isActive and True or None}` — that was wrong. Use `asChild={True}` + `isActive={...}` for active state instead.

---

## Translation rule #2 — Select API (Radix-style nested children)

jac-shadcn `Select` follows the Radix structure. **Don't** look for a base-style `items` prop — it doesn't exist:

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
        <SelectSeparator />
        <SelectGroup>
            <SelectItem value="carrot">Carrot</SelectItem>
        </SelectGroup>
    </SelectContent>
</Select>
```

Required nesting: every `SelectItem` / `SelectLabel` lives inside a `SelectGroup`. Multiple groups for visual sections, separated by `SelectSeparator`. The trigger holds a `SelectValue` — pass `placeholder` there, not on the trigger.

`Select` does **not** support `multiple`. For multi-select, use `Combobox` (which is base-flavored and exposes a different API — see Combobox-specific notes below).

---

## Translation rule #3 — ToggleGroup uses `type`, not `multiple`

```jac
# Single selection (radio-like)
<ToggleGroup type="single" value={value} onValueChange={setValue}>
    <ToggleGroupItem value="bold">B</ToggleGroupItem>
    <ToggleGroupItem value="italic">I</ToggleGroupItem>
</ToggleGroup>

# Multi-selection (checkbox-like)
<ToggleGroup type="multiple" value={values} onValueChange={setValues}>
    <ToggleGroupItem value="bold">B</ToggleGroupItem>
    <ToggleGroupItem value="italic">I</ToggleGroupItem>
</ToggleGroup>
```

Don't write `<ToggleGroup multiple>` — that's the base-flavored API.

`ToggleGroup` is the canonical pick for **2–7 mutually-exclusive or boolean options** in a row. Don't loop `<Button>` with manual active state; that loses keyboard nav and aria semantics.

---

## Translation rule #4 — Slider takes an array, returns an array

Radix `Slider` is array-shaped:

```jac
has volume: list = [50];
<Slider value={volume} onValueChange={lambda(v: list) { volume = v; }} max={100} step={1} />
# read scalar
current = volume[0];
```

Don't pass a scalar (`value={50}`) and don't expect a scalar back from `onValueChange`. For **range sliders**, just pass two values (`[20, 80]`) and you get two thumbs.

---

## Translation rule #5 — Accordion needs `type` and the right `defaultValue` shape

```jac
# Single — only one panel open at a time. defaultValue is a string.
<Accordion type="single" defaultValue="item-1" collapsible={True}>
    <AccordionItem value="item-1">
        <AccordionTrigger>Section one</AccordionTrigger>
        <AccordionContent>Body text.</AccordionContent>
    </AccordionItem>
</Accordion>

# Multiple — any number open. defaultValue is a list.
<Accordion type="multiple" defaultValue={["item-1", "item-3"]}>
    ...
</Accordion>
```

Required: `type="single"` or `type="multiple"`. `collapsible={True}` only applies to `type="single"` — it allows closing the open one. `defaultValue` shape **must match `type`** (string for single, list for multiple) — Jac will not warn if you pass the wrong shape, the panel just won't open.

---

## The one Combobox exception (base-flavored)

`Combobox` is the lone base-ui port in jac-shadcn. Its API is **different from the rest** — not Radix-style. Read `components/ui/combobox.cl.jac` directly when using it. Key differences from Select:
- `<Combobox>` accepts an `items` prop (array of objects) — children are not the source of truth.
- The trigger structure is `<ComboboxTrigger>` containing `<ComboboxInput>` (the typeable input) plus optional `<ComboboxClear>`.
- The dropdown structure is `<ComboboxContent><ComboboxList><ComboboxGroup><ComboboxItem /></ComboboxGroup></ComboboxList></ComboboxContent>`.
- Multi-select is supported via `<ComboboxChips>` + `<ComboboxChipsInput>`.

Treat Combobox as a foreign component — don't pattern-match it against Select.

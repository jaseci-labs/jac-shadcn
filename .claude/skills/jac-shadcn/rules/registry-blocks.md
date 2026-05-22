# Registry blocks vs marketing blocks

The skill ships two distinct block sources. Don't confuse them.

## Registry blocks (`examples/`)

Direct conversions of the **official shadcn/ui v4 registry** at https://ui.shadcn.com/blocks. These are the canonical, battle-tested reference for app-shell and auth UI.

> **When converting new registry blocks, always pull from `bases/radix/blocks/`, not `bases/base/blocks/`.** jac-shadcn is a Radix port (32 of 33 components use `radix-ui` — only Combobox uses base-ui). The radix-flavored sources use the `asChild={true}` + child-element pattern that maps 1:1 onto jac-shadcn. Base-flavored sources use `render={<X />}` and require an extra translation step that's easy to get wrong on triggers nested two levels deep. See `rules/base-vs-radix.md`.

Currently shipped:

| File | Source | What it shows |
|---|---|---|
| `examples/login-01.cl.jac` | `bases/base/blocks/login-01` | Minimal Card + email/password + Google SSO |
| `examples/login-03.cl.jac` | `bases/base/blocks/login-03` | Welcome card with Apple/Google SSO above email/password, brand logo above card |
| `examples/signup-01.cl.jac` | `bases/base/blocks/signup-01` | Card with full name + email + password + confirm + Google SSO |
| `examples/sidebar-07.cl.jac` | `bases/base/blocks/sidebar-07` | Canonical app shell — team switcher, collapsible nav groups, project list w/ action menus, user dropdown |
| `examples/dashboard-01.cl.jac` | `bases/base/blocks/dashboard-01` | Inset-sidebar dashboard with section cards (chart + data-table stubbed; recharts/tanstack-table not yet ported to Jac) |

**When the request matches one of these patterns** ("build a sign-in page", "make a dashboard with a sidebar", etc.), **use the registry conversion as your starting point**. Do not freelance an alternative.

## Marketing blocks (`blocks/*.md`)

Patterns that are **not in the official shadcn registry** but are common on marketing/landing pages — heroes, pricing, features, footers, CTAs, FAQs, testimonials, navbars, empty states. These are documentation + code samples, not pre-rendered .cl.jac files. They live in `blocks/<name>.md`.

There's overlap between the marketing `auth.md` / `dashboard.md` docs and the registry blocks above. **Prefer the registry block.** The marketing docs document alternatives for cases where the registry doesn't fit (e.g., split-with-image auth, marketing-style minimal dashboard).

## ⚠ jac-shadcn `Sidebar*` className spread bug

This bites everyone who builds with the sidebar primitives:

```jac
def:pub SidebarMenuAction(props: Any) -> JsxElement {
    return <Comp
        className={cn("absolute top-1.5 right-1 ...", props.className)}
        {...props}    // <- spreads AFTER className; overwrites the cn() result
    />;
}
```

Real shadcn/ui destructures `className` out of `...props` first. jac-shadcn does not. **Result:** any `className` you pass to a `Sidebar*` component drops the entire base class string, including `absolute top-1.5 right-1` (positioning), `flex w-full min-w-0 flex-col` (layout), and the cva variant classes.

### Workaround until upstream is patched

**Don't pass `className` to any of these:**

- `Sidebar`, `SidebarProvider`, `SidebarInset`, `SidebarRail`, `SidebarTrigger`
- `SidebarHeader`, `SidebarFooter`, `SidebarContent`, `SidebarSeparator`
- `SidebarGroup`, `SidebarGroupLabel`, `SidebarGroupContent`, `SidebarGroupAction`
- `SidebarMenu`, `SidebarMenuItem`, `SidebarMenuButton`, `SidebarMenuAction`
- `SidebarMenuBadge`, `SidebarMenuSkeleton`, `SidebarMenuSub`, `SidebarMenuSubItem`, `SidebarMenuSubButton`

**If you need extra styling, do one of these instead:**

1. Wrap in a regular `<div className="...">`:
   ```jac
   <SidebarMenuItem>
       <div className="flex items-center gap-2 pl-2 pr-2 pb-2">
           <Button className="flex-1" size="sm">Quick Create</Button>
           <Button size="icon" variant="outline">{icon}</Button>
       </div>
   </SidebarMenuItem>
   ```

2. Use a regular `<Button>` instead of `<SidebarMenuButton>` when you need a cva variant (`variant="outline"`, `variant="destructive"`, custom styling) that the sidebar cva doesn't expose. The Sidebar primitives are for nav structure; `<Button>` is for arbitrary buttons.

3. Skip cosmetic overrides like `aria-expanded:bg-muted` on a trigger. Without them the layout still works; with them you lose the entire base class string.

### How to tell when you've hit it

The component renders without its base layout — for example:
- `SidebarMenuAction` flows in the layout instead of being absolute-positioned (action dots appear as their own row below the project name).
- `SidebarMenuButton` loses its `flex w-full h-8` sizing (button collapses to content width or expands oddly).
- `SidebarGroupContent` loses `text-sm w-full`.

If the rendered output looks "broken" but doesn't throw any errors, suspect this bug first.

## Real-shadcn patterns to remember

From converting `login-01`/`03`, `signup-01`, `sidebar-07`, `dashboard-01`:

- **`render={<X />}` (Radix v3) translates to `asChild={True}` + child** in jac-shadcn. Always pass `asChild={True}`, never conditionally — `asChild={isActive and True or None}` was an old "fix" that's actually wrong; the real pattern is unconditional `asChild={True}` paired with `isActive={...}` for the active state.
- **Real shadcn relies on `Card`, `Field`, `FieldGroup`, `FieldLabel`, `FieldDescription`, `FieldSeparator` for form structure** — never raw `<div className="space-y-2">`. The marketing `blocks/auth.md` follows this; so should you.
- **Verify HugeIcons names exist** — the package has explicit suffixes (`Linkedin01Icon`, not `LinkedinIcon`; `ArrowUpRight01Icon`, not `ArrowUpRightIcon`; `Shield01Icon`, not `ShieldIcon`; `CubeIcon` or `Package01Icon`, not `BoxIcon`). If unsure, check the icon list before importing.
- **No layout-fragile tricks like `lg:scale-105 lg:z-10`** to emphasize the popular pricing tier — overflows the grid cell and gets clipped. `border-primary + shadow-lg + ring-1 ring-primary` plus a "Most Popular" Badge is enough emphasis.

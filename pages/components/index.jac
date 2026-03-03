"""Components index — landing page showing all available components in a grid."""
cl import from "@jac/runtime" { Link }
cl import from "...components.site-footer" { SiteFooter }

cl {
    glob COMPONENT_LIST: list = [
        {"name": "accordion", "title": "Accordion"},
        {"name": "alert", "title": "Alert"},
        {"name": "alert-dialog", "title": "Alert Dialog"},
        {"name": "aspect-ratio", "title": "Aspect Ratio"},
        {"name": "avatar", "title": "Avatar"},
        {"name": "badge", "title": "Badge"},
        {"name": "breadcrumb", "title": "Breadcrumb"},
        {"name": "button", "title": "Button"},
        {"name": "button-group", "title": "Button Group"},
        {"name": "calendar", "title": "Calendar"},
        {"name": "card", "title": "Card"},
        {"name": "carousel", "title": "Carousel"},
        {"name": "chart", "title": "Chart"},
        {"name": "checkbox", "title": "Checkbox"},
        {"name": "collapsible", "title": "Collapsible"},
        {"name": "combobox", "title": "Combobox"},
        {"name": "command", "title": "Command"},
        {"name": "context-menu", "title": "Context Menu"},
        {"name": "dialog", "title": "Dialog"},
        {"name": "drawer", "title": "Drawer"},
        {"name": "dropdown-menu", "title": "Dropdown Menu"},
        {"name": "empty", "title": "Empty"},
        {"name": "field", "title": "Field"},
        {"name": "hover-card", "title": "Hover Card"},
        {"name": "input", "title": "Input"},
        {"name": "input-group", "title": "Input Group"},
        {"name": "input-otp", "title": "Input OTP"},
        {"name": "item", "title": "Item"},
        {"name": "kbd", "title": "Kbd"},
        {"name": "label", "title": "Label"},
        {"name": "menubar", "title": "Menubar"},
        {"name": "native-select", "title": "Native Select"},
        {"name": "navigation-menu", "title": "Navigation Menu"},
        {"name": "pagination", "title": "Pagination"},
        {"name": "popover", "title": "Popover"},
        {"name": "progress", "title": "Progress"},
        {"name": "radio-group", "title": "Radio Group"},
        {"name": "resizable", "title": "Resizable"},
        {"name": "scroll-area", "title": "Scroll Area"},
        {"name": "select", "title": "Select"},
        {"name": "separator", "title": "Separator"},
        {"name": "sheet", "title": "Sheet"},
        {"name": "sidebar", "title": "Sidebar"},
        {"name": "skeleton", "title": "Skeleton"},
        {"name": "slider", "title": "Slider"},
        {"name": "spinner", "title": "Spinner"},
        {"name": "switch", "title": "Switch"},
        {"name": "table", "title": "Table"},
        {"name": "tabs", "title": "Tabs"},
        {"name": "textarea", "title": "Textarea"},
        {"name": "toggle", "title": "Toggle"},
        {"name": "toggle-group", "title": "Toggle Group"},
        {"name": "tooltip", "title": "Tooltip"}
    ];

    def:pub page -> JsxElement {
        return <div className="flex-1 flex flex-col">
            <main className="flex-1">
                <div className="mx-auto max-w-5xl px-6 py-10 sm:px-8">
                    <div className="mb-10">
                        <h1 className="text-3xl font-bold tracking-tight sm:text-4xl">Components</h1>
                        <p className="mt-2 text-lg text-muted-foreground">
                            Beautifully crafted UI components built with Jac and Radix UI. Browse the library and click any component to explore it live.
                        </p>
                    </div>

                    <div className="grid grid-cols-2 gap-x-8 gap-y-3 sm:grid-cols-3 md:grid-cols-4">
                        {COMPONENT_LIST.map(lambda(comp: Any) -> Any {
                            return <Link
                                key={comp["name"]}
                                to={"/components/" + comp["name"]}
                                className="group rounded-md px-1 py-1.5 text-sm font-medium text-foreground underline-offset-4 decoration-muted-foreground/40 hover:underline transition-colors no-underline"
                            >
                                {comp["title"]}
                            </Link>;
                        })}
                    </div>
                </div>
            </main>
            <SiteFooter />
        </div>;
    }
}

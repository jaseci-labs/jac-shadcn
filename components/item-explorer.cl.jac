cl import from ..lib.utils { cn }
cl import from react { useState }

glob EXPLORER_ITEMS: list = [
    {"name": "home", "title": "Home", "group": "Blocks"},
    {"name": "alert-dialog", "title": "Alert Dialog", "group": "Components"},
    {"name": "avatar", "title": "Avatar", "group": "Components"},
    {"name": "badge", "title": "Badge", "group": "Components"},
    {"name": "button", "title": "Button", "group": "Components"},
    {"name": "card", "title": "Card", "group": "Components"},
    {"name": "checkbox", "title": "Checkbox", "group": "Components"},
    {"name": "combobox", "title": "Combobox", "group": "Components"},
    {"name": "dialog", "title": "Dialog", "group": "Components"},
    {"name": "dropdown-menu", "title": "Dropdown Menu", "group": "Components"},
    {"name": "field", "title": "Field", "group": "Components"},
    {"name": "input", "title": "Input", "group": "Components"},
    {"name": "input-group", "title": "Input Group", "group": "Components"},
    {"name": "label", "title": "Label", "group": "Components"},
    {"name": "progress", "title": "Progress", "group": "Components"},
    {"name": "radio-group", "title": "Radio Group", "group": "Components"},
    {"name": "select", "title": "Select", "group": "Components"},
    {"name": "separator", "title": "Separator", "group": "Components"},
    {"name": "switch", "title": "Switch", "group": "Components"},
    {"name": "tabs", "title": "Tabs", "group": "Components"},
    {"name": "textarea", "title": "Textarea", "group": "Components"},
    {"name": "tooltip", "title": "Tooltip", "group": "Components"},
    {"name": "accordion", "title": "Accordion", "group": "Components"},
    {"name": "alert", "title": "Alert", "group": "Components"},
    {"name": "aspect-ratio", "title": "Aspect Ratio", "group": "Components"},
    {"name": "breadcrumb", "title": "Breadcrumb", "group": "Components"},
    {"name": "collapsible", "title": "Collapsible", "group": "Components"},
    {"name": "context-menu", "title": "Context Menu", "group": "Components"},
    {"name": "drawer", "title": "Drawer", "group": "Components"},
    {"name": "hover-card", "title": "Hover Card", "group": "Components"},
    {"name": "menubar", "title": "Menubar", "group": "Components"},
    {"name": "navigation-menu", "title": "Navigation Menu", "group": "Components"},
    {"name": "pagination", "title": "Pagination", "group": "Components"},
    {"name": "popover", "title": "Popover", "group": "Components"},
    {"name": "resizable", "title": "Resizable", "group": "Components"},
    {"name": "scroll-area", "title": "Scroll Area", "group": "Components"},
    {"name": "sheet", "title": "Sheet", "group": "Components"},
    {"name": "skeleton", "title": "Skeleton", "group": "Components"},
    {"name": "slider", "title": "Slider", "group": "Components"},
    {"name": "sonner", "title": "Sonner", "group": "Components"},
    {"name": "spinner", "title": "Spinner", "group": "Components"},
    {"name": "table", "title": "Table", "group": "Components"},
    {"name": "toggle", "title": "Toggle", "group": "Components"},
    {"name": "toggle-group", "title": "Toggle Group", "group": "Components"}
];

glob _groups: list = ["Blocks", "Components"];

cl {
    def:pub ItemExplorer(props: Any) -> JsxElement {
        selectedItem = props.selectedItem or "home";
        onSelect = props.onSelectItem;

        return <aside
            data-slot="app-sidebar"
            className="sticky top-0 z-30 hidden h-screen w-44 shrink-0 flex-col overflow-y-auto border-r border-border/50 p-4 pt-5 xl:flex"
        >
            {_groups.map(lambda(group: Any) -> Any {
                groupItems = [];
                for item in EXPLORER_ITEMS {
                    if item["group"] == group {
                        groupItems.push(item);
                    }
                }
                return <ExplorerGroup
                    key={group}
                    title={group}
                    items={groupItems}
                    selectedItem={selectedItem}
                    onSelect={onSelect}
                />;
            })}
        </aside>;
    }

    def:pub ExplorerGroup(props: Any) -> JsxElement {
        return <div className="mb-3">
            <div className="flex items-center gap-1 pb-1.5 text-[0.8rem] font-medium">
                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-muted-foreground">
                    <polyline points="6 9 12 15 18 9"></polyline>
                </svg>
                <span>{props.title}</span>
            </div>
            <div className="relative ml-1.5 border-l border-border/50 pl-2">
                {props.items.map(lambda(item: Any, index: Any) -> Any {
                    isActive = item["name"] == props.selectedItem;
                    isLast = index == props.items.length - 1;
                    selectHandler = props.onSelect;
                    itemName = item["name"];
                    return <div key={item["name"]} className="relative">
                        <div className={cn(
                            "absolute top-1/2 -left-2 h-px w-2 border-t border-border/50",
                            isLast and "bg-[oklch(0.985_0_0)]"
                        )} />
                        {isLast and <div className="absolute top-1/2 -bottom-1 -left-[9px] w-1 bg-[oklch(0.985_0_0)]" />}
                        <button
                            onClick={lambda -> None { selectHandler.call(None, itemName); }}
                            className={cn(
                                "w-full cursor-pointer rounded-md px-2 py-1 text-left text-[0.8rem] font-normal transition-colors",
                                isActive and "bg-accent text-accent-foreground font-medium",
                                not isActive and "text-muted-foreground hover:bg-muted hover:text-foreground"
                            )}
                        >
                            {item["title"]}
                        </button>
                    </div>;
                })}
            </div>
        </div>;
    }
}

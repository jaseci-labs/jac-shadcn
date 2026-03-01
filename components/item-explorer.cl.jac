cl import from ..lib.utils { cn }
cl import from react { useState, useMemo }

glob EXPLORER_ITEMS: list = [
    {"name": "home", "title": "Home", "group": "Blocks"},
    {"name": "accordion", "title": "Accordion", "group": "Components"},
    {"name": "alert", "title": "Alert", "group": "Components"},
    {"name": "alert-dialog", "title": "Alert Dialog", "group": "Components"},
    {"name": "aspect-ratio", "title": "Aspect Ratio", "group": "Components"},
    {"name": "avatar", "title": "Avatar", "group": "Components"},
    {"name": "badge", "title": "Badge", "group": "Components"},
    {"name": "breadcrumb", "title": "Breadcrumb", "group": "Components"},
    {"name": "button", "title": "Button", "group": "Components"},
    {"name": "button-group", "title": "Button Group", "group": "Components"},
    {"name": "calendar", "title": "Calendar", "group": "Components"},
    {"name": "card", "title": "Card", "group": "Components"},
    {"name": "carousel", "title": "Carousel", "group": "Components"},
    {"name": "chart", "title": "Chart", "group": "Components"},
    {"name": "checkbox", "title": "Checkbox", "group": "Components"},
    {"name": "collapsible", "title": "Collapsible", "group": "Components"},
    {"name": "combobox", "title": "Combobox", "group": "Components"},
    {"name": "command", "title": "Command", "group": "Components"},
    {"name": "context-menu", "title": "Context Menu", "group": "Components"},
    {"name": "dialog", "title": "Dialog", "group": "Components"},
    {"name": "drawer", "title": "Drawer", "group": "Components"},
    {"name": "dropdown-menu", "title": "Dropdown Menu", "group": "Components"},
    {"name": "empty", "title": "Empty", "group": "Components"},
    {"name": "field", "title": "Field", "group": "Components"},
    {"name": "hover-card", "title": "Hover Card", "group": "Components"},
    {"name": "input", "title": "Input", "group": "Components"},
    {"name": "input-group", "title": "Input Group", "group": "Components"},
    {"name": "input-otp", "title": "Input OTP", "group": "Components"},
    {"name": "item", "title": "Item", "group": "Components"},
    {"name": "kbd", "title": "Kbd", "group": "Components"},
    {"name": "label", "title": "Label", "group": "Components"},
    {"name": "menubar", "title": "Menubar", "group": "Components"},
    {"name": "native-select", "title": "Native Select", "group": "Components"},
    {"name": "navigation-menu", "title": "Navigation Menu", "group": "Components"},
    {"name": "pagination", "title": "Pagination", "group": "Components"},
    {"name": "popover", "title": "Popover", "group": "Components"},
    {"name": "progress", "title": "Progress", "group": "Components"},
    {"name": "radio-group", "title": "Radio Group", "group": "Components"},
    {"name": "resizable", "title": "Resizable", "group": "Components"},
    {"name": "scroll-area", "title": "Scroll Area", "group": "Components"},
    {"name": "select", "title": "Select", "group": "Components"},
    {"name": "separator", "title": "Separator", "group": "Components"},
    {"name": "sheet", "title": "Sheet", "group": "Components"},
    {"name": "sidebar", "title": "Sidebar", "group": "Components"},
    {"name": "skeleton", "title": "Skeleton", "group": "Components"},
    {"name": "slider", "title": "Slider", "group": "Components"},
    {"name": "spinner", "title": "Spinner", "group": "Components"},
    {"name": "switch", "title": "Switch", "group": "Components"},
    {"name": "table", "title": "Table", "group": "Components"},
    {"name": "tabs", "title": "Tabs", "group": "Components"},
    {"name": "textarea", "title": "Textarea", "group": "Components"},
    {"name": "toggle", "title": "Toggle", "group": "Components"},
    {"name": "toggle-group", "title": "Toggle Group", "group": "Components"},
    {"name": "tooltip", "title": "Tooltip", "group": "Components"}
];

glob _groups: list = ["Blocks", "Components"];

cl {
    def:pub ItemExplorer(props: Any) -> JsxElement {
        selectedItem = props.selectedItem or "home";
        onSelect = props.onSelectItem;
        has searchQuery: str = "";

        filteredItems = useMemo(lambda -> Any {
            if not searchQuery or searchQuery.trim() == "" {
                return EXPLORER_ITEMS;
            }
            q = searchQuery.toLowerCase();
            result = [];
            for item in EXPLORER_ITEMS {
                if item["title"].toLowerCase().indexOf(q) >= 0 or item["name"].toLowerCase().indexOf(q) >= 0 {
                    result.push(item);
                }
            }
            return result;
        }, [searchQuery]);

        return <aside
            data-slot="app-sidebar"
            className="sticky top-0 z-30 hidden h-[calc(100vh-3.5rem)] w-48 shrink-0 flex-col border-r border-border/50 xl:flex"
        >
            <div className="p-3 pb-2">
                <div className="relative">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="absolute left-2.5 top-1/2 -translate-y-1/2 text-muted-foreground">
                        <circle cx="11" cy="11" r="8" />
                        <path d="m21 21-4.3-4.3" />
                    </svg>
                    <input
                        type="text"
                        placeholder="Search..."
                        value={searchQuery}
                        onChange={lambda(e: Any) -> None { searchQuery = e.target.value; }}
                        className="w-full rounded-md border border-border/50 bg-transparent px-2 py-1.5 pl-8 text-xs text-foreground placeholder:text-muted-foreground focus:border-ring focus:outline-none"
                    />
                </div>
            </div>

            <div className="relative flex-1 overflow-hidden">
                <div className="pointer-events-none absolute inset-x-0 top-0 z-10 h-4 bg-gradient-to-b from-[var(--background)] to-transparent" />
                <div className="pointer-events-none absolute inset-x-0 bottom-0 z-10 h-8 bg-gradient-to-t from-[var(--background)] to-transparent" />

                <div className="h-full overflow-y-auto no-scrollbar px-3 pt-1 pb-6">
                    {_groups.map(lambda(group: Any) -> Any {
                        groupItems = [];
                        for item in filteredItems {
                            if item["group"] == group {
                                groupItems.push(item);
                            }
                        }
                        if groupItems.length == 0 {
                            return None;
                        }
                        return <ExplorerGroup
                            key={group}
                            title={group}
                            items={groupItems}
                            selectedItem={selectedItem}
                            onSelect={onSelect}
                        />;
                    })}
                    {filteredItems.length == 0 and <div className="text-xs text-muted-foreground text-center py-4">No components found</div>}
                </div>
            </div>
        </aside>;
    }

    def:pub ExplorerGroup(props: Any) -> JsxElement {
        return <div className="mb-3">
            <div className="flex items-center gap-1 pb-1.5 text-[0.8rem] font-medium text-foreground">
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
                            "absolute top-1/2 -left-2 h-px w-2 border-t border-border/50"
                        )} />
                        <button
                            onClick={lambda -> None { selectHandler.call(None, itemName); }}
                            className={cn(
                                "w-full cursor-pointer rounded-md px-2 py-1 text-left text-[0.8rem] font-normal transition-colors bg-transparent border-none outline-none",
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

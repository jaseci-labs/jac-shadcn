cl import from ".component-example" { ComponentExample }
cl import from ".component-showcases" { ComponentShowcase }
cl import from ".home-page" { HomePage }
cl import from "..lib.design-system-provider" { useDesignSystem }
cl import from ..lib.utils { cn }

cl {
    def:pub PreviewPanel(props: Any) -> JsxElement {
        selectedItem = props.selectedItem or "home";
        onSelectItem = props.onSelectItem;
        ds = useDesignSystem();
        themeClassName = ds["themeClassName"] or "";

        return <main
            className={cn("flex-1 min-w-0 overflow-y-auto h-[calc(100vh-3.5rem)] bg-background text-foreground", themeClassName)}
        >
            {selectedItem == "home"
                and <HomePage onSelectItem={onSelectItem} />
                or <div className="mx-auto w-full max-w-6xl p-6 pt-4">
                    <ComponentShowcase name={selectedItem} />
                </div>}
        </main>;
    }
}

cl import from ".component-example" { ComponentExample }
cl import from ".component-showcases" { ComponentShowcase }
cl import from "..lib.design-system-provider" { useDesignSystem }
cl import from ..lib.utils { cn }

cl {
    def:pub PreviewPanel(props: Any) -> JsxElement {
        selectedItem = props.selectedItem or "home";
        ds = useDesignSystem();
        themeStyle = ds["themeStyle"] or {};
        themeClassName = ds["themeClassName"] or "";

        return <main
            className={cn("flex-1 min-w-0 overflow-y-auto h-screen bg-background text-foreground", themeClassName)}
            style={themeStyle}
        >
            <div className="mx-auto w-full max-w-6xl p-6 pt-4">
                {selectedItem == "home"
                    and <ComponentExample />
                    or <ComponentShowcase name={selectedItem} />}
            </div>
        </main>;
    }
}

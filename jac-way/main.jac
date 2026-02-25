"""Main entry point for jac-way."""

cl import from ".components.component-example" { ComponentExample }
cl import from ".components.customizer" { Customizer }
cl import from ".lib.design-system-provider" { DesignSystemProvider }
cl import ".global.css";

cl {
    def:pub app() -> JsxElement {
        return <DesignSystemProvider>
            <div className="flex min-h-screen">
                <Customizer />
                <div className="flex-1 min-w-0">
                    <ComponentExample />
                </div>
            </div>
        </DesignSystemProvider>;
    }
}

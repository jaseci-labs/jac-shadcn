"""Main entry point for jac-shadcn."""

import from lib.export_service { build_jacpack, build_jacpack_from_config, load_registry, resolve_single_component }
import from http { HTTPMethod }

cl import from ".components.item-explorer" { ItemExplorer }
cl import from ".components.preview-panel" { PreviewPanel }
cl import from ".components.customizer" { Customizer }
cl import from ".components.site-header" { SiteHeader }
cl import from ".components.site-footer" { SiteFooter }
cl import from ".lib.design-system-provider" { DesignSystemProvider }
cl import from ".components.ui.sheet" { Sheet, SheetContent, SheetHeader, SheetTitle, SheetDescription }
cl import ".global.css";

cl {
    def:pub app() -> JsxElement {
        has selectedItem: str = "home";
        has mobileNavOpen: bool = False;
        has mobileCustomizerOpen: bool = False;

        handleSelectItem = lambda(name: Any) -> None {
            selectedItem = name;
            mobileNavOpen = False;
        };

        return <DesignSystemProvider>
            <div className="flex min-h-screen flex-col">
                <SiteHeader
                    selectedItem={selectedItem}
                    onSelectItem={handleSelectItem}
                    onToggleNav={lambda -> None { mobileNavOpen = True; }}
                    onToggleCustomizer={lambda -> None { mobileCustomizerOpen = True; }}
                />
                <div className="flex flex-1">
                    <ItemExplorer
                        selectedItem={selectedItem}
                        onSelectItem={handleSelectItem}
                    />
                    <PreviewPanel
                        selectedItem={selectedItem}
                        onSelectItem={handleSelectItem}
                    />
                    <Customizer />
                </div>
                <SiteFooter />

                <Sheet open={mobileNavOpen} onOpenChange={lambda(v: Any) -> None { mobileNavOpen = v; }}>
                    <SheetContent side="left" className="w-64 p-0">
                        <SheetHeader className="sr-only">
                            <SheetTitle>Navigation</SheetTitle>
                            <SheetDescription>Browse components</SheetDescription>
                        </SheetHeader>
                        <ItemExplorer
                            mobile={True}
                            selectedItem={selectedItem}
                            onSelectItem={handleSelectItem}
                        />
                    </SheetContent>
                </Sheet>

                <Sheet open={mobileCustomizerOpen} onOpenChange={lambda(v: Any) -> None { mobileCustomizerOpen = v; }}>
                    <SheetContent side="right" className="w-64 p-0 overflow-y-auto">
                        <SheetHeader className="sr-only">
                            <SheetTitle>Customizer</SheetTitle>
                            <SheetDescription>Customize theme settings</SheetDescription>
                        </SheetHeader>
                        <Customizer mobile={True} />
                    </SheetContent>
                </Sheet>
            </div>
        </DesignSystemProvider>;
    }
}

walker:pub export_theme {
    has style: str = "nova";
    has baseColor: str = "neutral";
    has theme: str = "neutral";
    has font: str = "figtree";
    has radius: str = "default";
    has menuAccent: str = "subtle";
    has menuColor: str = "default";
    has cssVars: dict = {};

    can start with Root entry {
        shadcn_config: dict = {
            "style": self.style,
            "baseColor": self.baseColor,
            "theme": self.theme,
            "font": self.font,
            "radius": self.radius,
            "menuAccent": self.menuAccent,
            "menuColor": self.menuColor
        };
        jacpack = build_jacpack(shadcn_config, self.cssVars);
        report jacpack;
    }
}

"""GET /jacpack — returns themed jacpack JSON from query params.
Used for: jac create --use 'https://jac-shadcn.jaseci.org/jacpack?style=nova&theme=rose&font=inter' myapp
Note: jac-scale wraps in TransportResponse — extract .data.result for raw jacpack."""
@restspec(method=HTTPMethod.GET, path="/jacpack")
def:pub get_jacpack(
    style: str = "nova",
    baseColor: str = "neutral",
    theme: str = "neutral",
    font: str = "figtree",
    radius: str = "default",
    menuAccent: str = "subtle",
    menuColor: str = "default"
) -> dict {
    shadcn_config: dict = {
        "style": style,
        "baseColor": baseColor,
        "theme": theme,
        "font": font,
        "radius": radius,
        "menuAccent": menuAccent,
        "menuColor": menuColor
    };
    return build_jacpack_from_config(shadcn_config);
}

"""GET /registry — returns the component manifest (list of all components + metadata)."""
@restspec(method=HTTPMethod.GET, path="/registry")
def:pub get_registry() -> dict {
    return load_registry();
}

"""GET /component/{name} — returns a single resolved component.
Used by: jac add --shadcn button"""
@restspec(method=HTTPMethod.GET, path="/component/{name}")
def:pub get_component(name: str, style: str = "nova") -> dict {
    return resolve_single_component(name, style);
}

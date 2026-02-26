"""Main entry point for jac-way."""

import from lib.export_service { build_jacpack, build_jacpack_from_config, load_registry, resolve_single_component }
import from http { HTTPMethod }

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
        kit_config: dict = {
            "style": self.style,
            "baseColor": self.baseColor,
            "theme": self.theme,
            "font": self.font,
            "radius": self.radius,
            "menuAccent": self.menuAccent,
            "menuColor": self.menuColor
        };
        jacpack = build_jacpack(kit_config, self.cssVars);
        report jacpack;
    }
}

"""GET /jacpack — returns themed jacpack JSON from query params.
Used for: jac create myapp --use "https://kit.jaseci.org/jacpack?style=nova&theme=rose&font=inter"
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
    kit_config: dict = {
        "style": style,
        "baseColor": baseColor,
        "theme": theme,
        "font": font,
        "radius": radius,
        "menuAccent": menuAccent,
        "menuColor": menuColor
    };
    return build_jacpack_from_config(kit_config);
}

"""GET /registry — returns the component manifest (list of all components + metadata)."""
@restspec(method=HTTPMethod.GET, path="/registry")
def:pub get_registry() -> dict {
    return load_registry();
}

"""GET /component/{name} — returns a single resolved component.
Used by: jac add --kit button"""
@restspec(method=HTTPMethod.GET, path="/component/{name}")
def:pub get_component(name: str, style: str = "nova") -> dict {
    return resolve_single_component(name, style);
}

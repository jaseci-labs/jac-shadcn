"""Main entry point for jac-shadcn."""

import from lib.export_service { build_jacpack, build_jacpack_from_config, load_registry, resolve_single_component }
import from http { HTTPMethod }

cl import from ".lib.design-system-provider" { DesignSystemProvider }
cl import from react { useEffect }
cl import ".global.css";

cl {
    """App shell — wraps all pages with DesignSystemProvider and initializes dark mode."""
    def:pub app(children: Any = None) -> JsxElement {
        useEffect(lambda -> Any {
            document.documentElement.classList.add("dark");
            document.body.classList.add("dark");
            return;
        }, []);

        return <DesignSystemProvider>
            <div className="flex min-h-screen flex-col">
                {children}
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

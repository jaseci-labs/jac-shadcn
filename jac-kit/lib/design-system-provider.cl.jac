"""
DesignSystemProvider — dynamically applies theme CSS variables, style classes,
and font family based on a design system config.
Ported from shadcn/ui app/(create)/components/design-system-provider.tsx.
"""
cl import from react { createContext, useContext, useMemo, useLayoutEffect, useEffect }
cl import from .config { getDefaultConfig, getFontsData, buildRegistryTheme }

glob _DesignSystemContext: Any = createContext(None);

cl {
    def:pub DesignSystemProvider(props: Any) -> Any {
        has config: dict = props.initialConfig or getDefaultConfig();
        has isReady: bool = False;

        styleName = config["style"] or "nova";
        baseColorName = config["baseColor"] or "neutral";
        themeName = config["theme"] or "neutral";
        fontValue = config["font"] or "figtree";
        menuAccent = config["menuAccent"] or "subtle";
        menuColor = config["menuColor"] or "default";
        radiusName = config["radius"] or "default";

        registryTheme = useMemo(lambda -> Any {
            return buildRegistryTheme({
                "baseColor": baseColorName,
                "theme": themeName,
                "menuAccent": menuAccent,
                "radius": radiusName
            });
        }, [baseColorName, themeName, menuAccent, radiusName]);

        useLayoutEffect(lambda -> Any {
            body = document.body;

            body.classList.forEach(lambda(cls: Any) -> None {
                if String(cls).startsWith("style-") {
                    body.classList.remove(cls);
                }
            });
            body.classList.add("style-" + styleName);

            body.classList.forEach(lambda(cls: Any) -> None {
                if String(cls).startsWith("base-color-") {
                    body.classList.remove(cls);
                }
            });
            body.classList.add("base-color-" + baseColorName);

            isReady = True;
        }, [styleName, baseColorName]);

        useLayoutEffect(lambda -> Any {
            selectedFont = None;
            allFonts = getFontsData();
            for f in allFonts {
                if f["value"] == fontValue {
                    selectedFont = f;
                }
            }
            if selectedFont {
                fontFamily = selectedFont["family"];
                document.documentElement.style.setProperty("--font-sans", fontFamily);
                document.documentElement.style.fontFamily = fontFamily;
                document.body.style.fontFamily = fontFamily;
            }
        }, [fontValue]);

        useLayoutEffect(lambda -> Any {
            if not registryTheme or not registryTheme["cssVars"] {
                return;
            }

            root = document.documentElement;
            lightVars = registryTheme["cssVars"]["light"] or {};
            lightKeys = Object.keys(lightVars);
            for i in range(lightKeys.length) {
                k = lightKeys[i];
                v = lightVars[k];
                if v {
                    root.style.setProperty("--" + k, v);
                }
            }
        }, [registryTheme]);

        useEffect(lambda -> Any {
            if not menuColor {
                return;
            }

            menuElements = document.querySelectorAll(".cn-menu-target");
            menuElements.forEach(lambda(element: Any) -> None {
                if menuColor == "inverted" {
                    element.classList.add("dark");
                } else {
                    element.classList.remove("dark");
                }
            });

            observer = Reflect.construct(MutationObserver, [lambda -> None {
                newElements = document.querySelectorAll(".cn-menu-target");
                newElements.forEach(lambda(el: Any) -> None {
                    if menuColor == "inverted" {
                        el.classList.add("dark");
                    } else {
                        el.classList.remove("dark");
                    }
                });
            }]);

            observer.observe(document.body, {"childList": True, "subtree": True});

            return lambda -> None {
                observer.disconnect();
            };
        }, [menuColor]);

        contextValue = useMemo(lambda -> Any {
            return {"config": config, "setConfig": setConfig};
        }, [config]);

        if not isReady {
            return <></>;
        }

        return <_DesignSystemContext.Provider value={contextValue}>
            {props.children}
        </_DesignSystemContext.Provider>;
    }

    def:pub useDesignSystem() -> Any {
        return useContext(_DesignSystemContext);
    }
}

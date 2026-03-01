"""
DesignSystemProvider — manages design system config in React context.
Style/base-color classes are applied to body for component style variants.
CSS vars (colors, radius) and font are computed and passed via context
for the preview panel to apply as scoped inline styles.
"""
cl import from react { createContext, useContext, useMemo, useLayoutEffect, useEffect }
cl import from .config { getDefaultConfig, getFontsData, buildRegistryTheme }

glob _DesignSystemContext: Any = createContext(None);

cl {
    def:pub DesignSystemProvider(props: Any) -> Any {
        has config: dict = props.initialConfig or getDefaultConfig();

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

        themeClassName = "style-" + styleName + " base-color-" + baseColorName;

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

        themeStyle = useMemo(lambda -> Any {
            styleObj = {};
            selectedFont = None;
            allFonts = getFontsData();
            for f in allFonts {
                if f["value"] == fontValue {
                    selectedFont = f;
                }
            }
            if selectedFont {
                styleObj["--font-sans"] = selectedFont["family"];
                styleObj["fontFamily"] = selectedFont["family"];
            }
            return styleObj;
        }, [fontValue]);

        useLayoutEffect(lambda -> Any {
            styleEl = document.getElementById("ds-theme-vars");
            if not styleEl {
                styleEl = document.createElement("style");
                styleEl.id = "ds-theme-vars";
                document.head.appendChild(styleEl);
            }
            lightLines = [];
            darkLines = [];
            if registryTheme and registryTheme["cssVars"] {
                lightVars = registryTheme["cssVars"]["light"] or {};
                lightKeys = Object.keys(lightVars);
                for i in range(lightKeys.length) {
                    k = lightKeys[i];
                    v = lightVars[k];
                    if v {
                        lightLines.push("--" + k + ": " + v + ";");
                    }
                }
                darkVars = registryTheme["cssVars"]["dark"] or {};
                darkKeys = Object.keys(darkVars);
                for i in range(darkKeys.length) {
                    k = darkKeys[i];
                    v = darkVars[k];
                    if v {
                        darkLines.push("--" + k + ": " + v + ";");
                    }
                }
            }
            # Compute radius-derived vars for both modes
            if registryTheme and registryTheme["cssVars"] {
                rv = (registryTheme["cssVars"]["light"] or {})["radius"];
                if rv {
                    radiusLines = [
                        "--radius: " + rv + ";",
                        "--radius-sm: calc(" + rv + " - 4px);",
                        "--radius-md: calc(" + rv + " - 2px);",
                        "--radius-lg: " + rv + ";",
                        "--radius-xl: calc(" + rv + " + 4px);",
                        "--radius-2xl: calc(" + rv + " + 8px);",
                        "--radius-3xl: calc(" + rv + " + 12px);",
                        "--radius-4xl: calc(" + rv + " + 16px);"
                    ];
                    lightLines = lightLines.concat(radiusLines);
                    darkLines = darkLines.concat(radiusLines);
                }
            }
            # Font var
            fontStyle = themeStyle["--font-sans"];
            if fontStyle {
                lightLines.push("--font-sans: " + fontStyle + ";");
                darkLines.push("--font-sans: " + fontStyle + ";");
            }
            css = "body { " + lightLines.join(" ") + " } .dark body, body.dark { " + darkLines.join(" ") + " }";
            styleEl.textContent = css;
            return lambda -> None {
                existing = document.getElementById("ds-theme-vars");
                if existing {
                    existing.remove();
                }
            };
        }, [registryTheme, themeStyle]);

        useLayoutEffect(lambda -> Any {
            classes = themeClassName.split(" ");
            for i in range(classes.length) {
                if classes[i] {
                    document.body.classList.add(classes[i]);
                }
            }
            return lambda -> None {
                for i in range(classes.length) {
                    if classes[i] {
                        document.body.classList.remove(classes[i]);
                    }
                }
            };
        }, [themeClassName]);

        contextValue = useMemo(lambda -> Any {
            return {"config": config, "setConfig": setConfig, "themeStyle": {}, "themeClassName": themeClassName};
        }, [config, themeClassName]);

        return <_DesignSystemContext.Provider value={contextValue}>
            {props.children}
        </_DesignSystemContext.Provider>;
    }

    def:pub useDesignSystem() -> Any {
        return useContext(_DesignSystemContext);
    }
}

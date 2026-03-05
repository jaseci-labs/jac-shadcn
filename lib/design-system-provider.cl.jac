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

        # Default theme (orange) — static, never changes with customizer
        defaultRegistryTheme = useMemo(lambda -> Any {
            dc = getDefaultConfig();
            return buildRegistryTheme({
                "baseColor": dc["baseColor"] or "neutral",
                "theme": dc["theme"] or "neutral",
                "menuAccent": dc["menuAccent"] or "subtle",
                "radius": dc["radius"] or "default"
            });
        }, []);

        themeClassName = "style-" + styleName + " base-color-" + baseColorName;

        # Default body classes — pinned to default config so header/landing never change
        defaultThemeClassName = useMemo(lambda -> Any {
            dc = getDefaultConfig();
            return "style-" + (dc["style"] or "nova") + " base-color-" + (dc["baseColor"] or "neutral");
        }, []);

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

            # Helper: extract light/dark CSS lines from a registry theme + optional font
            extractLines = lambda(rt: Any, fontVar: Any) -> Any {
                light = [];
                dark = [];
                if rt and rt["cssVars"] {
                    lv = rt["cssVars"]["light"] or {};
                    lk = Object.keys(lv);
                    for i in range(lk.length) {
                        k = lk[i];
                        v = lv[k];
                        if v { light.push("--" + k + ": " + v + ";"); }
                    }
                    dv = rt["cssVars"]["dark"] or {};
                    dk = Object.keys(dv);
                    for i in range(dk.length) {
                        k = dk[i];
                        v = dv[k];
                        if v { dark.push("--" + k + ": " + v + ";"); }
                    }
                    rv = (rt["cssVars"]["light"] or {})["radius"];
                    if rv {
                        rl = [
                            "--radius: " + rv + ";",
                            "--radius-sm: calc(" + rv + " - 4px);",
                            "--radius-md: calc(" + rv + " - 2px);",
                            "--radius-lg: " + rv + ";",
                            "--radius-xl: calc(" + rv + " + 4px);",
                            "--radius-2xl: calc(" + rv + " + 8px);",
                            "--radius-3xl: calc(" + rv + " + 12px);",
                            "--radius-4xl: calc(" + rv + " + 16px);"
                        ];
                        light = light.concat(rl);
                        dark = dark.concat(rl);
                    }
                }
                if fontVar {
                    light.push("--font-sans: " + fontVar + ";");
                    dark.push("--font-sans: " + fontVar + ";");
                }
                return {"light": light, "dark": dark};
            };

            # Default theme font
            defaultFontFamily = None;
            dc = getDefaultConfig();
            allFonts = getFontsData();
            for f in allFonts {
                if f["value"] == (dc["font"] or "figtree") {
                    defaultFontFamily = f["family"];
                }
            }

            # Body: default theme (static orange)
            bodyVars = extractLines(defaultRegistryTheme, defaultFontFamily);
            # Preview: current customized theme
            previewVars = extractLines(registryTheme, themeStyle["--font-sans"]);

            css = "body { " + bodyVars["light"].join(" ") + " } .dark body, body.dark { " + bodyVars["dark"].join(" ") + " } .ds-preview { " + previewVars["light"].join(" ") + " } .dark .ds-preview { " + previewVars["dark"].join(" ") + " }";
            styleEl.textContent = css;
            return lambda -> None {
                existing = document.getElementById("ds-theme-vars");
                if existing {
                    existing.remove();
                }
            };
        }, [registryTheme, themeStyle, defaultRegistryTheme]);

        useLayoutEffect(lambda -> Any {
            # Apply default style classes to body (pinned, never changes with customizer)
            defClasses = defaultThemeClassName.split(" ");
            for i in range(defClasses.length) {
                if defClasses[i] {
                    document.body.classList.add(defClasses[i]);
                }
            }
            return lambda -> None {
                for i in range(defClasses.length) {
                    if defClasses[i] {
                        document.body.classList.remove(defClasses[i]);
                    }
                }
            };
        }, [defaultThemeClassName]);

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

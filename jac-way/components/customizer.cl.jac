"""Customizer panel — pickers for style, color, font, radius + random/reset."""
cl import from ..lib.utils { cn }
cl import from "..lib.design-system-provider" { useDesignSystem }
cl import from "..lib.config" { getStylesData, getDefaultConfig, getFontsData, getRadiiData, getMenuAccentsData, getMenuColorsData, getBaseColors, getThemesForBaseColor, getTheme }
cl import from .ui.button { Button, buttonVariants }
cl import from .ui.badge { Badge }
cl import from .ui.separator { Separator }
cl import from ".ui.dropdown-menu" { DropdownMenu, DropdownMenuTrigger, DropdownMenuContent, DropdownMenuRadioGroup, DropdownMenuRadioItem }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowDown01Icon }
cl import from react { useEffect }

cl {
    def:pub ColorCircle(props: Any) -> JsxElement {
        return <span
            className={cn("inline-block size-3 rounded-full border border-foreground/15 shrink-0", props.className)}
            style={{"backgroundColor": props.color}}
        />;
    }

    def:pub StylePicker() -> JsxElement {
        ds = useDesignSystem();
        config = ds["config"];
        styles = getStylesData();
        currentTitle = "";
        for s in styles {
            if s["name"] == config["style"] {
                currentTitle = s["title"];
            }
        }

        return <div className="flex flex-col gap-1">
            <div className="text-[11px] text-muted-foreground font-medium uppercase tracking-wider">Style</div>
            <DropdownMenu>
                <DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "outline", "size": "sm", "className": "w-full justify-between font-normal"})}>
                    {currentTitle}
                    <HugeiconsIcon icon={ArrowDown01Icon} strokeWidth={2} className="size-3 text-muted-foreground" />
                </DropdownMenuTrigger>
                <DropdownMenuContent align="start" className="w-64">
                    <DropdownMenuRadioGroup value={config["style"]} onValueChange={lambda(v: Any) -> None {
                        ds["setConfig"].call(None, Object.assign({}, config, {"style": v}));
                    }}>
                        {styles.map(lambda(style: Any) -> Any {
                            return <DropdownMenuRadioItem key={style["name"]} value={style["name"]}>
                                <div className="flex flex-col gap-0.5">
                                    <span className="font-medium text-sm">{style["title"]}</span>
                                    <span className="text-xs text-muted-foreground">{style["description"]}</span>
                                </div>
                            </DropdownMenuRadioItem>;
                        })}
                    </DropdownMenuRadioGroup>
                </DropdownMenuContent>
            </DropdownMenu>
        </div>;
    }

    def:pub BaseColorPicker() -> JsxElement {
        ds = useDesignSystem();
        config = ds["config"];
        baseColors = getBaseColors();
        currentColor = None;
        for bc in baseColors {
            if bc["name"] == config["baseColor"] {
                currentColor = bc;
            }
        }

        return <div className="flex flex-col gap-1">
            <div className="text-[11px] text-muted-foreground font-medium uppercase tracking-wider">Base Color</div>
            <DropdownMenu>
                <DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "outline", "size": "sm", "className": "w-full justify-between font-normal"})}>
                    <span className="flex items-center gap-2">
                        {currentColor and <ColorCircle color={currentColor["cssVars"]["light"]["primary"]} />}
                        {currentColor and currentColor["title"] or "Neutral"}
                    </span>
                    <HugeiconsIcon icon={ArrowDown01Icon} strokeWidth={2} className="size-3 text-muted-foreground" />
                </DropdownMenuTrigger>
                <DropdownMenuContent align="start">
                    <DropdownMenuRadioGroup value={config["baseColor"]} onValueChange={lambda(v: Any) -> None {
                        ds["setConfig"].call(None, Object.assign({}, config, {"baseColor": v, "theme": v}));
                    }}>
                        {baseColors.map(lambda(bc: Any) -> Any {
                            return <DropdownMenuRadioItem key={bc["name"]} value={bc["name"]}>
                                <span className="flex items-center gap-2">
                                    <ColorCircle color={bc["cssVars"]["light"]["primary"]} />
                                    {bc["title"]}
                                </span>
                            </DropdownMenuRadioItem>;
                        })}
                    </DropdownMenuRadioGroup>
                </DropdownMenuContent>
            </DropdownMenu>
        </div>;
    }

    def:pub ThemePicker() -> JsxElement {
        ds = useDesignSystem();
        config = ds["config"];
        themes = getThemesForBaseColor(config["baseColor"] or "neutral");
        currentTheme = getTheme(config["theme"] or "neutral");
        currentTitle = "Neutral";
        currentPrimary = None;
        if currentTheme {
            currentTitle = currentTheme["title"];
            currentPrimary = currentTheme["cssVars"]["light"]["primary"];
        }

        return <div className="flex flex-col gap-1">
            <div className="text-[11px] text-muted-foreground font-medium uppercase tracking-wider">Theme</div>
            <DropdownMenu>
                <DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "outline", "size": "sm", "className": "w-full justify-between font-normal"})}>
                    <span className="flex items-center gap-2">
                        {currentPrimary and <ColorCircle color={currentPrimary} />}
                        {currentTitle}
                    </span>
                    <HugeiconsIcon icon={ArrowDown01Icon} strokeWidth={2} className="size-3 text-muted-foreground" />
                </DropdownMenuTrigger>
                <DropdownMenuContent align="start" className="max-h-72 overflow-y-auto">
                    <DropdownMenuRadioGroup value={config["theme"]} onValueChange={lambda(v: Any) -> None {
                        ds["setConfig"].call(None, Object.assign({}, config, {"theme": v}));
                    }}>
                        {themes.map(lambda(theme: Any) -> Any {
                            return <DropdownMenuRadioItem key={theme["name"]} value={theme["name"]}>
                                <span className="flex items-center gap-2">
                                    <ColorCircle color={theme["cssVars"]["light"]["primary"]} />
                                    {theme["title"]}
                                </span>
                            </DropdownMenuRadioItem>;
                        })}
                    </DropdownMenuRadioGroup>
                </DropdownMenuContent>
            </DropdownMenu>
        </div>;
    }

    def:pub FontPicker() -> JsxElement {
        ds = useDesignSystem();
        config = ds["config"];
        fonts = getFontsData();
        currentName = "Figtree";
        for f in fonts {
            if f["value"] == config["font"] {
                currentName = f["name"];
            }
        }

        return <div className="flex flex-col gap-1">
            <div className="text-[11px] text-muted-foreground font-medium uppercase tracking-wider">Font</div>
            <DropdownMenu>
                <DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "outline", "size": "sm", "className": "w-full justify-between font-normal"})}>
                    {currentName}
                    <HugeiconsIcon icon={ArrowDown01Icon} strokeWidth={2} className="size-3 text-muted-foreground" />
                </DropdownMenuTrigger>
                <DropdownMenuContent align="start" className="max-h-80 overflow-y-auto">
                    <DropdownMenuRadioGroup value={config["font"]} onValueChange={lambda(v: Any) -> None {
                        ds["setConfig"].call(None, Object.assign({}, config, {"font": v}));
                    }}>
                        {fonts.map(lambda(font: Any) -> Any {
                            return <DropdownMenuRadioItem key={font["value"]} value={font["value"]}>
                                <div className="flex flex-col gap-0.5">
                                    <span className="text-sm">{font["name"]}</span>
                                    <span className="text-[10px] text-muted-foreground">{font["type"]}</span>
                                </div>
                            </DropdownMenuRadioItem>;
                        })}
                    </DropdownMenuRadioGroup>
                </DropdownMenuContent>
            </DropdownMenu>
        </div>;
    }

    def:pub RadiusPicker() -> JsxElement {
        ds = useDesignSystem();
        config = ds["config"];
        radii = getRadiiData();
        currentLabel = "Default";
        for r in radii {
            if r["name"] == config["radius"] {
                currentLabel = r["label"];
            }
        }

        return <div className="flex flex-col gap-1">
            <div className="text-[11px] text-muted-foreground font-medium uppercase tracking-wider">Radius</div>
            <DropdownMenu>
                <DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "outline", "size": "sm", "className": "w-full justify-between font-normal"})}>
                    {currentLabel}
                    <HugeiconsIcon icon={ArrowDown01Icon} strokeWidth={2} className="size-3 text-muted-foreground" />
                </DropdownMenuTrigger>
                <DropdownMenuContent align="start">
                    <DropdownMenuRadioGroup value={config["radius"]} onValueChange={lambda(v: Any) -> None {
                        ds["setConfig"].call(None, Object.assign({}, config, {"radius": v}));
                    }}>
                        {radii.map(lambda(r: Any) -> Any {
                            return <DropdownMenuRadioItem key={r["name"]} value={r["name"]}>
                                {r["label"]}
                            </DropdownMenuRadioItem>;
                        })}
                    </DropdownMenuRadioGroup>
                </DropdownMenuContent>
            </DropdownMenu>
        </div>;
    }

    def:pub MenuAccentPicker() -> JsxElement {
        ds = useDesignSystem();
        config = ds["config"];
        accents = getMenuAccentsData();
        currentLabel = "Subtle";
        for a in accents {
            if a["value"] == config["menuAccent"] {
                currentLabel = a["label"];
            }
        }

        return <div className="flex flex-col gap-1">
            <div className="text-[11px] text-muted-foreground font-medium uppercase tracking-wider">Menu Accent</div>
            <DropdownMenu>
                <DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "outline", "size": "sm", "className": "w-full justify-between font-normal"})}>
                    {currentLabel}
                    <HugeiconsIcon icon={ArrowDown01Icon} strokeWidth={2} className="size-3 text-muted-foreground" />
                </DropdownMenuTrigger>
                <DropdownMenuContent align="start">
                    <DropdownMenuRadioGroup value={config["menuAccent"]} onValueChange={lambda(v: Any) -> None {
                        ds["setConfig"].call(None, Object.assign({}, config, {"menuAccent": v}));
                    }}>
                        {accents.map(lambda(a: Any) -> Any {
                            return <DropdownMenuRadioItem key={a["value"]} value={a["value"]}>
                                {a["label"]}
                            </DropdownMenuRadioItem>;
                        })}
                    </DropdownMenuRadioGroup>
                </DropdownMenuContent>
            </DropdownMenu>
        </div>;
    }

    def:pub MenuColorPicker() -> JsxElement {
        ds = useDesignSystem();
        config = ds["config"];
        colors = getMenuColorsData();
        currentLabel = "Default";
        for c in colors {
            if c["value"] == config["menuColor"] {
                currentLabel = c["label"];
            }
        }

        return <div className="flex flex-col gap-1">
            <div className="text-[11px] text-muted-foreground font-medium uppercase tracking-wider">Menu Color</div>
            <DropdownMenu>
                <DropdownMenuTrigger className={buttonVariants().call(None, {"variant": "outline", "size": "sm", "className": "w-full justify-between font-normal"})}>
                    {currentLabel}
                    <HugeiconsIcon icon={ArrowDown01Icon} strokeWidth={2} className="size-3 text-muted-foreground" />
                </DropdownMenuTrigger>
                <DropdownMenuContent align="start">
                    <DropdownMenuRadioGroup value={config["menuColor"]} onValueChange={lambda(v: Any) -> None {
                        ds["setConfig"].call(None, Object.assign({}, config, {"menuColor": v}));
                    }}>
                        {colors.map(lambda(c: Any) -> Any {
                            return <DropdownMenuRadioItem key={c["value"]} value={c["value"]}>
                                {c["label"]}
                            </DropdownMenuRadioItem>;
                        })}
                    </DropdownMenuRadioGroup>
                </DropdownMenuContent>
            </DropdownMenu>
        </div>;
    }

    def:pub randomizeConfig() -> dict {
        styles = getStylesData();
        baseColors = getBaseColors();
        fonts = getFontsData();
        radii = getRadiiData();
        menuAccents = getMenuAccentsData();
        menuColors = getMenuColorsData();

        styleName = styles[Math.floor(Math.random() * styles.length)]["name"];
        baseColorName = baseColors[Math.floor(Math.random() * baseColors.length)]["name"];

        themes = getThemesForBaseColor(baseColorName);
        themeName = themes[Math.floor(Math.random() * themes.length)]["name"];

        availableFonts = fonts;
        availableRadii = radii;
        if styleName == "lyra" {
            filteredFonts = [];
            for f in fonts {
                if f["value"] == "jetbrains-mono" {
                    filteredFonts.push(f);
                }
            }
            if filteredFonts.length > 0 {
                availableFonts = filteredFonts;
            }
            filteredRadii = [];
            for r in radii {
                if r["name"] == "none" {
                    filteredRadii.push(r);
                }
            }
            if filteredRadii.length > 0 {
                availableRadii = filteredRadii;
            }
        }

        fontValue = availableFonts[Math.floor(Math.random() * availableFonts.length)]["value"];
        radiusName = availableRadii[Math.floor(Math.random() * availableRadii.length)]["name"];
        menuAccent = menuAccents[Math.floor(Math.random() * menuAccents.length)]["value"];
        menuColor = menuColors[Math.floor(Math.random() * menuColors.length)]["value"];

        return {
            "style": styleName,
            "baseColor": baseColorName,
            "theme": themeName,
            "font": fontValue,
            "radius": radiusName,
            "menuAccent": menuAccent,
            "menuColor": menuColor
        };
    }

    def:pub RandomButton() -> JsxElement {
        ds = useDesignSystem();

        useEffect(lambda -> Any {
            onKeyDown = lambda(e: Any) -> None {
                if (e.key == "r" or e.key == "R") and e.target.tagName != "INPUT" and e.target.tagName != "TEXTAREA" {
                    e.preventDefault();
                    newConfig = randomizeConfig();
                    ds["setConfig"].call(None, newConfig);
                }
            };
            document.addEventListener("keydown", onKeyDown);
            return lambda -> None {
                document.removeEventListener("keydown", onKeyDown);
            };
        }, []);

        return <Button variant="outline" size="sm" className="flex-1 gap-1.5" onClick={lambda -> None {
            newConfig = randomizeConfig();
            ds["setConfig"].call(None, newConfig);
        }}>
            Random
            <Badge variant="secondary" className="ml-auto px-1 py-0 text-[10px] font-mono leading-4">R</Badge>
        </Button>;
    }

    def:pub ResetButton() -> JsxElement {
        ds = useDesignSystem();

        return <Button variant="outline" size="sm" className="flex-1" onClick={lambda -> None {
            ds["setConfig"].call(None, getDefaultConfig());
        }}>
            Reset
        </Button>;
    }

    def:pub Customizer() -> JsxElement {
        return <aside className="w-56 shrink-0 border-r border-border/50 overflow-y-auto h-screen sticky top-0">
            <div className="flex flex-col gap-3 p-4">
                <div className="text-sm font-semibold tracking-tight">Customize</div>
                <StylePicker />
                <BaseColorPicker />
                <ThemePicker />
                <FontPicker />
                <RadiusPicker />
                <MenuAccentPicker />
                <MenuColorPicker />
                <Separator className="my-1" />
                <div className="flex gap-2">
                    <RandomButton />
                    <ResetButton />
                </div>
            </div>
        </aside>;
    }
}

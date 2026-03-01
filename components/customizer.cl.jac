"""Customizer panel — right sidebar with theme pickers, create project modal."""
cl import from ..lib.utils { cn }
cl import from "..lib.design-system-provider" { useDesignSystem }
cl import from "..lib.config" { getStylesData, getDefaultConfig, getFontsData, getRadiiData, getMenuAccentsData, getMenuColorsData, getBaseColors, getThemesForBaseColor, getTheme, buildRegistryTheme }
cl import from .ui.button { buttonVariants }
cl import from ".ui.dropdown-menu" { DropdownMenu, DropdownMenuTrigger, DropdownMenuContent, DropdownMenuRadioGroup, DropdownMenuRadioItem }
cl import from ".ui.alert-dialog" { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { Copy01Icon, Tick01Icon, DownloadIcon, Undo02Icon }
cl import from react { useEffect }

glob _triggerClass: str = "relative w-full rounded-lg bg-transparent border-none p-2 hover:bg-muted data-[state=open]:bg-muted text-left select-none cursor-default outline-none";

cl {
    def:pub ColorCircle(props: Any) -> JsxElement {
        return <span
            className={cn("inline-block size-4 rounded-full border border-foreground/15 shrink-0", props.className)}
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

        return <DropdownMenu>
            <DropdownMenuTrigger className={_triggerClass}>
                <div className="flex flex-col justify-start text-left">
                    <div className="text-muted-foreground text-xs">Style</div>
                    <div className="text-foreground text-sm font-medium">{currentTitle}</div>
                </div>
            </DropdownMenuTrigger>
            <DropdownMenuContent side="left" align="start" className="w-64">
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
        </DropdownMenu>;
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

        return <DropdownMenu>
            <DropdownMenuTrigger className={_triggerClass}>
                <div className="flex flex-col justify-start text-left">
                    <div className="text-muted-foreground text-xs">Base Color</div>
                    <div className="text-foreground text-sm font-medium">{currentColor and currentColor["title"] or "Neutral"}</div>
                </div>
                {currentColor and <div
                    className="pointer-events-none absolute top-1/2 right-3 size-4 -translate-y-1/2 rounded-full border border-foreground/15 select-none"
                    style={{"backgroundColor": currentColor["cssVars"]["light"]["primary"]}}
                />}
            </DropdownMenuTrigger>
            <DropdownMenuContent side="left" align="start">
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
        </DropdownMenu>;
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

        return <DropdownMenu>
            <DropdownMenuTrigger className={_triggerClass}>
                <div className="flex flex-col justify-start text-left">
                    <div className="text-muted-foreground text-xs">Theme</div>
                    <div className="text-foreground text-sm font-medium">{currentTitle}</div>
                </div>
                {currentPrimary and <div
                    className="pointer-events-none absolute top-1/2 right-3 size-4 -translate-y-1/2 rounded-full border border-foreground/15 select-none"
                    style={{"backgroundColor": currentPrimary}}
                />}
            </DropdownMenuTrigger>
            <DropdownMenuContent side="left" align="start" className="max-h-80">
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
        </DropdownMenu>;
    }

    def:pub FontPicker() -> JsxElement {
        ds = useDesignSystem();
        config = ds["config"];
        fonts = getFontsData();
        currentName = "Figtree";
        currentFamily = "";
        for f in fonts {
            if f["value"] == config["font"] {
                currentName = f["name"];
                currentFamily = f["family"] or "";
            }
        }

        return <DropdownMenu>
            <DropdownMenuTrigger className={_triggerClass}>
                <div className="flex flex-col justify-start text-left">
                    <div className="text-muted-foreground text-xs">Font</div>
                    <div className="text-foreground text-sm font-medium">{currentName}</div>
                </div>
                <div
                    className="text-foreground pointer-events-none absolute top-1/2 right-3 flex size-4 -translate-y-1/2 items-center justify-center text-base select-none"
                    style={{"fontFamily": currentFamily}}
                >
                    Aa
                </div>
            </DropdownMenuTrigger>
            <DropdownMenuContent side="left" align="start" className="w-64 max-h-96">
                <DropdownMenuRadioGroup value={config["font"]} onValueChange={lambda(v: Any) -> None {
                    ds["setConfig"].call(None, Object.assign({}, config, {"font": v}));
                }}>
                    {fonts.map(lambda(font: Any) -> Any {
                        return <DropdownMenuRadioItem key={font["value"]} value={font["value"]}>
                            <div className="flex flex-col gap-0.5">
                                <span className="text-muted-foreground text-xs font-medium">{font["name"]}</span>
                                <span className="text-sm" style={{"fontFamily": font["family"]}}>{font["name"]}</span>
                            </div>
                        </DropdownMenuRadioItem>;
                    })}
                </DropdownMenuRadioGroup>
            </DropdownMenuContent>
        </DropdownMenu>;
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

        return <DropdownMenu>
            <DropdownMenuTrigger className={_triggerClass}>
                <div className="flex flex-col justify-start text-left">
                    <div className="text-muted-foreground text-xs">Radius</div>
                    <div className="text-foreground text-sm font-medium">{currentLabel}</div>
                </div>
                <div className="text-foreground pointer-events-none absolute top-1/2 right-3 flex size-4 -translate-y-1/2 rotate-90 items-center justify-center select-none">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" className="text-foreground">
                        <path fill="none" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 20v-5C4 8.925 8.925 4 15 4h5" />
                    </svg>
                </div>
            </DropdownMenuTrigger>
            <DropdownMenuContent side="left" align="start">
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
        </DropdownMenu>;
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

        return <DropdownMenu>
            <DropdownMenuTrigger className={_triggerClass}>
                <div className="flex flex-col justify-start text-left">
                    <div className="text-muted-foreground text-xs">Menu Accent</div>
                    <div className="text-foreground text-sm font-medium">{currentLabel}</div>
                </div>
            </DropdownMenuTrigger>
            <DropdownMenuContent side="left" align="start">
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
        </DropdownMenu>;
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

        return <DropdownMenu>
            <DropdownMenuTrigger className={_triggerClass}>
                <div className="flex flex-col justify-start text-left">
                    <div className="text-muted-foreground text-xs">Menu Color</div>
                    <div className="text-foreground text-sm font-medium">{currentLabel}</div>
                </div>
            </DropdownMenuTrigger>
            <DropdownMenuContent side="left" align="start">
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
        </DropdownMenu>;
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

    def:pub CreateProjectModal() -> JsxElement {
        ds = useDesignSystem();
        has copied: bool = False;
        has isDownloading: bool = False;

        handleCopy = lambda -> None {
            config = ds["config"];
            params = Reflect.construct(URLSearchParams, [{}]);
            params.set("style", config["style"] or "nova");
            params.set("baseColor", config["baseColor"] or "neutral");
            params.set("theme", config["theme"] or "neutral");
            params.set("font", config["font"] or "figtree");
            params.set("radius", config["radius"] or "default");
            params.set("menuAccent", config["menuAccent"] or "subtle");
            params.set("menuColor", config["menuColor"] or "default");

            origin = window.location.origin;
            url = origin + "/jacpack?" + params.toString();
            cmd = "jac create --use '" + url + "' myapp";

            navigator.clipboard.writeText(cmd).then(lambda -> None {
                copied = True;
                setTimeout(lambda -> None { copied = False; }, 2000);
            });
        };

        handleDownload = lambda -> None {
            config = ds["config"];
            registryTheme = buildRegistryTheme({
                "baseColor": config["baseColor"] or "neutral",
                "theme": config["theme"] or "neutral",
                "menuAccent": config["menuAccent"] or "subtle",
                "radius": config["radius"] or "default"
            });
            if not registryTheme { return; }
            isDownloading = True;
            body = JSON.stringify({
                "style": config["style"] or "nova",
                "baseColor": config["baseColor"] or "neutral",
                "theme": config["theme"] or "neutral",
                "font": config["font"] or "figtree",
                "radius": config["radius"] or "default",
                "menuAccent": config["menuAccent"] or "subtle",
                "menuColor": config["menuColor"] or "default",
                "cssVars": registryTheme["cssVars"]
            });
            fetch("/walker/export_theme", {
                "method": "POST",
                "headers": {"Content-Type": "application/json"},
                "body": body
            })
            .then(lambda(res: Any) -> Any { return res.json(); })
            .then(lambda(data: Any) -> None {
                jacpack = data;
                if data["reports"] {
                    jacpack = data["reports"][0];
                } elif data["data"] and data["data"]["reports"] {
                    jacpack = data["data"]["reports"][0];
                }
                blob = Reflect.construct(Blob, [[JSON.stringify(jacpack, None, 2)], {"type": "application/json"}]);
                url = URL.createObjectURL(blob);
                a = document.createElement("a");
                a.href = url;
                a.download = "themed-project.jacpack";
                a.click();
                URL.revokeObjectURL(url);
                isDownloading = False;
            })
            .catch(lambda(err: Any) -> None {
                console.error("Export failed:", err);
                isDownloading = False;
            });
        };

        return <AlertDialog>
            <AlertDialogTrigger className={buttonVariants().call(None, {"size": "sm", "className": "w-full"})}>
                Create Project
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle>Create Project</AlertDialogTitle>
                    <AlertDialogDescription>
                        Download a themed .jacpack file or copy the CLI command to create a new project with your customizations.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <div className="flex flex-col gap-3 py-2">
                    <button
                        onClick={handleDownload}
                        disabled={isDownloading}
                        className="flex items-center gap-3 rounded-lg border border-border p-3 text-left transition-colors hover:bg-muted cursor-pointer disabled:opacity-50"
                    >
                        <div className="flex size-9 items-center justify-center rounded-md bg-muted">
                            <HugeiconsIcon icon={DownloadIcon} strokeWidth={2} className="size-4" />
                        </div>
                        <div className="flex-1">
                            <div className="text-sm font-medium">{isDownloading and "Exporting..." or "Download .jacpack"}</div>
                            <div className="text-xs text-muted-foreground">Save the themed project template as a file</div>
                        </div>
                    </button>
                    <button
                        onClick={handleCopy}
                        className="flex items-center gap-3 rounded-lg border border-border p-3 text-left transition-colors hover:bg-muted cursor-pointer"
                    >
                        <div className="flex size-9 items-center justify-center rounded-md bg-muted">
                            {copied
                                and <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-4 text-green-500" />
                                or <HugeiconsIcon icon={Copy01Icon} strokeWidth={2} className="size-4" />}
                        </div>
                        <div className="flex-1">
                            <div className="text-sm font-medium">{copied and "Copied!" or "Copy CLI Command"}</div>
                            <div className="text-xs text-muted-foreground">jac create --use ... myapp</div>
                        </div>
                    </button>
                </div>
                <AlertDialogFooter>
                    <AlertDialogCancel>Close</AlertDialogCancel>
                </AlertDialogFooter>
            </AlertDialogContent>
        </AlertDialog>;
    }

    def:pub Customizer() -> JsxElement {
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

        return <aside
            data-slot="app-sidebar"
            className="sticky top-0 z-30 hidden pl-2 h-[calc(100vh-3.5rem)] w-52 shrink-0 flex-col border-l border-border/50 xl:flex"
        >
            <div className="flex flex-1 flex-col overflow-y-auto no-scrollbar gap-y-6">
                <div className="p-3 pb-1">
                    <CreateProjectModal />
                </div>
                <div className="flex flex-1 flex-col gap-y-2">
                    <StylePicker />
                    <BaseColorPicker />
                    <ThemePicker />
                    <FontPicker />
                    <RadiusPicker />
                    <MenuAccentPicker />
                    <MenuColorPicker />
                </div>
                <div className="mt-auto flex flex-col px-1 pb-2">
                    <button
                        className="relative w-full rounded-lg bg-transparent border-none p-2 hover:bg-muted text-left select-none cursor-pointer outline-none"
                        onClick={lambda -> None {
                            newConfig = randomizeConfig();
                            ds["setConfig"].call(None, newConfig);
                        }}
                    >
                        <div className="flex flex-col justify-start text-left">
                            <div className="text-muted-foreground text-xs">Shuffle</div>
                            <div className="text-foreground text-sm font-medium">Try Random</div>
                        </div>
                        <span className="pointer-events-none absolute top-1/2 right-3 -translate-y-1/2 bg-foreground/10 text-foreground text-[10px] font-mono px-1.5 py-0.5 rounded select-none">R</span>
                    </button>
                    <AlertDialog>
                        <AlertDialogTrigger className="relative w-full rounded-lg bg-transparent border-none p-2 hover:bg-muted text-left select-none cursor-pointer outline-none">
                            <div className="flex flex-col justify-start text-left">
                                <div className="text-muted-foreground text-xs">Reset</div>
                                <div className="text-foreground text-sm font-medium">Start Over</div>
                            </div>
                            <HugeiconsIcon icon={Undo02Icon} strokeWidth={2} className="absolute top-1/2 right-3 -translate-y-1/2 size-4 text-foreground" />
                        </AlertDialogTrigger>
                        <AlertDialogContent>
                            <AlertDialogHeader>
                                <AlertDialogTitle>Reset to defaults?</AlertDialogTitle>
                                <AlertDialogDescription>
                                    This will reset all customization options to their default values.
                                </AlertDialogDescription>
                            </AlertDialogHeader>
                            <AlertDialogFooter>
                                <AlertDialogCancel>Cancel</AlertDialogCancel>
                                <AlertDialogAction onClick={lambda -> None {
                                    ds["setConfig"].call(None, getDefaultConfig());
                                }}>Reset</AlertDialogAction>
                            </AlertDialogFooter>
                        </AlertDialogContent>
                    </AlertDialog>
                </div>
            </div>
        </aside>;
    }
}

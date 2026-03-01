"""Site header — sticky navbar with Jaseci branding, nav links, dark/light toggle."""
cl import from ..lib.utils { cn }
cl import from ".ui.button" { Button, buttonVariants }
cl import from ".ui.tooltip" { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger }
cl import from "..lib.design-system-provider" { useDesignSystem }
cl import from react { useEffect }

cl {
    def:pub SiteHeader(props: Any) -> JsxElement {
        has isDark: bool = False;
        selectedItem = props.selectedItem or "home";
        onSelectItem = props.onSelectItem;
        onToggleNav = props.onToggleNav;
        onToggleCustomizer = props.onToggleCustomizer;

        useEffect(lambda -> Any {
            isDark = document.documentElement.classList.contains("dark");
            return;
        }, []);

        toggleDark = lambda -> None {
            if isDark {
                document.documentElement.classList.remove("dark");
                document.body.classList.remove("dark");
                isDark = False;
            } else {
                document.documentElement.classList.add("dark");
                document.body.classList.add("dark");
                isDark = True;
            }
        };

        useEffect(lambda -> Any {
            onKeyDown = lambda(e: Any) -> None {
                if (e.key == "d" or e.key == "D") and e.target.tagName != "INPUT" and e.target.tagName != "TEXTAREA" and not e.metaKey and not e.ctrlKey {
                    e.preventDefault();
                    toggleDark();
                }
            };
            document.addEventListener("keydown", onKeyDown);
            return lambda -> None {
                document.removeEventListener("keydown", onKeyDown);
            };
        }, [isDark]);

        return <header className="sticky top-0 z-50 w-full border-b border-border/50 bg-background/80 backdrop-blur-lg supports-[backdrop-filter]:bg-background/60">
            <div className="flex h-14 items-center px-4 lg:px-6">
                <button
                    onClick={lambda -> None { onToggleNav and onToggleNav.call(None); }}
                    className="mr-2 inline-flex items-center justify-center rounded-md p-1.5 text-muted-foreground hover:text-foreground hover:bg-muted transition-colors cursor-pointer bg-transparent border-none outline-none xl:hidden"
                    aria-label="Toggle navigation"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <line x1="4" x2="20" y1="12" y2="12" />
                        <line x1="4" x2="20" y1="6" y2="6" />
                        <line x1="4" x2="20" y1="18" y2="18" />
                    </svg>
                </button>
                <div className="flex items-center gap-2 mr-6">
                    <button
                        onClick={lambda -> None { onSelectItem and onSelectItem.call(None, "home"); }}
                        className="flex items-center gap-2.5 cursor-pointer bg-transparent border-none outline-none"
                    >
                        <img src="static/logo.png" alt="Jaseci" className="size-7" />
                        <span className="text-foreground font-semibold text-base tracking-tight hidden sm:inline-block">jac-shadcn</span>
                    </button>
                </div>

                <nav className="hidden md:flex items-center gap-1 text-sm">
                    <button
                        onClick={lambda -> None { onSelectItem and onSelectItem.call(None, "home"); }}
                        className={cn(
                            "px-3 py-1.5 rounded-md text-sm font-medium transition-colors bg-transparent border-none cursor-pointer outline-none",
                            selectedItem == "home" and "text-foreground" or "text-muted-foreground hover:text-foreground"
                        )}
                    >
                        Home
                    </button>
                    <button
                        onClick={lambda -> None { onSelectItem and onSelectItem.call(None, "button"); }}
                        className={cn(
                            "px-3 py-1.5 rounded-md text-sm font-medium transition-colors bg-transparent border-none cursor-pointer outline-none",
                            selectedItem != "home" and "text-foreground" or "text-muted-foreground hover:text-foreground"
                        )}
                    >
                        Components
                    </button>
                    <a
                        href="https://docs.jaseci.org"
                        target="_blank"
                        rel="noopener noreferrer"
                        className="px-3 py-1.5 rounded-md text-sm font-medium text-muted-foreground hover:text-foreground transition-colors no-underline"
                    >
                        Docs
                    </a>
                </nav>

                <div className="ml-auto flex items-center gap-1.5">
                    <button
                        onClick={lambda -> None { onToggleCustomizer and onToggleCustomizer.call(None); }}
                        className="inline-flex items-center justify-center rounded-md p-1.5 text-muted-foreground hover:text-foreground hover:bg-muted transition-colors cursor-pointer bg-transparent border-none outline-none xl:hidden"
                        aria-label="Toggle customizer"
                    >
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <circle cx="13.5" cy="6.5" r="2.5" />
                            <path d="M17 6.5H22" />
                            <path d="M2 6.5h8.5" />
                            <circle cx="8.5" cy="12.5" r="2.5" />
                            <path d="M2 12.5h3.5" />
                            <path d="M12 12.5h10" />
                            <circle cx="15.5" cy="18.5" r="2.5" />
                            <path d="M19 18.5h3" />
                            <path d="M2 18.5h11" />
                        </svg>
                    </button>
                    <TooltipProvider delayDuration={0}>
                        <Tooltip>
                            <TooltipTrigger className={buttonVariants().call(None, {"variant": "ghost", "size": "icon", "className": "size-8"})}>
                                <a
                                    href="https://github.com/Jaseci-Labs/jaseci"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="flex items-center justify-center text-foreground"
                                >
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                                        <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z" />
                                    </svg>
                                </a>
                            </TooltipTrigger>
                            <TooltipContent>GitHub</TooltipContent>
                        </Tooltip>
                    </TooltipProvider>

                    <TooltipProvider delayDuration={0}>
                        <Tooltip>
                            <TooltipTrigger
                                className={buttonVariants().call(None, {"variant": "ghost", "size": "icon", "className": "size-8"})}
                                onClick={toggleDark}
                            >
                                {isDark
                                    and <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                        <circle cx="12" cy="12" r="4" />
                                        <path d="M12 2v2" />
                                        <path d="M12 20v2" />
                                        <path d="m4.93 4.93 1.41 1.41" />
                                        <path d="m17.66 17.66 1.41 1.41" />
                                        <path d="M2 12h2" />
                                        <path d="M20 12h2" />
                                        <path d="m6.34 17.66-1.41 1.41" />
                                        <path d="m19.07 4.93-1.41 1.41" />
                                    </svg>
                                    or <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                        <path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z" />
                                    </svg>}
                            </TooltipTrigger>
                            <TooltipContent>{isDark and "Light mode (D)" or "Dark mode (D)"}</TooltipContent>
                        </Tooltip>
                    </TooltipProvider>
                </div>
            </div>
        </header>;
    }
}

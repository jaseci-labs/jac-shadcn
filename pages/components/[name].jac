"""Component browser — sidebar navigation + component showcase + customizer."""
cl import from "@jac/runtime" { useParams, useNavigate }
cl import from "...components.item-explorer" { ItemExplorer }
cl import from ...components.showcases.router { ComponentShowcase }
cl import from ...components.customizer { Customizer }
cl import from "...lib.design-system-provider" { useDesignSystem }
cl import from ...lib.utils { cn }
cl import from "...components.ui.button" { Button }
cl import from "...components.ui.sheet" { Sheet, SheetContent, SheetHeader, SheetTitle, SheetDescription }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { SettingsIcon }

cl {
    def:pub page -> JsxElement {
        params = useParams();
        navigate = useNavigate();
        componentName = params.name or "button";
        has mobileNavOpen: bool = False;
        has mobileCustomizerOpen: bool = False;
        ds = useDesignSystem();
        themeClassName = ds["themeClassName"] or "";

        handleSelectItem = lambda(name: Any) -> None {
            navigate("/components/" + name);
            mobileNavOpen = False;
        };

        return <div className="flex flex-1 h-[calc(100vh-3.5rem)]">
            <ItemExplorer
                selectedItem={componentName}
                onSelectItem={handleSelectItem}
            />
            <main
                className={cn("flex-1 min-w-0 overflow-y-auto bg-background text-foreground", themeClassName)}
            >
                <div className="sticky top-0 z-20 flex items-center gap-2 border-b border-border/50 bg-background/80 backdrop-blur-sm px-4 py-2.5 xl:hidden">
                    <button
                        onClick={lambda -> None { mobileNavOpen = True; }}
                        className="inline-flex items-center justify-center rounded-md p-1.5 text-muted-foreground hover:text-foreground hover:bg-muted transition-colors cursor-pointer bg-transparent border-none outline-none"
                        aria-label="Open sidebar"
                    >
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <line x1="4" x2="20" y1="12" y2="12" />
                            <line x1="4" x2="20" y1="6" y2="6" />
                            <line x1="4" x2="20" y1="18" y2="18" />
                        </svg>
                    </button>
                    <span className="text-sm font-medium text-foreground">Components</span>
                </div>

                <div className="mx-auto w-full max-w-6xl p-6 pt-4">
                    <ComponentShowcase name={componentName} />
                </div>
            </main>

            <Customizer title={componentName} />

            <Sheet open={mobileNavOpen} onOpenChange={lambda(v: Any) -> None { mobileNavOpen = v; }}>
                <SheetContent side="left" className="w-64 p-0">
                    <SheetHeader className="sr-only">
                        <SheetTitle>Components</SheetTitle>
                        <SheetDescription>Browse all components</SheetDescription>
                    </SheetHeader>
                    <ItemExplorer
                        mobile={True}
                        selectedItem={componentName}
                        onSelectItem={handleSelectItem}
                    />
                </SheetContent>
            </Sheet>

            <div className="fixed bottom-6 right-6 lg:hidden z-40">
                <Button
                    size="lg"
                    className="rounded-full shadow-lg size-14"
                    onClick={lambda -> None { mobileCustomizerOpen = True; }}
                >
                    <HugeiconsIcon icon={SettingsIcon} strokeWidth={2} className="size-5" />
                </Button>
            </div>

            <Sheet open={mobileCustomizerOpen} onOpenChange={lambda(v: Any) -> None { mobileCustomizerOpen = v; }}>
                <SheetContent side="right" className="w-72 p-0 overflow-y-auto">
                    <SheetHeader className="sr-only">
                        <SheetTitle>Theme Settings</SheetTitle>
                        <SheetDescription>Customize component styles</SheetDescription>
                    </SheetHeader>
                    <Customizer mobile={True} title={componentName} />
                </SheetContent>
            </Sheet>
        </div>;
    }
}

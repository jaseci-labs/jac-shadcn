"""Create Project page — theme customizer + live preview of generated project."""
cl import from ..components.customizer { Customizer }
cl import from "..components.project-preview" { ProjectPreview }
cl import from "..lib.design-system-provider" { useDesignSystem }
cl import from ..lib.utils { cn }
cl import from ..components.ui.button { Button }
cl import from "..components.ui.sheet" { Sheet, SheetContent, SheetHeader, SheetTitle, SheetDescription }
cl import from "..components.site-footer" { SiteFooter }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { SettingsIcon }

cl {
    def:pub page -> JsxElement {
        has mobileCustomizerOpen: bool = False;
        ds = useDesignSystem();
        themeClassName = ds["themeClassName"] or "";

        return <div className="flex flex-1">
            <main className="flex-1 min-w-0 overflow-y-auto no-scrollbar h-[calc(100vh-4.5rem)]">
                <div className="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
                    <div className="mb-8 max-w-2xl">
                        <h1 className="text-2xl font-bold tracking-tight sm:text-3xl">Create Your Project</h1>
                        <p className="mt-2 text-muted-foreground">
                            Customize your design system using the panel on the right, then download a themed starter project. The preview below updates in real-time.
                        </p>
                    </div>

                    <div className={cn("rounded-xl border border-border/60 overflow-hidden bg-background shadow-sm ds-preview", themeClassName)}>
                        <div className="flex items-center gap-1.5 border-b border-border/50 bg-muted/30 px-4 py-2.5">
                            <div className="flex items-center gap-1.5">
                                <span className="size-3 rounded-full bg-red-400/60" />
                                <span className="size-3 rounded-full bg-yellow-400/60" />
                                <span className="size-3 rounded-full bg-green-400/60" />
                            </div>
                            <div className="ml-3 flex-1">
                                <div className="mx-auto max-w-xs rounded-md bg-background/60 border border-border/40 px-3 py-1 text-xs text-muted-foreground text-center font-mono">
                                    localhost:8000
                                </div>
                            </div>
                        </div>
                        <div className="p-0">
                            <ProjectPreview />
                        </div>
                    </div>
                </div>
                <SiteFooter />
            </main>

            <Customizer title="Your Project" />

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
                        <SheetDescription>Customize your theme</SheetDescription>
                    </SheetHeader>
                    <Customizer mobile={True} />
                </SheetContent>
            </Sheet>
        </div>;
    }
}

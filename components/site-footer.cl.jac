"""Site footer — simple footer with Jaseci branding and links."""
cl import from ..lib.utils { cn }

cl {
    def:pub SiteFooter() -> JsxElement {
        return <footer className="border-t border-border/50 bg-background">
            <div className="flex flex-col items-center justify-between gap-4 px-6 py-6 md:flex-row">
                <div className="flex items-center gap-2 text-sm text-muted-foreground">
                    <img src="static/logo.png" alt="Jaseci" className="size-4 opacity-60" />
                    <span>{"Built with Jac by "}
                        <a
                            href="https://jaseci.org"
                            target="_blank"
                            rel="noopener noreferrer"
                            className="font-medium text-foreground underline underline-offset-4 hover:no-underline"
                        >
                            Jaseci Labs
                        </a>
                    </span>
                </div>
                <div className="flex items-center gap-4 text-sm text-muted-foreground">
                    <a
                        href="https://docs.jaseci.org"
                        target="_blank"
                        rel="noopener noreferrer"
                        className="hover:text-foreground transition-colors no-underline text-muted-foreground"
                    >
                        Docs
                    </a>
                    <a
                        href="https://github.com/Jaseci-Labs/jaseci"
                        target="_blank"
                        rel="noopener noreferrer"
                        className="hover:text-foreground transition-colors no-underline text-muted-foreground"
                    >
                        GitHub
                    </a>
                    <a
                        href="https://jaseci.org"
                        target="_blank"
                        rel="noopener noreferrer"
                        className="hover:text-foreground transition-colors no-underline text-muted-foreground"
                    >
                        Jaseci
                    </a>
                </div>
            </div>
        </footer>;
    }
}

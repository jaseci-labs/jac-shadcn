"""Landing page — hero section + component masonry grid."""
cl import from "..components.home-page" { HomePage }
cl import from "..components.site-footer" { SiteFooter }

cl {
    def:pub page -> JsxElement {
        return <div className="flex-1 flex flex-col">
            <HomePage />
            <SiteFooter />
        </div>;
    }
}

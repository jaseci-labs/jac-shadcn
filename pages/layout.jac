"""Shared layout — SiteHeader on all pages, Outlet renders matched page."""
cl import from "@jac/runtime" { Outlet }
cl import from "..components.site-header" { SiteHeader }

cl {
    def:pub layout -> JsxElement {
        return <>
            <SiteHeader />
            <Outlet />
        </>;
    }
}

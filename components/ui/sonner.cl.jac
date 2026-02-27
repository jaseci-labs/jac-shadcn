cl import from "sonner" { Toaster as SonnerToaster }

glob _toasterStyle: Any = {
    "--normal-bg": "var(--popover)",
    "--normal-text": "var(--popover-foreground)",
    "--normal-border": "var(--border)",
    "--border-radius": "var(--radius)"
};

glob _toastOptions: Any = {
    "classNames": {
        "toast": "cn-toast"
    }
};

cl {
    def:pub Toaster(props: Any) -> JsxElement {
        theme = props.theme or "system";
        return <SonnerToaster
            theme={theme}
            className="toaster group"
            style={_toasterStyle}
            toastOptions={_toastOptions}
        />;
    }
}

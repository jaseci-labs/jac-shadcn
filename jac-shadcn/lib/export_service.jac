"""Export service — builds themed jacpack files for download.
Parses style CSS, resolves cn-* tokens in components, generates global.css,
and assembles the complete jacpack JSON.
Also provides server-side theme resolution from config params (for GET endpoint)."""

import os;
import re;
import json as json_mod;

glob BASE_COLOR_NAMES: list = ["neutral", "stone", "zinc", "gray"];

glob RADII_MAP: dict = {
    "none": "0",
    "small": "0.45rem",
    "medium": "0.625rem",
    "large": "0.875rem"
};

"""Load themes data from data/themes.json at module init."""
def _load_themes_data() -> list {
    themes_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "data", "themes.json");
    if os.path.isfile(themes_path) {
        with open(themes_path, "r") as f {
            return json_mod.load(f);
        }
    }
    return [];
}

glob _THEMES_DATA: list = _load_themes_data();

"""Find a theme by name from the loaded themes data."""
def _find_theme(name: str) -> Any {
    for theme in _THEMES_DATA {
        if theme["name"] == name {
            return theme;
        }
    }
    return None;
}

"""Resolve CSS variables from kit config params (server-side equivalent of buildRegistryTheme).
Returns dict with 'light' and 'dark' keys containing CSS variable mappings."""
def resolve_css_vars(kit_config: dict) -> dict {
    base_color_name = kit_config.get("baseColor", "neutral");
    theme_name = kit_config.get("theme", "neutral");

    base_color = _find_theme(base_color_name);
    theme = _find_theme(theme_name);

    if not base_color or not theme {
        return {"light": {}, "dark": {}};
    }

    base_css = base_color.get("cssVars", {});
    theme_css = theme.get("cssVars", {});

    light_vars: dict = {};
    light_vars.update(base_css.get("light", {}));
    light_vars.update(theme_css.get("light", {}));

    dark_vars: dict = {};
    dark_vars.update(base_css.get("dark", {}));
    dark_vars.update(theme_css.get("dark", {}));

    menu_accent = kit_config.get("menuAccent", "subtle");
    if menu_accent == "bold" {
        if light_vars.get("primary") {
            light_vars["accent"] = light_vars["primary"];
            light_vars["accent-foreground"] = light_vars.get("primary-foreground", "");
            light_vars["sidebar-accent"] = light_vars["primary"];
            light_vars["sidebar-accent-foreground"] = light_vars.get("primary-foreground", "");
        }
        if dark_vars.get("primary") {
            dark_vars["accent"] = dark_vars["primary"];
            dark_vars["accent-foreground"] = dark_vars.get("primary-foreground", "");
            dark_vars["sidebar-accent"] = dark_vars["primary"];
            dark_vars["sidebar-accent-foreground"] = dark_vars.get("primary-foreground", "");
        }
    }

    radius_name = kit_config.get("radius", "default");
    if radius_name and radius_name != "default" {
        radius_value = RADII_MAP.get(radius_name);
        if radius_value {
            light_vars["radius"] = radius_value;
        }
    }

    return {"light": light_vars, "dark": dark_vars};
}

"""Build jacpack from just config params (no pre-computed CSS vars needed).
Used by the GET endpoint for URL-based jac create."""
def build_jacpack_from_config(kit_config: dict) -> dict {
    css_vars = resolve_css_vars(kit_config);
    return build_jacpack(kit_config, css_vars);
}

"""Load the component registry manifest."""
def load_registry() -> dict {
    registry_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "data", "registry.json");
    if os.path.isfile(registry_path) {
        with open(registry_path, "r") as f {
            return json_mod.load(f);
        }
    }
    return {"version": "1.0.0", "components": {}, "sharedDeps": {}};
}

"""Resolve a single component with its style applied.
Returns dict with name, content, npmDeps, peerComponents."""
def resolve_single_component(component_name: str, style: str) -> dict {
    registry = load_registry();
    components = registry.get("components", {});

    comp_meta = components.get(component_name);
    if not comp_meta {
        return {"error": "Component not found: " + component_name};
    }

    filename = comp_meta["file"];
    filepath = os.path.join("components", "ui", filename);

    if not os.path.isfile(filepath) {
        return {"error": "Component file not found: " + filename};
    }

    resolution_map = parse_style_css(style);

    with open(filepath, "r") as f {
        source = f.read();
    }

    resolved = resolve_component(source, resolution_map);

    return {
        "name": component_name,
        "file": filename,
        "content": resolved,
        "npmDeps": comp_meta.get("npmDeps", []),
        "peerComponents": comp_meta.get("peerComponents", [])
    };
}

glob FONT_DATA: dict = {
    "geist": {"family": "'Geist Variable', sans-serif", "npm": "@fontsource-variable/geist", "type": "sans"},
    "inter": {"family": "'Inter Variable', sans-serif", "npm": "@fontsource-variable/inter", "type": "sans"},
    "noto-sans": {"family": "'Noto Sans Variable', sans-serif", "npm": "@fontsource-variable/noto-sans", "type": "sans"},
    "nunito-sans": {"family": "'Nunito Sans Variable', sans-serif", "npm": "@fontsource-variable/nunito-sans", "type": "sans"},
    "figtree": {"family": "'Figtree Variable', sans-serif", "npm": "@fontsource-variable/figtree", "type": "sans"},
    "roboto": {"family": "'Roboto Variable', sans-serif", "npm": "@fontsource-variable/roboto", "type": "sans"},
    "raleway": {"family": "'Raleway Variable', sans-serif", "npm": "@fontsource-variable/raleway", "type": "sans"},
    "dm-sans": {"family": "'DM Sans Variable', sans-serif", "npm": "@fontsource-variable/dm-sans", "type": "sans"},
    "public-sans": {"family": "'Public Sans Variable', sans-serif", "npm": "@fontsource-variable/public-sans", "type": "sans"},
    "outfit": {"family": "'Outfit Variable', sans-serif", "npm": "@fontsource-variable/outfit", "type": "sans"},
    "jetbrains-mono": {"family": "'JetBrains Mono Variable', monospace", "npm": "@fontsource-variable/jetbrains-mono", "type": "mono"},
    "geist-mono": {"family": "'Geist Mono Variable', monospace", "npm": "@fontsource-variable/geist-mono", "type": "mono"}
};

glob COMPONENT_FILES: list = [
    "button.cl.jac",
    "card.cl.jac",
    "badge.cl.jac",
    "input.cl.jac",
    "textarea.cl.jac",
    "label.cl.jac",
    "separator.cl.jac",
    "field.cl.jac",
    "input-group.cl.jac",
    "select.cl.jac",
    "combobox.cl.jac",
    "dropdown-menu.cl.jac",
    "alert-dialog.cl.jac"
];

glob THEME_INLINE_COLORS: list = [
    "sidebar-ring", "sidebar-border", "sidebar-accent-foreground",
    "sidebar-accent", "sidebar-primary-foreground", "sidebar-primary",
    "sidebar-foreground", "sidebar", "chart-5", "chart-4", "chart-3",
    "chart-2", "chart-1", "ring", "input", "border", "destructive",
    "accent-foreground", "accent", "muted-foreground", "muted",
    "secondary-foreground", "secondary", "primary-foreground", "primary",
    "popover-foreground", "popover", "card-foreground", "card",
    "foreground", "background"
];

glob _CN_PATTERN: Any = re.compile(r'\.(cn-[\w-]+)\s*\{\s*@apply\s+([^;]+);');


"""Parse a style CSS file and extract all .cn-* to @apply class mappings.
Returns dict mapping cn-class-name to tailwind-classes string."""
def parse_style_css(style_name: str) -> dict {
    style_path = os.path.join("styles", "style-" + style_name + ".css");

    if not os.path.isfile(style_path) {
        return {};
    }

    with open(style_path, "r") as f {
        content = f.read();
    }

    resolution_map: dict = {};
    matches = _CN_PATTERN.findall(content);

    for match in matches {
        cn_class = match[0];
        tailwind_classes = match[1].strip();
        resolution_map[cn_class] = tailwind_classes;
    }

    return resolution_map;
}


"""Replace all cn-* tokens in component source with resolved Tailwind classes.
Keys are sorted longest-first to avoid partial matches."""
def resolve_component(source: str, resolution_map: dict) -> str {
    sorted_keys = sorted(list(resolution_map.keys()), key=len, reverse=True);

    result = source;
    for key in sorted_keys {
        result = result.replace(key, resolution_map[key]);
    }

    return result;
}


"""Generate themed global.css content from font selection and resolved CSS variables."""
def generate_global_css(font_value: str, css_vars: dict) -> str {
    font_info = FONT_DATA.get(font_value, FONT_DATA["figtree"]);
    font_family = font_info["family"];
    font_npm = font_info["npm"];

    light_vars = css_vars.get("light", {});
    dark_vars = css_vars.get("dark", {});

    lines: list = [];
    lines.append('@import "tailwindcss";');
    lines.append('@import "tw-animate-css";');
    lines.append('@import "shadcn/tailwind.css";');
    lines.append('@import "' + font_npm + '";');
    lines.append("");
    lines.append("@custom-variant dark (&:is(.dark *));");
    lines.append("");

    lines.append(":root {");
    for k in light_vars {
        v = light_vars[k];
        lines.append("    --" + str(k) + ": " + str(v) + ";");
    }
    lines.append("}");
    lines.append("");

    lines.append(".dark {");
    for k in dark_vars {
        v = dark_vars[k];
        lines.append("    --" + str(k) + ": " + str(v) + ";");
    }
    lines.append("}");
    lines.append("");

    lines.append("@theme inline {");
    lines.append("    --font-sans: " + font_family + ";");
    for color_name in THEME_INLINE_COLORS {
        lines.append("    --color-" + color_name + ": var(--" + color_name + ");");
    }
    lines.append("    --radius-sm: calc(var(--radius) - 4px);");
    lines.append("    --radius-md: calc(var(--radius) - 2px);");
    lines.append("    --radius-lg: var(--radius);");
    lines.append("    --radius-xl: calc(var(--radius) + 4px);");
    lines.append("    --radius-2xl: calc(var(--radius) + 8px);");
    lines.append("    --radius-3xl: calc(var(--radius) + 12px);");
    lines.append("    --radius-4xl: calc(var(--radius) + 16px);");
    lines.append("}");
    lines.append("");

    lines.append("@layer base {");
    lines.append("    * {");
    lines.append("        @apply border-border outline-ring/50;");
    lines.append("    }");
    lines.append("    body {");
    lines.append("        @apply font-sans bg-background text-foreground;");
    lines.append("    }");
    lines.append("    html {");
    lines.append("        @apply font-sans;");
    lines.append("    }");
    lines.append("}");

    return "\n".join(lines);
}


"""Generate a starter main.jac for the exported project."""
def generate_main_jac() -> str {
    lines: list = [];
    lines.append('cl import from ".components.ui.button" { Button }');
    lines.append('cl import from ".components.ui.card" { Card, CardContent, CardHeader, CardTitle, CardDescription }');
    lines.append('cl import from ".components.ui.badge" { Badge }');
    lines.append('cl import from ".components.ui.input" { Input }');
    lines.append('cl import from ".components.ui.label" { Label }');
    lines.append('cl import ".global.css";');
    lines.append("");
    lines.append("cl {");
    lines.append("    def:pub app() -> JsxElement {");
    lines.append('        return <div className="min-h-screen bg-background text-foreground p-8">');
    lines.append('            <div className="max-w-2xl mx-auto space-y-8">');
    lines.append("                <Card>");
    lines.append("                    <CardHeader>");
    lines.append('                        <CardTitle>{"Welcome to Your Themed App"}</CardTitle>');
    lines.append('                        <CardDescription>{"Built with jac-way theme customizer."}</CardDescription>');
    lines.append("                    </CardHeader>");
    lines.append('                    <CardContent className="space-y-4">');
    lines.append('                        <div className="flex gap-2">');
    lines.append('                            <Button>{"Primary"}</Button>');
    lines.append('                            <Button variant="outline">{"Outline"}</Button>');
    lines.append('                            <Button variant="secondary">{"Secondary"}</Button>');
    lines.append("                        </div>");
    lines.append('                        <div className="flex gap-2">');
    lines.append('                            <Badge>{"Default"}</Badge>');
    lines.append('                            <Badge variant="secondary">{"Secondary"}</Badge>');
    lines.append('                            <Badge variant="outline">{"Outline"}</Badge>');
    lines.append("                        </div>");
    lines.append('                        <div className="grid gap-2">');
    lines.append('                            <Label htmlFor="email">{"Email"}</Label>');
    lines.append('                            <Input id="email" type="email" placeholder="Enter your email" />');
    lines.append("                        </div>");
    lines.append("                    </CardContent>");
    lines.append("                </Card>");
    lines.append("            </div>");
    lines.append("        </div>;");
    lines.append("    }");
    lines.append("}");

    return "\n".join(lines);
}


"""Build jac.toml config dict for the exported project.
Includes [kit] section with all 7 customization fields."""
def build_jac_toml_config(font_npm: str, kit_config: dict) -> dict {
    npm_deps: dict = {
        "jac-client-node": "1.0.4",
        "class-variance-authority": "^0.7.1",
        "clsx": "^2.1.1",
        "tailwind-merge": "^3.5.0",
        "tw-animate-css": "^1.4.0",
        "radix-ui": "^1.4.3",
        "@base-ui/react": "^1.2.0",
        "@hugeicons/core-free-icons": "^3.1.1",
        "@hugeicons/react": "^1.1.5",
        "shadcn": "^3.8.5"
    };
    npm_deps[font_npm] = "*";
    npm_deps["dev"] = {
        "@jac-client/dev-deps": "1.0.0",
        "@tailwindcss/vite": "latest",
        "tailwindcss": "latest"
    };

    return {
        "project": {
            "name": "themed-project",
            "version": "1.0.0",
            "description": "Jac client application with custom theme",
            "entry-point": "main.jac"
        },
        "dependencies": {
            "npm": npm_deps
        },
        "serve": {"base_route_app": "app"},
        "plugins": {
            "client": {
                "vite": {
                    "plugins": ["tailwindcss()"],
                    "lib_imports": ["import tailwindcss from '@tailwindcss/vite'"]
                },
                "configs": {
                    "tailwind": {
                        "content": ["./src/**/*.{jac,tsx,jsx}"]
                    }
                }
            }
        },
        "kit": {
            "style": kit_config.get("style", "nova"),
            "baseColor": kit_config.get("baseColor", "neutral"),
            "theme": kit_config.get("theme", "neutral"),
            "font": kit_config.get("font", "figtree"),
            "radius": kit_config.get("radius", "default"),
            "menuAccent": kit_config.get("menuAccent", "subtle"),
            "menuColor": kit_config.get("menuColor", "default"),
            "registry": "https://kit.jaseci.org"
        },
        "jacpack": {
            "name": "jac-way-themed-project",
            "description": "Themed jac-client project"
        }
    };
}


"""Build the complete jacpack dict ready for download.
kit_config: dict with all 7 fields (style, baseColor, theme, font, radius, menuAccent, menuColor)
css_vars: resolved CSS variables dict with 'light' and 'dark' keys"""
def build_jacpack(kit_config: dict, css_vars: dict) -> dict {
    style = kit_config.get("style", "nova");
    font = kit_config.get("font", "figtree");

    resolution_map = parse_style_css(style);

    files: dict = {};
    components_dir = os.path.join("components", "ui");

    for filename in COMPONENT_FILES {
        filepath = os.path.join(components_dir, filename);
        if os.path.isfile(filepath) {
            with open(filepath, "r") as f {
                source = f.read();
            }
            resolved = resolve_component(source, resolution_map);
            files["components/ui/" + filename] = resolved;
        }
    }

    utils_path = os.path.join("lib", "utils.cl.jac");
    if os.path.isfile(utils_path) {
        with open(utils_path, "r") as f {
            files["lib/utils.cl.jac"] = f.read();
        }
    }

    files["global.css"] = generate_global_css(font, css_vars);
    files["main.jac"] = generate_main_jac();

    font_info = FONT_DATA.get(font, FONT_DATA["figtree"]);
    config = build_jac_toml_config(font_info["npm"], kit_config);

    return {
        "name": "jac-way-themed-project",
        "description": "Themed jac-client project generated by jac-way",
        "config": config,
        "files": files,
        "directories": [
            "lib",
            "components",
            "components/ui"
        ],
        "root_gitignore_entries": [
            "packages/", "*.jbc", "*.jir", "__pycache__/",
            "*.py[cod]", ".venv/", "venv/", ".idea/",
            ".vscode/", "*.swp", "node_modules/", ".jac/",
            "*.session", "*.session.*"
        ]
    };
}

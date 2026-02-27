"""
Design system configuration — radii, menu options, base color filtering,
default config, presets, and helper functions.
Ported from shadcn/ui registry/config.ts.
"""
cl import from .themes { getThemes }
cl import from .styles { getStyles }
cl import from .fonts { getFonts }

glob THEMES: list = getThemes();
glob STYLES: list = getStyles();
glob FONTS: list = getFonts();
glob BASE_COLOR_NAMES: list = ["neutral", "stone", "zinc", "gray"];

glob RADII: list = [
    {"name": "default", "label": "Default", "value": ""},
    {"name": "none", "label": "None", "value": "0"},
    {"name": "small", "label": "Small", "value": "0.45rem"},
    {"name": "medium", "label": "Medium", "value": "0.625rem"},
    {"name": "large", "label": "Large", "value": "0.875rem"}
];

glob MENU_ACCENTS: list = [
    {"value": "subtle", "label": "Subtle"},
    {"value": "bold", "label": "Bold"}
];

glob MENU_COLORS: list = [
    {"value": "default", "label": "Default"},
    {"value": "inverted", "label": "Inverted"}
];

glob DEFAULT_CONFIG: dict = {
    "style": "nova",
    "baseColor": "neutral",
    "theme": "neutral",
    "font": "figtree",
    "menuAccent": "subtle",
    "menuColor": "default",
    "radius": "default"
};

glob PRESETS: list = [
    {
        "name": "vega-default",
        "title": "Vega",
        "description": "Vega / Hugeicons / Inter",
        "style": "vega",
        "baseColor": "neutral",
        "theme": "neutral",
        "font": "inter",
        "menuAccent": "subtle",
        "menuColor": "default",
        "radius": "default"
    },
    {
        "name": "nova-default",
        "title": "Nova",
        "description": "Nova / Hugeicons / Geist",
        "style": "nova",
        "baseColor": "neutral",
        "theme": "neutral",
        "font": "geist",
        "menuAccent": "subtle",
        "menuColor": "default",
        "radius": "default"
    },
    {
        "name": "maia-default",
        "title": "Maia",
        "description": "Maia / Hugeicons / Figtree",
        "style": "maia",
        "baseColor": "neutral",
        "theme": "neutral",
        "font": "figtree",
        "menuAccent": "subtle",
        "menuColor": "default",
        "radius": "default"
    },
    {
        "name": "lyra-default",
        "title": "Lyra",
        "description": "Lyra / Hugeicons / JetBrains Mono",
        "style": "lyra",
        "baseColor": "neutral",
        "theme": "neutral",
        "font": "jetbrains-mono",
        "menuAccent": "subtle",
        "menuColor": "default",
        "radius": "default"
    },
    {
        "name": "mira-default",
        "title": "Mira",
        "description": "Mira / Hugeicons / Inter",
        "style": "mira",
        "baseColor": "neutral",
        "theme": "neutral",
        "font": "inter",
        "menuAccent": "subtle",
        "menuColor": "default",
        "radius": "default"
    }
];

"""Returns the 4 base color themes (neutral, stone, zinc, gray)."""
def:pub getBaseColors() -> list {
    result: list = [];
    for theme in THEMES {
        if BASE_COLOR_NAMES.includes(theme["name"]) {
            result.push(theme);
        }
    }
    return result;
}

"""Returns themes available for a given base color.
Includes the matching base color itself + all non-base accent themes."""
def:pub getThemesForBaseColor(base_color_name: str) -> list {
    result: list = [];
    for theme in THEMES {
        if theme["name"] == base_color_name {
            result.push(theme);
        } elif not BASE_COLOR_NAMES.includes(theme["name"]) {
            result.push(theme);
        }
    }
    return result;
}

"""Find a theme by name. Returns None if not found."""
def:pub getTheme(name: str) -> Any {
    for theme in THEMES {
        if theme["name"] == name {
            return theme;
        }
    }
    return None;
}

"""Find a base color by name. Returns None if not found."""
def:pub getBaseColor(name: str) -> Any {
    for theme in THEMES {
        if theme["name"] == name and BASE_COLOR_NAMES.includes(name) {
            return theme;
        }
    }
    return None;
}

"""Find a style by name. Returns None if not found."""
def:pub getStyle(name: str) -> Any {
    for style in STYLES {
        if style["name"] == name {
            return style;
        }
    }
    return None;
}

"""Find a font by its value key. Returns None if not found."""
def:pub getFont(value: str) -> Any {
    for font in FONTS {
        if font["value"] == value {
            return font;
        }
    }
    return None;
}

"""Find a radius by name. Returns None if not found."""
def:pub getRadius(name: str) -> Any {
    for radius in RADII {
        if radius["name"] == name {
            return radius;
        }
    }
    return None;
}

"""Builds a merged theme from base color + accent theme + menu accent + radius.
config keys: baseColor, theme, menuAccent, menuColor, radius
Returns: {"name": str, "cssVars": {"light": {...}, "dark": {...}}}"""
def:pub buildRegistryTheme(config: dict) -> Any {
    base_color_name = config["baseColor"] or "neutral";
    theme_name = config["theme"] or "neutral";
    base_color = getBaseColor(base_color_name);
    theme = getTheme(theme_name);

    if not base_color or not theme {
        return None;
    }

    base_css = base_color["cssVars"] or {};
    theme_css = theme["cssVars"] or {};
    base_light = base_css["light"] or {};
    base_dark = base_css["dark"] or {};
    theme_light = theme_css["light"] or {};
    theme_dark = theme_css["dark"] or {};

    light_vars = Object.assign({}, base_light, theme_light);
    dark_vars = Object.assign({}, base_dark, theme_dark);

    menu_accent = config["menuAccent"] or "subtle";
    if menu_accent == "bold" {
        if light_vars["primary"] {
            light_vars["accent"] = light_vars["primary"];
            light_vars["accent-foreground"] = light_vars["primary-foreground"] or "";
            light_vars["sidebar-accent"] = light_vars["primary"];
            light_vars["sidebar-accent-foreground"] = light_vars["primary-foreground"] or "";
        }
        if dark_vars["primary"] {
            dark_vars["accent"] = dark_vars["primary"];
            dark_vars["accent-foreground"] = dark_vars["primary-foreground"] or "";
            dark_vars["sidebar-accent"] = dark_vars["primary"];
            dark_vars["sidebar-accent-foreground"] = dark_vars["primary-foreground"] or "";
        }
    }

    radius_name = config["radius"] or "default";
    if radius_name and radius_name != "default" {
        radius_item = getRadius(radius_name);
        if radius_item and radius_item["value"] {
            light_vars["radius"] = radius_item["value"];
        }
    }

    return {
        "name": base_color_name + "-" + theme_name,
        "cssVars": {
            "light": light_vars,
            "dark": dark_vars
        }
    };
}

def:pub getDefaultConfig() -> dict {
    return DEFAULT_CONFIG;
}

def:pub getFontsData() -> list {
    return FONTS;
}

def:pub getStylesData() -> list {
    return STYLES;
}

def:pub getRadiiData() -> list {
    return RADII;
}

def:pub getMenuAccentsData() -> list {
    return MENU_ACCENTS;
}

def:pub getMenuColorsData() -> list {
    return MENU_COLORS;
}

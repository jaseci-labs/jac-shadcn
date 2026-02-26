"""
Font definitions — 12 fonts adapted for @fontsource-variable (not next/font/google).
Each font has a CSS family string and an npm package name for dynamic loading.
Ported from shadcn/ui registry/fonts.ts + app/(create)/lib/fonts.ts.
"""

glob FONTS: list = [
    {
        "name": "Geist",
        "value": "geist",
        "family": "'Geist Variable', sans-serif",
        "npm": "@fontsource-variable/geist",
        "import": "@fontsource-variable/geist",
        "type": "sans"
    },
    {
        "name": "Inter",
        "value": "inter",
        "family": "'Inter Variable', sans-serif",
        "npm": "@fontsource-variable/inter",
        "import": "@fontsource-variable/inter",
        "type": "sans"
    },
    {
        "name": "Noto Sans",
        "value": "noto-sans",
        "family": "'Noto Sans Variable', sans-serif",
        "npm": "@fontsource-variable/noto-sans",
        "import": "@fontsource-variable/noto-sans",
        "type": "sans"
    },
    {
        "name": "Nunito Sans",
        "value": "nunito-sans",
        "family": "'Nunito Sans Variable', sans-serif",
        "npm": "@fontsource-variable/nunito-sans",
        "import": "@fontsource-variable/nunito-sans",
        "type": "sans"
    },
    {
        "name": "Figtree",
        "value": "figtree",
        "family": "'Figtree Variable', sans-serif",
        "npm": "@fontsource-variable/figtree",
        "import": "@fontsource-variable/figtree",
        "type": "sans"
    },
    {
        "name": "Roboto",
        "value": "roboto",
        "family": "'Roboto Variable', sans-serif",
        "npm": "@fontsource-variable/roboto",
        "import": "@fontsource-variable/roboto",
        "type": "sans"
    },
    {
        "name": "Raleway",
        "value": "raleway",
        "family": "'Raleway Variable', sans-serif",
        "npm": "@fontsource-variable/raleway",
        "import": "@fontsource-variable/raleway",
        "type": "sans"
    },
    {
        "name": "DM Sans",
        "value": "dm-sans",
        "family": "'DM Sans Variable', sans-serif",
        "npm": "@fontsource-variable/dm-sans",
        "import": "@fontsource-variable/dm-sans",
        "type": "sans"
    },
    {
        "name": "Public Sans",
        "value": "public-sans",
        "family": "'Public Sans Variable', sans-serif",
        "npm": "@fontsource-variable/public-sans",
        "import": "@fontsource-variable/public-sans",
        "type": "sans"
    },
    {
        "name": "Outfit",
        "value": "outfit",
        "family": "'Outfit Variable', sans-serif",
        "npm": "@fontsource-variable/outfit",
        "import": "@fontsource-variable/outfit",
        "type": "sans"
    },
    {
        "name": "JetBrains Mono",
        "value": "jetbrains-mono",
        "family": "'JetBrains Mono Variable', monospace",
        "npm": "@fontsource-variable/jetbrains-mono",
        "import": "@fontsource-variable/jetbrains-mono",
        "type": "mono"
    },
    {
        "name": "Geist Mono",
        "value": "geist-mono",
        "family": "'Geist Mono Variable', monospace",
        "npm": "@fontsource-variable/geist-mono",
        "import": "@fontsource-variable/geist-mono",
        "type": "mono"
    }
];

def:pub getFonts() -> list {
    return FONTS;
}


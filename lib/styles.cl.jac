"""
Style definitions — 5 visual styles that control component spacing, radius, and density.
Each style maps to a CSS file (Phase 2) loaded as `.style-{name}` with `.cn-*` classes.
Ported from shadcn/ui registry/styles.tsx.
"""

glob STYLES: list = [
    {
        "name": "vega",
        "title": "Vega",
        "description": "The classic shadcn/ui look. Clean, neutral, and familiar."
    },
    {
        "name": "nova",
        "title": "Nova",
        "description": "Reduced padding and margins for compact layouts."
    },
    {
        "name": "maia",
        "title": "Maia",
        "description": "Soft and rounded, with generous spacing."
    },
    {
        "name": "lyra",
        "title": "Lyra",
        "description": "Boxy and sharp. Pairs well with mono fonts."
    },
    {
        "name": "mira",
        "title": "Mira",
        "description": "Compact. Made for dense interfaces."
    }
];

def:pub getStyles() -> list {
    return STYLES;
}


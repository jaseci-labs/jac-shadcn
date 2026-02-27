# jac-shadcn

Shadcn-style UI component library and theme customizer for [Jac](https://jac-lang.org) — beautifully designed components built with Radix UI and Tailwind CSS, written entirely in Jac.

## Features

- **21 UI Components** — Button, Card, Dialog, Tabs, Checkbox, Switch, Tooltip, and more
- **5 Visual Styles** — Nova, Vega, Maia, Lyra, Mira
- **21 Color Themes** — Rose, Blue, Green, Orange, Purple, and more
- **12 Fonts** — Geist, Inter, Figtree, JetBrains Mono, and more
- **Visual Customizer** — Live theme editor with instant preview
- **Component Registry** — `jac add --shadcn button card` to install components on demand
- **Jacpack Export** — Download or URL-based project scaffolding

## Quick Start

```bash
# Install the CLI plugin
pip install jac-shadcn

# Create a new themed project
jac create myapp --use "https://jac-shadcn.jaseci.org/jacpack?style=nova&theme=rose"

# Or create a base project and add components individually
jac create myapp --use jac-shadcn
cd myapp
jac add --shadcn button card dialog tabs
jac start main.jac
```

## Running the Customizer

```bash
jac start main.jac    # Serves on http://localhost:8000
```

## Project Structure

```
jac-shadcn/
├── main.jac                # Entry point
├── jac.toml                # Project config
├── global.css              # Theme CSS variables (oklch)
├── styles/                 # 5 style CSS files (cn-* token definitions)
├── lib/                    # Theme engine, config, fonts, export service
├── components/
│   ├── customizer.cl.jac   # Theme customizer sidebar
│   ├── preview-panel.cl.jac # Live component preview
│   └── ui/                 # 21 UI components
└── docs/                   # Conversion guide, architecture
```

## Components

| Component | Primitives |
|-----------|-----------|
| Alert Dialog | Radix UI |
| Avatar | Radix UI |
| Badge | CVA |
| Button | CVA |
| Card | — |
| Checkbox | Radix UI |
| Combobox | Base UI |
| Dialog | Radix UI |
| Dropdown Menu | Radix UI |
| Field | CVA |
| Input | — |
| Input Group | CVA |
| Label | Radix UI |
| Progress | Radix UI |
| Radio Group | Radix UI |
| Select | Radix UI |
| Separator | Radix UI |
| Switch | Radix UI |
| Tabs | Radix UI |
| Textarea | — |
| Tooltip | Radix UI |

## Registry API

```
GET /registry                           # Component manifest
GET /component/{name}?style=nova        # Single resolved component
GET /jacpack?style=nova&theme=rose&...  # Full .jacpack for jac create
```

## License

MIT

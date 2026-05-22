# jac-shadcn

Shadcn-style UI component library and theme customizer for [Jac](https://jac-lang.org) — beautifully designed components built with Radix UI and Tailwind CSS, written entirely in Jac.

This repo serves the public registry at [jac-shadcn.jaseci.org](https://jac-shadcn.jaseci.org) and ships the live customizer. The CLI plugin that consumes it lives separately at [jac-shadcn (pypi)](https://pypi.org/project/jac-shadcn/) / `jac-plugins/jac-shadcn/` in the [jaseci monorepo](https://github.com/jaseci-labs/jaseci).

## Features

- **53 UI components** across form, navigation, layout, status, and feedback (Button, Card, Dialog, Combobox, Calendar, Carousel, Chart, and 46 more)
- **5 visual styles** — Nova, Vega, Maia, Lyra, Mira
- **21 color themes** — Rose, Blue, Emerald, Orange, Purple, and 16 more
- **12 fonts** — Geist, Inter, Figtree, Outfit, JetBrains Mono, and more
- **Live customizer** with instant preview + "Copy CLI command" button
- **Component registry** consumed by the `jac shadcn` plugin

## Quick Start (for plugin users)

```bash
pip install jac-shadcn

# Scaffold a themed project + install 10 essential components in one shot
jac create myapp --use shadcn --style nova --theme rose --font outfit

cd myapp && jac install && jac start main.jac
```

Other common flows:

```bash
# Add a component to an existing project
jac shadcn add button

# Retrofit shadcn onto an existing Jac project
jac shadcn init --style nova --theme rose

# Switch theme; all installed components re-fetched in the new style
jac shadcn upgrade --style vega --theme blue
```

See the [plugin reference](https://docs.jaseci.org/reference/plugins/jac-shadcn/) for the full command catalog.

## Running the Customizer

```bash
jac start main.jac    # Serves on http://localhost:8000
```

Pick a style, theme, font, etc. visually. The "Copy CLI command" button gives you the exact `jac create myapp --use shadcn --style ... --theme ...` invocation for your selection — no URLs to copy around.

## Project Structure

```
jac-shadcn/
├── main.jac                # Entry point + REST endpoints (/registry, /component, /theme, /options, /jacpack)
├── jac.toml                # Project config
├── global.css              # Theme CSS variables (oklch)
├── styles/                 # 5 style CSS files (cn-* token definitions)
├── lib/                    # Theme engine, config, fonts, export service
├── components/
│   ├── customizer.cl.jac    # Theme customizer sidebar
│   ├── preview-panel.cl.jac # Live component preview
│   └── ui/                  # 53 UI components
└── docs/                    # Conversion guide, architecture notes
```

## Registry API

| Endpoint | Returns |
|---|---|
| `GET /registry` | Component manifest + peer deps + shared npm deps |
| `GET /component/{name}?style=…` | Resolved `.cl.jac` source + `npmDeps` + `version` |
| `GET /theme?style=…&baseColor=…&theme=…&font=…&radius=…&menuAccent=…` | Themed `global.css` + `[jac-shadcn]` config + npm deps + default components |
| `GET /jacpack?style=…&theme=…` | Complete `.jacpack` for project scaffold |
| `GET /options` | The universe of valid theme params (consumed by plugin's client-side validator) |

## License

MIT

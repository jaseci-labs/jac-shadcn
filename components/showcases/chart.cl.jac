cl import from ..ui.card { Card, CardAction, CardContent, CardDescription, CardFooter, CardHeader, CardTitle }
cl import from ..ui.label { Label }
cl import from ..ui.separator { Separator }
cl import from ..ui.tooltip { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger }
cl import from ..ui.chart { ChartContainer, ChartTooltip, ChartTooltipContent, ChartLegend, ChartLegendContent }
cl import from "recharts" { Bar, BarChart, CartesianGrid, XAxis, YAxis, Line, LineChart, Area, AreaChart, Pie, PieChart, RadialBar, RadialBarChart }
cl import from ".shared" { ShowcaseSection, ShowcaseHeader }

glob _codeExamples: dict = {
    "chart": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent\n}\ncl import from recharts { Bar, BarChart, XAxis }\n\nconfig = {\n    desktop: {\n        label: 'Desktop',\n        color: 'var(--chart-1)'\n    }\n};\n\n<ChartContainer config={config}>\n    <BarChart data={data}>\n        <XAxis dataKey='month' />\n        <ChartTooltip\n            content={<ChartTooltipContent />}\n        />\n        <Bar dataKey='desktop'\n            fill='var(--color-desktop)' />\n    </BarChart>\n</ChartContainer>",
    "chart-area": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent\n}\ncl import from recharts { Area, AreaChart, XAxis }\n\n<ChartContainer config={multiConfig}>\n    <AreaChart data={data}>\n        <XAxis dataKey='month' />\n        <ChartTooltip\n            content={<ChartTooltipContent />} />\n        <Area dataKey='desktop' type='natural'\n            fill='url(#fillDesktop)'\n            stroke='var(--color-desktop)' />\n    </AreaChart>\n</ChartContainer>",
    "chart-line": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent, ChartLegend,\n    ChartLegendContent\n}\ncl import from recharts { Line, LineChart, XAxis }\n\n<ChartContainer config={multiConfig}>\n    <LineChart data={data}>\n        <XAxis dataKey='month' />\n        <ChartTooltip\n            content={<ChartTooltipContent />} />\n        <Line dataKey='desktop' type='monotone'\n            stroke='var(--color-desktop)' />\n        <Line dataKey='mobile' type='monotone'\n            stroke='var(--color-mobile)' />\n    </LineChart>\n</ChartContainer>",
    "chart-pie": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent\n}\ncl import from recharts { Pie, PieChart }\n\n<ChartContainer config={browserConfig}>\n    <PieChart>\n        <ChartTooltip\n            content={<ChartTooltipContent />} />\n        <Pie data={browserData}\n            dataKey='visitors'\n            nameKey='browser'\n            innerRadius={60} />\n    </PieChart>\n</ChartContainer>",
    "chart-radial": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent\n}\ncl import from recharts { RadialBar, RadialBarChart }\n\n<ChartContainer config={browserConfig}>\n    <RadialBarChart data={browserData}\n        innerRadius={30} outerRadius={110}>\n        <ChartTooltip\n            content={<ChartTooltipContent />} />\n        <RadialBar dataKey='visitors'\n            background={true} />\n    </RadialBarChart>\n</ChartContainer>",
    "chart-stacked": "cl import from .ui.chart {\n    ChartContainer, ChartTooltip,\n    ChartTooltipContent, ChartLegend,\n    ChartLegendContent\n}\ncl import from recharts { Bar, BarChart, XAxis }\n\n<ChartContainer config={multiConfig}>\n    <BarChart data={data}>\n        <XAxis dataKey='month' />\n        <ChartTooltip\n            content={<ChartTooltipContent />} />\n        <ChartLegend\n            content={<ChartLegendContent />} />\n        <Bar dataKey='desktop' stackId='a'\n            fill='var(--color-desktop)' />\n        <Bar dataKey='mobile' stackId='a'\n            fill='var(--color-mobile)' />\n    </BarChart>\n</ChartContainer>",
};

cl {
    def:pub ChartShowcase() -> JsxElement {
        monthData = [
            {month: "January", desktop: 186, mobile: 80},
            {month: "February", desktop: 305, mobile: 200},
            {month: "March", desktop: 237, mobile: 120},
            {month: "April", desktop: 73, mobile: 190},
            {month: "May", desktop: 209, mobile: 130},
            {month: "June", desktop: 214, mobile: 140}
        ];
        desktopConfig = {desktop: {label: "Desktop", color: "var(--chart-1)"}};
        multiConfig = {
            desktop: {label: "Desktop", color: "var(--chart-1)"},
            mobile: {label: "Mobile", color: "var(--chart-2)"}
        };
        browserData = [
            {browser: "chrome", visitors: 275, fill: "var(--color-chrome)"},
            {browser: "safari", visitors: 200, fill: "var(--color-safari)"},
            {browser: "firefox", visitors: 287, fill: "var(--color-firefox)"},
            {browser: "edge", visitors: 173, fill: "var(--color-edge)"},
            {browser: "other", visitors: 190, fill: "var(--color-other)"}
        ];
        browserConfig = {
            visitors: {label: "Visitors"},
            chrome: {label: "Chrome", color: "var(--chart-1)"},
            safari: {label: "Safari", color: "var(--chart-2)"},
            firefox: {label: "Firefox", color: "var(--chart-3)"},
            edge: {label: "Edge", color: "var(--chart-4)"},
            other: {label: "Other", color: "var(--chart-5)"}
        };
        shortMonth = lambda(v: Any) -> Any { return v.slice(0, 3); };
        return <div className="space-y-8">
            <ShowcaseHeader title="Chart" description="Beautiful charts built with Recharts." name="chart" />

            <ShowcaseSection title="Bar Chart" className="flex-col w-full" code={_codeExamples["chart"]}>
                <Card className="w-full">
                    <CardHeader>
                        <CardTitle>Bar Chart - Grouped</CardTitle>
                        <CardDescription>Desktop vs Mobile — January - June 2024</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <ChartContainer config={multiConfig} className="min-h-[200px] w-full">
                            <BarChart accessibilityLayer={true} data={monthData} margin={{left: 12, right: 12}}>
                                <CartesianGrid vertical={false} />
                                <XAxis dataKey="month" tickLine={false} axisLine={false} tickMargin={8} tickFormatter={shortMonth} />
                                <ChartTooltip cursor={false} content={<ChartTooltipContent />} />
                                <ChartLegend content={<ChartLegendContent />} />
                                <Bar dataKey="desktop" fill="var(--color-desktop)" radius={4} />
                                <Bar dataKey="mobile" fill="var(--color-mobile)" radius={4} />
                            </BarChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>

            <Separator />

            <ShowcaseSection title="Stacked Bar Chart" className="flex-col w-full" code={_codeExamples["chart-stacked"]}>
                <Card className="w-full">
                    <CardHeader>
                        <CardTitle>Bar Chart - Stacked + Legend</CardTitle>
                        <CardDescription>January - June 2024</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <ChartContainer config={multiConfig} className="min-h-[200px] w-full">
                            <BarChart accessibilityLayer={true} data={monthData}>
                                <CartesianGrid vertical={false} />
                                <XAxis dataKey="month" tickLine={false} tickMargin={10} axisLine={false} tickFormatter={shortMonth} />
                                <ChartTooltip content={<ChartTooltipContent hideLabel={true} />} />
                                <ChartLegend content={<ChartLegendContent />} />
                                <Bar dataKey="desktop" stackId="a" fill="var(--color-desktop)" radius={[0, 0, 4, 4]} />
                                <Bar dataKey="mobile" stackId="a" fill="var(--color-mobile)" radius={[4, 4, 0, 0]} />
                            </BarChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>

            <Separator />

            <ShowcaseSection title="Line Chart" className="flex-col w-full" code={_codeExamples["chart-line"]}>
                <Card className="w-full">
                    <CardHeader>
                        <CardTitle>Line Chart</CardTitle>
                        <CardDescription>January - June 2024</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <ChartContainer config={multiConfig} className="min-h-[200px] w-full">
                            <LineChart accessibilityLayer={true} data={monthData} margin={{left: 12, right: 12}}>
                                <CartesianGrid vertical={false} />
                                <XAxis dataKey="month" tickLine={false} axisLine={false} tickMargin={8} tickFormatter={shortMonth} />
                                <ChartTooltip cursor={false} content={<ChartTooltipContent />} />
                                <ChartLegend content={<ChartLegendContent />} />
                                <Line dataKey="desktop" type={"monotone"} stroke="var(--color-desktop)" strokeWidth={2} dot={{r: 4}} activeDot={{r: 6}} />
                                <Line dataKey="mobile" type={"monotone"} stroke="var(--color-mobile)" strokeWidth={2} dot={{r: 4}} activeDot={{r: 6}} />
                            </LineChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>

            <Separator />

            <ShowcaseSection title="Area Chart" className="flex-col w-full" code={_codeExamples["chart-area"]}>
                <Card className="w-full">
                    <CardHeader>
                        <CardTitle>Area Chart - Gradient</CardTitle>
                        <CardDescription>January - June 2024</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <ChartContainer config={multiConfig} className="min-h-[200px] w-full">
                            <AreaChart accessibilityLayer={true} data={monthData} margin={{left: 12, right: 12}}>
                                <CartesianGrid vertical={false} />
                                <XAxis dataKey="month" tickLine={false} axisLine={false} tickMargin={8} tickFormatter={shortMonth} />
                                <ChartTooltip cursor={false} content={<ChartTooltipContent />} />
                                <defs>
                                    <linearGradient id="fillDesktop" x1="0" y1="0" x2="0" y2="1">
                                        <stop offset="5%" stopColor="var(--color-desktop)" stopOpacity={0.8} />
                                        <stop offset="95%" stopColor="var(--color-desktop)" stopOpacity={0.1} />
                                    </linearGradient>
                                    <linearGradient id="fillMobile" x1="0" y1="0" x2="0" y2="1">
                                        <stop offset="5%" stopColor="var(--color-mobile)" stopOpacity={0.8} />
                                        <stop offset="95%" stopColor="var(--color-mobile)" stopOpacity={0.1} />
                                    </linearGradient>
                                </defs>
                                <Area dataKey="mobile" type="natural" fill="url(#fillMobile)" fillOpacity={0.4} stroke="var(--color-mobile)" stackId="a" />
                                <Area dataKey="desktop" type="natural" fill="url(#fillDesktop)" fillOpacity={0.4} stroke="var(--color-desktop)" stackId="a" />
                            </AreaChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>

            <Separator />

            <ShowcaseSection title="Pie Chart" className="flex-col w-full" code={_codeExamples["chart-pie"]}>
                <Card className="w-full">
                    <CardHeader className="items-center pb-0">
                        <CardTitle>Pie Chart - Donut</CardTitle>
                        <CardDescription>Browser market share 2024</CardDescription>
                    </CardHeader>
                    <CardContent className="flex-1 pb-0">
                        <ChartContainer config={browserConfig} className="mx-auto aspect-square max-h-[250px]">
                            <PieChart>
                                <ChartTooltip cursor={false} content={<ChartTooltipContent hideLabel={true} />} />
                                <Pie data={browserData} dataKey="visitors" nameKey="browser" innerRadius={60} strokeWidth={5} />
                            </PieChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>

            <Separator />

            <ShowcaseSection title="Radial Chart" className="flex-col w-full" code={_codeExamples["chart-radial"]}>
                <Card className="w-full">
                    <CardHeader className="items-center pb-0">
                        <CardTitle>Radial Bar Chart</CardTitle>
                        <CardDescription>Browser market share 2024</CardDescription>
                    </CardHeader>
                    <CardContent className="flex-1 pb-0">
                        <ChartContainer config={browserConfig} className="mx-auto aspect-square max-h-[250px]">
                            <RadialBarChart data={browserData} innerRadius={30} outerRadius={110}>
                                <ChartTooltip cursor={false} content={<ChartTooltipContent hideLabel={true} nameKey="browser" />} />
                                <RadialBar dataKey="visitors" background={true} />
                            </RadialBarChart>
                        </ChartContainer>
                    </CardContent>
                </Card>
            </ShowcaseSection>
        </div>;
    }

}

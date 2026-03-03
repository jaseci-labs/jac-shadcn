"""Project preview — renders a realistic preview of the generated starter project.
Mirrors the UI that generate_main_jac() in export_service.jac produces,
so users see exactly what their exported project will look like."""
cl import from .ui.button { Button }
cl import from ".ui.card" { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle }
cl import from .ui.badge { Badge }
cl import from .ui.input { Input }
cl import from .ui.label { Label }
cl import from .ui.textarea { Textarea }
cl import from .ui.separator { Separator }
cl import from ".ui.tabs" { Tabs, TabsList, TabsTrigger, TabsContent }
cl import from .ui.switch { Switch }
cl import from .ui.checkbox { Checkbox }
cl import from .ui.progress { Progress }
cl import from ".ui.avatar" { Avatar, AvatarFallback }
cl import from ".ui.alert" { Alert, AlertTitle, AlertDescription }

cl {
    """Realistic preview of the generated starter project."""
    def:pub ProjectPreview() -> JsxElement {
        has previewDark: bool = False;

        return <div className="min-h-[600px] bg-background text-foreground">
            <header className="border-b border-border p-4">
                <div className="max-w-4xl mx-auto flex items-center justify-between">
                    <h1 className="text-lg font-bold">My App</h1>
                    <div className="flex items-center gap-2">
                        <label className="flex items-center gap-2 text-sm cursor-pointer">
                            <Switch checked={previewDark} onCheckedChange={lambda(v: Any) -> None {
                                previewDark = v;
                            }} />
                            Dark Mode
                        </label>
                    </div>
                </div>
            </header>
            <main className="max-w-4xl mx-auto p-6 space-y-8">
                <Alert>
                    <AlertTitle>{"Welcome!"}</AlertTitle>
                    <AlertDescription>Your themed project is ready. Start building!</AlertDescription>
                </Alert>

                <Tabs defaultValue="overview">
                    <TabsList>
                        <TabsTrigger value="overview">Overview</TabsTrigger>
                        <TabsTrigger value="settings">Settings</TabsTrigger>
                    </TabsList>
                    <TabsContent value="overview">
                        <div className="grid gap-4 md:grid-cols-2 mt-4">
                            <Card>
                                <CardHeader>
                                    <CardTitle>Project Stats</CardTitle>
                                    <CardDescription>Your project overview</CardDescription>
                                </CardHeader>
                                <CardContent className="space-y-4">
                                    <div className="flex items-center justify-between text-sm">
                                        <span className="text-muted-foreground">Progress</span>
                                        <span className="font-medium">68%</span>
                                    </div>
                                    <Progress value={68} />
                                    <div className="flex gap-2">
                                        <Badge>Active</Badge>
                                        <Badge variant="secondary">v1.0</Badge>
                                        <Badge variant="outline">Jac</Badge>
                                    </div>
                                </CardContent>
                            </Card>
                            <Card>
                                <CardHeader>
                                    <CardTitle>Team</CardTitle>
                                    <CardDescription>Project members</CardDescription>
                                </CardHeader>
                                <CardContent className="space-y-3">
                                    <div className="flex items-center gap-3">
                                        <Avatar>
                                            <AvatarFallback>JM</AvatarFallback>
                                        </Avatar>
                                        <div>
                                            <p className="text-sm font-medium">Jason Mars</p>
                                            <p className="text-xs text-muted-foreground">Owner</p>
                                        </div>
                                    </div>
                                    <Separator />
                                    <div className="flex items-center gap-2">
                                        <Checkbox id="preview-newsletter" defaultChecked={True} />
                                        <Label htmlFor="preview-newsletter" className="text-sm">Receive updates</Label>
                                    </div>
                                </CardContent>
                            </Card>
                        </div>
                    </TabsContent>
                    <TabsContent value="settings">
                        <Card className="mt-4">
                            <CardHeader>
                                <CardTitle>Settings</CardTitle>
                                <CardDescription>Manage your preferences</CardDescription>
                            </CardHeader>
                            <CardContent className="space-y-4">
                                <div className="space-y-2">
                                    <Label htmlFor="preview-project-name">Project Name</Label>
                                    <Input id="preview-project-name" placeholder="My Project" />
                                </div>
                                <div className="space-y-2">
                                    <Label htmlFor="preview-description">Description</Label>
                                    <Textarea id="preview-description" placeholder="Describe your project..." />
                                </div>
                                <div className="flex gap-2">
                                    <Button>Save</Button>
                                    <Button variant="outline">Cancel</Button>
                                </div>
                            </CardContent>
                        </Card>
                    </TabsContent>
                </Tabs>
            </main>
        </div>;
    }
}

cl import from ..ui.button { Button, buttonVariants }
cl import from ..ui.card { Card, CardAction, CardContent, CardDescription, CardFooter, CardHeader, CardTitle }
cl import from ..ui.separator { Separator }
cl import from ..ui.progress { Progress }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon, ArrowDownIcon, ArrowUpIcon, PlusSignIcon, DownloadIcon, MailIcon, SearchIcon, SettingsIcon, UserIcon, Copy01Icon, Tick01Icon, TextAlignLeftIcon, TextAlignCenterIcon, TextAlignRightIcon, TextBoldIcon, TextItalicIcon, TextUnderlineIcon }
cl import from react { useState, useEffect }
cl import from ..ui.alert { Alert, AlertTitle, AlertDescription, AlertAction }
cl import from ..ui.skeleton { Skeleton }
cl import from ..ui.spinner { Spinner }
cl import from ..ui.table { Table, TableHeader, TableBody, TableFooter, TableRow, TableHead, TableCell, TableCaption }
cl import from ..ui.empty { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription, EmptyContent }
cl import from ".shared" { ShowcaseSection, ShowcaseHeader }

glob _codeExamples: dict = {
    "alert": "cl import from .ui.alert {\n    Alert, AlertTitle, AlertDescription\n}\n\n<Alert>\n    <AlertTitle>Heads up!</AlertTitle>\n    <AlertDescription>\n        You can add components using the CLI.\n    </AlertDescription>\n</Alert>\n\n<Alert variant='destructive'>\n    <AlertTitle>Error</AlertTitle>\n    <AlertDescription>Session expired.</AlertDescription>\n</Alert>",
    "alert-destructive": "cl import from .ui.alert {\n    Alert, AlertTitle, AlertDescription\n}\n\n<Alert variant='destructive'>\n    <AlertTitle>Error</AlertTitle>\n    <AlertDescription>\n        Your session has expired.\n    </AlertDescription>\n</Alert>",
    "empty": "cl import from .ui.empty {\n    Empty, EmptyHeader, EmptyTitle,\n    EmptyDescription, EmptyContent\n}\n\n<Empty>\n    <EmptyHeader>\n        <EmptyTitle>No results found</EmptyTitle>\n        <EmptyDescription>\n            Try adjusting your search.\n        </EmptyDescription>\n    </EmptyHeader>\n    <EmptyContent>\n        <Button size='sm'>Clear filters</Button>\n    </EmptyContent>\n</Empty>",
    "progress": "cl import from .ui.progress { Progress }\n\nhas value: int = 40;\n\n<Progress value={value} />",
    "progress-static": "cl import from .ui.progress { Progress }\n\n<Progress value={25} />\n<Progress value={50} />\n<Progress value={75} />\n<Progress value={100} />",
    "skeleton": "cl import from .ui.skeleton { Skeleton }\n\n<div className='flex items-center space-x-4'>\n    <Skeleton className='h-12 w-12 rounded-full' />\n    <div className='space-y-2'>\n        <Skeleton className='h-4 w-48' />\n        <Skeleton className='h-4 w-36' />\n    </div>\n</div>",
    "skeleton-table": "cl import from .ui.skeleton { Skeleton }\n\n<Skeleton className='h-8 w-full' />\n<Skeleton className='h-6 w-full' />\n<Skeleton className='h-6 w-full' />\n<Skeleton className='h-6 w-3/4' />",
    "spinner": "cl import from .ui.spinner { Spinner }\n\n<Spinner size={16} />\n<Spinner size={24} />\n<Spinner size={32} />",
    "spinner-text": "cl import from .ui.spinner { Spinner }\n\n<Spinner size={20} />\n<span className='text-sm text-muted-foreground'>\n    Loading...\n</span>",
};

cl {
    def:pub AlertShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Alert" description="Displays a callout for user attention." name="alert" />
            <ShowcaseSection title="Default" className="flex-col gap-4" code={_codeExamples["alert"]}>
                <Alert className="max-w-md">
                    <AlertTitle>Heads up!</AlertTitle>
                    <AlertDescription>You can add components to your app using the cli.</AlertDescription>
                </Alert>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Destructive" className="flex-col gap-4" code={_codeExamples["alert-destructive"]}>
                <Alert variant="destructive" className="max-w-md">
                    <AlertTitle>Error</AlertTitle>
                    <AlertDescription>Your session has expired. Please log in again.</AlertDescription>
                </Alert>
            </ShowcaseSection>
        </div>;
    }

    def:pub ProgressShowcase() -> JsxElement {
        has progressValue: int = 40;

        useEffect(lambda -> Any {
            timer = setInterval(lambda -> None {
                progressValue = progressValue + 10;
                if progressValue > 100 {
                    progressValue = 0;
                }
            }, 1500);
            return lambda -> None { clearInterval(timer); };
        }, []);

        return <div className="space-y-8">
            <ShowcaseHeader
                title="Progress"
                description="Displays an indicator showing the completion progress of a task."
                name="progress"
            />
            <ShowcaseSection title="Default" code={_codeExamples["progress"]}>
                <div className="w-full max-w-md space-y-2">
                    <Progress value={progressValue} />
                    <p className="text-sm text-muted-foreground text-right">{String(progressValue) + "%"}</p>
                </div>
            </ShowcaseSection>
            <ShowcaseSection title="Static Values" className="flex-col gap-4" code={_codeExamples["progress-static"]}>
                <div className="w-full max-w-md space-y-1">
                    <p className="text-sm text-muted-foreground">25%</p>
                    <Progress value={25} />
                </div>
                <div className="w-full max-w-md space-y-1">
                    <p className="text-sm text-muted-foreground">50%</p>
                    <Progress value={50} />
                </div>
                <div className="w-full max-w-md space-y-1">
                    <p className="text-sm text-muted-foreground">75%</p>
                    <Progress value={75} />
                </div>
                <div className="w-full max-w-md space-y-1">
                    <p className="text-sm text-muted-foreground">100%</p>
                    <Progress value={100} />
                </div>
            </ShowcaseSection>
        </div>;
    }

    def:pub SkeletonShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Skeleton" description="Use to show a placeholder while content is loading." name="skeleton" />
            <ShowcaseSection title="Card Skeleton" className="flex-col gap-4" code={_codeExamples["skeleton"]}>
                <div className="flex items-center space-x-4">
                    <Skeleton className="h-12 w-12 rounded-full" />
                    <div className="space-y-2">
                        <Skeleton className="h-4 w-48" />
                        <Skeleton className="h-4 w-36" />
                    </div>
                </div>
                <Skeleton className="h-32 w-full max-w-sm rounded-xl" />
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Table Skeleton" className="flex-col gap-2" code={_codeExamples["skeleton-table"]}>
                <Skeleton className="h-8 w-full max-w-sm" />
                <Skeleton className="h-6 w-full max-w-sm" />
                <Skeleton className="h-6 w-full max-w-sm" />
                <Skeleton className="h-6 w-3/4 max-w-sm" />
            </ShowcaseSection>
        </div>;
    }

    def:pub SpinnerShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Spinner" description="An animated loading indicator." name="spinner" />
            <ShowcaseSection title="Sizes" className="flex-wrap gap-6 items-center" code={_codeExamples["spinner"]}>
                <Spinner size={16} />
                <Spinner size={24} />
                <Spinner size={32} />
                <Spinner size={48} />
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="With Text" className="gap-3 items-center" code={_codeExamples["spinner-text"]}>
                <Spinner size={20} />
                <span className="text-sm text-muted-foreground">Loading...</span>
            </ShowcaseSection>
        </div>;
    }

    def:pub EmptyShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Empty" description="A component to display empty state with optional media, title, and description." name="empty" />
            <ShowcaseSection title="Default" code={_codeExamples["empty"]}>
                <div className="w-full max-w-sm border rounded-lg p-8">
                    <Empty>
                        <EmptyHeader>
                            <EmptyMedia>
                                <HugeiconsIcon icon={SearchIcon} size={32} className="text-muted-foreground" />
                            </EmptyMedia>
                            <EmptyTitle className="mt-3 text-base font-semibold">No results found</EmptyTitle>
                            <EmptyDescription className="mt-1 text-sm">Try adjusting your search or filters.</EmptyDescription>
                        </EmptyHeader>
                        <EmptyContent className="mt-4">
                            <Button size="sm">Clear filters</Button>
                        </EmptyContent>
                    </Empty>
                </div>
            </ShowcaseSection>
        </div>;
    }

}

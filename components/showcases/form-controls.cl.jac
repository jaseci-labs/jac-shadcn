cl import from ..ui.button { Button, buttonVariants }
cl import from ..ui.separator { Separator }
cl import from ..ui.checkbox { Checkbox }
cl import from ..ui.switch { Switch }
cl import from "..ui.radio-group" { RadioGroup, RadioGroupItem }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon, ArrowDownIcon, ArrowUpIcon, PlusSignIcon, DownloadIcon, MailIcon, SearchIcon, SettingsIcon, UserIcon, Copy01Icon, Tick01Icon, TextAlignLeftIcon, TextAlignCenterIcon, TextAlignRightIcon, TextBoldIcon, TextItalicIcon, TextUnderlineIcon }
cl import from ..ui.slider { Slider }
cl import from ..ui.item { Item, ItemGroup, ItemMedia, ItemContent, ItemTitle, ItemDescription, ItemActions, ItemSeparator }
cl import from ".shared" { ShowcaseSection, ShowcaseHeader }

glob _codeExamples: dict = {
    "button": "cl import from .ui.button { Button }\n\n<Button>Click me</Button>\n<Button variant='secondary'>Secondary</Button>\n<Button variant='outline'>Outline</Button>\n<Button variant='destructive'>Destructive</Button>\n<Button variant='ghost'>Ghost</Button>\n<Button variant='link'>Link</Button>",
    "button-disabled": "<Button disabled={True}>Disabled</Button>\n<Button variant='outline' disabled={True}>\n    Disabled\n</Button>",
    "button-icon": "cl import from .ui.button { Button }\ncl import from '@hugeicons/react' { HugeiconsIcon }\ncl import from '@hugeicons/core-free-icons' {\n    ArrowRight01Icon\n}\n\n<Button>\n    Next\n    <HugeiconsIcon icon={ArrowRight01Icon}\n        data-icon='inline-end' />\n</Button>",
    "button-icon-left": "cl import from .ui.button { Button }\ncl import from '@hugeicons/react' { HugeiconsIcon }\ncl import from '@hugeicons/core-free-icons' { MailIcon }\n\n<Button>\n    <HugeiconsIcon icon={MailIcon}\n        data-icon='inline-start' />\n    Send Email\n</Button>",
    "button-icon-only": "cl import from .ui.button { Button }\ncl import from '@hugeicons/react' { HugeiconsIcon }\ncl import from '@hugeicons/core-free-icons' { PlusSignIcon }\n\n<Button size='icon'>\n    <HugeiconsIcon icon={PlusSignIcon} />\n</Button>\n<Button size='icon-sm' variant='outline'>\n    <HugeiconsIcon icon={PlusSignIcon} />\n</Button>",
    "checkbox": "cl import from .ui.checkbox { Checkbox }\n\nhas checked: bool = False;\n\n<label className='flex items-center gap-2'>\n    <Checkbox\n        checked={checked}\n        onCheckedChange={lambda(v: Any) -> None {\n            checked = v;\n        }}\n    />\n    Accept terms\n</label>",
    "checkbox-description": "cl import from .ui.checkbox { Checkbox }\n\n<label className='flex items-start gap-3'>\n    <Checkbox className='mt-0.5'\n        defaultChecked={True} />\n    <div className='space-y-1'>\n        <div className='text-sm font-medium'>\n            Accept terms\n        </div>\n        <div className='text-sm text-muted-foreground'>\n            You agree to our Terms of Service.\n        </div>\n    </div>\n</label>",
    "radio-disabled": "cl import from '.ui.radio-group' {\n    RadioGroup, RadioGroupItem\n}\n\n<RadioGroup defaultValue='option-1'>\n    <label className='flex items-center gap-3'>\n        <RadioGroupItem value='option-1' />\n        Option 1\n    </label>\n    <label className='flex items-center gap-3\n        text-muted-foreground'>\n        <RadioGroupItem value='option-2'\n            disabled={True} />\n        Option 2 (Disabled)\n    </label>\n</RadioGroup>",
    "radio-group": "cl import from '.ui.radio-group' {\n    RadioGroup, RadioGroupItem\n}\n\nhas value: str = 'default';\n\n<RadioGroup value={value}\n    onValueChange={lambda(v: Any) -> None {\n        value = v;\n    }}>\n    <label className='flex items-center gap-3'>\n        <RadioGroupItem value='default' /> Default\n    </label>\n    <label className='flex items-center gap-3'>\n        <RadioGroupItem value='comfortable' /> Comfortable\n    </label>\n</RadioGroup>",
    "slider": "cl import from .ui.slider { Slider }\n\nhas value: list = [50];\n\n<Slider\n    defaultValue={[50]}\n    max={100}\n    step={1}\n    onValueChange={lambda(v: list) -> None {\n        value = v;\n    }}\n/>",
    "slider-disabled": "<Slider defaultValue={[40]}\n    max={100} step={1} disabled={True} />",
    "slider-range": "cl import from .ui.slider { Slider }\n\n<Slider defaultValue={[20, 80]}\n    max={100} step={1} />",
    "switch": "cl import from .ui.switch { Switch }\n\nhas enabled: bool = False;\n\n<label className='flex items-center gap-3'>\n    <Switch\n        checked={enabled}\n        onCheckedChange={lambda(v: Any) -> None {\n            enabled = v;\n        }}\n    />\n    Airplane Mode\n</label>",
    "switch-description": "cl import from .ui.switch { Switch }\n\n<div className='flex items-start gap-3'>\n    <Switch defaultChecked={True} />\n    <div className='space-y-1'>\n        <div className='text-sm font-medium'>\n            Marketing emails\n        </div>\n        <div className='text-sm text-muted-foreground'>\n            Receive emails about new products.\n        </div>\n    </div>\n</div>",
    "switch-disabled": "<Switch disabled={True} />\n<Switch disabled={True} checked={True} />",
    "switch-sizes": "cl import from .ui.switch { Switch }\n\n<Switch size='sm' defaultChecked={True} />\n<Switch size='default' defaultChecked={True} />",
};

cl {
    def:pub ButtonShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Button"
                description="A clickable element that triggers an action."
                name="button"
            />
            <ShowcaseSection title="Variants & Sizes" code={_codeExamples["button"]}>
                <div className="space-y-3 w-full">
                    {["default", "sm", "lg", "xs"].map(lambda(size: Any) -> Any {
                        return <div key={size} className="flex flex-wrap items-center gap-2">
                            <Button size={size}>Default</Button>
                            <Button variant="secondary" size={size}>Secondary</Button>
                            <Button variant="outline" size={size}>Outline</Button>
                            <Button variant="ghost" size={size}>Ghost</Button>
                            <Button variant="destructive" size={size}>Destructive</Button>
                            <Button variant="link" size={size}>Link</Button>
                        </div>;
                    })}
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Icon Right" code={_codeExamples["button-icon"]}>
                <div className="space-y-3 w-full">
                    {["default", "sm", "lg", "xs"].map(lambda(size: Any) -> Any {
                        return <div key={size} className="flex flex-wrap items-center gap-2">
                            <Button size={size}>Default <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                            <Button variant="secondary" size={size}>Secondary <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                            <Button variant="outline" size={size}>Outline <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                            <Button variant="ghost" size={size}>Ghost <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                            <Button variant="destructive" size={size}>Destructive <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                            <Button variant="link" size={size}>Link <HugeiconsIcon icon={ArrowRight01Icon} strokeWidth={2} data-icon="inline-end" /></Button>
                        </div>;
                    })}
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Icon Left" code={_codeExamples["button-icon-left"]}>
                <div className="space-y-3 w-full">
                    <div className="flex flex-wrap items-center gap-2">
                        <Button><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Default</Button>
                        <Button variant="secondary"><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Secondary</Button>
                        <Button variant="outline"><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Outline</Button>
                        <Button variant="ghost"><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Ghost</Button>
                        <Button variant="destructive"><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Destructive</Button>
                        <Button variant="link"><HugeiconsIcon icon={MailIcon} strokeWidth={2} data-icon="inline-start" /> Link</Button>
                    </div>
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Icon Only" code={_codeExamples["button-icon-only"]}>
                <div className="flex flex-wrap items-center gap-2">
                    <Button size="icon"><HugeiconsIcon icon={PlusSignIcon} strokeWidth={2} /></Button>
                    <Button size="icon-sm" variant="outline"><HugeiconsIcon icon={SettingsIcon} strokeWidth={2} /></Button>
                    <Button size="icon-xs" variant="ghost"><HugeiconsIcon icon={SearchIcon} strokeWidth={2} /></Button>
                    <Button size="icon-lg" variant="secondary"><HugeiconsIcon icon={UserIcon} strokeWidth={2} /></Button>
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Disabled" code={_codeExamples["button-disabled"]}>
                <Button disabled={True}>Disabled</Button>
                <Button variant="outline" disabled={True}>Disabled</Button>
                <Button variant="secondary" disabled={True}>Disabled</Button>
                <Button variant="ghost" disabled={True}>Disabled</Button>
            </ShowcaseSection>
        </div>;
    }

    def:pub CheckboxShowcase() -> JsxElement {
        has checked1: bool = True;
        has checked2: bool = False;
        has checked3: Any = "indeterminate";
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Checkbox"
                description="A control that allows the user to toggle between checked and not checked."
                name="checkbox"
            />
            <ShowcaseSection title="States" className="gap-6" code={_codeExamples["checkbox"]}>
                <label className="flex items-center gap-2 text-sm">
                    <Checkbox checked={checked1} onCheckedChange={lambda(v: Any) -> None { checked1 = v; }} />
                    Checked
                </label>
                <label className="flex items-center gap-2 text-sm">
                    <Checkbox checked={checked2} onCheckedChange={lambda(v: Any) -> None { checked2 = v; }} />
                    Unchecked
                </label>
                <label className="flex items-center gap-2 text-sm">
                    <Checkbox disabled={True} />
                    Disabled
                </label>
                <label className="flex items-center gap-2 text-sm">
                    <Checkbox checked={True} disabled={True} />
                    Checked Disabled
                </label>
            </ShowcaseSection>
            <ShowcaseSection title="With Description" code={_codeExamples["checkbox-description"]}>
                <div className="space-y-4">
                    <label className="flex items-start gap-3">
                        <Checkbox className="mt-0.5" defaultChecked={True} />
                        <div className="space-y-1">
                            <div className="text-sm font-medium">Accept terms and conditions</div>
                            <div className="text-sm text-muted-foreground">You agree to our Terms of Service and Privacy Policy.</div>
                        </div>
                    </label>
                    <label className="flex items-start gap-3">
                        <Checkbox className="mt-0.5" />
                        <div className="space-y-1">
                            <div className="text-sm font-medium">Marketing emails</div>
                            <div className="text-sm text-muted-foreground">Receive emails about new products, features, and more.</div>
                        </div>
                    </label>
                </div>
            </ShowcaseSection>
        </div>;
    }

    def:pub SwitchShowcase() -> JsxElement {
        has airplaneMode: bool = False;
        has notifications: bool = True;
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Switch"
                description="A control that allows the user to toggle between on and off."
                name="switch"
            />
            <ShowcaseSection title="Default" className="gap-6" code={_codeExamples["switch"]}>
                <label className="flex items-center gap-3 text-sm">
                    <Switch checked={airplaneMode} onCheckedChange={lambda(v: Any) -> None { airplaneMode = v; }} />
                    Airplane Mode
                </label>
                <label className="flex items-center gap-3 text-sm">
                    <Switch checked={notifications} onCheckedChange={lambda(v: Any) -> None { notifications = v; }} />
                    Notifications
                </label>
            </ShowcaseSection>
            <ShowcaseSection title="Sizes" className="gap-6" code={_codeExamples["switch-sizes"]}>
                <label className="flex items-center gap-3 text-sm">
                    <Switch size="sm" defaultChecked={True} />
                    Small
                </label>
                <label className="flex items-center gap-3 text-sm">
                    <Switch size="default" defaultChecked={True} />
                    Default
                </label>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled" className="gap-6" code={_codeExamples["switch-disabled"]}>
                <label className="flex items-center gap-3 text-sm text-muted-foreground">
                    <Switch disabled={True} />
                    Disabled Off
                </label>
                <label className="flex items-center gap-3 text-sm text-muted-foreground">
                    <Switch disabled={True} checked={True} />
                    Disabled On
                </label>
            </ShowcaseSection>
            <ShowcaseSection title="With Description" code={_codeExamples["switch-description"]}>
                <div className="flex items-start gap-3">
                    <Switch defaultChecked={True} className="mt-0.5" />
                    <div className="space-y-1">
                        <div className="text-sm font-medium">Marketing emails</div>
                        <div className="text-sm text-muted-foreground">Receive emails about new products, features, and more.</div>
                    </div>
                </div>
            </ShowcaseSection>
        </div>;
    }

    def:pub RadioGroupShowcase() -> JsxElement {
        has selectedValue: str = "comfortable";
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Radio Group"
                description="A set of checkable buttons where no more than one can be checked at a time."
                name="radio-group"
            />
            <ShowcaseSection title="Default" code={_codeExamples["radio-group"]}>
                <RadioGroup value={selectedValue} onValueChange={lambda(v: Any) -> None { selectedValue = v; }} className="max-w-xs">
                    <label className="flex items-center gap-3 text-sm">
                        <RadioGroupItem value="default" />
                        Default
                    </label>
                    <label className="flex items-center gap-3 text-sm">
                        <RadioGroupItem value="comfortable" />
                        Comfortable
                    </label>
                    <label className="flex items-center gap-3 text-sm">
                        <RadioGroupItem value="compact" />
                        Compact
                    </label>
                </RadioGroup>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled" code={_codeExamples["radio-disabled"]}>
                <RadioGroup defaultValue="option-1" className="max-w-xs">
                    <label className="flex items-center gap-3 text-sm">
                        <RadioGroupItem value="option-1" />
                        Option 1
                    </label>
                    <label className="flex items-center gap-3 text-sm text-muted-foreground">
                        <RadioGroupItem value="option-2" disabled={True} />
                        Option 2 (Disabled)
                    </label>
                    <label className="flex items-center gap-3 text-sm">
                        <RadioGroupItem value="option-3" />
                        Option 3
                    </label>
                </RadioGroup>
            </ShowcaseSection>
        </div>;
    }

    def:pub SliderShowcase() -> JsxElement {
        has sliderValue: list = [50];

        return <div className="space-y-8">
            <ShowcaseHeader title="Slider" description="An input where the user selects a value from within a given range." name="slider" />
            <ShowcaseSection title="Default" code={_codeExamples["slider"]}>
                <div className="w-full max-w-sm space-y-4">
                    <Slider
                        defaultValue={[50]}
                        max={100}
                        step={1}
                        className="w-full"
                        onValueChange={lambda val: list -> None { sliderValue = val; }}
                    />
                    <p className="text-sm text-muted-foreground text-center">Value: {String(sliderValue[0])}</p>
                </div>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Range" code={_codeExamples["slider-range"]}>
                <Slider defaultValue={[20, 80]} max={100} step={1} className="w-full max-w-sm" />
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Disabled" code={_codeExamples["slider-disabled"]}>
                <Slider defaultValue={[40]} max={100} step={1} disabled={True} className="w-full max-w-sm" />
            </ShowcaseSection>
        </div>;
    }

}

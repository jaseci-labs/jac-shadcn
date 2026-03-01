cl import from ..ui.button { Button, buttonVariants }
cl import from ..ui.badge { Badge }
cl import from ..ui.input { Input }
cl import from ..ui.separator { Separator }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon, ArrowDownIcon, ArrowUpIcon, PlusSignIcon, DownloadIcon, MailIcon, SearchIcon, SettingsIcon, UserIcon, Copy01Icon, Tick01Icon, TextAlignLeftIcon, TextAlignCenterIcon, TextAlignRightIcon, TextBoldIcon, TextItalicIcon, TextUnderlineIcon }
cl import from ..ui.toggle { Toggle }
cl import from "..ui.toggle-group" { ToggleGroup, ToggleGroupItem }
cl import from "..ui.button-group" { ButtonGroup, ButtonGroupText, ButtonGroupSeparator }
cl import from ..ui.kbd { Kbd, KbdGroup }
cl import from ..ui.item { Item, ItemGroup, ItemMedia, ItemContent, ItemTitle, ItemDescription, ItemActions, ItemSeparator }
cl import from ".shared" { ShowcaseSection, ShowcaseHeader }

glob _codeExamples: dict = {
    "button-group": "cl import from '.ui.button-group' {\n    ButtonGroup, ButtonGroupText\n}\ncl import from .ui.button { Button }\n\n<ButtonGroup>\n    <Button variant='outline'>Left</Button>\n    <Button variant='outline'>Center</Button>\n    <Button variant='outline'>Right</Button>\n</ButtonGroup>",
    "button-group-addon": "cl import from '.ui.button-group' {\n    ButtonGroup, ButtonGroupText\n}\n\n<ButtonGroup>\n    <ButtonGroupText>https://</ButtonGroupText>\n    <Input placeholder='yoursite.com' />\n    <Button>Go</Button>\n</ButtonGroup>",
    "button-group-vertical": "cl import from '.ui.button-group' { ButtonGroup }\ncl import from .ui.button { Button }\n\n<ButtonGroup orientation='vertical'>\n    <Button variant='outline'>Top</Button>\n    <Button variant='outline'>Middle</Button>\n    <Button variant='outline'>Bottom</Button>\n</ButtonGroup>",
    "item": "cl import from .ui.item {\n    Item, ItemGroup, ItemContent,\n    ItemTitle, ItemDescription, ItemActions\n}\n\n<ItemGroup>\n    <Item>\n        <ItemContent>\n            <ItemTitle>Alice Johnson</ItemTitle>\n            <ItemDescription>alice@example.com</ItemDescription>\n        </ItemContent>\n        <ItemActions>\n            <Badge variant='secondary'>Admin</Badge>\n        </ItemActions>\n    </Item>\n</ItemGroup>",
    "item-variants": "cl import from .ui.item { Item, ItemContent, ItemTitle }\n\n<Item variant='default'>\n    <ItemContent><ItemTitle>Default</ItemTitle></ItemContent>\n</Item>\n<Item variant='muted'>\n    <ItemContent><ItemTitle>Muted</ItemTitle></ItemContent>\n</Item>\n<Item variant='outline'>\n    <ItemContent><ItemTitle>Outline</ItemTitle></ItemContent>\n</Item>",
    "kbd": "cl import from .ui.kbd { Kbd, KbdGroup }\n\n<Kbd>K</Kbd>\n\n<KbdGroup>\n    <Kbd>Ctrl</Kbd>\n    <Kbd>Shift</Kbd>\n    <Kbd>P</Kbd>\n</KbdGroup>",
    "kbd-combinations": "cl import from .ui.kbd { Kbd, KbdGroup }\n\n<KbdGroup>\n    <Kbd>Ctrl</Kbd>\n    <Kbd>Shift</Kbd>\n    <Kbd>P</Kbd>\n</KbdGroup>",
    "separator": "cl import from .ui.separator { Separator }\n\n<Separator />\n\n<div className='flex items-center gap-4 h-8'>\n    <span>Left</span>\n    <Separator orientation='vertical' />\n    <span>Right</span>\n</div>",
    "separator-vertical": "cl import from .ui.separator { Separator }\n\n<div className='flex items-center gap-4 h-8'>\n    <span>Left</span>\n    <Separator orientation='vertical' />\n    <span>Center</span>\n    <Separator orientation='vertical' />\n    <span>Right</span>\n</div>",
    "toggle": "cl import from .ui.toggle { Toggle }\n\n<Toggle aria-label='Bold'>\n    <HugeiconsIcon icon={TextBoldIcon} size={16} />\n</Toggle>\n<Toggle variant='outline' aria-label='Italic'>\n    <HugeiconsIcon icon={TextItalicIcon} size={16} />\n</Toggle>",
    "toggle-disabled": "cl import from .ui.toggle { Toggle }\n\n<Toggle disabled={True} aria-label='Disabled'>\n    <HugeiconsIcon icon={TextUnderlineIcon}\n        size={16} />\n</Toggle>",
    "toggle-group": "cl import from '.ui.toggle-group' {\n    ToggleGroup, ToggleGroupItem\n}\n\n<ToggleGroup type='single' defaultValue='center'>\n    <ToggleGroupItem value='left'>Left</ToggleGroupItem>\n    <ToggleGroupItem value='center'>Center</ToggleGroupItem>\n    <ToggleGroupItem value='right'>Right</ToggleGroupItem>\n</ToggleGroup>",
    "toggle-group-multiple": "cl import from '.ui.toggle-group' {\n    ToggleGroup, ToggleGroupItem\n}\n\n<ToggleGroup type='multiple'\n    defaultValue={['bold', 'italic']}>\n    <ToggleGroupItem value='bold'>B</ToggleGroupItem>\n    <ToggleGroupItem value='italic'>I</ToggleGroupItem>\n    <ToggleGroupItem value='underline'>U</ToggleGroupItem>\n</ToggleGroup>",
    "toggle-group-outline": "cl import from '.ui.toggle-group' {\n    ToggleGroup, ToggleGroupItem\n}\n\n<ToggleGroup type='single' variant='outline'\n    defaultValue='center'>\n    <ToggleGroupItem value='left'>Left</ToggleGroupItem>\n    <ToggleGroupItem value='center'>Center</ToggleGroupItem>\n    <ToggleGroupItem value='right'>Right</ToggleGroupItem>\n</ToggleGroup>",
    "toggle-sizes": "cl import from .ui.toggle { Toggle }\n\n<Toggle size='sm'>Sm</Toggle>\n<Toggle size='default'>Default</Toggle>\n<Toggle size='lg'>Lg</Toggle>",
};

cl {
    def:pub SeparatorShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Separator"
                description="A visual divider between content sections."
                name="separator"
            />
            <ShowcaseSection title="Horizontal" className="flex-col w-full max-w-sm" code={_codeExamples["separator"]}>
                <div className="w-full space-y-2">
                    <p className="text-sm">Content above</p>
                    <Separator />
                    <p className="text-sm">Content below</p>
                </div>
            </ShowcaseSection>
            <ShowcaseSection title="Vertical" code={_codeExamples["separator-vertical"]}>
                <div className="flex items-center gap-4 h-8">
                    <span className="text-sm">Left</span>
                    <Separator orientation="vertical" />
                    <span className="text-sm">Center</span>
                    <Separator orientation="vertical" />
                    <span className="text-sm">Right</span>
                </div>
            </ShowcaseSection>
        </div>;
    }

    def:pub ToggleShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Toggle" description="A two-state button that can be either on or off." name="toggle" />
            <ShowcaseSection title="Variants" className="flex-wrap gap-3" code={_codeExamples["toggle"]}>
                <Toggle aria-label="Bold">
                    <HugeiconsIcon icon={TextBoldIcon} size={16} />
                </Toggle>
                <Toggle variant="outline" aria-label="Italic">
                    <HugeiconsIcon icon={TextItalicIcon} size={16} />
                </Toggle>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Sizes" className="flex-wrap gap-3" code={_codeExamples["toggle-sizes"]}>
                <Toggle size="sm" aria-label="Small">Sm</Toggle>
                <Toggle size="default" aria-label="Default">Default</Toggle>
                <Toggle size="lg" aria-label="Large">Lg</Toggle>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Disabled" code={_codeExamples["toggle-disabled"]}>
                <Toggle disabled={True} aria-label="Disabled">
                    <HugeiconsIcon icon={TextUnderlineIcon} size={16} />
                </Toggle>
            </ShowcaseSection>
        </div>;
    }

    def:pub ToggleGroupShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Toggle Group" description="A set of two-state buttons that can be toggled on or off." name="toggle-group" />
            <ShowcaseSection title="Single" code={_codeExamples["toggle-group"]}>
                <ToggleGroup type="single" defaultValue="center">
                    <ToggleGroupItem value="left" aria-label="Align left">
                        <HugeiconsIcon icon={TextAlignLeftIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="center" aria-label="Align center">
                        <HugeiconsIcon icon={TextAlignCenterIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="right" aria-label="Align right">
                        <HugeiconsIcon icon={TextAlignRightIcon} size={16} />
                    </ToggleGroupItem>
                </ToggleGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Multiple" code={_codeExamples["toggle-group-multiple"]}>
                <ToggleGroup type="multiple" defaultValue={["bold", "italic"]}>
                    <ToggleGroupItem value="bold" aria-label="Bold">
                        <HugeiconsIcon icon={TextBoldIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="italic" aria-label="Italic">
                        <HugeiconsIcon icon={TextItalicIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="underline" aria-label="Underline">
                        <HugeiconsIcon icon={TextUnderlineIcon} size={16} />
                    </ToggleGroupItem>
                </ToggleGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Outline Variant" code={_codeExamples["toggle-group-outline"]}>
                <ToggleGroup type="single" variant="outline" defaultValue="center">
                    <ToggleGroupItem value="left" aria-label="Align left">
                        <HugeiconsIcon icon={TextAlignLeftIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="center" aria-label="Align center">
                        <HugeiconsIcon icon={TextAlignCenterIcon} size={16} />
                    </ToggleGroupItem>
                    <ToggleGroupItem value="right" aria-label="Align right">
                        <HugeiconsIcon icon={TextAlignRightIcon} size={16} />
                    </ToggleGroupItem>
                </ToggleGroup>
            </ShowcaseSection>
        </div>;
    }

    def:pub ButtonGroupShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Button Group" description="A group of buttons that are visually connected." name="button-group" />
            <ShowcaseSection title="Default" code={_codeExamples["button-group"]}>
                <ButtonGroup>
                    <Button variant="outline">Left</Button>
                    <Button variant="outline">Center</Button>
                    <Button variant="outline">Right</Button>
                </ButtonGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="With Text Addon" code={_codeExamples["button-group-addon"]}>
                <ButtonGroup>
                    <ButtonGroupText>https://</ButtonGroupText>
                    <Input placeholder="yoursite.com" className="w-48" />
                    <Button>Go</Button>
                </ButtonGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Vertical" code={_codeExamples["button-group-vertical"]}>
                <ButtonGroup orientation="vertical">
                    <Button variant="outline">Top</Button>
                    <Button variant="outline">Middle</Button>
                    <Button variant="outline">Bottom</Button>
                </ButtonGroup>
            </ShowcaseSection>
        </div>;
    }

    def:pub KbdShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Kbd" description="Keyboard shortcut display component." name="kbd" />
            <ShowcaseSection title="Single Keys" className="flex-wrap gap-3 items-center" code={_codeExamples["kbd"]}>
                <Kbd>⌘</Kbd>
                <Kbd>K</Kbd>
                <Kbd>Enter</Kbd>
                <Kbd>Esc</Kbd>
                <Kbd>Tab</Kbd>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Combinations" className="flex-wrap gap-4 items-center" code={_codeExamples["kbd-combinations"]}>
                <KbdGroup>
                    <Kbd>⌘</Kbd>
                    <Kbd>K</Kbd>
                </KbdGroup>
                <KbdGroup>
                    <Kbd>Ctrl</Kbd>
                    <Kbd>Shift</Kbd>
                    <Kbd>P</Kbd>
                </KbdGroup>
                <KbdGroup>
                    <Kbd>⌥</Kbd>
                    <Kbd>Enter</Kbd>
                </KbdGroup>
            </ShowcaseSection>
        </div>;
    }

    def:pub ItemShowcase() -> JsxElement {
        users = [
            {"name": "Alice Johnson", "email": "alice@example.com", "role": "Admin"},
            {"name": "Bob Smith", "email": "bob@example.com", "role": "Editor"},
            {"name": "Carol White", "email": "carol@example.com", "role": "Viewer"}
        ];
        return <div className="space-y-8">
            <ShowcaseHeader title="Item" description="A flexible list item component with media, content, and actions." name="item" />
            <ShowcaseSection title="Default" className="flex-col w-full max-w-sm" code={_codeExamples["item"]}>
                <ItemGroup>
                    {users.map(lambda u: dict -> Any {
                        return <Item key={u["email"]}>
                            <ItemContent>
                                <ItemTitle>{u["name"]}</ItemTitle>
                                <ItemDescription>{u["email"]}</ItemDescription>
                            </ItemContent>
                            <ItemActions>
                                <Badge variant="secondary">{u["role"]}</Badge>
                            </ItemActions>
                        </Item>;
                    })}
                </ItemGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Variants" className="flex-col gap-2 w-full max-w-sm" code={_codeExamples["item-variants"]}>
                <Item variant="default"><ItemContent><ItemTitle>Default item</ItemTitle></ItemContent></Item>
                <Item variant="muted"><ItemContent><ItemTitle>Muted item</ItemTitle></ItemContent></Item>
                <Item variant="outline"><ItemContent><ItemTitle>Outline item</ItemTitle></ItemContent></Item>
            </ShowcaseSection>
        </div>;
    }

}

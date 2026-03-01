cl import from ..ui.button { Button, buttonVariants }
cl import from ..ui.input { Input }
cl import from "..ui.input-group" { InputGroup }
cl import from ..ui.textarea { Textarea }
cl import from ..ui.select { Select, SelectContent, SelectGroup, SelectItem, SelectTrigger, SelectValue }
cl import from ..ui.combobox { Combobox, ComboboxContent, ComboboxEmpty, ComboboxInput, ComboboxItem, ComboboxList }
cl import from ..ui.field { Field, FieldGroup, FieldLabel }
cl import from ..ui.label { Label }
cl import from ..ui.separator { Separator }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { ArrowRight01Icon, ArrowDownIcon, ArrowUpIcon, PlusSignIcon, DownloadIcon, MailIcon, SearchIcon, SettingsIcon, UserIcon, Copy01Icon, Tick01Icon, TextAlignLeftIcon, TextAlignCenterIcon, TextAlignRightIcon, TextBoldIcon, TextItalicIcon, TextUnderlineIcon }
cl import from ..ui.empty { Empty, EmptyHeader, EmptyMedia, EmptyTitle, EmptyDescription, EmptyContent }
cl import from "..ui.native-select" { NativeSelect, NativeSelectOption }
cl import from ..ui.item { Item, ItemGroup, ItemMedia, ItemContent, ItemTitle, ItemDescription, ItemActions, ItemSeparator }
cl import from "..ui.otp-input" { InputOTP, InputOTPGroup, InputOTPSlot, InputOTPSeparator }
cl import from ".shared" { ShowcaseSection, ShowcaseHeader }

glob _frameworks: list = ["Next.js", "SvelteKit", "Nuxt.js", "Remix", "Astro"];

glob _codeExamples: dict = {
    "combobox": "cl import from .ui.combobox {\n    Combobox, ComboboxContent, ComboboxEmpty,\n    ComboboxInput, ComboboxItem, ComboboxList\n}\n\nitems = ['Next.js', 'SvelteKit', 'Nuxt.js'];\n\n<Combobox items={items}>\n    <ComboboxInput placeholder='Search...' />\n    <ComboboxContent>\n        <ComboboxEmpty>No results.</ComboboxEmpty>\n        <ComboboxList>\n            {lambda(item: Any) -> Any {\n                return <ComboboxItem value={item}>\n                    {item}\n                </ComboboxItem>;\n            }}\n        </ComboboxList>\n    </ComboboxContent>\n</Combobox>",
    "combobox-label": "cl import from .ui.field { Field, FieldLabel }\ncl import from .ui.combobox {\n    Combobox, ComboboxContent, ComboboxEmpty,\n    ComboboxInput, ComboboxItem, ComboboxList\n}\n\n<Field>\n    <FieldLabel>Framework</FieldLabel>\n    <Combobox items={items}>\n        <ComboboxInput placeholder='Select...' />\n        <ComboboxContent>\n            <ComboboxEmpty>No results.</ComboboxEmpty>\n            <ComboboxList>\n                {lambda(item: Any) -> Any {\n                    return <ComboboxItem value={item}>\n                        {item}\n                    </ComboboxItem>;\n                }}\n            </ComboboxList>\n        </ComboboxContent>\n    </Combobox>\n</Field>",
    "field": "cl import from .ui.field { Field, FieldGroup, FieldLabel }\ncl import from .ui.input { Input }\n\n<FieldGroup>\n    <Field>\n        <FieldLabel htmlFor='name'>Name</FieldLabel>\n        <Input id='name' placeholder='Enter name' />\n    </Field>\n    <Field>\n        <FieldLabel htmlFor='email'>Email</FieldLabel>\n        <Input id='email' type='email' />\n    </Field>\n</FieldGroup>",
    "field-horizontal": "cl import from .ui.field { Field }\ncl import from .ui.button { Button }\n\n<Field orientation='horizontal'>\n    <Button>Submit</Button>\n    <Button variant='outline'>Cancel</Button>\n</Field>",
    "input": "cl import from .ui.input { Input }\n\n<Input placeholder='Type something...' />\n<Input type='email' placeholder='Email' />\n<Input disabled={True} />",
    "input-disabled": "<Input placeholder='Disabled' disabled={True} />",
    "input-group": "cl import from '.ui.input-group' { InputGroup }\ncl import from .ui.input { Input }\ncl import from .ui.button { Button }\n\n<InputGroup>\n    <Input placeholder='Search...' />\n    <Button>Go</Button>\n</InputGroup>",
    "input-group-email": "cl import from '.ui.input-group' { InputGroup }\ncl import from .ui.input { Input }\ncl import from .ui.button { Button }\n\n<InputGroup>\n    <Input placeholder='Enter your email'\n        type='email' />\n    <Button>Subscribe</Button>\n</InputGroup>",
    "input-label": "cl import from .ui.field { Field, FieldLabel }\ncl import from .ui.input { Input }\n\n<Field>\n    <FieldLabel htmlFor='email'>Email</FieldLabel>\n    <Input id='email' type='email'\n        placeholder='you@example.com' />\n</Field>",
    "input-otp": "cl import from '.ui.otp-input' {\n    InputOTP, InputOTPGroup,\n    InputOTPSlot, InputOTPSeparator\n}\n\n<InputOTP maxLength={6}>\n    <InputOTPGroup>\n        <InputOTPSlot index={0} />\n        <InputOTPSlot index={1} />\n        <InputOTPSlot index={2} />\n    </InputOTPGroup>\n    <InputOTPSeparator />\n    <InputOTPGroup>\n        <InputOTPSlot index={3} />\n        <InputOTPSlot index={4} />\n        <InputOTPSlot index={5} />\n    </InputOTPGroup>\n</InputOTP>",
    "label": "cl import from .ui.label { Label }\ncl import from .ui.input { Input }\n\n<Label htmlFor='username'>Username</Label>\n<Input id='username' placeholder='Enter username' />",
    "native-select": "cl import from '.ui.native-select' {\n    NativeSelect, NativeSelectOption\n}\n\n<NativeSelect>\n    <NativeSelectOption value=''>Select...</NativeSelectOption>\n    <NativeSelectOption value='apple'>Apple</NativeSelectOption>\n    <NativeSelectOption value='banana'>Banana</NativeSelectOption>\n</NativeSelect>",
    "native-select-disabled": "<NativeSelect disabled={True}>\n    <NativeSelectOption value=''>\n        Disabled select\n    </NativeSelectOption>\n</NativeSelect>",
    "native-select-small": "cl import from '.ui.native-select' {\n    NativeSelect, NativeSelectOption\n}\n\n<NativeSelect size='sm'>\n    <NativeSelectOption value=''>Small...</NativeSelectOption>\n    <NativeSelectOption value='a'>Option A</NativeSelectOption>\n    <NativeSelectOption value='b'>Option B</NativeSelectOption>\n</NativeSelect>",
    "select": "cl import from .ui.select {\n    Select, SelectContent, SelectGroup,\n    SelectItem, SelectTrigger, SelectValue\n}\n\n<Select>\n    <SelectTrigger>\n        <SelectValue placeholder='Pick an option' />\n    </SelectTrigger>\n    <SelectContent>\n        <SelectGroup>\n            <SelectItem value='opt1'>Option 1</SelectItem>\n            <SelectItem value='opt2'>Option 2</SelectItem>\n        </SelectGroup>\n    </SelectContent>\n</Select>",
    "select-label": "cl import from .ui.field { Field, FieldLabel }\ncl import from .ui.select {\n    Select, SelectContent, SelectGroup,\n    SelectItem, SelectTrigger, SelectValue\n}\n\n<Field>\n    <FieldLabel>Role</FieldLabel>\n    <Select>\n        <SelectTrigger>\n            <SelectValue placeholder='Select role' />\n        </SelectTrigger>\n        <SelectContent>\n            <SelectGroup>\n                <SelectItem value='dev'>Developer</SelectItem>\n                <SelectItem value='design'>Designer</SelectItem>\n            </SelectGroup>\n        </SelectContent>\n    </Select>\n</Field>",
    "textarea": "cl import from .ui.textarea { Textarea }\n\n<Textarea placeholder='Write your message...' />\n<Textarea disabled={True} />",
    "textarea-disabled": "<Textarea placeholder='Disabled'\n    disabled={True} />",
    "textarea-label": "cl import from .ui.field { Field, FieldLabel }\ncl import from .ui.textarea { Textarea }\n\n<Field>\n    <FieldLabel htmlFor='bio'>Bio</FieldLabel>\n    <Textarea id='bio'\n        placeholder='Tell us about yourself...' />\n</Field>",
};

cl {
    def:pub InputShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Input"
                description="A text input field for user data entry."
                name="input"
            />
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm" code={_codeExamples["input"]}>
                <Input placeholder="Type something..." />
            </ShowcaseSection>
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm" code={_codeExamples["input-label"]}>
                <Field>
                    <FieldLabel htmlFor="email-input">Email</FieldLabel>
                    <Input id="email-input" type="email" placeholder="you@example.com" />
                </Field>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled" className="flex-col items-start max-w-sm" code={_codeExamples["input-disabled"]}>
                <Input placeholder="Disabled input" disabled={True} />
            </ShowcaseSection>
        </div>;
    }

    def:pub TextareaShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Textarea"
                description="A multi-line text input area."
                name="textarea"
            />
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm" code={_codeExamples["textarea"]}>
                <Textarea placeholder="Write your message here..." />
            </ShowcaseSection>
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm" code={_codeExamples["textarea-label"]}>
                <Field>
                    <FieldLabel htmlFor="bio-textarea">Bio</FieldLabel>
                    <Textarea id="bio-textarea" placeholder="Tell us about yourself..." />
                </Field>
            </ShowcaseSection>
            <ShowcaseSection title="Disabled" className="flex-col items-start max-w-sm" code={_codeExamples["textarea-disabled"]}>
                <Textarea placeholder="Disabled textarea" disabled={True} />
            </ShowcaseSection>
        </div>;
    }

    def:pub SelectShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Select"
                description="A dropdown for selecting from a list of options."
                name="select"
            />
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm" code={_codeExamples["select"]}>
                <Select>
                    <SelectTrigger>
                        <SelectValue placeholder="Select a framework" />
                    </SelectTrigger>
                    <SelectContent>
                        <SelectGroup>
                            <SelectItem value="nextjs">Next.js</SelectItem>
                            <SelectItem value="svelte">SvelteKit</SelectItem>
                            <SelectItem value="nuxt">Nuxt.js</SelectItem>
                            <SelectItem value="remix">Remix</SelectItem>
                            <SelectItem value="astro">Astro</SelectItem>
                        </SelectGroup>
                    </SelectContent>
                </Select>
            </ShowcaseSection>
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm" code={_codeExamples["select-label"]}>
                <Field>
                    <FieldLabel>Role</FieldLabel>
                    <Select defaultValue="">
                        <SelectTrigger>
                            <SelectValue placeholder="Select a role" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectGroup>
                                <SelectItem value="developer">Developer</SelectItem>
                                <SelectItem value="designer">Designer</SelectItem>
                                <SelectItem value="manager">Manager</SelectItem>
                            </SelectGroup>
                        </SelectContent>
                    </Select>
                </Field>
            </ShowcaseSection>
        </div>;
    }

    def:pub ComboboxShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Combobox"
                description="An input with searchable dropdown for autocomplete."
                name="combobox"
            />
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm" code={_codeExamples["combobox"]}>
                <Combobox items={_frameworks}>
                    <ComboboxInput placeholder="Search frameworks..." />
                    <ComboboxContent>
                        <ComboboxEmpty>No frameworks found.</ComboboxEmpty>
                        <ComboboxList>
                            {lambda(item: Any) -> Any {
                                return <ComboboxItem key={item} value={item}>{item}</ComboboxItem>;
                            }}
                        </ComboboxList>
                    </ComboboxContent>
                </Combobox>
            </ShowcaseSection>
            <ShowcaseSection title="With Label" className="flex-col items-start max-w-sm" code={_codeExamples["combobox-label"]}>
                <Field>
                    <FieldLabel>Framework</FieldLabel>
                    <Combobox items={_frameworks}>
                        <ComboboxInput placeholder="Select a framework" />
                        <ComboboxContent>
                            <ComboboxEmpty>No frameworks found.</ComboboxEmpty>
                            <ComboboxList>
                                {lambda(item: Any) -> Any {
                                    return <ComboboxItem key={item} value={item}>{item}</ComboboxItem>;
                                }}
                            </ComboboxList>
                        </ComboboxContent>
                    </Combobox>
                </Field>
            </ShowcaseSection>
        </div>;
    }

    def:pub FieldShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Field"
                description="A form field container with label and validation support."
                name="field"
            />
            <ShowcaseSection title="Field Group" className="flex-col items-start max-w-sm" code={_codeExamples["field"]}>
                <FieldGroup>
                    <Field>
                        <FieldLabel htmlFor="fg-name">Name</FieldLabel>
                        <Input id="fg-name" placeholder="Enter your name" />
                    </Field>
                    <Field>
                        <FieldLabel htmlFor="fg-email">Email</FieldLabel>
                        <Input id="fg-email" type="email" placeholder="you@example.com" />
                    </Field>
                    <Field>
                        <FieldLabel htmlFor="fg-bio">Bio</FieldLabel>
                        <Textarea id="fg-bio" placeholder="Tell us about yourself..." />
                    </Field>
                </FieldGroup>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Horizontal" className="flex-col items-start max-w-sm" code={_codeExamples["field-horizontal"]}>
                <Field orientation="horizontal">
                    <Button>Submit</Button>
                    <Button variant="outline">Cancel</Button>
                </Field>
            </ShowcaseSection>
        </div>;
    }

    def:pub InputGroupShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Input Group"
                description="Combine inputs and buttons into a single visual group."
                name="input-group"
            />
            <ShowcaseSection title="Search" className="flex-col items-start max-w-sm" code={_codeExamples["input-group"]}>
                <InputGroup>
                    <Input placeholder="Search..." />
                    <Button>
                        <HugeiconsIcon icon={SearchIcon} strokeWidth={2} />
                    </Button>
                </InputGroup>
            </ShowcaseSection>
            <ShowcaseSection title="Email Subscribe" className="flex-col items-start max-w-sm" code={_codeExamples["input-group-email"]}>
                <InputGroup>
                    <Input placeholder="Enter your email" type="email" />
                    <Button>Subscribe</Button>
                </InputGroup>
            </ShowcaseSection>
        </div>;
    }

    def:pub LabelShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader
                title="Label"
                description="A text label associated with a form control."
                name="label"
            />
            <ShowcaseSection title="Default" className="flex-col items-start max-w-sm" code={_codeExamples["label"]}>
                <Label htmlFor="label-demo">Username</Label>
                <Input id="label-demo" placeholder="Enter username" />
            </ShowcaseSection>
        </div>;
    }

    def:pub NativeSelectShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Native Select" description="A styled native HTML select element." name="native-select" />
            <ShowcaseSection title="Default" code={_codeExamples["native-select"]}>
                <NativeSelect>
                    <NativeSelectOption value="">Select a fruit...</NativeSelectOption>
                    <NativeSelectOption value="apple">Apple</NativeSelectOption>
                    <NativeSelectOption value="banana">Banana</NativeSelectOption>
                    <NativeSelectOption value="cherry">Cherry</NativeSelectOption>
                    <NativeSelectOption value="date">Date</NativeSelectOption>
                </NativeSelect>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Small" code={_codeExamples["native-select-small"]}>
                <NativeSelect size="sm">
                    <NativeSelectOption value="">Small select...</NativeSelectOption>
                    <NativeSelectOption value="a">Option A</NativeSelectOption>
                    <NativeSelectOption value="b">Option B</NativeSelectOption>
                </NativeSelect>
            </ShowcaseSection>
            <Separator />
            <ShowcaseSection title="Disabled" code={_codeExamples["native-select-disabled"]}>
                <NativeSelect disabled={True}>
                    <NativeSelectOption value="">Disabled select</NativeSelectOption>
                </NativeSelect>
            </ShowcaseSection>
        </div>;
    }

    def:pub InputOTPShowcase() -> JsxElement {
        return <div className="space-y-8">
            <ShowcaseHeader title="Input OTP" description="Accessible one-time password component." name="input-otp" />
            <ShowcaseSection title="Default" code={_codeExamples["input-otp"]}>
                <InputOTP maxLength={6}>
                    <InputOTPGroup>
                        <InputOTPSlot index={0} />
                        <InputOTPSlot index={1} />
                        <InputOTPSlot index={2} />
                    </InputOTPGroup>
                    <InputOTPSeparator />
                    <InputOTPGroup>
                        <InputOTPSlot index={3} />
                        <InputOTPSlot index={4} />
                        <InputOTPSlot index={5} />
                    </InputOTPGroup>
                </InputOTP>
            </ShowcaseSection>
        </div>;
    }

}

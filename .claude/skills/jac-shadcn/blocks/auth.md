# Auth blocks (login + signup + reset)

> **First, check `examples/` for the official shadcn registry blocks.** `examples/login-01/`, `examples/login-03/`, and `examples/signup-01/` are direct conversions from the shadcn/ui v4 registry — they are the canonical reference. Use those for standard sign-in/sign-up flows. The variants below describe alternative layouts (split-with-image, modal, magic-link) where you need something the registry doesn't cover.

## When to use

Sign-in, sign-up, forgot-password, magic-link, and verification pages. Any standalone screen whose only job is to collect a small set of credentials and authenticate the user. Auth pages are **not** marketing sections — they don't use `pt-24 pb-24` hero rhythm, they don't have eyebrows, and they don't try to sell. One card, centered, minimum chrome.

## Components used

- `Card` + `CardHeader` + `CardTitle` + `CardDescription` + `CardContent` + `CardFooter`
- `Field` + `FieldLabel` + `FieldDescription` + `FieldError`
- `Input`
- `Button` (variants `default` for primary submit, `outline` for SSO)
- `Separator` (with "Or continue with" label)
- `Checkbox` (terms acceptance on signup)
- `HugeiconsIcon` (`GithubIcon`, `GoogleIcon`, `AppleIcon` for SSO)

---

## Variant 1: Centered Card login (default)

### Layout intent

Full-viewport-height wrapper centers a single narrow card. Card width caps at `max-w-sm` — auth forms are narrow on purpose; `max-w-md` already feels too wide for an email + password pair. Title is sentence-case `text-2xl` (CardTitle default — never bump it up). Submit is `w-full`. Below the credential block, an "Or continue with" divider, then SSO buttons that all use `variant="outline"` — the brand icon does the recognition work, no hardcoded brand colors.

### Jac code

```jac
cl import from ..ui.card { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter }
cl import from ..ui.field { Field, FieldLabel }
cl import from ..ui.input { Input }
cl import from ..ui.button { Button }
cl import from ..ui.separator { Separator }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { GithubIcon, GoogleIcon }

cl {
    def:pub LoginPage(props: Any) -> JsxElement {
        return <div className="flex min-h-svh items-center justify-center pt-12 pb-12 pl-4 pr-4">
            <Card className="w-full max-w-sm">
                <CardHeader>
                    <CardTitle className="text-2xl">Sign in</CardTitle>
                    <CardDescription>Enter your email to access your account.</CardDescription>
                </CardHeader>
                <CardContent>
                    <form className="flex flex-col gap-6">
                        <Field>
                            <FieldLabel htmlFor="email">Email</FieldLabel>
                            <Input id="email" type="email" placeholder="m@example.com" required />
                        </Field>
                        <Field>
                            <div className="flex items-center">
                                <FieldLabel htmlFor="password">Password</FieldLabel>
                                <a href="/forgot" className="ml-auto text-sm underline-offset-4 hover:underline">
                                    {"Forgot your password?"}
                                </a>
                            </div>
                            <Input id="password" type="password" required />
                        </Field>
                        <Button type="submit" className="w-full">Sign in</Button>
                        <div className="relative">
                            <Separator />
                            <span className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 bg-card pl-2 pr-2 text-xs uppercase text-muted-foreground">
                                Or continue with
                            </span>
                        </div>
                        <div className="flex flex-col gap-2">
                            <Button variant="outline" type="button" className="w-full gap-2">
                                <HugeiconsIcon icon={GithubIcon} strokeWidth={2} className="size-4" />
                                Continue with GitHub
                            </Button>
                            <Button variant="outline" type="button" className="w-full gap-2">
                                <HugeiconsIcon icon={GoogleIcon} strokeWidth={2} className="size-4" />
                                Continue with Google
                            </Button>
                        </div>
                    </form>
                </CardContent>
                <CardFooter>
                    <p className="w-full text-center text-sm text-muted-foreground">
                        {"Don't have an account?"} <a href="/signup" className="text-foreground underline-offset-4 hover:underline">Sign up</a>
                    </p>
                </CardFooter>
            </Card>
        </div>;
    }
}
```

---

## Variant 2: Split-screen login (text/image left, form right)

### Layout intent

Two-column grid only at `lg+` (`grid lg:grid-cols-2`). Left column is hidden below `lg` and contains an image with optional overlay copy at bottom-left — the form column is always visible and identical to Variant 1. The form column uses the same centered-card structure so collapsing to one column on mobile drops you into Variant 1's layout for free.

### Jac code

```jac
cl {
    def:pub SplitLoginPage(props: Any) -> JsxElement {
        return <div className="grid min-h-svh lg:grid-cols-2">
            <div className="hidden bg-muted lg:block relative">
                <img
                    src="/auth-cover.jpg"
                    alt=""
                    className="absolute inset-0 size-full object-cover"
                />
                <div className="absolute bottom-10 left-10 right-10 text-foreground">
                    <p className="text-lg font-semibold">Build full-stack apps in Jac.</p>
                    <p className="mt-2 text-sm text-muted-foreground">
                        One language, one runtime, zero boilerplate.
                    </p>
                </div>
            </div>
            <div className="flex items-center justify-center pt-12 pb-12 pl-4 pr-4">
                <Card className="w-full max-w-sm">
                    <CardHeader>
                        <CardTitle className="text-2xl">Welcome back</CardTitle>
                        <CardDescription>Sign in to continue to your workspace.</CardDescription>
                    </CardHeader>
                    <CardContent>
                        <form className="flex flex-col gap-6">
                            <Field>
                                <FieldLabel htmlFor="email">Email</FieldLabel>
                                <Input id="email" type="email" placeholder="m@example.com" required />
                            </Field>
                            <Field>
                                <FieldLabel htmlFor="password">Password</FieldLabel>
                                <Input id="password" type="password" required />
                            </Field>
                            <Button type="submit" className="w-full">Sign in</Button>
                        </form>
                    </CardContent>
                </Card>
            </div>
        </div>;
    }
}
```

---

## Variant 3: Signup with terms checkbox

### Layout intent

Same skeleton as Variant 1 but with a name field at the top, a confirm-password field after password, and a horizontal Field row containing a Checkbox + label that links out to `/terms` and `/privacy`. The terms label uses `text-sm font-normal` so it reads as body copy rather than a form label. Submit text changes to "Create account". Footer flips to "Already have an account? Sign in".

### Jac code

```jac
cl import from ..ui.checkbox { Checkbox }

cl {
    def:pub SignupPage(props: Any) -> JsxElement {
        has agreed: bool = False;
        return <div className="flex min-h-svh items-center justify-center pt-12 pb-12 pl-4 pr-4">
            <Card className="w-full max-w-sm">
                <CardHeader>
                    <CardTitle className="text-2xl">Create your account</CardTitle>
                    <CardDescription>It only takes a minute. No credit card required.</CardDescription>
                </CardHeader>
                <CardContent>
                    <form className="flex flex-col gap-6">
                        <Field>
                            <FieldLabel htmlFor="name">Full name</FieldLabel>
                            <Input id="name" type="text" placeholder="Ada Lovelace" required />
                        </Field>
                        <Field>
                            <FieldLabel htmlFor="email">Email</FieldLabel>
                            <Input id="email" type="email" placeholder="m@example.com" required />
                        </Field>
                        <Field>
                            <FieldLabel htmlFor="password">Password</FieldLabel>
                            <Input id="password" type="password" required />
                        </Field>
                        <Field>
                            <FieldLabel htmlFor="confirm">Confirm password</FieldLabel>
                            <Input id="confirm" type="password" required />
                        </Field>
                        <Field orientation="horizontal">
                            <Checkbox id="terms" checked={agreed} onCheckedChange={lambda(v: Any) -> None { agreed = Boolean(v); }} />
                            <FieldLabel htmlFor="terms" className="text-sm font-normal">
                                I agree to the <a href="/terms" className="underline">Terms</a> and <a href="/privacy" className="underline">Privacy Policy</a>
                            </FieldLabel>
                        </Field>
                        <Button type="submit" className="w-full" disabled={agreed == False}>Create account</Button>
                    </form>
                </CardContent>
                <CardFooter>
                    <p className="w-full text-center text-sm text-muted-foreground">
                        Already have an account? <a href="/login" className="text-foreground underline-offset-4 hover:underline">Sign in</a>
                    </p>
                </CardFooter>
            </Card>
        </div>;
    }
}
```

---

## Variant 4: Forgot-password / magic-link

### Layout intent

Stripped-down version of Variant 1 — just the email field and submit. Title `Reset your password` (or `Sign in with a magic link`), description explains what arrives in their inbox. After submit, swap the card content for a confirmation state showing "Check your email" so the page never navigates away.

### Jac code

```jac
cl {
    def:pub ForgotPasswordPage(props: Any) -> JsxElement {
        has submitted: bool = False;
        return <div className="flex min-h-svh items-center justify-center pt-12 pb-12 pl-4 pr-4">
            <Card className="w-full max-w-sm">
                <CardHeader>
                    <CardTitle className="text-2xl">Reset your password</CardTitle>
                    <CardDescription>
                        {"We'll send you a link to reset it."}
                    </CardDescription>
                </CardHeader>
                <CardContent>
                    {submitted == True
                        ? <p className="text-sm text-muted-foreground">
                            Check your email for the reset link. It expires in 30 minutes.
                          </p>
                        : <form className="flex flex-col gap-6" onSubmit={lambda(e: Any) -> None { e.preventDefault(); submitted = True; }}>
                            <Field>
                                <FieldLabel htmlFor="email">Email</FieldLabel>
                                <Input id="email" type="email" placeholder="m@example.com" required />
                            </Field>
                            <Button type="submit" className="w-full">Send reset link</Button>
                          </form>}
                </CardContent>
                <CardFooter>
                    <p className="w-full text-center text-sm text-muted-foreground">
                        Remembered it? <a href="/login" className="text-foreground underline-offset-4 hover:underline">Sign in</a>
                    </p>
                </CardFooter>
            </Card>
        </div>;
    }
}
```

---

## Common mistakes specific to auth blocks

- **Using marketing-section padding**: `pt-24 pb-24` belongs on hero/feature sections. Auth pages center a card in `min-h-svh` instead. No section padding, no eyebrow Badge, no `tracking-tight` headlines.
- **`max-w-md` Card**: a touch wide for auth — use `max-w-sm`. The narrower card focuses the eye on the credential pair.
- **Forgetting `className="w-full"` on the submit button**: a mid-width button inside a narrow card looks unfinished. Submit always spans full card width.
- **Forgetting `type="submit"` on the form button**: without it the form won't submit on Enter.
- **Hardcoded brand colors on SSO buttons**: never `bg-blue-600` for Google, `bg-black` for GitHub. Use `variant="outline"` — the icon supplies brand recognition; the button stays neutral.
- **Hardcoded primary on Submit**: never `bg-orange-500` or `bg-blue-600`. Default `Button` already paints `bg-primary text-primary-foreground` from semantic tokens.
- **Raw `<div className="space-y-4">` for form layout**: use `flex flex-col gap-6` or wrap in `FieldGroup`. `space-y-*` doesn't compose with adjacent gap utilities cleanly.
- **Raw `<label>` + `<input>` instead of `Field` + `FieldLabel`**: `Field` handles the htmlFor wiring, error styling, and orientation variants. Don't reinvent it. (See [forms.md](../rules/forms.md).)
- **Marketing-style ALL CAPS titles**: `Sign in` not `SIGN IN`. CardTitle's default `text-2xl font-semibold` is the right size — don't bump it up.
- **Missing footer link to switch between sign-in and sign-up**: every auth page has its mirror; the footer link is mandatory. `text-sm text-muted-foreground` paragraph; the link itself is `text-foreground underline-offset-4 hover:underline`.
- **Plain text "Forgot password?" instead of a link**: place inside the password label row using `ml-auto` and style as `text-sm underline-offset-4 hover:underline`.
- **Putting "Forgot password?" below the password input**: belongs in the label row beside the "Password" label — discoverable while the user is reading the field, not after they've typed.
- **JSX-bare apostrophes / question marks**: `Don't have an account?` raw inside JSX breaks the parser. Wrap in `{"Don't have an account?"}`. Same for `We'll`, `you're`, `Forgot your password?`.
- **`{!!agreed}`**: not valid Jac. Use `{Boolean(agreed)}` (or compare explicitly: `agreed == True`).
- **Lowercase `true`/`false`/`null`**: must be `True`, `False`, `None`.
- **JSX comments inside the form** (`{/* ... */}` or `# ...`): both crash the Jac compiler. Document layout intent in surrounding `.jac` comments, never inside JSX.
- **`tracking-wide` or `uppercase` on the title**: that's an eyebrow style; titles stay sentence-case.

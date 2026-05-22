"""Signup-01 — official shadcn registry block. Card with full name + email + password + confirm + Google SSO."""

cl import from ..ui.button { Button }
cl import from ..ui.card { Card, CardContent, CardDescription, CardHeader, CardTitle }
cl import from ..ui.field { Field, FieldDescription, FieldGroup, FieldLabel }
cl import from ..ui.input { Input }

cl {
    def:pub SignupForm(props: Any) -> JsxElement {
        return <Card>
            <CardHeader>
                <CardTitle>Create an account</CardTitle>
                <CardDescription>
                    Enter your information below to create your account
                </CardDescription>
            </CardHeader>
            <CardContent>
                <form>
                    <FieldGroup>
                        <Field>
                            <FieldLabel htmlFor="name">Full Name</FieldLabel>
                            <Input id="name" type="text" placeholder="John Doe" required={True} />
                        </Field>
                        <Field>
                            <FieldLabel htmlFor="email">Email</FieldLabel>
                            <Input
                                id="email"
                                type="email"
                                placeholder="m@example.com"
                                required={True}
                            />
                            <FieldDescription>
                                {"We'll use this to contact you. We will not share your email with anyone else."}
                            </FieldDescription>
                        </Field>
                        <Field>
                            <FieldLabel htmlFor="password">Password</FieldLabel>
                            <Input id="password" type="password" required={True} />
                            <FieldDescription>
                                Must be at least 8 characters long.
                            </FieldDescription>
                        </Field>
                        <Field>
                            <FieldLabel htmlFor="confirm-password">Confirm Password</FieldLabel>
                            <Input id="confirm-password" type="password" required={True} />
                            <FieldDescription>Please confirm your password.</FieldDescription>
                        </Field>
                        <FieldGroup>
                            <Field>
                                <Button type="submit">Create Account</Button>
                                <Button variant="outline" type="button">
                                    Sign up with Google
                                </Button>
                                <FieldDescription className="pl-6 pr-6 text-center">
                                    Already have an account? <a href="#">Sign in</a>
                                </FieldDescription>
                            </Field>
                        </FieldGroup>
                    </FieldGroup>
                </form>
            </CardContent>
        </Card>;
    }

    def:pub Signup01Page(props: Any) -> JsxElement {
        return <div className="flex min-h-svh w-full items-center justify-center pt-6 pb-6 pl-6 pr-6 md:pt-10 md:pb-10 md:pl-10 md:pr-10">
            <div className="w-full max-w-sm">
                <SignupForm />
            </div>
        </div>;
    }
}

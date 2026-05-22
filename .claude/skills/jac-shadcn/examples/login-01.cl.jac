"""Login-01 — official shadcn registry block. Minimal Card + email/password + Google SSO."""

cl import from ..ui.button { Button }
cl import from ..ui.card { Card, CardContent, CardDescription, CardHeader, CardTitle }
cl import from ..ui.field { Field, FieldDescription, FieldGroup, FieldLabel }
cl import from ..ui.input { Input }

cl {
    def:pub LoginForm(props: Any) -> JsxElement {
        return <div className="flex flex-col gap-6">
            <Card>
                <CardHeader>
                    <CardTitle>Login to your account</CardTitle>
                    <CardDescription>
                        Enter your email below to login to your account
                    </CardDescription>
                </CardHeader>
                <CardContent>
                    <form>
                        <FieldGroup>
                            <Field>
                                <FieldLabel htmlFor="email">Email</FieldLabel>
                                <Input
                                    id="email"
                                    type="email"
                                    placeholder="m@example.com"
                                    required={True}
                                />
                            </Field>
                            <Field>
                                <div className="flex items-center">
                                    <FieldLabel htmlFor="password">Password</FieldLabel>
                                    <a
                                        href="#"
                                        className="ml-auto inline-block text-sm underline-offset-4 hover:underline"
                                    >
                                        Forgot your password?
                                    </a>
                                </div>
                                <Input id="password" type="password" required={True} />
                            </Field>
                            <Field>
                                <Button type="submit">Login</Button>
                                <Button variant="outline" type="button">
                                    Login with Google
                                </Button>
                                <FieldDescription className="text-center">
                                    {"Don't have an account?"} <a href="#">Sign up</a>
                                </FieldDescription>
                            </Field>
                        </FieldGroup>
                    </form>
                </CardContent>
            </Card>
        </div>;
    }

    def:pub Login01Page(props: Any) -> JsxElement {
        return <div className="flex min-h-svh w-full items-center justify-center pt-6 pb-6 pl-6 pr-6 md:pt-10 md:pb-10 md:pl-10 md:pr-10">
            <div className="w-full max-w-sm">
                <LoginForm />
            </div>
        </div>;
    }
}

cl import from "...lib.utils" { cn }
cl import from "@hugeicons/react" { HugeiconsIcon }
cl import from "@hugeicons/core-free-icons" { Copy01Icon, Tick01Icon }



# ── Helpers for code display ──

glob _BS: str = String.fromCharCode(92);
glob _NL: str = String.fromCharCode(10);
glob _BSN: str = _BS + "n";
glob _WB: str = _BS + "b";

glob _processCode: Any = lambda(raw: str) -> str {
    return raw.split(_BSN).join(_NL);
};

glob _highlightJac: Any = lambda(source: str) -> str {
    lines = source.split(_NL);
    highlighted = lines.map(lambda(line: str) -> str {
        # 1 ─ Extract single-quoted strings → placeholders
        strings = [];
        work = line.replace(RegExp("'[^']*'", "g"), lambda(m: str) -> str {
            strings.push(m);
            return "___S" + String(strings.length - 1) + "___";
        });

        # 2 ─ Extract // comments → placeholders
        comments = [];
        work = work.replace(RegExp("//.*", "g"), lambda(m: str) -> str {
            comments.push(m);
            return "___C" + String(comments.length - 1) + "___";
        });

        # 3 ─ HTML-escape
        work = work.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        # 4 ─ Keywords
        work = work.replace(
            RegExp(_WB + "(cl|import|from|def|has|return|lambda|if|else|for|in|True|False|None|and|or|not|pub|glob|type|new|let|const|var)" + _WB, "g"),
            "<span class='hl-kw'>$&</span>"
        );

        # 5 ─ JSX component names (PascalCase after &lt; or &lt;/)
        work = work.replace(
            RegExp("(&lt;/?)([A-Z][a-zA-Z0-9]*)", "g"),
            "$1<span class='hl-tag'>$2</span>"
        );

        # 6 ─ HTML element names
        work = work.replace(
            RegExp("(&lt;/?)(div|span|p|button|label|h[1-6]|a|img|input|form|ul|li|defs|stop|linearGradient)" + _WB, "g"),
            "$1<span class='hl-el'>$2</span>"
        );

        # 7 ─ Restore comments with hl-cmt
        work = comments.reduce(
            lambda(acc: str, c: str, i: int) -> str {
                escaped = c.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
                return acc.replace("___C" + String(i) + "___", "<span class='hl-cmt'>" + escaped + "</span>");
            },
            work
        );

        # 8 ─ Restore strings with hl-str
        return strings.reduce(
            lambda(acc: str, s: str, i: int) -> str {
                escaped = s.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
                return acc.replace("___S" + String(i) + "___", "<span class='hl-str'>" + escaped + "</span>");
            },
            work
        );
    });
    return highlighted.join(_NL);
};


cl {
    def:pub CopyCommand(props: Any) -> JsxElement {
        has copied: bool = False;
        cmd = "jac add --shadcn " + props.name;

        return <div className="group flex items-center gap-2 rounded-lg border border-border/60 bg-muted/30 px-3 py-2.5 font-mono text-sm transition-colors hover:bg-muted/50">
            <span className="text-muted-foreground select-none text-xs">$</span>
            <code className="flex-1 text-foreground/80 text-xs">{cmd}</code>
            <button
                onClick={lambda -> None {
                    navigator.clipboard.writeText(cmd);
                    copied = True;
                    setTimeout(lambda -> None { copied = False; }, 2000);
                }}
                className="shrink-0 rounded-md p-1 text-muted-foreground hover:text-foreground transition-colors cursor-pointer bg-transparent border-none outline-none"
            >
                {copied
                    and <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-3.5 text-green-500" />
                    or <HugeiconsIcon icon={Copy01Icon} strokeWidth={2} className="size-3.5" />}
            </button>
        </div>;
    }

    def:pub ShowcaseSection(props: Any) -> JsxElement {
        has showCode: bool = False;
        has copied: bool = False;
        code = props.code or "";
        hasCode = code.length > 0;

        # Process literal \n → actual newlines
        processedCode = _processCode(code);
        highlightedHtml = _highlightJac(processedCode);

        handleCopy = lambda -> None {
            navigator.clipboard.writeText(processedCode);
            copied = True;
            setTimeout(lambda -> None { copied = False; }, 2000);
        };

        lines = processedCode.split(_NL);
        previewHtml = _highlightJac(lines.slice(0, 3).join(_NL));

        return <div className="space-y-3">
            {props.title and <h3 className="text-sm font-medium text-muted-foreground">{props.title}</h3>}
            <div className="rounded-xl border overflow-hidden">
                <div className={cn("flex flex-wrap items-center gap-2 p-6 min-h-[120px] justify-center", props.className)}>
                    {props.children}
                </div>
                {hasCode and (
                    <div className="relative border-t bg-zinc-50 dark:bg-zinc-900">
                        {showCode and (
                            <div className="relative">
                                <button
                                    onClick={handleCopy}
                                    className="absolute right-3 top-3 inline-flex items-center justify-center rounded-md p-1.5 text-zinc-500 hover:text-zinc-900 dark:text-zinc-400 dark:hover:text-zinc-100 hover:bg-zinc-200/60 dark:hover:bg-zinc-800 transition-colors z-10 cursor-pointer border-none outline-none bg-transparent"
                                >
                                    {copied
                                        and <HugeiconsIcon icon={Tick01Icon} strokeWidth={2} className="size-3.5 text-green-500" />
                                        or <HugeiconsIcon icon={Copy01Icon} strokeWidth={2} className="size-3.5" />
                                    }
                                </button>
                                <div className="overflow-x-auto overflow-y-auto max-h-[400px]">
                                    <pre className="p-4 pr-12 text-[13px] font-mono leading-relaxed text-zinc-800 dark:text-zinc-300">
                                        <code dangerouslySetInnerHTML={{"__html": highlightedHtml}} />
                                    </pre>
                                </div>
                                <div className="flex justify-center border-t border-zinc-200 dark:border-zinc-800 py-2">
                                    <button
                                        onClick={lambda -> None { showCode = False; }}
                                        className="text-xs text-zinc-500 hover:text-zinc-900 dark:text-zinc-400 dark:hover:text-zinc-200 transition-colors cursor-pointer border-none outline-none bg-transparent"
                                    >
                                        Collapse
                                    </button>
                                </div>
                            </div>
                        ) or (
                            <div className="relative">
                                <div className="overflow-hidden max-h-[72px]">
                                    <pre className="p-4 text-[13px] font-mono leading-relaxed text-zinc-800 dark:text-zinc-300">
                                        <code dangerouslySetInnerHTML={{"__html": previewHtml}} />
                                    </pre>
                                </div>
                                <div className="absolute inset-0 flex items-center justify-center">
                                    <div className="absolute inset-0 bg-gradient-to-t from-zinc-50 via-zinc-50/70 to-transparent dark:from-zinc-900 dark:via-zinc-900/70" />
                                    <button
                                        onClick={lambda -> None { showCode = True; }}
                                        className="relative z-10 inline-flex items-center rounded-lg border border-zinc-300 bg-white px-3 py-1.5 text-xs font-medium text-zinc-700 hover:bg-zinc-100 hover:border-zinc-400 dark:border-zinc-700 dark:bg-zinc-800 dark:text-zinc-200 dark:hover:bg-zinc-700 dark:hover:border-zinc-600 transition-colors cursor-pointer shadow-sm"
                                    >
                                        View Code
                                    </button>
                                </div>
                            </div>
                        )}
                    </div>
                )}
            </div>
        </div>;
    }

    def:pub ShowcaseHeader(props: Any) -> JsxElement {
        return <div className="space-y-3 pb-4 mb-6 border-b border-border/50">
            <div className="flex items-center gap-2">
                <h2 className="text-2xl font-semibold tracking-tight">{props.title}</h2>
            </div>
            {props.description and <p className="text-sm text-muted-foreground max-w-2xl">{props.description}</p>}
            <CopyCommand name={props.name} />
        </div>;
    }

}

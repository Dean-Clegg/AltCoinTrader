import Link from "next/link";

export function AppHeader() {
    return (
        <header className="border-b border-border bg-surface sticky top-0 z-40">
            <div className="max-w-7xl mx-auto px-4 py-4 flex items-center gap-8">
                <Link
                    href="/"
                    className="text-accent font-mono font-bold text-lg tracking-widest hover:text-accent/80 transition-colors"
                >
                    ABYSSAL CODEX
                </Link>
                <nav aria-label="Main navigation">
                    <Link
                        href="/games"
                        className="text-sm text-text-muted hover:text-foreground transition-colors"
                    >
                        Game Registry
                    </Link>
                </nav>
            </div>
        </header>
    );
}

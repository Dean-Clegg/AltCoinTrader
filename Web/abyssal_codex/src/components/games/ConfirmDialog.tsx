"use client";

import {useEffect, useRef} from "react";

type Props = {
    title: string;
    message: string;
    confirmLabel?: string;
    onConfirmAction: () => void;
    onCancelAction: () => void;
};

export function ConfirmDialog({
                                  title,
                                  message,
                                  confirmLabel = "Confirm",
                                  onConfirmAction,
                                  onCancelAction,
                              }: Props) {
    const confirmRef = useRef<HTMLButtonElement>(null);

    useEffect(() => {
        confirmRef.current?.focus();
        const handler = (e: KeyboardEvent) => {
            if (e.key === "Escape") onCancelAction();
        };
        window.addEventListener("keydown", handler);
        return () => window.removeEventListener("keydown", handler);
    }, [onCancelAction]);

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
            <div className="absolute inset-0 bg-black/60" onClick={onCancelAction}/>
            <div
                role="dialog"
                aria-modal="true"
                aria-labelledby="confirm-title"
                className="relative bg-surface border border-border rounded-xl p-6 w-full max-w-sm shadow-2xl"
            >
                <h2 id="confirm-title" className="text-lg font-semibold mb-2">
                    {title}
                </h2>
                <p className="text-text-muted text-sm mb-6">{message}</p>
                <div className="flex gap-3 justify-end">
                    <button
                        onClick={onCancelAction}
                        className="px-4 py-2 text-sm rounded-lg bg-surface-alt border border-border hover:border-text-muted transition-colors"
                    >
                        Cancel
                    </button>
                    <button
                        ref={confirmRef}
                        onClick={onConfirmAction}
                        className="px-4 py-2 text-sm rounded-lg bg-red-500/10 text-red-400 border border-red-500/30 hover:bg-red-500/20 transition-colors"
                    >
                        {confirmLabel}
                    </button>
                </div>
            </div>
        </div>
    );
}

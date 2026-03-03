"use client";

import React, {useState, useEffect, useRef} from "react";
import type {Game} from "@/types";
import {GameStatus, GameCategory} from "@/types";
import {GameValidator} from "@/lib";

type FormState = {
    name: string;
    status: GameStatus;
    category: GameCategory;
    developer: string;
    publisher: string;
};

type Props = {
    game?: Game;
    onSaveAction: (data: Omit<Game, "id" | "updatedAt">) => void;
    onCloseAction: () => void;
};

export function EditGameModal({game, onSaveAction, onCloseAction}: Props) {
    const isEdit = !!game;
    const [form, setForm] = useState<FormState>({
        name: game?.name ?? "",
        status: game?.status ?? GameStatus.Released,
        category: game?.category ?? GameCategory.FPS,
        developer: game?.developer ?? "",
        publisher: game?.publisher ?? "",
    });
    const [errors, setErrors] = useState<Record<string, string>>({});
    const [saving, setSaving] = useState(false);
    const nameRef = useRef<HTMLInputElement>(null);

    useEffect(() => {
        nameRef.current?.focus();
        const handler = (e: KeyboardEvent) => {
            if (e.key === "Escape") onCloseAction();
        };
        window.addEventListener("keydown", handler);
        return () => window.removeEventListener("keydown", handler);
    }, [onCloseAction]);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSaving(true);

        const result = await GameValidator.validate({
            name: form.name,
            status: form.status,
            category: form.category,
            publisher: form.publisher || undefined,
        });

        const newErrors: Record<string, string> = {};
        if (!result.valid) {
            Object.assign(newErrors, result.errors);
        }

        if (!form.developer.trim()) {
            newErrors.developer = "Developer is required.";
        } else if (form.developer.trim().length < 2) {
            newErrors.developer = "Developer must be at least 2 characters.";
        }

        if (Object.keys(newErrors).length > 0) {
            setErrors(newErrors);
            setSaving(false);
            return;
        }

        onSaveAction({
            name: form.name.trim(),
            status: form.status,
            category: form.category,
            developer: form.developer.trim(),
            ...(form.publisher.trim() ? {publisher: form.publisher.trim()} : {}),
        });
        setSaving(false);
    };

    const update =
        (field: keyof FormState) =>
            (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
                setForm((prev) => ({...prev, [field]: e.target.value}));
                if (errors[field]) {
                    setErrors((prev) => {
                        const next = {...prev};
                        delete next[field];
                        return next;
                    });
                }
            };

    const inputClass =
        "w-full bg-surface-alt border border-border rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent transition-colors";

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
            <div className="absolute inset-0 bg-black/60" onClick={onCloseAction}/>
            <div
                role="dialog"
                aria-modal="true"
                aria-labelledby="modal-title"
                className="relative bg-surface border border-border rounded-xl p-6 w-full max-w-lg shadow-2xl max-h-[90vh] overflow-y-auto"
            >
                <h2 id="modal-title" className="text-lg font-semibold mb-5">
                    {isEdit ? "Edit Game" : "New Game"}
                </h2>

                <form onSubmit={handleSubmit} noValidate className="space-y-4">
                    <div>
                        <label htmlFor="edit-name" className="block text-sm text-text-muted mb-1">
                            Name <span aria-hidden="true">*</span>
                        </label>
                        <input
                            ref={nameRef}
                            id="edit-name"
                            type="text"
                            value={form.name}
                            onChange={update("name")}
                            className={inputClass}
                        />
                        {errors.name && <p className="text-red-400 text-xs mt-1">{errors.name}</p>}
                    </div>

                    <div>
                        <label htmlFor="edit-developer" className="block text-sm text-text-muted mb-1">
                            Developer <span aria-hidden="true">*</span>
                        </label>
                        <input
                            id="edit-developer"
                            type="text"
                            value={form.developer}
                            onChange={update("developer")}
                            className={inputClass}
                        />
                        {errors.developer && (
                            <p className="text-red-400 text-xs mt-1">{errors.developer}</p>
                        )}
                    </div>

                    <div>
                        <label htmlFor="edit-status" className="block text-sm text-text-muted mb-1">
                            Status <span aria-hidden="true">*</span>
                        </label>
                        <select
                            id="edit-status"
                            value={form.status}
                            onChange={update("status")}
                            className={inputClass}
                        >
                            <option value={GameStatus.Released}>Released</option>
                            <option value={GameStatus.EarlyAccess}>Early Access</option>
                            <option value={GameStatus.Development}>Development</option>
                            <option value={GameStatus.Obsolete}>Obsolete</option>
                        </select>
                        {errors.status && <p className="text-red-400 text-xs mt-1">{errors.status}</p>}
                    </div>

                    <div>
                        <label htmlFor="edit-category" className="block text-sm text-text-muted mb-1">
                            Category <span aria-hidden="true">*</span>
                        </label>
                        <select
                            id="edit-category"
                            value={form.category}
                            onChange={update("category")}
                            className={inputClass}
                        >
                            {Object.values(GameCategory).map((c) => (
                                <option key={c} value={c}>
                                    {c}
                                </option>
                            ))}
                        </select>
                        {errors.category && (
                            <p className="text-red-400 text-xs mt-1">{errors.category}</p>
                        )}
                    </div>

                    <div>
                        <label htmlFor="edit-publisher" className="block text-sm text-text-muted mb-1">
                            Publisher
                        </label>
                        <input
                            id="edit-publisher"
                            type="text"
                            value={form.publisher}
                            onChange={update("publisher")}
                            className={inputClass}
                        />
                        {errors.publisher && (
                            <p className="text-red-400 text-xs mt-1">{errors.publisher}</p>
                        )}
                    </div>

                    <div className="flex gap-3 justify-end pt-2">
                        <button
                            type="button"
                            onClick={onCloseAction}
                            className="px-4 py-2 text-sm rounded-lg bg-surface-alt border border-border hover:border-text-muted transition-colors"
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            disabled={saving}
                            className="px-4 py-2 text-sm rounded-lg bg-accent/10 text-accent border border-accent/30 hover:bg-accent/20 transition-colors disabled:opacity-50"
                        >
                            {saving ? "Saving…" : isEdit ? "Save Changes" : "Create Game"}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
}

"use client";

import {useMemo, useState} from "react";
import Link from "next/link";
import {useRouter} from "next/navigation";
import type {Game} from "@/types";
import {useGames} from "@/hooks/useGames";
import {StatusBadge} from "@/components/ui";
import {EditGameModal} from "./EditGameModal";
import {ConfirmDialog} from "./ConfirmDialog";

function formatDate(iso: string): string {
    return new Date(iso).toLocaleString("en-US", {
        year: "numeric",
        month: "long",
        day: "numeric",
        hour: "2-digit",
        minute: "2-digit",
    });
}

function Field({label, value}: { label: string; value: string }) {
    return (
        <div>
            <p className="text-text-muted text-xs uppercase tracking-wider mb-1">{label}</p>
            <p className="font-medium">{value}</p>
        </div>
    );
}

type Props = { id: string };

export function GameDetailClient({id}: Props) {
    const {allGames, loading, updateGame, deleteGame} = useGames();
    const [showEdit, setShowEdit] = useState(false);
    const [showDelete, setShowDelete] = useState(false);
    const router = useRouter();

    const game = useMemo(() => allGames.find((g) => g.id === id), [allGames, id]);

    if (loading) {
        return (
            <div className="flex items-center justify-center py-32">
                <div className="w-8 h-8 border-2 border-accent/30 border-t-accent rounded-full animate-spin"/>
            </div>
        );
    }

    if (!game) {
        return (
            <div className="flex flex-col items-center justify-center py-32 gap-3">
                <p className="text-5xl font-bold text-text-muted">404</p>
                <p className="text-xl font-semibold">Game not found</p>
                <p className="text-text-muted text-sm">No game with ID &ldquo;{id}&rdquo; exists.</p>
                <Link href="/games" className="text-accent hover:underline text-sm mt-2">
                    ← Back to Game Registry
                </Link>
            </div>
        );
    }

    const handleSave = (data: Omit<Game, "id" | "updatedAt">) => {
        updateGame(game.id, data);
        setShowEdit(false);
    };

    const handleDelete = () => {
        deleteGame(game.id);
        router.push("/games");
    };

    return (
        <div className="max-w-2xl mx-auto">
            <Link
                href="/games"
                className="inline-flex items-center gap-1 text-text-muted text-sm hover:text-accent transition-colors mb-6"
            >
                ← Game Registry
            </Link>

            <div className="flex items-start justify-between gap-4 mb-6">
                <div>
                    <h1 className="text-3xl font-bold mb-2">{game.name}</h1>
                    <StatusBadge status={game.status}/>
                </div>
                <div className="flex gap-2 shrink-0">
                    <button
                        onClick={() => setShowEdit(true)}
                        className="px-4 py-2 text-sm rounded-lg bg-accent/10 text-accent border border-accent/30 hover:bg-accent/20 transition-colors"
                    >
                        Edit
                    </button>
                    <button
                        onClick={() => setShowDelete(true)}
                        className="px-4 py-2 text-sm rounded-lg bg-red-500/10 text-red-400 border border-red-500/30 hover:bg-red-500/20 transition-colors"
                    >
                        Delete
                    </button>
                </div>
            </div>

            <div className="bg-surface border border-border rounded-xl p-6 grid grid-cols-1 sm:grid-cols-2 gap-6">
                <Field label="Developer" value={game.developer}/>
                {game.publisher && <Field label="Publisher" value={game.publisher}/>}
                <Field label="Category" value={game.category}/>
                <Field label="Last Updated" value={formatDate(game.updatedAt)}/>
                <div className="sm:col-span-2">
                    <p className="text-text-muted text-xs uppercase tracking-wider mb-1">ID</p>
                    <p className="font-mono text-sm text-text-muted">{game.id}</p>
                </div>
            </div>

            {showEdit && (
                <EditGameModal
                    game={game}
                    onSaveAction={handleSave}
                    onCloseAction={() => setShowEdit(false)}
                />
            )}

            {showDelete && (
                <ConfirmDialog
                    title={`Delete "${game.name}"?`}
                    message="This will permanently remove the game from the registry. This action cannot be undone."
                    confirmLabel="Delete"
                    onConfirmAction={handleDelete}
                    onCancelAction={() => setShowDelete(false)}
                />
            )}
        </div>
    );
}

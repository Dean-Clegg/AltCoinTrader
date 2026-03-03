"use client";

import Link from "next/link";
import type {Game} from "@/types";
import {StatusBadge} from "@/components/ui";

type Props = {
    game: Game;
    selected: boolean;
    onToggleSelectAction: (id: string) => void;
    onEditAction: (game: Game) => void;
    onDeleteAction: (game: Game) => void;
};

function formatDate(iso: string): string {
    return new Date(iso).toLocaleDateString("en-US", {
        year: "numeric",
        month: "short",
        day: "numeric",
    });
}

export function GameRow({game, selected, onToggleSelectAction, onEditAction, onDeleteAction}: Props) {
    return (
        <tr
            className={`border-b border-border transition-colors ${
                selected ? "bg-accent/5" : "hover:bg-surface-alt"
            }`}
        >
            <td className="px-4 py-3 w-10">
                <input
                    type="checkbox"
                    checked={selected}
                    onChange={() => onToggleSelectAction(game.id)}
                    aria-label={`Select ${game.name}`}
                    className="rounded border-border bg-surface-alt accent-accent cursor-pointer"
                />
            </td>
            <td className="px-4 py-3 font-medium">
                <Link
                    href={`/games/${game.id}`}
                    className="hover:text-accent transition-colors"
                >
                    {game.name}
                </Link>
            </td>
            <td className="px-4 py-3 text-text-muted text-sm">{game.developer}</td>
            <td className="px-4 py-3 text-text-muted text-sm">{game.category}</td>
            <td className="px-4 py-3">
                <StatusBadge status={game.status}/>
            </td>
            <td className="px-4 py-3 text-text-muted text-sm whitespace-nowrap">
                {formatDate(game.updatedAt)}
            </td>
            <td className="px-4 py-3">
                <div className="flex items-center gap-2">
                    <button
                        onClick={() => onEditAction(game)}
                        aria-label={`Edit ${game.name}`}
                        className="px-2 py-1 text-xs rounded border border-border text-text-muted hover:border-accent hover:text-accent transition-colors"
                    >
                        Edit
                    </button>
                    <button
                        onClick={() => onDeleteAction(game)}
                        aria-label={`Delete ${game.name}`}
                        className="px-2 py-1 text-xs rounded border border-red-500/20 text-red-400/70 hover:border-red-500/50 hover:text-red-400 transition-colors"
                    >
                        Delete
                    </button>
                </div>
            </td>
        </tr>
    );
}

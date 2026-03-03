"use client";

import {GameStatus} from "@/types";

type Props = {
    query: string;
    statusFilter: GameStatus | "all";
    selectedCount: number;
    onQueryChangeAction: (q: string) => void;
    onStatusChangeAction: (s: GameStatus | "all") => void;
    onClearSelectionAction: () => void;
    onBulkStatusAction: (status: GameStatus) => void;
    onBulkDeleteAction: () => void;
    onCreateAction: () => void;
};

const BULK_STATUSES: { value: GameStatus; label: string }[] = [
    {value: GameStatus.Released, label: "Released"},
    {value: GameStatus.EarlyAccess, label: "Early Access"},
    {value: GameStatus.Development, label: "Development"},
    {value: GameStatus.Obsolete, label: "Obsolete"},
];

export function GamesToolbar({
                                 query,
                                 statusFilter,
                                 selectedCount,
                                 onQueryChangeAction,
                                 onStatusChangeAction,
                                 onClearSelectionAction,
                                 onBulkStatusAction,
                                 onBulkDeleteAction,
                                 onCreateAction,
                             }: Props) {
    return (
        <div className="space-y-3">
            <div className="flex flex-wrap items-center gap-3">
                <input
                    type="search"
                    aria-label="Search games"
                    placeholder="Search by name, developer, category…"
                    value={query}
                    onChange={(e) => onQueryChangeAction(e.target.value)}
                    className="flex-1 min-w-48 bg-surface-alt border border-border rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent placeholder:text-text-muted transition-colors"
                />
                <select
                    value={statusFilter}
                    onChange={(e) => onStatusChangeAction(e.target.value as GameStatus | "all")}
                    aria-label="Filter by status"
                    className="bg-surface-alt border border-border rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent transition-colors"
                >
                    <option value="all">All Statuses</option>
                    <option value={GameStatus.Released}>Released</option>
                    <option value={GameStatus.EarlyAccess}>Early Access</option>
                    <option value={GameStatus.Development}>Development</option>
                    <option value={GameStatus.Obsolete}>Obsolete</option>
                </select>
                <button
                    onClick={onCreateAction}
                    className="px-4 py-2 text-sm rounded-lg bg-accent text-background font-medium hover:bg-accent/90 transition-colors"
                >
                    + New Game
                </button>
            </div>

            {selectedCount > 0 && (
                <div className="flex flex-wrap items-center gap-3 bg-accent/5 border border-accent/20 rounded-lg px-4 py-2">
          <span className="text-sm text-accent font-medium">
            {selectedCount} selected
          </span>
                    <span className="text-text-muted text-sm">Set status:</span>
                    <div className="flex flex-wrap gap-2 flex-1">
                        {BULK_STATUSES.map((s) => (
                            <button
                                key={s.value}
                                onClick={() => onBulkStatusAction(s.value)}
                                className="px-2 py-0.5 text-xs rounded border border-border bg-surface-alt hover:border-accent hover:text-accent transition-colors"
                            >
                                {s.label}
                            </button>
                        ))}
                    </div>
                    <div className="flex gap-2">
                        <button
                            onClick={onBulkDeleteAction}
                            className="px-3 py-1 text-xs rounded border border-red-500/30 text-red-400 bg-red-500/5 hover:bg-red-500/10 transition-colors"
                        >
                            Delete selected
                        </button>
                        <button
                            onClick={onClearSelectionAction}
                            className="px-3 py-1 text-xs rounded border border-border text-text-muted hover:border-text-muted transition-colors"
                        >
                            Clear
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
}

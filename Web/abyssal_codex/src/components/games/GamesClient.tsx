"use client";

import React, {useState} from "react";
import type {Game, GameSortField} from "@/types";
import {useGames} from "@/hooks/useGames";
import {GamesToolbar} from "./GamesToolbar";
import {GameRow} from "./GameRow";
import {EditGameModal} from "./EditGameModal";
import {ConfirmDialog} from "./ConfirmDialog";

type ModalState =
    | { type: "none" }
    | { type: "edit"; game: Game }
    | { type: "create" }
    | { type: "delete"; game: Game }
    | { type: "bulkDelete"; ids: string[] };

function SortTh({
                    field,
                    activeField,
                    direction,
                    onSort,
                    children,
                }: {
    field: GameSortField;
    activeField: GameSortField;
    direction: "asc" | "desc";
    onSort: (f: GameSortField) => void;
    children: React.ReactNode;
}) {
    const isActive = field === activeField;
    return (
        <th className="px-4 py-3 text-left">
            <button
                onClick={() => onSort(field)}
                className={`flex items-center gap-1 text-xs uppercase tracking-wider transition-colors ${
                    isActive ? "text-accent" : "text-text-muted hover:text-foreground"
                }`}
            >
                {children}
                <span className="w-3 text-center">
          {isActive ? (direction === "asc" ? "↑" : "↓") : ""}
        </span>
            </button>
        </th>
    );
}

export function GamesClient() {
    const {
        games,
        allGames,
        loading,
        error,
        query,
        statusFilter,
        sortField,
        sortDirection,
        selectedIds,
        setQuery,
        setStatusFilter,
        toggleSort,
        toggleSelect,
        selectAll,
        clearSelection,
        updateGame,
        createGame,
        deleteGame,
        bulkSetStatus,
        triggerError,
        clearError,
        resetToDefaults,
    } = useGames();

    const [modal, setModal] = useState<ModalState>({type: "none"});

    const handleSaveGame = (data: Omit<Game, "id" | "updatedAt">) => {
        if (modal.type === "edit") {
            updateGame(modal.game.id, data);
        } else if (modal.type === "create") {
            createGame(data);
        }
        setModal({type: "none"});
    };

    const handleDeleteConfirm = () => {
        if (modal.type === "delete") {
            deleteGame(modal.game.id);
        } else if (modal.type === "bulkDelete") {
            modal.ids.forEach((id) => deleteGame(id));
        }
        setModal({type: "none"});
    };

    const allDisplayedSelected =
        games.length > 0 && games.every((g) => selectedIds.has(g.id));

    return (
        <div>
            <div className="flex items-start justify-between mb-6">
                <div>
                    <h1 className="text-2xl font-bold">Game Registry</h1>
                    <p className="text-text-muted text-sm mt-1">
                        {loading ? "Loading…" : `${allGames.length} games total`}
                    </p>
                </div>
                <div className="flex gap-3 mt-1">
                    <button
                        onClick={resetToDefaults}
                        title="Reset to seed data and clear localStorage"
                        className="text-xs text-text-muted/40 hover:text-text-muted transition-colors"
                    >
                        ↺ Reset
                    </button>
                    <button
                        onClick={triggerError}
                        title="Simulate an error state (dev)"
                        className="text-xs text-text-muted/40 hover:text-status-pending transition-colors"
                    >
                        ⚠ Error
                    </button>
                </div>
            </div>

            {error && (
                <div className="bg-red-500/10 border border-red-500/30 rounded-lg px-4 py-3 mb-4 flex items-center justify-between">
                    <p className="text-red-400 text-sm">{error}</p>
                    <button
                        onClick={clearError}
                        className="text-xs text-red-400/70 hover:text-red-400 ml-4 shrink-0"
                    >
                        Dismiss
                    </button>
                </div>
            )}

            <GamesToolbar
                query={query}
                statusFilter={statusFilter}
                selectedCount={selectedIds.size}
                onQueryChangeAction={setQuery}
                onStatusChangeAction={setStatusFilter}
                onClearSelectionAction={clearSelection}
                onBulkStatusAction={(status) => bulkSetStatus(Array.from(selectedIds), status)}
                onBulkDeleteAction={() =>
                    setModal({type: "bulkDelete", ids: Array.from(selectedIds)})
                }
                onCreateAction={() => setModal({type: "create"})}
            />

            <div className="mt-4 bg-surface border border-border rounded-xl overflow-hidden">
                {loading && (
                    <div className="flex flex-col items-center justify-center py-24 gap-3">
                        <div className="w-8 h-8 border-2 border-accent/30 border-t-accent rounded-full animate-spin"/>
                        <p className="text-text-muted text-sm">Loading game registry…</p>
                    </div>
                )}

                {!loading && error && games.length === 0 && (
                    <div className="flex flex-col items-center justify-center py-24 gap-2">
                        <p className="text-3xl">⚠</p>
                        <p className="text-foreground font-medium">Failed to load games</p>
                        <button onClick={clearError} className="text-accent text-sm hover:underline">
                            Try again
                        </button>
                    </div>
                )}

                {!loading && games.length === 0 && !error && (
                    <div className="flex flex-col items-center justify-center py-24 gap-2">
                        <p className="text-4xl">🎮</p>
                        <p className="text-foreground font-medium">No games found</p>
                        <p className="text-text-muted text-sm">
                            {query || statusFilter !== "all"
                                ? "Try adjusting your search or filters."
                                : "Add a game to get started."}
                        </p>
                    </div>
                )}

                {!loading && games.length > 0 && (
                    <div className="overflow-x-auto">
                        <table className="w-full">
                            <thead>
                            <tr className="border-b border-border bg-surface-alt">
                                <th className="px-4 py-3 w-10">
                                    <input
                                        type="checkbox"
                                        checked={allDisplayedSelected}
                                        onChange={allDisplayedSelected ? clearSelection : selectAll}
                                        aria-label="Select all visible games"
                                        className="rounded border-border bg-surface accent-accent cursor-pointer"
                                    />
                                </th>
                                <SortTh
                                    field="name"
                                    activeField={sortField}
                                    direction={sortDirection}
                                    onSort={toggleSort}
                                >
                                    Name
                                </SortTh>
                                <th className="px-4 py-3 text-left text-text-muted text-xs uppercase tracking-wider">
                                    Developer
                                </th>
                                <SortTh
                                    field="category"
                                    activeField={sortField}
                                    direction={sortDirection}
                                    onSort={toggleSort}
                                >
                                    Category
                                </SortTh>
                                <SortTh
                                    field="status"
                                    activeField={sortField}
                                    direction={sortDirection}
                                    onSort={toggleSort}
                                >
                                    Status
                                </SortTh>
                                <SortTh
                                    field="updatedAt"
                                    activeField={sortField}
                                    direction={sortDirection}
                                    onSort={toggleSort}
                                >
                                    Updated
                                </SortTh>
                                <th className="px-4 py-3 text-left text-text-muted text-xs uppercase tracking-wider">
                                    Actions
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            {games.map((game) => (
                                <GameRow
                                    key={game.id}
                                    game={game}
                                    selected={selectedIds.has(game.id)}
                                    onToggleSelectAction={toggleSelect}
                                    onEditAction={(g) => setModal({type: "edit", game: g})}
                                    onDeleteAction={(g) => setModal({type: "delete", game: g})}
                                />
                            ))}
                            </tbody>
                        </table>
                    </div>
                )}
            </div>

            {!loading && games.length > 0 && (
                <p className="text-text-muted text-xs mt-3">
                    Showing {games.length} of {allGames.length} games
                </p>
            )}
            {(modal.type === "edit" || modal.type === "create") && (
                <EditGameModal
                    game={modal.type === "edit" ? modal.game : undefined}
                    onSaveAction={handleSaveGame}
                    onCloseAction={() => setModal({type: "none"})}
                />
            )}
            {(modal.type === "delete" || modal.type === "bulkDelete") && (
                <ConfirmDialog
                    title={
                        modal.type === "delete"
                            ? `Delete "${modal.game.name}"?`
                            : `Delete ${modal.ids.length} games?`
                    }
                    message={
                        modal.type === "delete"
                            ? "This action cannot be undone."
                            : `You are about to permanently delete ${modal.ids.length} games. This cannot be undone.`
                    }
                    confirmLabel="Delete"
                    onConfirmAction={handleDeleteConfirm}
                    onCancelAction={() => setModal({type: "none"})}
                />
            )}
        </div>
    );
}

"use client";

import { useState, useEffect, useCallback } from "react";
import type { Game, GameStatus, GameSortField, SortDirection } from "@/types";
import { GameFilter, GameSort, Storage } from "@/lib";
import rawData from "@/data/games.json";

const STORAGE_KEY = "abyssal:games";
const seedGames = rawData as unknown as Game[];

function newId(): string {
  return `game-${Date.now()}`;
}

export function useGames() {
  const [allGames, setAllGames] = useState<Game[]>([]);
  const [displayed, setDisplayed] = useState<Game[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const [query, setQuery] = useState("");
  const [statusFilter, setStatusFilter] = useState<GameStatus | "all">("all");
  const [sortField, setSortField] = useState<GameSortField>("updatedAt");
  const [sortDirection, setSortDirection] = useState<SortDirection>("desc");
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  useEffect(() => {
    const t = setTimeout(async () => {
      try {
        const stored = await Storage.get<Game[]>(STORAGE_KEY);
        if (stored) {
          setAllGames(stored);
        } else {
          await Storage.set(STORAGE_KEY, seedGames);
          setAllGames(seedGames);
        }
      } catch {
        setError("Failed to load game data.");
      } finally {
        setLoading(false);
      }
    }, 400);
    return () => clearTimeout(t);
  }, []);
  useEffect(() => {
    if (loading) return;
    GameFilter.filter(allGames, query, statusFilter)
      .then((f) => GameSort.sort(f, sortField, sortDirection))
      .then(setDisplayed);
  }, [allGames, query, statusFilter, sortField, sortDirection, loading]);

  const setAndPersist = useCallback(
    (updater: (prev: Game[]) => Game[]) => {
      setAllGames((prev) => {
        const next = updater(prev);
        Storage.set(STORAGE_KEY, next);
        return next;
      });
    },
    []
  );

  const updateGame = useCallback(
    (id: string, updates: Partial<Omit<Game, "id">>) => {
      setAndPersist((prev) =>
        prev.map((g) =>
          g.id === id ? { ...g, ...updates, updatedAt: new Date().toISOString() } : g
        )
      );
    },
    [setAndPersist]
  );

  const createGame = useCallback(
    (data: Omit<Game, "id" | "updatedAt">): Game => {
      const game: Game = { ...data, id: newId(), updatedAt: new Date().toISOString() };
      setAndPersist((prev) => [game, ...prev]);
      return game;
    },
    [setAndPersist]
  );

  const deleteGame = useCallback(
    (id: string) => {
      setAndPersist((prev) => prev.filter((g) => g.id !== id));
      setSelectedIds((prev) => {
        const next = new Set(prev);
        next.delete(id);
        return next;
      });
    },
    [setAndPersist]
  );

  const bulkSetStatus = useCallback(
    (ids: string[], status: GameStatus) => {
      setAndPersist((prev) =>
        prev.map((g) =>
          ids.includes(g.id) ? { ...g, status, updatedAt: new Date().toISOString() } : g
        )
      );
      setSelectedIds(new Set());
    },
    [setAndPersist]
  );

  const toggleSort = useCallback(
    (field: GameSortField) => {
      if (field === sortField) {
        setSortDirection((d) => (d === "asc" ? "desc" : "asc"));
      } else {
        setSortField(field);
        setSortDirection("asc");
      }
    },
    [sortField]
  );

  const toggleSelect = useCallback((id: string) => {
    setSelectedIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }, []);

  const selectAll = useCallback(
    () => setSelectedIds(new Set(displayed.map((g) => g.id))),
    [displayed]
  );

  const clearSelection = useCallback(() => setSelectedIds(new Set()), []);

  const triggerError = useCallback(
    () => setError("Failed to load game data. Please try again."),
    []
  );

  const clearError = useCallback(() => setError(null), []);

  const resetToDefaults = useCallback(async () => {
    await Storage.remove(STORAGE_KEY);
    await Storage.set(STORAGE_KEY, seedGames);
    setAllGames(seedGames);
    setSelectedIds(new Set());
  }, []);

  return {
    games: displayed,
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
  };
}

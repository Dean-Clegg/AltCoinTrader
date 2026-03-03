import type { Game, GameStatus } from "@/types";

export default class GameFilter {
  public static async filter(
    games: Game[],
    query: string,
    statusFilter: GameStatus | "all"
  ): Promise<Game[]> {
    const normalizedQuery = query.trim().toLowerCase();

    return games.filter((game) => {
      if (statusFilter !== "all" && game.status !== statusFilter) return false;
      if (!normalizedQuery) return true;

      return (
        game.name.toLowerCase().includes(normalizedQuery) ||
        game.category.toLowerCase().includes(normalizedQuery) ||
        game.developer.toLowerCase().includes(normalizedQuery) ||
        (game.publisher?.toLowerCase().includes(normalizedQuery) ?? false)
      );
    });
  }
}

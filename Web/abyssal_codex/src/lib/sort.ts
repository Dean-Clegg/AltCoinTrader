import type {Game, GameSortField, SortDirection} from "@/types";

export default class GameSort {
    public static async sort(
        games: Game[],
        field: GameSortField,
        direction: SortDirection
    ): Promise<Game[]> {
        return [...games].sort((a, b) => {
            let comparison: number;

            if (field === "updatedAt") {
                comparison = new Date(a.updatedAt).getTime() - new Date(b.updatedAt).getTime();
            } else comparison = a[field].localeCompare(b[field]);


            return direction === "asc" ? comparison : -comparison;
        });
    }
}

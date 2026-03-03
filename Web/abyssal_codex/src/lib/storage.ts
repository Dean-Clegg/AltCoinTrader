export const STORAGE_KEYS = {
  GAMES_SORT_FIELD: "games_sort_field",
  GAMES_SORT_DIRECTION: "games_sort_direction",
  GAMES_STATUS_FILTER: "games_status_filter",
  GAMES_SEARCH_QUERY: "games_search_query",
} as const;

export default class Storage {
  public static async get<T>(key: string): Promise<T | null> {
    if (typeof window === "undefined") return null;
    try {
      const item = window.localStorage.getItem(key);
      return item ? (JSON.parse(item) as T) : null;
    } catch {
      return null;
    }
  }

  public static async set<T>(key: string, value: T): Promise<void> {
    if (typeof window === "undefined") return;
    try {
      window.localStorage.setItem(key, JSON.stringify(value));
    } catch {}
  }

  public static async remove(key: string): Promise<void> {
    if (typeof window === "undefined") return;
    try {
      window.localStorage.removeItem(key);
    } catch {}
  }
}

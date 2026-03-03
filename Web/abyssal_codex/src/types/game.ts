export enum GameStatus {
  Released = "released",
  EarlyAccess = "earlyAccess",
  Development = "development",
  Obsolete = "obsolete",
}

export enum GameCategory {
  FPS = "FPS",
  RPG = "RPG",
  BattleRoyale = "Battle Royale",
  MOBA = "MOBA",
  Strategy = "Strategy",
  Sports = "Sports",
  Adventure = "Adventure",
  Sandbox = "Sandbox",
  Fighting = "Fighting",
  Horror = "Horror",
}

export type Game = {
    id: string;
    name: string;
    status: GameStatus;
    category: GameCategory;
    developer: string;
    publisher?: string;
    updatedAt: string;
};

export type GameSortField = keyof Pick<Game, "name" | "status" | "category" | "updatedAt">;

export type SortDirection = "asc" | "desc";

export type GameFormInput = Pick<Game, "name" | "status" | "category"> & {
    publisher?: string;
};

export type ValidationResult<T> = | { valid: true; data: T } | { valid: false; errors: Partial<Record<keyof T, string>> };

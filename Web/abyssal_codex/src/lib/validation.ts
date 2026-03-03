import { GameStatus, GameCategory } from "@/types";
import type { GameFormInput, ValidationResult } from "@/types";

export default class GameValidator {
  public static async validate(
    partial: Partial<GameFormInput>
  ): Promise<ValidationResult<GameFormInput>> {
    const errors: Partial<Record<keyof GameFormInput, string>> = {};

    const publisher = partial.publisher?.trim();
    const name = partial.name?.trim();

    if (!name || name.length < 2) {
      errors.name = "Name must be at least 2 characters.";
    } else if (name.length > 100) {
      errors.name = "Name must be 100 characters or fewer.";
    }

    if (!partial.status || !Object.values(GameStatus).includes(partial.status as GameStatus)) {
      errors.status = `Status must be one of: ${Object.values(GameStatus).join(", ")}.`;
    }

    if (!partial.category || !Object.values(GameCategory).includes(partial.category as GameCategory)) {
      errors.category = `Category must be one of: ${Object.values(GameCategory).join(", ")}.`;
    }

    if (publisher && publisher !== "") {
      if (publisher.length < 2) {
        errors.publisher = "Publisher must be at least 2 characters.";
      } else if (publisher.length > 80) {
        errors.publisher = "Publisher must be 80 characters or fewer.";
      }
    }

    if (Object.keys(errors).length > 0) return { valid: false, errors };

    return {
      valid: true,
      data: {
        name: partial.name!.trim(),
        status: partial.status!,
        category: partial.category!,
        ...(partial.publisher ? { publisher: partial.publisher.trim() } : {}),
      },
    };
  }
}

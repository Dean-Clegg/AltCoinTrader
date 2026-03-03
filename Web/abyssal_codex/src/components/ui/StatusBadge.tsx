import {GameStatus} from "@/types";

const LABELS: Record<GameStatus, string> = {
    released: "Released",
    earlyAccess: "Early Access",
    development: "Development",
    obsolete: "Obsolete",
};

const CLASSES: Record<GameStatus, string> = {
    released:
        "bg-status-active/10 text-status-active border-status-active/30",
    earlyAccess:
        "bg-status-pending/10 text-status-pending border-status-pending/30",
    development:
        "bg-accent/10 text-accent border-accent/30",
    obsolete:
        "bg-status-inactive/10 text-status-inactive border-status-inactive/30",
};

export function StatusBadge({status}: { status: GameStatus }) {
    return (
        <span
            className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium border ${CLASSES[status]}`}
        >
      {LABELS[status]}
    </span>
    );
}

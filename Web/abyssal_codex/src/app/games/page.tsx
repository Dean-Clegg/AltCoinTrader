import { GamesClient } from "@/components/games";

export const metadata = {
  title: "Game Registry — Abyssal Codex",
};

export default function GamesPage() {
  return (
    <main className="max-w-7xl mx-auto px-4 py-8">
      <GamesClient />
    </main>
  );
}

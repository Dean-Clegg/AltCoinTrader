import { GameDetailClient } from "@/components/games";

type Props = {
  params: Promise<{ id: string }>;
};

export default async function GameDetailPage({ params }: Props) {
  const { id } = await params;
  return (
    <main className="max-w-7xl mx-auto px-4 py-8">
      <GameDetailClient id={id} />
    </main>
  );
}

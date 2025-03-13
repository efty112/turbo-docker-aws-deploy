import { prismaClient } from "db/client";

// export const revalidate = 600;
// or,
// export const dynamic = 'force-dynamic'

export default async function Home() {
  const users  = await prismaClient.user.findMany();
  console.log(users);
  return (
    <div>
      Hello from Turbo
    </div>
  );
}

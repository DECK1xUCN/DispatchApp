import { createYoga } from "graphql-yoga";
import { createServer } from "http";
import { context } from "./utils/context";
import { makeExecutableSchema } from "@graphql-tools/schema";
import resolvers from "./graphql/resolvers";
import typeDefs from "./graphql/typeDefs";

function main() {
  const schema = makeExecutableSchema({
    resolvers: [resolvers],
    typeDefs: [typeDefs],
  });
  const yoga = createYoga({ schema, context });
  const server = createServer(yoga);
  server.listen(4000, () => {
    console.info("🚀 Server is running on http://localhost:4000/graphql");
  });
}

main();

import { createYoga } from "graphql-yoga";
import { context } from "./utils/context";
import { makeExecutableSchema } from "@graphql-tools/schema";
import resolvers from "./graphql/resolvers";
import typeDefs from "./graphql/typeDefs";
import express from "express";

function main() {
  const app = express();
  const schema = makeExecutableSchema({
    resolvers: [resolvers],
    typeDefs: [typeDefs],
  });
  const yoga = createYoga({ schema, context });
  app.use("/graphql", yoga);
  app.listen(4000, () => {
    console.info("🚀 Server is running on http://localhost:4000/graphql");
  });
}

main();

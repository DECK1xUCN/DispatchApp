import { createYoga } from "graphql-yoga";
import { context } from "./utils/context";
import { makeExecutableSchema } from "@graphql-tools/schema";
import resolvers from "./graphql/resolvers";
import typeDefs from "./graphql/typeDefs";
import express from "express";
import * as Sentry from "@sentry/node";

function main() {
  const app = express();

  // Create GraphQL schema
  const schema = makeExecutableSchema({
    resolvers: [resolvers],
    typeDefs: [typeDefs],
  });

  // Initialize Sentry
  Sentry.init({
    dsn: "https://42a1f5475b854a11b48c8d13df244f73@o4504977322868736.ingest.sentry.io/4504977336696832",
    tracesSampleRate: 1.0,
  });

  const yoga = createYoga({ schema, context });
  app.use("/graphql", yoga);
  app.listen(4000, () => {
    console.info("🚀 Server is running on http://localhost:4000/graphql");
  });
}

main();

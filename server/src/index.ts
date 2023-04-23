import { createYoga } from "graphql-yoga";
import { makeExecutableSchema } from "@graphql-tools/schema";
import resolvers from "./graphql/resolvers";
import typeDefs from "./graphql/typeDefs";
import express from "express";
import https from "https";
import fs from "fs";
import * as Sentry from "@sentry/node";
import { ctx } from "./utils/context";

function main() {
  // Create an instance of Express
  const app = express();

  // Create the GraphQL schema
  const schema = makeExecutableSchema({
    resolvers: [resolvers],
    typeDefs: [typeDefs],
  });

  // Start the https server
  const httpsServer = https.createServer(
    {
      key: fs.readFileSync("./src/ssl/private.key"),
      cert: fs.readFileSync("./src/ssl/certificate.crt"),
      ca: fs.readFileSync("./src/ssl/ca_bundle.crt"),
    },
    app
  );

  // Initialize Sentry
  Sentry.init({
    dsn: "https://42a1f5475b854a11b48c8d13df244f73@o4504977322868736.ingest.sentry.io/4504977336696832",
    tracesSampleRate: 1.0,
  });

  const yoga = createYoga({ schema, context: ctx, graphqlEndpoint: "/" });
  app.use(yoga);

  httpsServer.listen(443, () => {
    console.log(`🚀 Server is running on https://localhost`);
  });
}

main();

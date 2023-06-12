import { createYoga } from "graphql-yoga";
import { ctx } from "./utils/context";
import { makeExecutableSchema } from "@graphql-tools/schema";
import resolvers from "./graphql/resolvers";
import typeDefs from "./graphql/typeDefs";
import express from "express";
import cron from "node-cron";
import DailyReportService from "./services/DailyReportService";

function main() {
  const app = express();

  // Create GraphQL schema
  const schema = makeExecutableSchema({
    resolvers: [resolvers],
    typeDefs: [typeDefs],
  });
  const yoga = createYoga({ schema, context: ctx });
  app.use("/graphql", yoga);

  // Create daily reports at midnight
  cron.schedule("0 0 * * *", async () => {
    await DailyReportService.createDailyReports();
  });

  app.listen(4000, () => {
    console.info("🚀 Server is running on http://localhost:4000/graphql");
  });
}

main();

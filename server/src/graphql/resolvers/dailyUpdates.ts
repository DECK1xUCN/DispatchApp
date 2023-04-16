import DailyUpdateService from "@/services/DailyUpdateService";
import { CreateDailyUpdate } from "@/types/dailyUpdates";
import { createGraphQLError } from "graphql-yoga";

const dailyUpdateResolver = {
  Query: {
    dailyUpdate: async (parent: any, args: { id: number }) => {
      const dailyUpdate = await DailyUpdateService.getDailyUpdateById(args.id);
      if (!dailyUpdate) throw createGraphQLError("No daily update found");
      return dailyUpdate;
    },

    dailyUpdates: async () => {
      const dailyUpdates = await DailyUpdateService.getAllDailyUpdates();
      if (!dailyUpdates) throw createGraphQLError("No daily updates found");
      return dailyUpdates;
    },
  },

  Mutation: {
    createDailyUpdate: async (
      parent: any,
      args: { input: CreateDailyUpdate }
    ) => {
      const dailyUpdate = await DailyUpdateService.createDailyUpdate(
        args.input
      );
      if (!dailyUpdate)
        throw createGraphQLError("Daily update could not be created");
      return dailyUpdate;
    },
  },
};

export default dailyUpdateResolver;

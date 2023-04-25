import HoistOperatorService from "@/services/HoistOperatorService";
import { createGraphQLError } from "graphql-yoga";

const hoistOperatorResolver = {
  Query: {
    hoistOperators: async () => {
      const hoistOperators = await HoistOperatorService.getHoistOperators();
      if (!hoistOperators) throw createGraphQLError("No hoist operators found");
      return hoistOperators;
    },

    hoistOperator: async (parent: any, args: { id: number }) => {
      const hoistOperator = await HoistOperatorService.getHoistOperatorById(
        args.id
      );
      if (!hoistOperator) throw createGraphQLError("No hoist operator found");
      return hoistOperator;
    },
  },

  Mutation: {
    createHoistOperator: async (parent: any, args: { name: string }) => {
      const hoistOperator = await HoistOperatorService.createHoistOperator(
        args.name
      );
      if (!hoistOperator)
        throw createGraphQLError("Could not create hoist operator");
      return hoistOperator;
    },

    updateHoistOperator: async (
      parent: any,
      args: { id: number; name: string }
    ) => {
      const hoistOperator = await HoistOperatorService.updateHoistOperator({
        id: args.id,
        name: args.name,
      });
      if (!hoistOperator)
        throw createGraphQLError("Could not update hoist operator");
      return hoistOperator;
    },
  },
};

export default hoistOperatorResolver;

import { ctx } from "../../utils/context";
import HoistOperatorService from "../../services/HoistOperatorService";
import { createGraphQLError } from "graphql-yoga";

const hoistOperatorResolver = {
  Query: {
    hoistOperators: async () => {
      const hoistOperators = await HoistOperatorService.getHoistOperators(ctx);
      if (!hoistOperators) throw createGraphQLError("No hoist operators found");
      return hoistOperators;
    },

    hoistOperator: async (_: any, args: { id: number }) => {
      const hoistOperator = await HoistOperatorService.getHoistOperatorById(
        args.id,
        ctx
      );
      if (!hoistOperator) throw createGraphQLError("No hoist operator found");
      return hoistOperator;
    },
  },

  Mutation: {
    createHoistOperator: async (_: any, args: { name: string }) => {
      const hoistOperator = await HoistOperatorService.createHoistOperator(
        args.name,
        ctx
      );
      if (!hoistOperator)
        throw createGraphQLError("Could not create hoist operator");
      return hoistOperator;
    },

    updateHoistOperator: async (_: any, args: { id: number; name: string }) => {
      const hoistOperator = await HoistOperatorService.updateHoistOperator(
        {
          id: args.id,
          name: args.name,
        },
        ctx
      );
      if (!hoistOperator)
        throw createGraphQLError("Could not update hoist operator");
      return hoistOperator;
    },
  },
};

export default hoistOperatorResolver;

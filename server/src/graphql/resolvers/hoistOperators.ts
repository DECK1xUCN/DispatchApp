import HoistOperatorService from "@/services/HoistOperatorService";
import { CreateHoistOperator } from "@/types/hoistOperators";
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
    createHoistOperator: async (
      parent: any,
      args: { hoistOperator: CreateHoistOperator }
    ) => {
      const hoistOperator = await HoistOperatorService.createHoistOperator(
        args.hoistOperator
      );
      if (!hoistOperator)
        throw createGraphQLError("Could not create hoist operator");
      return hoistOperator;
    },
  },
};

export default hoistOperatorResolver;

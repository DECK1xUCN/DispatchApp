import { CreateHoistOperator } from "@/types/hoistOperators";
import { context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

export default {
  getHoistOperators: async () => {
    const hoistOperators = await context.prisma.hoistOperator
      .findMany({ include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("No hoist operators found");
      });
    return hoistOperators;
  },

  getHoistOperatorById: async (id: number) => {
    const hoistOperator = await context.prisma.hoistOperator
      .findUnique({ where: { id }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError(
          "Hoist operator with id + " + id + "not found"
        );
      });
    return hoistOperator;
  },

  createHoistOperator: async (data: CreateHoistOperator) => {
    const hoistOperator = await context.prisma.hoistOperator
      .create({ data, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Could not create hoist operator");
      });
    return hoistOperator;
  },
};

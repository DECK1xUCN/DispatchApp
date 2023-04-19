import { ctx } from "@/utils/context";
import { checkName } from "@/utils/zodCheck";
import { createGraphQLError } from "graphql-yoga";

export default {
  getHoistOperators: async () => {
    const hoistOperators = await ctx.prisma.hoistOperator
      .findMany({ include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperators;
  },

  getHoistOperatorById: async (id: number) => {
    const hoistOperator = await ctx.prisma.hoistOperator
      .findUnique({ where: { id }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperator;
  },

  createHoistOperator: async (name: string) => {
    const hoistOperator = await ctx.prisma.hoistOperator
      .create({ data: { name: checkName(name) }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperator;
  },

  updateHoistOperator: async (data: { id: number; name: string }) => {
    const hoistOperator = await ctx.prisma.hoistOperator
      .update({
        where: { id: data.id },
        data: { name: checkName(data.name) },
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperator;
  },
};

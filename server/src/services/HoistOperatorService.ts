import { Context, ctx } from "../utils/context";
import { validateName } from "../utils/validators";
import { createGraphQLError } from "graphql-yoga";

export default {
  getHoistOperators: async (ctx: Context) => {
    const hoistOperators = await ctx.prisma.hoistOperator
      .findMany({ include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperators;
  },

  getHoistOperatorById: async (id: number, ctx: Context) => {
    const hoistOperator = await ctx.prisma.hoistOperator
      .findUnique({ where: { id }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperator;
  },

  createHoistOperator: async (name: string, ctx: Context) => {
    const hoistOperator = await ctx.prisma.hoistOperator
      .create({
        data: { name: validateName(name) },
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperator;
  },

  updateHoistOperator: async (
    data: { id: number; name: string },
    ctx: Context
  ) => {
    const hoistOperator = await ctx.prisma.hoistOperator
      .update({
        where: { id: data.id },
        data: { name: validateName(data.name) },
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperator;
  },
};

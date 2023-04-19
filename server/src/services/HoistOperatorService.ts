import { ctx } from "@/utils/context";
import { checkStringMax4, cheeckEmptyString } from "@/utils/zodCheck";
import { createGraphQLError } from "graphql-yoga";
import z from "zod";

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
    checkStringMax4(name);
    cheeckEmptyString(name);

    const hoistOperator = await ctx.prisma.hoistOperator
      .create({ data: { name }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperator;
  },

  updateHoistOperator: async (data: { id: number; name: string }) => {
    checkStringMax4(data.name);
    cheeckEmptyString(data.name);

    const hoistOperator = await ctx.prisma.hoistOperator
      .update({
        where: { id: data.id },
        data: { name: data.name },
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperator;
  },
};

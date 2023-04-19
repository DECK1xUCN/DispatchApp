import { context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";
import z from "zod";

export default {
  getHoistOperators: async () => {
    const hoistOperators = await context.prisma.hoistOperator
      .findMany({ include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperators;
  },

  getHoistOperatorById: async (id: number) => {
    const hoistOperator = await context.prisma.hoistOperator
      .findUnique({ where: { id }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperator;
  },

  createHoistOperator: async (name: string) => {
    try {
      z.string().max(4).parse(name);
    } catch {
      throw createGraphQLError("Name must be 4 characters or less");
    }

    const hoistOperator = await context.prisma.hoistOperator
      .create({ data: { name }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return hoistOperator;
  },

  updateHoistOperator: async (data: { id: number; name: string }) => {
    try {
      z.string().max(4).min(1).parse(data.name);
    } catch {
      throw createGraphQLError("Name must be 4 characters or less");
    }

    const hoistOperator = await context.prisma.hoistOperator
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

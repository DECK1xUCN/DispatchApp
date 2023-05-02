import { Context } from "../utils/context";
import { validateName } from "../utils/validators";
import { createGraphQLError } from "graphql-yoga";

export default {
  getPilot: async (id: number, ctx: Context) => {
    const pilot = await ctx.prisma.pilot
      .findUnique({ where: { id }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return pilot;
  },

  getPilots: async (ctx: Context) => {
    const pilots = await ctx.prisma.pilot
      .findMany({ include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return pilots;
  },

  createPilot: async (name: string, ctx: Context) => {
    const pilot = await ctx.prisma.pilot
      .create({
        data: { name: validateName(name) },
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return pilot;
  },

  updatePilot: async (data: { id: number; name: string }, ctx: Context) => {
    const pilot = await ctx.prisma.pilot
      .update({
        where: { id: data.id },
        data: { name: validateName(data.name) },
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return pilot;
  },
};

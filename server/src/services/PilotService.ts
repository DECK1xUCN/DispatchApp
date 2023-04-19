import { ctx } from "@/utils/context";
import { checkName } from "@/utils/zodCheck";
import { createGraphQLError } from "graphql-yoga";

export default {
  getPilot: async (id: number) => {
    const pilot = await ctx.prisma.pilot
      .findUnique({ where: { id }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return pilot;
  },

  getPilots: async () => {
    const pilots = await ctx.prisma.pilot
      .findMany({ include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return pilots;
  },

  createPilot: async (name: string) => {
    const pilot = await ctx.prisma.pilot
      .create({ data: { name: checkName(name) }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return pilot;
  },

  updatePilot: async (data: { id: number; name: string }) => {
    const pilot = await ctx.prisma.pilot
      .update({
        where: { id: data.id },
        data: { name: checkName(data.name) },
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return pilot;
  },
};

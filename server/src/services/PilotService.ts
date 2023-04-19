import { ctx } from "@/utils/context";
import { checkStringMax4, cheeckEmptyString } from "@/utils/zodCheck";
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
    cheeckEmptyString(name);
    checkStringMax4(name);

    const pilot = await ctx.prisma.pilot
      .create({ data: { name }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return pilot;
  },

  updatePilot: async (data: { id: number; name: string }) => {
    cheeckEmptyString(data.name);
    checkStringMax4(data.name);

    const pilot = await ctx.prisma.pilot
      .update({
        where: { id: data.id },
        data: { name: data.name },
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return pilot;
  },
};

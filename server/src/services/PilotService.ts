import { CreatePilot } from "@/types/pilots";
import { context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

export default {
  getPilot: async (id: number) => {
    const pilot = await context.prisma.pilot
      .findUnique({ where: { id }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Pilot with id " + id + " not found");
      });
    return pilot;
  },

  getPilots: async () => {
    const pilots = await context.prisma.pilot
      .findMany({ include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("No pilots found");
      });
    return pilots;
  },

  createPilot: async (data: CreatePilot) => {
    const pilot = await context.prisma.pilot
      .create({ data: { name: data.name } })
      .catch(() => {
        throw createGraphQLError("Could not create pilot");
      });
    return pilot;
  },
};

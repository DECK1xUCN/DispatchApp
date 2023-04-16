import { CreateSite } from "@/types/sites";
import { context } from "../utils/context";
import { createGraphQLError } from "graphql-yoga";

export default {
  getSites: async () => {
    const sites = await context.prisma.site
      .findMany({
        include: { locations: true, flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Sites not found");
      });

    return sites;
  },

  getSite: async (id: number) => {
    const site = await context.prisma.site
      .findUnique({
        where: {
          id,
        },
        include: { locations: true, flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Site with id " + id + " not found");
      });

    return site;
  },

  createSite: async (name: string) => {
    const createdSite = await context.prisma.site
      .create({
        data: { name },
      })
      .catch(() => {
        throw createGraphQLError("Site could not be created");
      });

    return createdSite;
  },
};

import { context } from "../utils/context";
import { createGraphQLError } from "graphql-yoga";

export default {
  getSites: async () => {
    const sites = await context.prisma.site
      .findMany({
        include: { locations: true, flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
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
        throw createGraphQLError("Database exception");
      });

    return site;
  },

  createSite: async (name: string) => {
    const createdSite = await context.prisma.site
      .create({
        data: { name },
        include: { locations: true, flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });

    return createdSite;
  },

  updateSite: async (id: number, name: string) => {
    const updatedSite = await context.prisma.site
      .update({
        where: { id },
        data: { name },
        include: { locations: true, flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });

    return updatedSite;
  },
};

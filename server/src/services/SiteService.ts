import { cheeckEmptyString } from "@/utils/zodCheck";
import { ctx } from "../utils/context";
import { createGraphQLError } from "graphql-yoga";

export default {
  getSites: async () => {
    const sites = await ctx.prisma.site
      .findMany({
        include: { locations: true, flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });

    return sites;
  },

  getSite: async (id: number) => {
    const site = await ctx.prisma.site
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
    const createdSite = await ctx.prisma.site
      .create({
        data: { name: cheeckEmptyString(name) },
        include: { locations: true, flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });

    return createdSite;
  },

  updateSite: async (id: number, name: string) => {
    const updatedSite = await ctx.prisma.site
      .update({
        where: { id },
        data: { name: cheeckEmptyString(name) },
        include: { locations: true, flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });

    return updatedSite;
  },
};

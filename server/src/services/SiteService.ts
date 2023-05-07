import { validateEmptyString } from "../utils/validators";
import { Context } from "../utils/context";
import { createGraphQLError } from "graphql-yoga";

export default {
  getSites: async (ctx: Context) => {
    const sites = await ctx.prisma.site
      .findMany({
        include: { locations: true, flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });

    return sites;
  },

  getSite: async (id: number, ctx: Context) => {
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

  createSite: async (name: string, ctx: Context) => {
    const createdSite = await ctx.prisma.site
      .create({
        data: { name: validateEmptyString(name) },
        include: { locations: true, flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });

    return createdSite;
  },

  updateSite: async (data: { id: number; name: string }, ctx: Context) => {
    const updatedSite = await ctx.prisma.site
      .update({
        where: { id: data.id },
        data: { name: validateEmptyString(data.name) },
        include: { locations: true, flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });

    return updatedSite;
  },
};

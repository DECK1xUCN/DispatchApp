import { context } from "../utils/context";
import { createGraphQLError } from "graphql-yoga";
import z from "zod";

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
    try {
      z.string().nonempty().parse(name);
    } catch {
      throw createGraphQLError("Name cannot be empty");
    }

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
    try {
      z.string().nonempty().parse(name);
    } catch {
      throw createGraphQLError("Name cannot be empty");
    }

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

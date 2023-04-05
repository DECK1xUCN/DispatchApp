import { SiteInput } from "@/types/sites";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

const siteResolver = {
  Query: {
    sites: async (parent: any, args: any, context: Context) => {
      const sites = await context.prisma.site.findMany();
      if (!sites) {
        throw createGraphQLError(`No sites found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return sites;
    },
    site: async (parent: any, args: { id: string }, context: Context) => {
      const site = await context.prisma.site.findUnique({
        where: { id: parseInt(args.id) },
      });
      if (!site) {
        throw createGraphQLError(`No site found with id ${args.id}`, {
          extensions: {
            code: "404",
          },
        });
      }
      return site;
    },
  },

  Mutation: {
    createSite: async (
      parent: any,
      args: { data: SiteInput },
      context: Context
    ) => {
      const site = await context.prisma.site.create({
        data: {
          name: args.data.name,
        },
      });
      if (!site) {
        throw createGraphQLError(`Site could not be created`, {
          extensions: {
            code: "500",
          },
        });
      }
      return site;
    },

    updateSite: async (
      parent: any,
      args: { id: string; data: SiteInput },
      context: Context
    ) => {
      const site = await context.prisma.site.update({
        where: { id: parseInt(args.id) },
        data: {
          name: args.data.name,
        },
      });
      if (!site) {
        throw createGraphQLError(`Site could not be updated`, {
          extensions: {
            code: "500",
          },
        });
      }
      return site;
    },
  },
};

export default siteResolver;

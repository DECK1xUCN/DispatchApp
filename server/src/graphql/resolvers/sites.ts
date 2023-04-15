import { Context } from "@/utils/context";

const siteResolver = {
  Query: {
    sites: async (parent: any, args: any, context: Context) => {
      const sites = await context.prisma.site.findMany({
        include: { locations: true, flights: true },
      });
      return sites;
    },
    site: async (parent: any, { id }: any, context: Context) => {
      const site = await context.prisma.site.findUnique({
        where: {
          id,
        },
        include: { locations: true, flights: true },
      });
      return site;
    },
  },
  Mutation: {
    createSite: async (parent: any, { name }: any, context: Context) => {
      const createdSite = await context.prisma.site.create({
        data: {
          name,
        },
      });
      return createdSite;
    },
  },
};

export default siteResolver;

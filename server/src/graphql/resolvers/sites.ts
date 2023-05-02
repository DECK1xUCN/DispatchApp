import { ctx } from "../../utils/context";
import SiteService from "../../services/SiteService";
import { CreateSite } from "../../types/sites";
import { createGraphQLError } from "graphql-yoga";

const siteResolver = {
  Query: {
    sites: async () => {
      const sites = await SiteService.getSites(ctx);
      if (!sites) throw createGraphQLError("Sites not found");
      return sites;
    },

    site: async (_: any, args: { id: number }) => {
      const site = await SiteService.getSite(args.id, ctx);
      if (!site)
        throw createGraphQLError("Site with id " + args.id + " not found");
      return site;
    },
  },

  Mutation: {
    createSite: async (_: any, args: { data: CreateSite }) => {
      const createdSite = await SiteService.createSite(args.data.name, ctx);
      if (!createdSite) throw createGraphQLError("Site could not be created");
      return createdSite;
    },

    updateSite: async (_: any, args: { id: number; name: string }) => {
      const updatedSite = await SiteService.updateSite(
        { id: args.id, name: args.name },
        ctx
      );
      if (!updatedSite) throw createGraphQLError("Site could not be updated");
      return updatedSite;
    },
  },
};

export default siteResolver;

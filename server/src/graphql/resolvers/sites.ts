import SiteService from "../../services/SiteService";
import { CreateSite } from "../../types/sites";
import { createGraphQLError } from "graphql-yoga";

const siteResolver = {
  Query: {
    sites: async () => {
      const sites = await SiteService.getSites();
      if (!sites) throw createGraphQLError("Sites not found");
      return sites;
    },

    site: async (parent: any, args: { id: number }) => {
      const site = await SiteService.getSite(args.id);
      if (!site)
        throw createGraphQLError("Site with id " + args.id + " not found");
      return site;
    },
  },

  Mutation: {
    createSite: async (parent: any, args: { data: CreateSite }) => {
      const createdSite = await SiteService.createSite(args.data.name);
      if (!createdSite) throw createGraphQLError("Site could not be created");
      return createdSite;
    },

    updateSite: async (parent: any, args: { id: number; name: string }) => {
      const updatedSite = await SiteService.updateSite(args.id, args.name);
      if (!updatedSite) throw createGraphQLError("Site could not be updated");
      return updatedSite;
    },
  },
};

export default siteResolver;

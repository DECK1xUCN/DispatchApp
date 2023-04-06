import { SiteInput } from "@/types/sites";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

const siteResolver = {
  Query: {
    /**
     * Retrieves a list of sites from the database using Prisma's site.findMany() method.
     *
     * @async
     * @function
     * @param {any} parent - The parent object.
     * @param {any} args - The arguments passed to the function.
     * @param {Context} context - The context object containing the Prisma client.
     * @returns {Promise<Array>} A Promise that resolves to an array of site objects.
     * @throws {GraphQLError} If no sites are found, a GraphQLError with a 404 status code is thrown.
     */
    sites: async (parent: any, args: any, context: Context) => {
      const sites = await context.prisma.site.findMany().catch((err: any) => {
        throw createGraphQLError(`No sites found`, {
          extensions: {
            code: "404",
          },
        });
      });
      if (!sites) {
        throw createGraphQLError(`No sites found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return sites;
    },

    /**
     * Retrieves a site with a specified ID from the database using Prisma's site.findUnique() method.
     *
     * @async
     * @function
     * @param {any} parent - The parent object.
     * @param {{id: string}} args - An object containing the ID of the site to retrieve.
     * @param {Context} context - The context object containing the Prisma client.
     * @returns {Promise<Object>} A Promise that resolves to a site object.
     * @throws {GraphQLError} If the site is not found, a GraphQLError with a 404 status code is thrown. If there is an error with the server, a GraphQLError with a 500 status code is thrown.
     */
    site: async (parent: any, args: { id: string }, context: Context) => {
      const site = await context.prisma.site
        .findUnique({
          where: { id: parseInt(args.id) },
        })
        .catch((err: any) => {
          throw createGraphQLError(`No site found with id ${args.id}`, {
            extensions: {
              code: "500",
            },
          });
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
    /**
     * Creates a new site in the database using Prisma's site.create() method.
     *
     * @async
     * @function
     * @param {any} parent - The parent object.
     * @param {{data: SiteInput}} args - An object containing the data for the new site to be created.
     * @param {Context} context - The context object containing the Prisma client.
     * @returns {Promise<Object>} A Promise that resolves to the created site object.
     * @throws {GraphQLError} If the site could not be created, a GraphQLError with a 500 status code is thrown.
     */
    createSite: async (
      parent: any,
      args: { data: SiteInput },
      context: Context
    ) => {
      const site = await context.prisma.site
        .create({
          data: {
            name: args.data.name,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Site could not be created`, {
            extensions: {
              code: "500",
            },
          });
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

    /**
     * Updates an existing site in the database using Prisma's site.update() method.
     *
     * @async
     * @function
     * @param {any} parent - The parent object.
     * @param {{id: string, data: SiteInput}} args - An object containing the ID of the site to update and the new data.
     * @param {Context} context - The context object containing the Prisma client.
     * @returns {Promise<Object>} A Promise that resolves to the updated site object.
     * @throws {GraphQLError} If the site could not be updated, a GraphQLError with a 500 status code is thrown.
     */
    updateSite: async (
      parent: any,
      args: { id: string; data: SiteInput },
      context: Context
    ) => {
      const site = await context.prisma.site
        .update({
          where: { id: parseInt(args.id) },
          data: {
            name: args.data.name,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Site could not be updated`, {
            extensions: {
              code: "500",
            },
          });
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

import { HeliportInput } from "@/types/heliports";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

const heliportResolver = {
  Query: {
    /**
     * Retrieves a list of all heliports in the system.
     *
     * @function
     * @async
     * @param {Object} parent - The parent of the resolver chain.
     * @param {Object} args - The arguments passed to the resolver.
     * @param {Object} context - The context object containing the Prisma client.
     * @returns {Promise<Array<Object>>} - A promise that resolves to an array of heliport objects.
     * @throws {GraphQLError} - Throws an error if no heliports are found.
     */
    heliports: async (parent: any, args: any, context: Context) => {
      const heliports = await context.prisma.heliport
        .findMany()
        .catch((err: any) => {
          throw createGraphQLError(`No heliports found`, {
            extensions: {
              code: "404",
            },
          });
        });
      if (!heliports) {
        throw createGraphQLError(`No heliports found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return heliports;
    },

    /**
     * Retrieves a heliport with a specified ID from the database using Prisma's heliport.findUnique() method.
     * @function
     * @async
     * @param {Object} parent - The parent of the resolver chain.
     * @param {{id: string}} args - An object containing the ID of the heliport to retrieve.
     * @param {Object} context - The context object containing the Prisma client.
     * @returns {Promise<Object>} - A promise that resolves to a heliport object.
     * @throws {GraphQLError} - Throws an error if the heliport is not found.
     * @throws {GraphQLError} - Throws an error if there is an error with the server.
     * @param {any} parent - The parent object.
     * @param {{id: string}} args - An object containing the ID of the heliport to retrieve.
     * @param {Context} context - The context object containing the Prisma client.
     * @returns {Promise<Object>} A Promise that resolves to a heliport object.
     * @throws {GraphQLError} If the heliport is not found, a GraphQLError with a 404 status code is thrown. If there is an error with the server, a GraphQLError with a 500 status code is thrown.
     */
    heliport: async (parent: any, args: { id: string }, context: Context) => {
      const heliport = await context.prisma.heliport
        .findUnique({
          where: { id: parseInt(args.id) },
        })
        .catch((err: any) => {
          throw createGraphQLError(`No heliport found with id ${args.id}`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!heliport) {
        throw createGraphQLError(`No heliport found with id ${args.id}`, {
          extensions: {
            code: "404",
          },
        });
      }
      return heliport;
    },
  },

  Mutation: {
    /**
     * Creates a new heliport.
     * @async
     * @function createHeliport
     * @param {Object} parent - The parent object.
     * @param {Object} args - The arguments object.
     * @param {Object} args.data - The data for the new heliport.
     * @param {string} args.data.name - The name of the heliport.
     * @param {Object} context - The context object.
     * @returns {Promise<Object>} The newly created heliport.
     * @throws {GraphQLError} If the heliport could not be created.
     * @throws {Error} If an unexpected error occurs.
     */
    createHeliport: async (
      parent: any,
      args: { data: HeliportInput },
      context: Context
    ) => {
      const heliport = await context.prisma.heliport
        .create({
          data: {
            name: args.data.name,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Heliport could not be created`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!heliport) {
        throw createGraphQLError(`Heliport could not be created`, {
          extensions: {
            code: "500",
          },
        });
      }
      return heliport;
    },

    /**
     * Updates a heliport record in the database.
     *
     * @async
     * @function updateHeliport
     * @param {object} parent - The parent object of the GraphQL resolver chain.
     * @param {object} args - The arguments passed to the GraphQL resolver.
     * @param {string} args.id - The ID of the heliport to update.
     * @param {object} args.data - The updated data to apply to the heliport.
     * @param {string} args.data.name - The updated name of the heliport.
     * @param {object} context - The context object of the GraphQL resolver chain.
     * @param {object} context.prisma - The Prisma client instance used to interact with the database.
     * @returns {Promise<object>} A Promise that resolves to the updated heliport record.
     * @throws {GraphQLError} If the heliport record could not be updated.
     */
    updateHeliport: async (
      parent: any,
      args: { id: string; data: HeliportInput },
      context: Context
    ) => {
      const heliport = await context.prisma.heliport
        .update({
          where: { id: parseInt(args.id) },
          data: {
            name: args.data.name,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Heliport could not be updated`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!heliport) {
        throw createGraphQLError(`Heliport could not be updated`, {
          extensions: {
            code: "500",
          },
        });
      }
      return heliport;
    },
  },
};

export default heliportResolver;

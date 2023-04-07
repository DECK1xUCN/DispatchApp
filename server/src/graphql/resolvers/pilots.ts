import { PilotInput } from "@/types/pilots";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

const pilotResolver = {
  Query: {
    /**
     * Retrieves all pilots from the database using Prisma's pilot.findMany() method.
     *
     * @async
     * @function
     * @param {any} parent - The parent object.
     * @param {any} args - Unused.
     * @param {Context} context - The context object containing the Prisma client.
     * @returns {Promise<Array<Object>>} A Promise that resolves to an array of pilot objects.
     * @throws {GraphQLError} If no pilots are found, a GraphQLError with a 404 status code is thrown.
     */
    pilots: async (parent: any, args: any, context: Context) => {
      const pilots = await context.prisma.pilot.findMany().catch((err: any) => {
        throw createGraphQLError(`No sites found`, {
          extensions: {
            code: "404",
          },
        });
      });
      if (!pilots) {
        throw createGraphQLError(`No sites found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return pilots;
    },

    /**
     * Retrieves a single pilot by ID from the database using Prisma's pilot.findUnique() method.
     *
     * @async
     * @function
     * @param {any} parent - The parent object.
     * @param {{id: string}} args - An object containing the ID of the pilot to retrieve.
     * @param {Context} context - The context object containing the Prisma client.
     * @returns {Promise<Object>} A Promise that resolves to a pilot object.
     * @throws {GraphQLError} If no pilot is found with the specified ID, a GraphQLError with a 404 status code is thrown.
     */
    pilot: async (parent: any, args: { id: string }, context: Context) => {
      const pilot = await context.prisma.pilot
        .findUnique({
          where: { id: parseInt(args.id) },
        })
        .catch((err: any) => {
          throw createGraphQLError(`No pilot found with id ${args.id}`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!pilot) {
        throw createGraphQLError(`No pilot found with id ${args.id}`, {
          extensions: {
            code: "404",
          },
        });
      }
      return pilot;
    },
  },

  Mutation: {
    /**
     *Creates a new pilot with the given name.
     * @async
     * @function createPilot
     * @param {Object} parent - The parent resolver's result.
     * @param {Object} args - The arguments passed to the resolver.
     * @param {Object} args.data - The input data for creating a new pilot.
     * @param {string} args.data.name - The name of the new pilot.
     * @param {Object} context - The context object containing the Prisma client.
     * @throws {GraphQLError} Throws an error if the pilot could not be created.
     * @returns {Object} Returns the newly created pilot object.
     */
    createPilot: async (
      parent: any,
      args: { data: PilotInput },
      context: Context
    ) => {
      const pilot = await context.prisma.pilot
        .create({
          data: {
            name: args.data.name,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Pilot could not be created`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!pilot) {
        throw createGraphQLError(`Pilot could not be created`, {
          extensions: {
            code: "500",
          },
        });
      }
      return pilot;
    },

    /**
     * Updates the details of a specific pilot.
     *
     * @async
     * @function updatePilot
     * @param {Object} parent - The parent object in the resolver chain.
     * @param {Object} args - The arguments passed to the resolver function.
     * @param {string} args.id - The ID of the pilot to update.
     * @param {Object} args.data - The updated details of the pilot.
     * @param {string} args.data.name - The updated name of the pilot.
     * @param {Object} context - The context object containing services such as the Prisma client.
     * @returns {Promise<Object>} The updated pilot.
     * @throws {Error} Throws an error if the pilot cannot be found or updated.
     */
    updatePilot: async (
      parent: any,
      args: { id: string; data: PilotInput },
      context: Context
    ) => {
      const pilot = await context.prisma.pilot
        .update({
          where: { id: parseInt(args.id) },
          data: {
            name: args.data.name,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Pilot could not be updated`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!pilot) {
        throw createGraphQLError(`Pilot could not be updated`, {
          extensions: {
            code: "500",
          },
        });
      }
      return pilot;
    },
  },
};

export default pilotResolver;

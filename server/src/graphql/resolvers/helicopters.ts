import { UpdateHelicopterInput } from "@/types/helicopters";
import { CreateHelicopterInput } from "@/types/helicopters";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

const helicopterResolver = {
  Query: {
    helicoptersWhereModel: async (
      _parent: any,
      args: { model: string },
      context: Context
    ) => {
      const helicopters = await context.prisma.helicopter
        .findMany({
          where: { model: args.model },
        })
        .catch((err: any) => {
          throw createGraphQLError(
            `No helicopters found with model ${args.model}`,
            {
              extensions: {
                code: "500",
              },
            }
          );
        });
      if (!helicopters) {
        throw createGraphQLError(
          `No helicopters found with model ${args.model}`,
          {
            extensions: {
              code: "404",
            },
          }
        );
      }
      return helicopters;
    },
    /**
     * Retrieves a list of all helicopters.
     *
     * @async
     * @function
     * @param {any} parent - The parent value of the resolver chain.
     * @param {any} args - The arguments passed to the resolver.
     * @param {Context} context - The context object containing the Prisma client.
     * @returns {Promise<Array>} - A Promise that resolves to an array of helicopters.
     * @throws Will throw an error if no helicopters are found.
     */
    helicopters: async (parent: any, args: any, context: Context) => {
      const helicopters = await context.prisma.helicopter.findMany();
      if (!helicopters) {
        throw createGraphQLError(`No helicopters found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return helicopters;
    },

    /**
     * Returns a list of all helicopters.
     *
     * @async
     * @function
     * @param {object} parent - The parent object.
     * @param {object} args - The arguments object.
     * @param {object} context - The context object.
     * @returns {Promise<object[]>} - A promise that resolves to an array of all helicopters.
     * @throws {Error} - If no helicopters are found, throws a 404 error.
     */
    helicopter: async (parent: any, args: { id: string }, context: Context) => {
      const helicopter = await context.prisma.helicopter.findUnique({
        where: { id: parseInt(args.id) },
      });
      if (!helicopter) {
        throw createGraphQLError(`No helicopter found with id ${args.id}`, {
          extensions: {
            code: "404",
          },
        });
      }
      return helicopter;
    },
  },
  Mutation: {
    /**
     * Creates a new helicopter in the database.
     *
     * @async
     * @function createHelicopter
     *
     * @param {any} parent - The parent of the GraphQL resolver.
     * @param {Object} args - The arguments for the function.
     * @param {Object} args.data - The data for the new helicopter.
     * @param {string} args.data.reg - The registration code of the new helicopter.
     * @param {string} args.data.model - The model of the new helicopter.
     * @param {Object} context - The context object for the GraphQL resolver.
     * @param {Object} context.prisma - The Prisma client for interacting with the database.
     *
     * @throws {GraphQLError} If the helicopter could not be created.
     *
     * @returns {Object} The newly created helicopter.
     */
    createHelicopter: async (
      parent: any,
      args: { data: CreateHelicopterInput },
      context: Context
    ) => {
      const helicopter = await context.prisma.helicopter
        .create({
          data: {
            reg: args.data.reg,
            model: args.data.model,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Helicopter could not be created`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!helicopter) {
        throw createGraphQLError(`Helicopter could not be created`, {
          extensions: {
            code: "500",
          },
        });
      }
      return helicopter;
    },

    /**
     * Updates an existing helicopter in the database.
     *
     * @async
     * @function updateHelicopter
     *
     * @param {any} parent - The parent of the GraphQL resolver.
     * @param {Object} args - The arguments for the function.
     * @param {string} args.id - The ID of the helicopter to update.
     * @param {Object} args.data - The data to update the helicopter with.
     * @param {string} [args.data.reg] - The new registration code of the helicopter.
     * @param {string} [args.data.model] - The new model of the helicopter.
     * @param {Object} context - The context object for the GraphQL resolver.
     * @param {Object} context.prisma - The Prisma client for interacting with the database.
     *
     * @throws {GraphQLError} If the helicopter could not be updated.
     *
     * @returns {Object} The updated helicopter.
     */
    updateHelicopter: async (
      parent: any,
      args: { id: string; data: UpdateHelicopterInput },
      context: Context
    ) => {
      const helicopter = await context.prisma.helicopter
        .update({
          where: { id: parseInt(args.id) },
          data: {
            reg: args.data.reg && args.data.reg,
            model: args.data.model && args.data.model,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Helicopter could not be updated`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!helicopter) {
        throw createGraphQLError(`Helicopter could not be updated`, {
          extensions: {
            code: "500",
          },
        });
      }
      return helicopter;
    },
  },
};

export default helicopterResolver;

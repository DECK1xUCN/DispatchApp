import { HoistOperatorInput } from "@/types/hoistOperators";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

const hoistOperatorResolver = {
  Query: {
    /**
     * Retrieves a hoist operator by ID.
     *
     * @function
     * @async
     * @param {object} parent - The parent object.
     * @param {object} args - The arguments object containing the ID of the operator to retrieve.
     * @param {string} args.id - The ID of the operator to retrieve.
     * @param {object} context - The context object containing the Prisma client.
     * @returns {Promise<object>} A Promise that resolves to the retrieved operator object.
     * @throws {Error} Throws an error if the operator could not be found.
     */
    hoistOperator: async (parent: any, args: any, context: Context) => {
      const operator = await context.prisma.hoistOperator
        .findUnique({
          where: { id: parseInt(args.id) },
        })
        .catch((err: any) => {
          throw createGraphQLError(`No operator found with id ${args.id}`, {
            extensions: {
              code: "404",
            },
          });
        });
      if (!operator) {
        throw createGraphQLError(`No operator found with id ${args.id}`, {
          extensions: {
            code: "404",
          },
        });
      }
      return operator;
    },

    /**
     * Retrieves all hoist operators from the database
     *
     * @async
     * @function
     * @param {Object} parent - The parent object.
     * @param {Object} args - The arguments object.
     * @param {Object} context - The context object.
     * @throws Will throw an error if no operators are found.
     * @returns {Promise<Array>} Returns an array of hoist operators.
     */
    hoistOperators: async (parent: any, args: any, context: Context) => {
      const operators = await context.prisma.hoistOperator
        .findMany()
        .catch((err: any) => {
          throw createGraphQLError(`No operators found`, {
            extensions: {
              code: "404",
            },
          });
        });
      if (!operators) {
        throw createGraphQLError(`No operators found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return operators;
    },
  },
  Mutation: {
    /**
     * Creates a new hoist operator with the specified name.
     *
     * @async
     * @function createHoistOperator
     * @param {object} parent - The parent object in the resolver chain.
     * @param {object} args - The arguments passed to the resolver.
     * @param {object} args.data - The data required to create the hoist operator.
     * @param {string} args.data.name - The name of the hoist operator to be created.
     * @param {object} context - The context object containing the Prisma client.
     * @param {object} context.prisma - The Prisma client for database queries.
     * @returns {Promise<object>} Returns a Promise that resolves to the created hoist operator.
     * @throws {object} Throws an error if the hoist operator could not be created.
     * @throws {object} Throws an error if the Prisma client fails to perform the database query.
     */
    createHoistOperator: async (
      parent: any,
      args: { data: HoistOperatorInput },
      context: Context
    ) => {
      const operator = await context.prisma.hoistOperator
        .create({
          data: {
            name: args.data.name,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Operator could not be created`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!operator) {
        throw createGraphQLError(`Operator could not be created`, {
          extensions: {
            code: "500",
          },
        });
      }
      return operator;
    },

    /**
     * Update a hoist operator in the database.
     * @async
     * @function updateHoistOperator
     * @param {Object} parent - The parent object.
     * @param {Object} args - The arguments object.
     * @param {string} args.id - The ID of the operator to update.
     * @param {HoistOperatorInput} args.data - The new data for the operator.
     * @param {Context} context - The context object.
     * @returns {Promise<HoistOperator>} The updated hoist operator.
     * @throws {GraphQLError} If the operator cannot be updated.
     */
    updateHoistOperator: async (
      parent: any,
      args: { id: string; data: HoistOperatorInput },
      context: Context
    ) => {
      const operator = await context.prisma.hoistOperator
        .update({
          where: { id: parseInt(args.id) },
          data: {
            name: args.data.name,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Operator could not be updated`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!operator) {
        throw createGraphQLError(`Operator could not be updated`, {
          extensions: {
            code: "500",
          },
        });
      }
      return operator;
    },
  },
};

export default hoistOperatorResolver;

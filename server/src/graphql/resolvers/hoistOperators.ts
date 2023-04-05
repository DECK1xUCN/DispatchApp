import { HoistOperatorInput } from "@/types/hoistOperators";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

const hoistOperatorResolver = {
  Query: {
    hoistOperator: async (parent: any, args: any, context: Context) => {
      const operator = await context.prisma.hoistOperator.findUnique({
        where: { id: parseInt(args.id) },
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
    hoistOperators: async (parent: any, args: any, context: Context) => {
      const operators = await context.prisma.hoistOperator.findMany();
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
    createHoistOperator: async (
      parent: any,
      args: { data: HoistOperatorInput },
      context: Context
    ) => {
      const operator = await context.prisma.hoistOperator.create({
        data: {
          name: args.data.name,
        },
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
    updateHoistOperator: async (
      parent: any,
      args: { id: string; data: HoistOperatorInput },
      context: Context
    ) => {
      const operator = await context.prisma.hoistOperator.update({
        where: { id: parseInt(args.id) },
        data: {
          name: args.data.name,
        },
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

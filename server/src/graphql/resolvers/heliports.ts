import { HeliportInput } from "@/types/heliports";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

const heliportResolver = {
  Query: {
    heliports: async (parent: any, args: any, context: Context) => {
      const heliports = await context.prisma.heliport.findMany();
      if (!heliports) {
        throw createGraphQLError(`No heliports found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return heliports;
    },
    heliport: async (parent: any, args: { id: string }, context: Context) => {
      const heliport = await context.prisma.heliport.findUnique({
        where: { id: parseInt(args.id) },
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
    createHeliport: async (
      parent: any,
      args: { data: HeliportInput },
      context: Context
    ) => {
      const heliport = await context.prisma.heliport.create({
        data: {
          name: args.data.name,
        },
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

    updateHeliport: async (
      parent: any,
      args: { id: string; data: HeliportInput },
      context: Context
    ) => {
      const heliport = await context.prisma.heliport.update({
        where: { id: parseInt(args.id) },
        data: {
          name: args.data.name,
        },
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

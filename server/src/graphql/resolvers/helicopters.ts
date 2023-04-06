import { UpdateHelicopterInput } from "@/types/helicopters";
import { CreateHelicopterInput } from "@/types/helicopters";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

const helicopterResolver = {
  Query: {
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

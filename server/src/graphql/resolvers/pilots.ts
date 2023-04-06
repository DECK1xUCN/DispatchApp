import { PilotInput } from "@/types/pilots";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

const pilotResolver = {
  Query: {
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

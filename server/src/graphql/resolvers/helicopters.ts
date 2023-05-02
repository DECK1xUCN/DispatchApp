import HelicopterService from "../../services/HelicopterService";
import { CreateHelicopter } from "../../types/helicopters";
import { createGraphQLError } from "graphql-yoga";

const helicopterResolver = {
  Query: {
    helicopter: async (parent: any, args: { id: number }) => {
      const helicopter = HelicopterService.getHelicopter(args.id);
      if (!helicopter)
        throw createGraphQLError(
          "Helicopter with id " + args.id + " not found"
        );
      return helicopter;
    },

    // depracted
    helicoptersWhereModel: async (parent: any, args: { model: string }) => {
      const helicopters = HelicopterService.getHelicoptersWhereModel(
        args.model
      );
      if (!helicopters)
        throw createGraphQLError(
          "No helicopters found with model " + args.model
        );
      return helicopters;
    },

    helicopters: async (parent: any, args: { model?: string }) => {
      let helicopters;
      if (args.model) {
        helicopters = HelicopterService.getHelicoptersWhereModel(args.model);
      } else {
        helicopters = HelicopterService.getHelicopters();
      }
      if (!helicopters) throw createGraphQLError("No helicopters found");
      return helicopters;
    },
  },
  Mutation: {
    createHelicopter: async (parent: any, args: { data: CreateHelicopter }) => {
      const helicopter = HelicopterService.createHelicopter(args.data);
      if (!helicopter) throw createGraphQLError("Failed to create helicopter");
      return helicopter;
    },
  },
};

export default helicopterResolver;

import { ctx } from "../../utils/context";
import PilotService from "../../services/PilotService";
import { createGraphQLError } from "graphql-yoga";

const pilotResolver = {
  Query: {
    pilot: async (_: any, args: { id: number }) => {
      const pilot = await PilotService.getPilot(args.id, ctx);
      if (!pilot)
        throw createGraphQLError("Pilot with id " + args.id + " not found");
      return pilot;
    },

    pilots: async () => {
      const pilots = await PilotService.getPilots(ctx);
      if (!pilots || pilots.length === 0)
        throw createGraphQLError("No pilots found");
      return pilots;
    },
  },

  Mutation: {
    createPilot: async (_: any, args: { name: string }) => {
      const pilot = await PilotService.createPilot(args.name, ctx);
      if (!pilot) throw createGraphQLError("Could not create pilot");
      return pilot;
    },

    updatePilot: async (_: any, args: { id: number; name: string }) => {
      const pilot = await PilotService.updatePilot(args, ctx);
      if (!pilot) throw createGraphQLError("Could not update pilot");
      return pilot;
    },
  },
};

export default pilotResolver;

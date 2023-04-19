import PilotService from "@/services/PilotService";
import { createGraphQLError } from "graphql-yoga";

const pilotResolver = {
  Query: {
    pilot: async (parent: any, args: { id: number }) => {
      const pilot = await PilotService.getPilot(args.id);
      if (!pilot)
        throw createGraphQLError("Pilot with id " + args.id + " not found");
      return pilot;
    },

    pilots: async () => {
      const pilots = await PilotService.getPilots();
      if (!pilots || pilots.length === 0)
        throw createGraphQLError("No pilots found");
      return pilots;
    },
  },

  Mutation: {
    createPilot: async (parent: any, args: { name: string }) => {
      const pilot = await PilotService.createPilot(args.name);
      if (!pilot) throw createGraphQLError("Could not create pilot");
      return pilot;
    },

    updatePilot: async (parent: any, args: { id: number; name: string }) => {
      const pilot = await PilotService.updatePilot(args);
      if (!pilot) throw createGraphQLError("Could not update pilot");
      return pilot;
    },
  },
};

export default pilotResolver;

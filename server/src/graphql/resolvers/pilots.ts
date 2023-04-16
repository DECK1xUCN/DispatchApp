import PilotService from "@/services/PilotService";
import { CreatePilot } from "@/types/pilots";
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
      if (!pilots) throw createGraphQLError("No pilots found");
      if (pilots.length === 0) throw createGraphQLError("No pilots found");
      return pilots;
    },
  },
  Mutation: {
    createPilot: async (parent: any, args: { data: CreatePilot }) => {
      const pilot = await PilotService.createPilot(args.data);
      if (!pilot) throw createGraphQLError("Could not create pilot");
      return pilot;
    },
  },
};

export default pilotResolver;

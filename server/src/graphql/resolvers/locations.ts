import LocationService from "@/services/LocationService";
import { CreateLocation } from "@/types/locations";
import { createGraphQLError } from "graphql-yoga";

const locationsResolver = {
  Query: {
    locations: async (parent: any) => {
      const locations = await LocationService.getLocations();

      if (!locations) throw createGraphQLError("Locations not found");
      return locations;
    },

    location: async (parent: any, args: { id: number }) => {
      const location = await LocationService.getLocation(args.id);

      if (!location)
        throw createGraphQLError("Location with id " + args.id + " not found");
      return location;
    },
  },
  Mutation: {
    createLocation: async (parent: any, args: { data: CreateLocation }) => {
      const location = await LocationService.createLocation(args.data);

      if (!location) throw createGraphQLError("Location could not be created");
      return location;
    },
  },
};

export default locationsResolver;

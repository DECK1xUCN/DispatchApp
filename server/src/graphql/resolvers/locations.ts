import LocationService from "@/services/LocationService";
import { CreateLocation, UpdateLocation } from "@/types/locations";
import { createGraphQLError } from "graphql-yoga";

const locationsResolver = {
  Query: {
    locations: async (
      parent: any,
      args: { siteId?: number; type?: string }
    ) => {
      let locations;
      if (args.siteId && args.type) {
        locations = await LocationService.getLocationsWhereTypeAndId(
          args.type,
          args.siteId
        );
      } else if (args.type) {
        locations = await LocationService.getLocationsWhereType(args.type);
      } else if (args.siteId) {
        locations = await LocationService.getLocationsPerSite(args.siteId);
      } else {
        locations = await LocationService.getLocations();
      }

      if (!locations) throw createGraphQLError("Locations not found");
      return locations;
    },

    location: async (parent: any, args: { id: number }) => {
      const location = await LocationService.getLocation(args.id);

      if (!location)
        throw createGraphQLError("Location with id " + args.id + " not found");
      return location;
    },
    locoationsPerSite: async (parent: any, args: { siteId: number }) => {
      const locations = await LocationService.getLocationsPerSite(args.siteId);

      if (!locations)
        throw createGraphQLError(
          "Locations for site with id " + args.siteId + " not found"
        );
      return locations;
    },
    heliportsPerSite: async (parent: any, args: { siteId: number }) => {
      const locations = await LocationService.getHeliportsPerSite(args.siteId);

      if (!locations)
        throw createGraphQLError(
          "Heliports for site with id " + args.siteId + " not found"
        );
      return locations;
    },
    viaPerSite: async (parent: any, args: { siteId: number }) => {
      const locations = await LocationService.getViaPerSite(args.siteId);

      if (!locations)
        throw createGraphQLError(
          "Via for site with id " + args.siteId + " not found"
        );
      return locations;
    },
  },

  Mutation: {
    createLocation: async (parent: any, args: { data: CreateLocation }) => {
      const location = await LocationService.createLocation(args.data);

      if (!location) throw createGraphQLError("Location could not be created");
      return location;
    },

    updateLocation: async (
      parent: any,
      args: { id: number; data: UpdateLocation }
    ) => {
      const location = await LocationService.updateLocation(args.id, args.data);

      if (!location) throw createGraphQLError("Location could not be updated");
      return location;
    },
  },
};

export default locationsResolver;

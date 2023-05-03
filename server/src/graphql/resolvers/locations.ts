import { ctx } from "../../utils/context";
import LocationService from "../../services/LocationService";
import { CreateLocation, UpdateLocation } from "../../types/locations";
import { createGraphQLError } from "graphql-yoga";

const locationsResolver = {
  Query: {
    locations: async (_: any, args: { siteId?: number; type?: string }) => {
      let locations;
      if (args.siteId && args.type) {
        locations = await LocationService.getLocationsWhereTypeAndId(
          {
            type: args.type,
            id: args.siteId,
          },
          ctx
        );
      } else if (args.type) {
        locations = await LocationService.getLocationsWhereType(args.type, ctx);
      } else if (args.siteId) {
        locations = await LocationService.getLocationsPerSite(args.siteId, ctx);
      } else {
        locations = await LocationService.getLocations(ctx);
      }

      if (!locations) throw createGraphQLError("Locations not found");
      return locations;
    },

    location: async (_: any, args: { id: number }) => {
      const location = await LocationService.getLocation(args.id, ctx);

      if (!location)
        throw createGraphQLError("Location with id " + args.id + " not found");
      return location;
    },
    locoationsPerSite: async (_: any, args: { siteId: number }) => {
      const locations = await LocationService.getLocationsPerSite(
        args.siteId,
        ctx
      );

      if (!locations)
        throw createGraphQLError(
          "Locations for site with id " + args.siteId + " not found"
        );
      return locations;
    },
    heliportsPerSite: async (_: any, args: { siteId: number }) => {
      const locations = await LocationService.getHeliportsPerSite(
        args.siteId,
        ctx
      );

      if (!locations)
        throw createGraphQLError(
          "Heliports for site with id " + args.siteId + " not found"
        );
      return locations;
    },
    viaPerSite: async (_: any, args: { siteId: number }) => {
      const locations = await LocationService.getViaPerSite(args.siteId, ctx);

      if (!locations)
        throw createGraphQLError(
          "Via for site with id " + args.siteId + " not found"
        );
      return locations;
    },
  },

  Mutation: {
    createLocation: async (_: any, args: { data: CreateLocation }) => {
      const location = await LocationService.createLocation(args.data, ctx);

      if (!location) throw createGraphQLError("Location could not be created");
      return location;
    },

    updateLocation: async (
      _: any,
      args: { id: number; data: UpdateLocation }
    ) => {
      const location = await LocationService.updateLocation(
        { id: args.id, input: args.data },
        ctx
      );

      if (!location) throw createGraphQLError("Location could not be updated");
      return location;
    },
  },
};

export default locationsResolver;

import { CreateLocation, LocationType } from "@/types/locations";
import { Context, context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

export default {
  getLocation: async (id: number) => {
    const location = await context.prisma.location
      .findUnique({
        where: { id },
        include: { site: true },
      })
      .catch(() => {
        throw createGraphQLError("Location with id " + id + " not found");
      });
    return location;
  },

  getLocations: async () => {
    const locations = await context.prisma.location
      .findMany({ include: { site: true } })
      .catch(() => {
        throw createGraphQLError("Locations not found");
      });

    return locations;
  },

  createLocation: async (input: CreateLocation) => {
    const location = await context.prisma.location
      .create({
        data: {
          name: input.name,
          lat: input.lat ?? 0,
          lng: input.lng ?? 0,
          type: input.type as LocationType,
          siteId: input.siteId,
        },
      })
      .catch(() => {
        throw createGraphQLError("Location could not be created");
      });
    return location;
  },
};

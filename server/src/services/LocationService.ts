import {
  CreateLocation,
  LocationType,
  UpdateLocation,
} from "../types/locations";
import { Context } from "../utils/context";
import { isLocationType } from "../utils/locationValidator";
import { validateLocationName } from "../utils/validators";
import { createGraphQLError } from "graphql-yoga";

export default {
  getLocation: async (id: number, ctx: Context) => {
    const location = await ctx.prisma.location
      .findUnique({
        where: { id },
        include: { site: true, from: true, via: true, to: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return location;
  },

  getLocations: async (ctx: Context) => {
    const locations = await ctx.prisma.location
      .findMany({ include: { site: true, from: true, via: true, to: true } })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });

    return locations;
  },

  getLocationsWhereType: async (type: string, ctx: Context) => {
    if (!isLocationType(type)) {
      throw createGraphQLError("Invalid location type");
    }
    const locations = await ctx.prisma.location
      .findMany({
        where: { type },
        include: { site: true, from: true, via: true, to: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    if (!locations) throw createGraphQLError("Locations not found");
    return locations;
  },

  getLocationsWhereTypeAndId: async (
    data: { type: string; id: number },
    ctx: Context
  ) => {
    if (!isLocationType(data.type)) {
      throw createGraphQLError("Invalid location type");
    }
    const locations = await ctx.prisma.location
      .findMany({
        where: { type: data.type, id: data.id },
        include: { site: true, from: true, via: true, to: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    if (!locations) throw createGraphQLError("Locations not found");
    return locations;
  },

  getLocationsPerSite: async (siteId: number, ctx: Context) => {
    const locations = await ctx.prisma.location
      .findMany({
        where: { siteId },
        include: { site: true, from: true, via: true, to: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return locations;
  },

  getHeliportsPerSite: async (siteId: number, ctx: Context) => {
    const locations = await ctx.prisma.location
      .findMany({
        where: { siteId, type: { in: ["HELIPORT", "AIRPORT"] } },
        include: { site: true, from: true, via: true, to: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return locations;
  },

  getViaPerSite: async (siteId: number, ctx: Context) => {
    const locations = await ctx.prisma.location
      .findMany({
        where: { siteId, type: "VIA" },
        include: { site: true, from: true, via: true, to: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return locations;
  },

  getViaByIds: async (ids: number[], ctx: Context) => {
    const locations = await ctx.prisma.location
      .findMany({
        where: { id: { in: ids }, type: "VIA" },
        include: { site: true, from: true, via: true, to: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return locations;
  },

  createLocation: async (input: CreateLocation, ctx: Context) => {
    if (!isLocationType(input.type))
      throw createGraphQLError("Location type is not valid");

    const location = await ctx.prisma.location
      .create({
        data: {
          name: validateLocationName(input.name),
          lat: input.lat ?? 0,
          lng: input.lng ?? 0,
          type: input.type as LocationType,
          siteId: input.siteId,
        },
        include: { site: true, from: true, via: true, to: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return location;
  },

  updateLocation: async (
    data: { id: number; input: UpdateLocation },
    ctx: Context
  ) => {
    if (data.input.name) validateLocationName(data.input.name);

    const location = await ctx.prisma.location
      .update({
        where: { id: data.id },
        data: {
          name: data.input.name,
          lat: data.input.lat,
          lng: data.input.lng,
        },
        include: { site: true, from: true, via: true, to: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return location;
  },

  validateLandable: async (id: number, ctx: Context) => {
    const location = await ctx.prisma.location
      .findUnique({
        where: { id },
        include: { site: true, from: true, via: true, to: true },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    if (location && (location.type === "HELIPORT" || "AIRPORT")) return true;
    return false;
  },
};

import { CreateFlight, UpdateFlight } from "../types/flights";
import { ctx } from "../utils/context";
import { createGraphQLError } from "graphql-yoga";
import { formatDate } from "../utils/dateHelper";
import {
  isAfter,
  validateDateBeforeNow,
  validateFlightNumber,
  validateFlightTime,
} from "../utils/validators";
import LocationService from "./LocationService";

export default {
  getFlights: async () => {
    const flights = await ctx.prisma.flight
      .findMany({
        include: {
          helicopter: true,
          pilot: true,
          hoistOperator: true,
          site: true,
          from: true,
          via: true,
          to: true,
          dailyUpdate: true,
          dailyReport: true,
        },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return flights;
  },

  getFlightsBySiteId: async (siteId: number) => {
    const flights = await ctx.prisma.flight
      .findMany({
        where: { siteId },
        include: {
          helicopter: true,
          pilot: true,
          hoistOperator: true,
          site: true,
          from: true,
          via: true,
          to: true,
          dailyUpdate: true,
          dailyReport: true,
        },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return flights;
  },

  getFlightsPerDay: async (inputDate: string) => {
    const date = formatDate(inputDate);
    const datePlusOne = new Date(
      date.getFullYear(),
      date.getMonth(),
      date.getDate() + 1
    );

    const flights = await ctx.prisma.flight
      .findMany({
        where: {
          date: {
            gte: date,
            lt: datePlusOne,
          },
        },
        include: {
          helicopter: true,
          pilot: true,
          hoistOperator: true,
          site: true,
          from: true,
          via: true,
          to: true,
          dailyUpdate: true,
          dailyReport: true,
        },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return flights;
  },

  getFlightsWhereDuIsNull: async () => {
    const flights = await ctx.prisma.flight
      .findMany({
        where: {
          dailyUpdate: {
            is: null,
          },
        },
        include: {
          helicopter: true,
          pilot: true,
          hoistOperator: true,
          site: true,
          from: true,
          via: true,
          to: true,
          dailyUpdate: true,
          dailyReport: true,
        },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return flights;
  },

  getFlightsWhereDfrIsNull: async () => {
    const flights = await ctx.prisma.flight
      .findMany({
        where: {
          dailyReport: {
            is: null,
          },
        },
        include: {
          helicopter: true,
          pilot: true,
          hoistOperator: true,
          site: true,
          from: true,
          via: true,
          to: true,
          dailyUpdate: true,
          dailyReport: true,
        },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return flights;
  },

  getFlightById: async (id: number) => {
    const flight = await ctx.prisma.flight
      .findUnique({
        where: { id },
        include: {
          helicopter: true,
          pilot: true,
          hoistOperator: true,
          site: true,
          from: true,
          via: true,
          to: true,
          dailyUpdate: true,
          dailyReport: true,
        },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return flight;
  },

  getFlightByFlightNumber: async (flightNumber: string) => {
    const flight = await ctx.prisma.flight
      .findUnique({
        where: { flightNumber },
        include: {
          helicopter: true,
          pilot: true,
          hoistOperator: true,
          site: true,
          from: true,
          via: true,
          to: true,
          dailyUpdate: true,
          dailyReport: true,
        },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return flight;
  },

  createFlight: async (data: CreateFlight) => {
    // when creating a flight, check if the date is in the past
    // if so, set editable to false
    let isEditable: boolean = true;
    if (validateDateBeforeNow(formatDate(data.date))) isEditable = false;

    // check if all via locations exist
    // if not, return null
    const via = await LocationService.getViaByIds(data.viaIds);
    if (data.viaIds.length > 0 && via.length !== data.viaIds.length)
      throw createGraphQLError("Enter valid locations for VIA");

    // check if to and from have valid location types
    const isFromLandable: boolean = await LocationService.validateLandable(
      data.fromId
    );
    const isToLandable: boolean = await LocationService.validateLandable(
      data.toId
    );
    if (!isFromLandable)
      throw createGraphQLError(
        "FROM location must be either Heliport or Airport"
      );
    if (!isToLandable)
      throw createGraphQLError(
        "TO location must be either Heliport or Airport"
      );

    const flight = await ctx.prisma.flight
      .create({
        data: {
          flightNumber: validateFlightNumber(data.flightNumber),
          date: formatDate(data.date),
          helicopterId: data.helicopterId,
          pilotId: data.pilotId,
          hoistOperatorId: data.hoistOperatorId,
          siteId: data.siteId,
          fromId: data.fromId,
          via: {
            connect: data.viaIds.map((id) => ({ id })),
          },
          toId: data.toId,
          etd: formatDate(data.etd),
          rotorStart: formatDate(data.etd),
          atd: formatDate(data.etd),
          eta: formatDate(data.eta),
          rotorStop: formatDate(data.eta),
          ata: formatDate(data.eta),
          flightTime: data.flightTime ? validateFlightTime(data.flightTime) : 0,
          blockTime: data.blockTime ? validateFlightTime(data.blockTime) : 0,
          pax: data.pax,
          paxTax: data.paxTax,
          cargoPP: data.cargoPP,
          hoistCycles: data.hoistCycles,
          note: data.note,
          editable: isEditable,
        },
        include: {
          helicopter: true,
          pilot: true,
          hoistOperator: true,
          site: true,
          from: true,
          via: true,
          to: true,
          dailyUpdate: true,
          dailyReport: true,
        },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    return flight;
  },

  updateFlight: async (id: number, data: UpdateFlight) => {
    const flight = await ctx.prisma.flight
      .findUnique({
        where: { id },
        include: {
          helicopter: true,
          pilot: true,
          hoistOperator: true,
          site: true,
          from: true,
          via: true,
          to: true,
          dailyUpdate: true,
          dailyReport: true,
        },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    if (!flight) throw createGraphQLError("Flight not found");
    if (validateDateBeforeNow(formatDate(flight.date.toString())))
      throw createGraphQLError("Flight is not editable");

    if (data.viaIds) {
      const via = await LocationService.getViaByIds(data.viaIds).catch(() => {
        throw createGraphQLError("Database exception");
      });
      if (data.viaIds.length > 0 && via.length !== data.viaIds.length)
        throw createGraphQLError("Enter valid locations for VIA");
    }

    // validate landable
    if (data.fromId) {
      const isFromLandable: boolean = await LocationService.validateLandable(
        data.fromId
      );
      if (!isFromLandable)
        throw createGraphQLError(
          "FROM location must be either Heliport or Airport"
        );
    }
    if (data.toId) {
      const isToLandable: boolean = await LocationService.validateLandable(
        data.toId
      );
      if (!isToLandable)
        throw createGraphQLError(
          "TO location must be either Heliport or Airport"
        );
    }

    const updatedFlight = await ctx.prisma.flight
      .update({
        where: { id },
        data: {
          flightNumber:
            data.flightNumber ?? validateFlightNumber(data.flightNumber),
          date: data.date ?? formatDate(data.date),
          helicopterId: data.helicopterId ?? data.helicopterId,
          pilotId: data.pilotId ?? data.pilotId,
          hoistOperatorId: data.hoistOperatorId ?? data.hoistOperatorId,
          siteId: data.siteId ?? data.siteId,
          fromId: data.fromId ?? data.fromId,
          via: data.viaIds
            ? {
                connect: data.viaIds.map((id) => ({ id })),
              }
            : undefined,
          toId: data.toId ?? data.toId,
          etd: data.etd ?? formatDate(data.etd),
          rotorStart: data.rotorStart ?? formatDate(data.rotorStart),
          atd: data.atd ?? formatDate(data.atd),
          eta: data.eta ?? formatDate(data.eta),
          rotorStop: data.rotorStop ?? formatDate(data.rotorStop),
          ata: data.eta ?? formatDate(data.ata),
          flightTime: data.flightTime ?? validateFlightTime(data.flightTime),
          blockTime: data.blockTime ?? validateFlightTime(data.blockTime),
        },
        include: {
          helicopter: true,
          pilot: true,
          hoistOperator: true,
          site: true,
          from: true,
          via: true,
          to: true,
          dailyUpdate: true,
          dailyReport: true,
        },
      })
      .catch(() => {
        throw createGraphQLError("Database exception");
      });
    if (!updatedFlight) throw createGraphQLError("Flight not updated");
    return updatedFlight;
  },
};

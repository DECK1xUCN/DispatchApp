import { CreateFlight, UpdateFlight } from "@/types/flights";
import { ctx } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";
import { formatDate } from "@/utils/dateHelper";
import {
  isAfter,
  validateDateBeforeNow,
  validateFlightNumber,
  validateFlightTime,
} from "@/utils/validators";
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
    if (
      !(await LocationService.validateLocationType(data.fromId, "HELIPORT")) ||
      !(await LocationService.validateLocationType(data.fromId, "AIRPORT"))
    )
      throw createGraphQLError("Enter valid location for FROM");
    if (
      !(await LocationService.validateLocationType(data.toId, "HELIPORT")) ||
      !(await LocationService.validateLocationType(data.toId, "AIRPORT"))
    )
      throw createGraphQLError("Enter valid location for TO");

    if (isAfter(formatDate(data.etd), formatDate(data.atd)))
      throw createGraphQLError("ETD must be before ATD");
    if (isAfter(formatDate(data.eta), formatDate(data.ata)))
      throw createGraphQLError("ETA must be before ATA");
    if (isAfter(formatDate(data.rotorStart), formatDate(data.rotorStop)))
      throw createGraphQLError("Rotor start must be before rotor stop");

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
          rotorStart: formatDate(data.rotorStart),
          atd: formatDate(data.atd),
          eta: formatDate(data.eta),
          rotorStop: formatDate(data.rotorStop),
          ata: formatDate(data.ata),
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
      .update({
        where: { id },
        data: {
          flightNumber: data.flightNumber
            ? validateFlightNumber(data.flightNumber)
            : undefined,
          date: data.date ? formatDate(data.date) : undefined,
          helicopterId: data.helicopterId ? data.helicopterId : undefined,
          pilotId: data.pilotId ? data.pilotId : undefined,
          hoistOperatorId: data.hoistOperatorId
            ? data.hoistOperatorId
            : undefined,
          siteId: data.siteId ? data.siteId : undefined,
          fromId: data.fromId,
          via: data.viaIds
            ? {
                connect: data.viaIds.map((id) => ({ id })),
              }
            : undefined,
          toId: data.toId ? data.toId : undefined,
          etd: data.etd ? formatDate(data.etd) : undefined,
          rotorStart: data.rotorStart ? formatDate(data.rotorStart) : undefined,
          atd: data.atd ? formatDate(data.atd) : undefined,
          eta: data.eta ? formatDate(data.eta) : undefined,
          rotorStop: data.rotorStop ? formatDate(data.rotorStop) : undefined,
          ata: data.eta ? formatDate(data.ata) : undefined,
          flightTime: data.flightTime
            ? validateFlightTime(data.flightTime)
            : undefined,
          blockTime: data.blockTime
            ? validateFlightTime(data.blockTime)
            : undefined,
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
};

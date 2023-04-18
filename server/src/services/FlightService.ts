import { CreateFlight } from "@/types/flights";
import { context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";
import dayjs from "dayjs";
import customParseFormat from "dayjs/plugin/customParseFormat";
import timezone from "dayjs/plugin/timezone";
dayjs.extend(customParseFormat);
dayjs.extend(timezone);

export default {
  getFlights: async () => {
    const flights = await context.prisma.flight
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
        throw createGraphQLError("No flights found");
      });
    return flights;
  },

  getFlightsBySiteId: async (siteId: number) => {
    const flights = await context.prisma.flight
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
        throw createGraphQLError("No flights found");
      });
    return flights;
  },

  getFlightsPerDay: async (inputDate: string) => {
    if (
      !(
        new Date(inputDate) instanceof Date &&
        !isNaN(new Date(inputDate).getTime())
      )
    ) {
      throw createGraphQLError("Invalid date");
    }
    const date = new Date(inputDate);
    const datePlusOne = new Date(
      date.getFullYear(),
      date.getMonth(),
      date.getDate() + 1
    );
    console.log(datePlusOne);

    const flights = await context.prisma.flight
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
        throw createGraphQLError("No flights found");
      });
    return flights;
  },

  getFlightById: async (id: number) => {
    const flight = await context.prisma.flight
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
        throw createGraphQLError("No flight found");
      });
    return flight;
  },

  getFlightByFlightNumber: async (flightNumber: string) => {
    const flight = await context.prisma.flight
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
        throw createGraphQLError("No flight found");
      });
    return flight;
  },

  createFlight: async (data: CreateFlight) => {
    const flight = await context.prisma.flight
      .create({
        data: data,
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
        throw createGraphQLError("No flight created");
      });
    return flight;
  },
};

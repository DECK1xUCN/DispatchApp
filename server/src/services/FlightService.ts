import { CreateFlight } from "@/types/flights";
import { context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";
import dayjs from "dayjs";

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

  getFlightsPerDay: async (date: string) => {
    // const flights = await context.prisma.flight
    //   .findMany({
    //     where: { etd: { gte: new Date(getDate(dayjs(date).toDate())) } },
    //     include: {
    //       helicopter: true,
    //       pilot: true,
    //       hoistOperator: true,
    //       site: true,
    //       from: true,
    //       via: true,
    //       to: true,
    //       dailyUpdate: true,
    //       dailyReport: true,
    //     },
    //   })
    //   .catch(() => {
    //     throw createGraphQLError("No flights found");
    //   });
    // return flights;
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

const getDate = (givenDate = new Date()): string => {
  const offset = givenDate.getTimezoneOffset();
  givenDate = new Date(givenDate.getTime() - offset * 60 * 1000);
  return givenDate.toISOString().split("T")[0];
};

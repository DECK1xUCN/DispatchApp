import { CreateFlight } from "@/types/flights";
import { context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";
import { formatDate } from "@/utils/dateHelper";

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
    const date = formatDate(inputDate);
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
    const date = formatDate(data.date);
    console.log(date);
    const etd = formatDate(data.etd);
    const rotorStart = formatDate(data.rotorStart);
    const atd = formatDate(data.atd);
    const eta = formatDate(data.eta);
    const rotorStop = formatDate(data.rotorStop);
    const ata = formatDate(data.ata);

    const flight = await context.prisma.flight
      .create({
        data: {
          flightNumber: data.flightNumber,
          date: date,
          helicopterId: data.helicopterId,
          pilotId: data.pilotId,
          hoistOperatorId: data.hoistOperatorId,
          siteId: data.siteId,
          fromId: data.fromId,
          via: {
            connect: data.viaIds.map((id) => ({ id })),
          },
          toId: data.toId,
          etd: etd,
          rotorStart: rotorStart,
          atd: atd,
          eta: eta,
          rotorStop: rotorStop,
          ata: ata,
          flightTime: data.flightTime,
          blockTime: data.blockTime,
          editable: false,
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
        throw createGraphQLError("No flight created");
      });
    return flight;
  },
};

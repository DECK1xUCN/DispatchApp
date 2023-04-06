import { CreateFlightInput, UpdateFlightInput } from "@/types/flights";
import { createGraphQLError } from "graphql-yoga";
import { Context } from "vm";
import moment from "moment";

const flightResolvers = {
  Query: {
    flights: async (_parent: any, args: any, context: Context) => {
      const flights = await context.prisma.flight
        .findMany()
        .catch((err: any) => {
          throw createGraphQLError(`No flights found`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!flights) {
        throw createGraphQLError(`No flights found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return flights;
    },
    flight: async (parent: any, args: { id: string }, context: Context) => {
      const flight = await context.prisma.flight
        .findUnique({
          where: { id: parseInt(args.id) },
        })
        .catch((err: any) => {
          throw createGraphQLError(`No flight found with id ${args.id}`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!flight) {
        throw createGraphQLError(`No flight found with id ${args.id}`, {
          extensions: {
            code: "404",
          },
        });
      }
      return flight;
    },
  },

  Mutation: {
    updateFlight: async (
      _parent: any,
      args: { id: string; data: UpdateFlightInput },
      context: Context
    ) => {
      const flight = await context.prisma.flight
        .update({
          where: { id: args.id },
          data: {
            flightNumber: args.data.flightNumber,
            from: {
              connect: args.data.fromId && { id: args.data.fromId },
            },
            via: {
              connect: args.data.viaId && { id: args.data.viaId },
            },
            to: {
              connect: args.data.toId && { id: args.data.toId },
            },
            etd: args.data.etd && formatDate(args.data.etd),
            rotorStart:
              args.data.rotorStart && formatDate(args.data.rotorStart),
            atd: args.data.atd && formatDate(args.data.atd),
            eta: args.data.eta && formatDate(args.data.eta),
            rotorStop: args.data.rotorStop && formatDate(args.data.rotorStop),
            ata: args.data.ata && formatDate(args.data.ata),
            blockTime: args.data.blockTime,
            flightTime: args.data.flightTime,
            delay: args.data.delay,
            delayMin: args.data.delayMin,
            delayCode: args.data.delayCode,
            delayDesc: args.data.delayDesc,
            pax: args.data.pax,
            paxTax: args.data.paxTax,
            cargoPP: args.data.cargoPP,
            hoistCycles: args.data.hoistCycles,
            notes: args.data.notes,
            dailyReport: {
              connect: args.data.dailyReportId && {
                id: args.data.dailyReportId,
              },
            },
            dailyUpdate: {
              connect: args.data.dailyUpdateId && {
                id: args.data.dailyUpdateId,
              },
            },
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(
            `Unable to update. Please check if flight with id ${args.id} exists`,
            {
              extensions: {
                code: "500",
              },
            }
          );
        });
      if (!flight) {
        throw createGraphQLError(`No flight found with id ${args.id}`, {
          extensions: {
            code: "404",
          },
        });
      }
      return flight;
    },

    createFlight: async (
      _parent: any,
      args: { data: CreateFlightInput },
      context: Context
    ) => {
      const flight = await context.prisma.flight
        .create({
          data: {
            flightNumber: args.data.flightNumber,
            from: {
              connect: args.data.fromId && { id: args.data.fromId },
            },
            via: {
              connect: args.data.viaId && { id: args.data.viaId },
            },
            to: {
              connect: args.data.toId && { id: args.data.toId },
            },
            etd: args.data.etd && formatDate(args.data.etd),
            rotorStart:
              args.data.rotorStart && formatDate(args.data.rotorStart),
            atd: args.data.atd && formatDate(args.data.atd),
            eta: args.data.eta && formatDate(args.data.eta),
            rotorStop: args.data.rotorStop && formatDate(args.data.rotorStop),
            ata: args.data.ata && formatDate(args.data.ata),
            blockTime: args.data.blockTime,
            flightTime: args.data.flightTime,
            delay: args.data.delay,
            delayMin: args.data.delayMin,
            delayCode: args.data.delayCode,
            delayDesc: args.data.delayDesc,
            pax: args.data.pax,
            paxTax: args.data.paxTax,
            cargoPP: args.data.cargoPP,
            hoistCycles: args.data.hoistCycles,
            notes: args.data.notes,
            dailyReport: {
              connect: args.data.dailyReportId && {
                id: args.data.dailyReportId,
              },
            },
            dailyUpdate: {
              connect: args.data.dailyUpdateId && {
                id: args.data.dailyUpdateId,
              },
            },
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Flight could not be created`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!flight) {
        throw createGraphQLError(`Flight could not be created`, {
          extensions: {
            code: "500",
          },
        });
      }
      return flight;
    },
  },
  Flight: {
    from: async (parent: any, args: any, context: Context) => {
      const heliport = await context.prisma.heliport
        .findUnique({
          where: { id: parent.fromId },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Heliport could not be found`, {
            extensions: {
              code: "500",
            },
          });
        });
      return heliport;
    },
    via: async (parent: any, args: any, context: Context) => {
      const sites = await context.prisma.flight
        .findUnique({
          where: { id: parent.id },
        })
        .via()
        .catch((err: any) => {
          throw createGraphQLError(
            `Heliport with id ${parent.id} could not be found`,
            {
              extensions: {
                code: "500",
              },
            }
          );
        });
      return sites;
    },
    to: async (parent: any, args: any, context: Context) => {
      const heliport = await context.prisma.heliport
        .findUnique({
          where: { id: parent.toId },
        })
        .catch((err: any) => {
          throw createGraphQLError(
            `Heliport with id ${parent.id} could not be found`,
            {
              extensions: {
                code: "500",
              },
            }
          );
        });
      return heliport;
    },
    dailyReport: async (parent: any, args: any, context: Context) => {
      const dailyReport = await context.prisma.dailyReport
        .findUnique({
          where: { id: parent.dailyReportId },
        })
        .catch((err: any) => {
          throw createGraphQLError(
            `Daily report with id ${parent.id} could not be found`,
            {
              extensions: {
                code: "500",
              },
            }
          );
        });
      return dailyReport;
    },
    dailyUpdate: async (parent: any, args: any, context: Context) => {
      const dailyUpdate = await context.prisma.dailyUpdate
        .findUnique({
          where: { id: parent.dailyUpdateId },
        })
        .catch((err: any) => {
          throw createGraphQLError(
            `Daily update with id ${parent.id} could not be found`,
            {
              extensions: {
                code: "500",
              },
            }
          );
        });
      return dailyUpdate;
    },
  },
};

function formatDate(date: any) {
  return moment(date, "DD-MM-YYYY HH:mm:ss").add(2, "hours").toDate();
}

export default flightResolvers;

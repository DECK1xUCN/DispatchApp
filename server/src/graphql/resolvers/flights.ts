import { CreateFlightInput, UpdateFlightInput } from "@/types/flights";
import { createGraphQLError } from "graphql-yoga";
import { Context } from "vm";
import moment from "moment";

const flightResolvers = {
  Query: {
    /**
     * Returns a list of all flights in the database.
     *
     * @async
     * @function flights
     *
     * @param {any} _parent - The parent of the GraphQL resolver (unused).
     * @param {Object} args - The arguments for the function (unused).
     * @param {Object} context - The context object for the GraphQL resolver.
     * @param {Object} context.prisma - The Prisma client for interacting with the database.
     *
     * @throws {GraphQLError} If no flights are found in the database.
     *
     * @returns {Array} A list of all flights in the database.
     */
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
    /**
     * Returns a flight with the specified ID.
     *
     * @async
     * @function flight
     *
     * @param {any} parent - The parent of the GraphQL resolver (unused).
     * @param {Object} args - The arguments for the function.
     * @param {string} args.id - The ID of the flight to retrieve.
     * @param {Object} context - The context object for the GraphQL resolver.
     * @param {Object} context.prisma - The Prisma client for interacting with the database.
     *
     * @throws {GraphQLError} If no flight is found with the specified ID.
     *
     * @returns {Object} The flight with the specified ID.
     */
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
    flightWhereDailyReportId: async (
      _parent: any,
      args: { dailyReportId: number },
      context: Context
    ) => {
      const flights = await context.prisma.flight
        .findMany({
          where: {
            dailyReportId: args.dailyReportId,
          },
        })
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
  },

  Mutation: {
    /**
     * Updates a flight in the database.
     *
     * @async
     * @function
     * @param {object} _parent - The parent object provided by Apollo Server.
     * @param {object} args - The arguments object containing the `id` and `data` properties.
     * @param {string} args.id - The ID of the flight to be updated.
     * @param {object} args.data - The data object containing the new values to be updated.
     * @param {object} context - The context object provided by Apollo Server.
     * @returns {object} - The updated flight object.
     * @throws {Error} - Throws an error if the flight is not found or if there was an issue updating the flight.
     */
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

    /**
     * Creates a new flight with the given input data
     *
     * @async
     * @function
     * @param {any} _parent - The parent element of the GraphQL resolver chain
     * @param {object} args - The input arguments for the resolver function
     * @param {object} args.data - The input data to create a new flight
     * @param {object} context - The context object containing the Prisma client
     * @returns {Promise<object>} A Promise that resolves to the newly created flight
     * @throws {Error} If the flight could not be created
     */
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
    /**
     * Retrieves the heliport from the provided parent's ID using Prisma ORM.
     * @async
     * @function
     * @param {any} parent - Parent object that contains the 'fromId' property to be used to retrieve the heliport.
     * @param {any} args - Unused argument.
     * @param {Context} context - Context object containing the Prisma ORM instance.
     * @returns {Promise<Heliport>} - A Promise that resolves to the Heliport object found based on the provided parent's ID.
     * @throws {GraphQLError} - Throws a GraphQLError if the heliport could not be found in the database.
     */
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
    /**
     * Retrieves the sites that were visited by the flight with the provided parent's ID using Prisma ORM.
     * @async
     * @function
     * @param {any} parent - Parent object that contains the ID property of the flight to be used to retrieve the visited sites.
     * @param {any} args - Unused argument.
     * @param {Context} context - Context object containing the Prisma ORM instance.
     * @returns {Promise<Site[]>} - A Promise that resolves to an array of Site objects visited by the flight with the provided ID.
     * @throws {GraphQLError} - Throws a GraphQLError if the sites could not be found in the database.
     */
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
    /**
     * Retrieves the heliport of the destination of the flight with the provided parent's ID using Prisma ORM.
     * @async
     * @function
     * @param {any} parent - Parent object that contains the ID property of the flight to be used to retrieve the destination heliport.
     * @param {any} args - Unused argument.
     * @param {Context} context - Context object containing the Prisma ORM instance.
     * @returns {Promise<Heliport>} - A Promise that resolves to the Heliport object of the destination of the flight with the provided ID.
     * @throws {GraphQLError} - Throws a GraphQLError if the heliport could not be found in the database.
     */
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
    /**
     * Retrieves the daily report with the provided parent's dailyReportId using Prisma ORM.
     * @async
     * @function
     * @param {any} parent - Parent object that contains the dailyReportId property to be used to retrieve the daily report.
     * @param {any} args - Unused argument.
     * @param {Context} context - Context object containing the Prisma ORM instance.
     * @returns {Promise<DailyReport>} - A Promise that resolves to the DailyReport object found based on the provided dailyReportId.
     * @throws {GraphQLError} - Throws a GraphQLError if the daily report could not be found in the database.
     */
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
    /**
     * Retrieves the daily update with the provided parent's dailyUpdateId using Prisma ORM.
     * @async
     * @function
     * @param {any} parent - Parent object that contains the dailyUpdateId property to be used to retrieve the daily update.
     * @param {any} args - Unused argument.
     * @param {Context} context - Context object containing the Prisma ORM instance.
     * @returns {Promise<DailyUpdate>} - A Promise that resolves to the DailyUpdate object found based on the provided dailyUpdateId.
     * @throws {GraphQLError} - Throws a GraphQLError if the daily update could not be found in the database.
     */
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

/**
 * Formats the given date by adding 2 hours to the provided time and returning it as a Date object.
 * @function
 * @param {any} date - The date to be formatted.
 * @returns {Date} - The formatted Date object.
 */
function formatDate(date: any) {
  return moment(date, "DD-MM-YYYY HH:mm:ss").add(2, "hours").toDate();
}

export default flightResolvers;

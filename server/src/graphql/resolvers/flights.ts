import { Context } from "@/utils/context";
import { FlightCreateInput, FlightUpdateInput } from "@/types/flights";
import moment from "moment";
import { createGraphQLError } from "graphql-yoga";

const flightResolver: any = {
  Query: {
    /**
     * This function fetches all flights from the database using Prisma.
     *
     * @async
     * @function findAll
     * @param {any} parent - The parent object.
     * @param {any} args - The arguments passed into the function.
     * @param {Context} context - The context object, which contains the Prisma client.
     * @throws {Error} If there was an error finding all flights.
     * @returns {Promise} A Promise that resolves to an array of flights.
     */
    findAllFlights: async (parent: any, args: any, context: Context) => {
      // Retrieve all flights from the database using Prisma.
      const flights = await context.prisma.flight.findMany();
      // If no flights were found, throw an error.
      if (!flights) {
        throw createGraphQLError(`Error finding all flights`, {
          extensions: {
            code: "404",
          },
        });
      }
      // Return the array of flights.
      return flights;
    },

    /**
     * This function fetches a flight from the database by its ID using Prisma.
     *
     * @async
     * @function findById
     * @param {any} parent - The parent object.
     * @param {{ id: string }} args - An object containing the ID parameter.
     * @param {Context} context - The context object, which contains the Prisma client.
     * @throws {GraphQLError} If there was an error finding the flight by its ID.
     * @returns {Promise} A Promise that resolves to a flight object.
     */
    findFlightById: async (
      parent: any,
      args: { id: string },
      context: Context
    ) => {
      // Retrieve the flight from the database using its ID and Prisma.
      const flight = await context.prisma.flight.findUnique({
        where: {
          flightNumber: args.id,
        },
      });
      // If no flight was found, throw an error.
      if (!flight) {
        throw createGraphQLError(
          `Error finding flight by flight number: ${args.id}`,
          {
            extensions: {
              code: "404",
            },
          }
        );
      }

      // Return the flight object.
      return flight;
    },

    /**
     * This function fetches a flight from the database by its flight number using Prisma.
     *
     * @async
     * @function findByFlightNumber
     * @param {any} parent - The parent object.
     * @param {{ flightNumber: string }} args - An object containing the flightNumber parameter.
     * @param {Context} context - The context object, which contains the Prisma client.
     * @throws {GraphQLError} If there was an error finding the flight by its flight number.
     * @returns {Promise} A Promise that resolves to a flight object.
     */
    findFlightByFlightNumber: async (
      parent: any,
      args: { flightNumber: string },
      context: Context
    ) => {
      // Retrieve the flight from the database using its flight number and Prisma.
      const flight = await context.prisma.flight.findUnique({
        where: {
          flightNumber: args.flightNumber,
        },
      });
      // If no flight was found, throw an error.
      if (!flight) {
        throw createGraphQLError(
          `Error finding flight by flight number: ${args.flightNumber}`,
          {
            extensions: {
              code: "404",
            },
          }
        );
      }
      // Return the flight object.
      return flight;
    },
  },

  Mutation: {
    /**
     * This function creates a new flight in the database using Prisma.
     *
     * @async
     * @function createFlight
     * @param {any} parent - The parent object.
     * @param {{ data: FlightCreateInput }} args - An object containing the flight data to create.
     * @param {Context} context - The context object, which contains the Prisma client.
     * @throws {GraphQLError} If there was an error creating the flight in the database.
     * @returns {Promise} A Promise that resolves to the created flight object.
     */
    // createFlight: async (
    //   parent: any,
    //   args: { data: FlightCreateInput },
    //   context: Context
    // ) => {
    //   // Create the new flight in the database using Prisma.
    //   const flight = await context.prisma.flight
    //     .create({
    //       data: {
    //         flightNumber: args.data.flightNumber,
    //         from: args.data.from,
    //         via: args.data.via,
    //         to: args.data.to,
    //         etd: moment(args.data.etd, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         rotorStart: moment(
    //           args.data.rotorStart,
    //           "DD-MM-YYYY HH:mm:ss"
    //         ).toDate(),
    //         atd: moment(args.data.atd, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         eta: moment(args.data.eta, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         rotorStop: moment(
    //           args.data.rotorStop,
    //           "DD-MM-YYYY HH:mm:ss"
    //         ).toDate(),
    //         ata: moment(args.data.ata, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         pax: args.data.pax,
    //         cargoPP: args.data.cargoPP,
    //         hoistCycles: args.data.hoistCycles,
    //         late: args.data.late,
    //         delayCode: args.data.delayCode,
    //         lateNote: args.data.lateNote,
    //       },
    //     })
    //     .catch((error: any) => {
    //       // If there was an error creating the flight, log it to the console and throw an error.
    //       console.error(error);
    //       throw createGraphQLError(`Error creating flight`, {
    //         extensions: {
    //           code: "415",
    //         },
    //       });
    //     });
    //   // If no flight was created, throw an error.
    //   if (!flight) {
    //     throw createGraphQLError(`Error creating flight`, {
    //       extensions: {
    //         code: "415",
    //       },
    //     });
    //   }
    //   // Return the created flight object.
    //   return flight;
    // },
    /**
     * Updates an existing flight with the given id and data.
     * @param parent The parent resolver's result
     * @param args An object containing the flight's ID and the new data to update
     * @param {id: string} id of the flight to update
     * @param {{ data: FlightUpdateInput }} args - An object containing the flight data to update.
     * @param {Context} context - The context object, which contains the Prisma client.
     * @throws {GraphQLError} If there was an error updating the flight in the database.
     * @returns The updated flight object
     */
    // updateFlightById: async (
    //   parent: any,
    //   args: { id: string; data: FlightCreateInput },
    //   context: Context
    // ) => {
    //   const flight = await context.prisma.flight
    //     .update({
    //       where: {
    //         id: args.id,
    //       },
    //       data: {
    //         from: args.data.from,
    //         via: args.data.via,
    //         to: args.data.to,
    //         etd: moment(args.data.etd, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         rotorStart: moment(
    //           args.data.rotorStart,
    //           "DD-MM-YYYY HH:mm:ss"
    //         ).toDate(),
    //         atd: moment(args.data.atd, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         eta: moment(args.data.eta, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         rotorStop: moment(
    //           args.data.rotorStop,
    //           "DD-MM-YYYY HH:mm:ss"
    //         ).toDate(),
    //         ata: moment(args.data.ata, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         flightNumber: args.data.flightNumber,
    //         pax: args.data.pax,
    //         cargoPP: args.data.cargoPP,
    //         hoistCycles: args.data.hoistCycles,
    //         late: args.data.late,
    //         delayCode: args.data.delayCode,
    //         lateNote: args.data.lateNote,
    //       },
    //     })
    //     .catch((error: any) => {
    //       console.error(error);
    //       throw createGraphQLError(`Error updating flight`, {
    //         extensions: {
    //           code: "415",
    //         },
    //       });
    //     });
    //   if (!flight) {
    //     throw createGraphQLError(`Error updating flight`, {
    //       extensions: {
    //         code: "415",
    //       },
    //     });
    //   }
    //   return flight;
    // },
    /**
     * Updates an existing flight with the given id and data.
     * @param parent The parent resolver's result
     * @param args An object containing the flight's flightNumber and the new data to update
     * @param {flightNumber: string} flightNumber of the flight to update
     * @param {{ data: FlightUpdateInput }} args - An object containing the flight data to update.
     * @param {Context} context - The context object, which contains the Prisma client.
     * @throws {GraphQLError} If there was an updating creating the flight in the database.
     * @returns The updated flight object
     */
    // updateFlightByFlightNumber: async (
    //   parent: any,
    //   args: { flightNumber: string; data: FlightUpdateInput },
    //   context: Context
    // ) => {
    //   const flight = await context.prisma.flight
    //     .update({
    //       where: {
    //         flightNumber: args.flightNumber,
    //       },
    //       data: {
    //         from: args.data.from,
    //         via: args.data.via,
    //         to: args.data.to,
    //         etd: moment(args.data.etd, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         rotorStart: moment(
    //           args.data.rotorStart,
    //           "DD-MM-YYYY HH:mm:ss"
    //         ).toDate(),
    //         atd: moment(args.data.atd, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         eta: moment(args.data.eta, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         rotorStop: moment(
    //           args.data.rotorStop,
    //           "DD-MM-YYYY HH:mm:ss"
    //         ).toDate(),
    //         ata: moment(args.data.ata, "DD-MM-YYYY HH:mm:ss").toDate(),
    //         flightNumber: args.data.flightNumber,
    //         pax: args.data.pax,
    //         cargoPP: args.data.cargoPP,
    //         hoistCycles: args.data.hoistCycles,
    //         late: args.data.late,
    //         delayCode: args.data.delayCode,
    //         lateNote: args.data.lateNote,
    //       },
    //     })
    //     .catch((error: any) => {
    //       console.error(error);
    //       throw createGraphQLError(`Error updating flight`, {
    //         extensions: {
    //           code: "415",
    //         },
    //       });
    //     });
    //   if (!flight) {
    //     throw createGraphQLError(`Error updating flight`, {
    //       extensions: {
    //         code: "415",
    //       },
    //     });
    //   }
    //   return flight;
    // },
  },
};

export default flightResolver;

import { Context } from "@/utils/context";
import { FlightCreateInput, FlightUpdateInput } from "@/types/flights";
import moment from "moment";

const flightResolver: any = {
  Query: {
    /**
     * Resolver function that returns all flights in the database.
     *
     * @param parent The parent object (unused in this case)
     * @param args The arguments passed to the query (unused in this case)
     * @param context The context object containing the Prisma client
     * @returns {Promise} A promise that resolves to an array of flight objects.
     */
    findAll: (parent: any, args: any, context: Context) => {
      return context.prisma.flights.findMany();
    },

    /**
     * Resolver function that returns a single flight based on its ID.
     *
     * @param parent The parent object (unused in this case)
     * @param args The arguments passed to the query, which should include the ID of the flight to retrieve
     * @param context The context object containing the Prisma client
     * @returns {Promise} A promise that resolves to a flight object.
     */
    findById: (parent: any, args: { id: string }, context: Context) => {
      return context.prisma.flights.findUnique({
        where: {
          id: args.id,
        },
      });
    },

    /**
     * Resolver function that returns a single flight based on its flight number.
     *
     * @param parent The parent object (unused in this case)
     * @param args The arguments passed to the query, which should include the flight number of the flight to retrieve
     * @param context The context object containing the Prisma client
     * @returns {Promise} A promise that resolves to a flight object.
     */
    findByFlightNumber: (
      parent: any,
      args: { flightNumber: string },
      context: Context
    ) => {
      return context.prisma.flights.findUnique({
        where: {
          flightNumber: args.flightNumber,
        },
      });
    },
  },

  Mutation: {
    /**
     * Resolver function that creates a new flight in the database.
     *
     * @param parent The parent object (unused in this case)
     * @param args The arguments passed to the mutation, which should include the flight data for the new flight
     * @param context The context object containing the Prisma client
     * @returns {Promise} A promise that resolves to the newly created flight object.
     */
    createFlight: (
      parent: any,
      args: { data: FlightCreateInput },
      context: Context
    ) => {
      return context.prisma.flights.create({
        data: {
          flightNumber: args.data.flightNumber,
          from: args.data.from,
          via: args.data.via,
          to: args.data.to,
          etd: moment(args.data.etd, "DD-MM-YYYY HH:mm:ss").toDate(),
          pax: args.data.pax,
          cargoPP: args.data.cargoPP,
          hoistCycles: args.data.hoistCycles,
          late: args.data.late,
          delayCode: args.data.delayCode,
          lateNote: args.data.lateNote,
        },
      });
    },

    /**
      Update a flight by its ID
      This mutation allows updating a flight's details using its unique ID.
      The ID is used to find the flight to update in the database, and the data argument
      contains the new values for the flight's fields.
      @param parent The parent resolver's result
      @param args An object containing the flight's ID and the new data to update
      @param context An object containing the Prisma client
      @returns The updated flight object
      */
    updateById: (
      parent: any,
      args: { id: string; data: FlightCreateInput },
      context: Context
    ) => {
      if (args.data.etd) {
        return context.prisma.flights.update({
          where: {
            id: args.id,
          },
          data: {
            from: args.data.from,
            via: args.data.via,
            to: args.data.to,
            etd: moment(args.data.etd, "DD-MM-YYYY HH:mm:ss").toDate(),
            flightNumber: args.data.flightNumber,
            pax: args.data.pax,
            cargoPP: args.data.cargoPP,
            hoistCycles: args.data.hoistCycles,
            late: args.data.late,
            delayCode: args.data.delayCode,
            lateNote: args.data.lateNote,
          },
        });
      } else {
        return context.prisma.flights.update({
          where: {
            id: args.id,
          },
          data: {
            from: args.data.from,
            via: args.data.via,
            to: args.data.to,
            flightNumber: args.data.flightNumber,
            pax: args.data.pax,
            cargoPP: args.data.cargoPP,
            hoistCycles: args.data.hoistCycles,
            late: args.data.late,
            delayCode: args.data.delayCode,
            lateNote: args.data.lateNote,
          },
        });
      }
    },

    /**
        Update a flight by its flight number
        This mutation allows updating a flight's details using its unique flight number.
        The flight number is used to find the flight to update in the database, and the data argument
        contains the new values for the flight's fields.
      @param parent The parent resolver's result
      @param args An object containing the flight's flight number and the new data to update
      @param context An object containing the Prisma client
      @returns The updated flight object
      */
    updateByFlightNumber: (
      parent: any,
      args: { flightNumber: string; data: FlightUpdateInput },
      context: Context
    ) => {
      if (args.data.etd) {
        return context.prisma.flights.update({
          where: {
            flightNumber: args.flightNumber,
          },
          data: {
            from: args.data.from,
            via: args.data.via,
            to: args.data.to,
            etd: moment(args.data.etd, "DD-MM-YYYY HH:mm:ss").toDate(),
            flightNumber: args.data.flightNumber,
            pax: args.data.pax,
            cargoPP: args.data.cargoPP,
            hoistCycles: args.data.hoistCycles,
            late: args.data.late,
            delayCode: args.data.delayCode,
            lateNote: args.data.lateNote,
          },
        });
      } else {
        return context.prisma.flights.update({
          where: {
            flightNumber: args.flightNumber,
          },
          data: {
            from: args.data.from,
            via: args.data.via,
            to: args.data.to,
            flightNumber: args.data.flightNumber,
            pax: args.data.pax,
            cargoPP: args.data.cargoPP,
            hoistCycles: args.data.hoistCycles,
            late: args.data.late,
            delayCode: args.data.delayCode,
            lateNote: args.data.lateNote,
          },
        });
      }
    },
  },
};

export default flightResolver;

import FlightService from "../../services/FlightService";
import { CreateFlight, UpdateFlight } from "../../types/flights";
import { createGraphQLError } from "graphql-yoga";
import { ctx } from "../../utils/context";

const flightResolver = {
  Query: {
    flights: async (_: any, args: { siteId?: number; date?: string }) => {
      let flights;
      if (args.siteId) {
        flights = await FlightService.getFlightsBySiteId(args.siteId, ctx);
      } else if (args.date) {
        flights = await FlightService.getFlightsPerDay(args.date, ctx);
      } else {
        flights = await FlightService.getFlights(ctx);
      }
      if (!flights || flights.length === 0)
        throw createGraphQLError("No flights found");
      return flights;
    },

    // deprecated
    flightsBySiteId: async (_: any, args: { siteId: number }) => {
      const flights = await FlightService.getFlightsBySiteId(args.siteId, ctx);
      if (!flights || flights.length === 0)
        throw createGraphQLError("No flights found");
      return flights;
    },

    // deprecated
    flightsPerDay: async (_: any, args: { date: string }) => {
      const flights = await FlightService.getFlightsPerDay(args.date, ctx);
      if (!flights || flights.length === 0)
        throw createGraphQLError("No flights found");
      return flights;
    },

    flightsWhereDuIsNull: async () => {
      const flights = await FlightService.getFlightsWhereDuIsNull(ctx);
      if (!flights || flights.length === 0)
        throw createGraphQLError("No flights found");
      return flights;
    },

    flight: async (_: any, args: { id?: number; flightNumber?: string }) => {
      let flight;
      if (args.id) {
        flight = await FlightService.getFlightById(args.id, ctx);
      } else if (args.flightNumber) {
        flight = await FlightService.getFlightByFlightNumber(
          args.flightNumber,
          ctx
        );
      } else {
        throw createGraphQLError("Expected 1 to 2 parameters, received 0");
      }
      if (!flight) throw createGraphQLError("No flight found");
      return flight;
    },

    flightById: async (_: any, args: { id: number }) => {
      const flight = await FlightService.getFlightById(args.id, ctx);
      if (!flight) throw createGraphQLError("No flight found");
      return flight;
    },

    // deprecated
    flightsWhereDfrIsNull: async () => {
      const flights = await FlightService.getFlightsWhereDfrIsNull(ctx);
      if (!flights || flights.length === 0)
        throw createGraphQLError("No flights found");
      return flights;
    },

    // deprecated
    flightByFlightNumber: async (_: any, args: { flightNumber: string }) => {
      const flight = await FlightService.getFlightByFlightNumber(
        args.flightNumber,
        ctx
      );
      if (!flight) throw createGraphQLError("No flight found");
      return flight;
    },
  },

  Mutation: {
    createFlight: async (_: any, args: { data: CreateFlight }) => {
      const flight = await FlightService.createFlight(args.data, ctx);
      if (!flight) throw createGraphQLError("No flight created");
      return flight;
    },

    updateFlight: async (_: any, args: { id: number; data: UpdateFlight }) => {
      const flight = await FlightService.updateFlight(args.id, args.data, ctx);
      if (!flight) throw createGraphQLError("No flight updated");
      return flight;
    },
  },
};

export default flightResolver;

import FlightService from "../../services/FlightService";
import { CreateFlight, UpdateFlight } from "../../types/flights";
import { createGraphQLError } from "graphql-yoga";

const flightResolver = {
  Query: {
    flights: async (parent: any, args: { siteId?: number; date?: string }) => {
      let flights;
      // const flights = await FlightService.getFlights();
      if (args.siteId) {
        flights = await FlightService.getFlightsBySiteId(args.siteId);
      } else if (args.date) {
        flights = await FlightService.getFlightsPerDay(args.date);
      } else {
        flights = await FlightService.getFlights();
      }
      if (!flights || flights.length === 0)
        throw createGraphQLError("No flights found");
      return flights;
    },

    // deprecated
    flightsBySiteId: async (parent: any, args: { siteId: number }) => {
      const flights = await FlightService.getFlightsBySiteId(args.siteId);
      if (!flights || flights.length === 0)
        throw createGraphQLError("No flights found");
      return flights;
    },

    // deprecated
    flightsPerDay: async (parent: any, args: { date: string }) => {
      const flights = await FlightService.getFlightsPerDay(args.date);
      if (!flights || flights.length === 0)
        throw createGraphQLError("No flights found");
      return flights;
    },

    flightsWhereDuIsNull: async () => {
      const flights = await FlightService.getFlightsWhereDuIsNull();
      if (!flights || flights.length === 0)
        throw createGraphQLError("No flights found");
      return flights;
    },

    flight: async (
      parent: any,
      args: { id?: number; flightNumber?: string }
    ) => {
      let flight;
      if (args.id) {
        flight = await FlightService.getFlightById(args.id);
      } else if (args.flightNumber) {
        flight = await FlightService.getFlightByFlightNumber(args.flightNumber);
      } else {
        throw createGraphQLError("Expected 1 to 2 parameters, received 0");
      }
      if (!flight) throw createGraphQLError("No flight found");
      return flight;
    },

    flightById: async (parent: any, args: { id: number }) => {
      const flight = await FlightService.getFlightById(args.id);
      if (!flight) throw createGraphQLError("No flight found");
      return flight;
    },

    // deprecated
    flightsWhereDfrIsNull: async () => {
      const flights = await FlightService.getFlightsWhereDfrIsNull();
      if (!flights || flights.length === 0)
        throw createGraphQLError("No flights found");
      return flights;
    },

    // deprecated
    flightByFlightNumber: async (
      parent: any,
      args: { flightNumber: string }
    ) => {
      const flight = await FlightService.getFlightByFlightNumber(
        args.flightNumber
      );
      if (!flight) throw createGraphQLError("No flight found");
      return flight;
    },
  },

  Mutation: {
    createFlight: async (parent: any, args: { data: CreateFlight }) => {
      const flight = await FlightService.createFlight(args.data);
      if (!flight) throw createGraphQLError("No flight created");
      return flight;
    },

    updateFlight: async (
      parent: any,
      args: { id: number; data: UpdateFlight }
    ) => {
      const flight = await FlightService.updateFlight(args.id, args.data);
      if (!flight) throw createGraphQLError("No flight updated");
      return flight;
    },
  },
};

export default flightResolver;

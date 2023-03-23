type Flight = {
  from: String;
  via: String;
  to: String;
  flightNumber: String;
  ETD: Date;
  PAX: number;
  cargo: number;
  hoistCycles: number;
  lateNote: String;
  delayCode: String;
};

const flights: Flight[] = [
  {
    from: "LHR",
    via: "AMS",
    to: "AMS",
    flightNumber: "BA123",
    ETD: new Date(),
    PAX: 100,
    cargo: 100,
    hoistCycles: 100,
    lateNote: "late",
    delayCode: "delay",
  },
  {
    from: "LHR",
    via: "AMS",
    to: "AMS",
    flightNumber: "BA123",
    ETD: new Date(),
    PAX: 100,
    cargo: 100,
    hoistCycles: 100,
    lateNote: "late",
    delayCode: "delay",
  },
];

const flightResolver: any = {
  Query: {
    flight: () => flights,
  },
  Mutation: {
    createFlight: (
      parent: unknown,
      args: {
        from: string;
        via: string;
        to: string;
        flightNumber: string;
        ETD: Date;
        PAX: number;
        cargo: number;
        hoistCycles: number;
        lateNote: string;
        delayCode: string;
      }
    ) => {
      const flight: Flight = {
        from: args.from,
        via: args.via,
        to: args.to,
        flightNumber: args.flightNumber,
        ETD: args.ETD,
        PAX: args.PAX,
        cargo: args.cargo,
        hoistCycles: args.hoistCycles,
        lateNote: args.lateNote,
        delayCode: args.delayCode,
      };

      return flight ? flights.push(flight) && true : false;
    },
  },
};

export default flightResolver;

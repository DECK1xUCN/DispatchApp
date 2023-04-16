import { Context } from "@/utils/context";

const flightResolver = {
  Query: {
    flights: async (parent: any, args: any, context: Context) => {
      const flights = await context.prisma.flight.findMany({
        include: {
          sites: true,
          helicopter: true,
          pilot: true,
        },
      });
      return flights;
    },
  },
  Mutation: {
    createFlight: async (parent: any, { input }: any, context: Context) => {
      const { sites, ...data } = input;
      const createdFlight = await context.prisma.flight.create({
        data: {
          ...data,
          sites: {
            create: sites.map((site: any) => ({ ...site })),
          },
        },
        include: {
          sites: true,
          helicopter: true,
          pilot: true,
        },
      });
      return createdFlight;
    },
  },
};

export default flightResolver;

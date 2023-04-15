import { Context } from "@/utils/context";

const locationsResolver = {
  Query: {
    locations: async (parent: any, args: any, context: Context) => {
      const locations = await context.prisma.location.findMany();
      return locations;
    },
    location: async (parent: any, { id }: any, context: Context) => {
      const location = await context.prisma.location.findUnique({
        where: {
          id,
        },
      });
      return location;
    },
  },
  Mutation: {
    createLocation: async (parent: any, { input }: any, context: Context) => {
      const createdLocation = await context.prisma.location.create({
        data: {
          name: input.name,
          lat: input.lat,
          long: input.long,
          type: input.type,
        },
      });
      return createdLocation;
    },
  },
};

export default locationsResolver;

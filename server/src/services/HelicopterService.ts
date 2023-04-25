import { CreateHelicopter } from "@/types/helicopters";
import { ctx } from "@/utils/context";
import { validateEmptyString } from "@/utils/validators";
import { validateModel, validateReg } from "@/utils/validators";
import { createGraphQLError } from "graphql-yoga";

export default {
  getHelicopter: async (id: number) => {
    const helicopter = await ctx.prisma.helicopter
      .findUnique({ where: { id }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("Helicopter with id " + id + " not found");
      });
    return helicopter;
  },

  getHelicoptersWhereModel: async (model: string) => {
    const helicopters = await ctx.prisma.helicopter
      .findMany({ where: { model }, include: { flights: true } })
      .catch(() => {
        throw createGraphQLError(
          "Helicopter with model " + model + " not found"
        );
      });
    return helicopters;
  },

  getHelicopters: async () => {
    const helicopters = await ctx.prisma.helicopter
      .findMany({ include: { flights: true } })
      .catch(() => {
        throw createGraphQLError("No helicopters found");
      });
    return helicopters;
  },

  createHelicopter: async (data: CreateHelicopter) => {
    const helicopter = await ctx.prisma.helicopter
      .create({
        data: {
          manufacturer: validateEmptyString(data.manufacturer),
          model: validateModel(data.model),
          reg: validateReg(data.reg),
        },
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("Failed to create helicopter");
      });
    return helicopter;
  },
};

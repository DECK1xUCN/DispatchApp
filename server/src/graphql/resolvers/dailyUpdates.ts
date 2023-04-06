import {
  CreateDailyUpdateInput,
  UpdateDailyUpdateInput,
} from "@/types/dailyUpdates";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";
import moment from "moment";

const dailyUpdateResolver = {
  Query: {
    dailyUpdates: async (parent: any, args: any, context: Context) => {
      const dailyUpdates = await context.prisma.dailyUpdate.findMany();
      if (!dailyUpdates) {
        throw createGraphQLError(`No dailyUpdates found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return dailyUpdates;
    },
    dailyUpdate: async (
      parent: any,
      args: { id: string },
      context: Context
    ) => {
      const dailyUpdate = await context.prisma.dailyUpdate
        .findUnique({
          where: { id: parseInt(args.id) },
        })
        .catch((err: any) => {
          throw createGraphQLError(`No dailyUpdate found with id ${args.id}`, {
            extensions: {
              code: "404",
            },
          });
        });
      if (!dailyUpdate) {
        throw createGraphQLError(`No dailyUpdate found with id ${args.id}`, {
          extensions: {
            code: "404",
          },
        });
      }
      return dailyUpdate;
    },
  },
  Mutation: {
    createDailyUpdate: async (
      parent: any,
      args: { data: CreateDailyUpdateInput },
      context: Context
    ) => {
      const dailyUpdate = await context.prisma.dailyUpdate.create({
        data: {
          flightId: args.data.flightId,
          date: args.data.date && formatDate(args.data.date),
          wasFlight: args.data.wasFlight,
          delay: args.data.delay,
          delayReason: args.data.delayReason && args.data.delayReason,
          delayDesc: args.data.delayReasonDesc && args.data.delayReasonDesc,
          maintenace: args.data.maintenace,
          plannedMaintenance:
            args.data.plannedMaintenance && args.data.plannedMaintenance,
          unplannedMaintenance:
            args.data.unplannedMaintenance && args.data.unplannedMaintenance,
          otherMaintenance:
            args.data.otherMaintenance && args.data.otherMaintenance,
          maintenanceDesc:
            args.data.maintenanceDesc && args.data.maintenanceDesc,
          baseAndEquipment: args.data.baseAndEquipment,
          note: args.data.note,
        },
      });
      if (!dailyUpdate) {
        throw createGraphQLError(`DailyUpdate could not be created`, {
          extensions: {
            code: "500",
          },
        });
      }
      return dailyUpdate;
    },
    updateDailyUpdate: async (
      parent: any,
      args: { id: string; data: UpdateDailyUpdateInput },
      context: Context
    ) => {
      const dailyUpdate = await context.prisma.dailyUpdate
        .update({
          where: { id: parseInt(args.id) },
          data: {
            flightId: args.data.flightId,
            date: args.data.date && formatDate(args.data.date),
            wasFlight: args.data.wasFlight,
            delay: args.data.delay,
            delayReason: args.data.delayReason && args.data.delayReason,
            delayDesc: args.data.delayReasonDesc && args.data.delayReasonDesc,
            maintenace: args.data.maintenace,
            plannedMaintenance:
              args.data.plannedMaintenance && args.data.plannedMaintenance,
            unplannedMaintenance:
              args.data.unplannedMaintenance && args.data.unplannedMaintenance,
            otherMaintenance:
              args.data.otherMaintenance && args.data.otherMaintenance,
            maintenanceDesc:
              args.data.maintenanceDesc && args.data.maintenanceDesc,
            baseAndEquipment: args.data.baseAndEquipment,
            note: args.data.note && args.data.note,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`No dailyUpdate found with id ${args.id}`, {
            extensions: {
              code: "404",
            },
          });
        });
      if (!dailyUpdate) {
        throw createGraphQLError(`DailyUpdate could not be updated`, {
          extensions: {
            code: "500",
          },
        });
      }
      return dailyUpdate;
    },
  },
  DailyUpdate: {
    flight: async (parent: any, args: any, context: Context) => {
      const flight = await context.prisma.flight
        .findUnique({
          where: { id: parent.flightId },
        })
        .catch((err: any) => {
          throw createGraphQLError(
            `No flight found with id ${parent.flightId}`,
            {
              extensions: {
                code: "404",
              },
            }
          );
        });
      if (!flight) {
        throw createGraphQLError(`No flight found with id ${parent.flightId}`, {
          extensions: {
            code: "404",
          },
        });
      }
      return flight;
    },
  },
};

function formatDate(date: any) {
  return moment(date, "DD-MM-YYYY HH:mm:ss").add(2, "hours").toDate();
}

export default dailyUpdateResolver;

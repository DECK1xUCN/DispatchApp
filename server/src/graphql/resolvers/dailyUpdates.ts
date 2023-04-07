import {
  CreateDailyUpdateInput,
  UpdateDailyUpdateInput,
} from "@/types/dailyUpdates";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";
import moment from "moment";

const dailyUpdateResolver = {
  Query: {
    /**
     * Retrieves all daily updates from the database using Prisma ORM.
     * @async
     * @function
     * @param {any} parent - Unused argument.
     * @param {any} args - Unused argument.
     * @param {Context} context - Context object containing the Prisma ORM instance.
     * @returns {Promise<DailyUpdate[]>} - A Promise that resolves to an array of DailyUpdate objects.
     * @throws {GraphQLError} - Throws a GraphQLError if no daily updates are found in the database.
     */
    dailyUpdates: async (parent: any, args: any, context: Context) => {
      const dailyUpdates = await context.prisma.dailyUpdate
        .findMany()
        .catch((err: any) => {
          throw createGraphQLError(`No dailyUpdates found`, {
            extensions: {
              code: "404",
            },
          });
        });
      if (!dailyUpdates) {
        throw createGraphQLError(`No dailyUpdates found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return dailyUpdates;
    },
    /**
     * Retrieves a daily update with the specified ID from the database using Prisma ORM.
     * @async
     * @function
     * @param {any} parent - Unused argument.
     * @param {{id: string}} args - An object containing the ID of the daily update to be retrieved.
     * @param {Context} context - Context object containing the Prisma ORM instance.
     * @returns {Promise<DailyUpdate>} - A Promise that resolves to the DailyUpdate object with the specified ID.
     * @throws {GraphQLError} - Throws a GraphQLError if no daily update with the specified ID is found in the database.
     */
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
    /**
     * Creates a new daily update.
     *
     * @async
     * @function createDailyUpdate
     * @param {Object} parent - The parent object.
     * @param {Object} args - The arguments object.
     * @param {CreateDailyUpdateInput} args.data - The data for the daily update.
     * @param {Context} context - The context object.
     * @returns {Promise<DailyUpdate>} The newly created daily update.
     * @throws {GraphQLError} If the daily update could not be created.
     */
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
    /**
     * Updates a daily update record with the specified ID and data.
     *
     * @async
     * @function
     * @param {any} parent
     * @param {{ id: string, data: UpdateDailyUpdateInput }} args - The ID and updated data.
     * @param {Context} context - The context object.
     * @returns {Promise<DailyUpdate>} - The updated daily update record.
     * @throws {GraphQLError} - If no daily update record with the specified ID was found, or if the update operation fails.
     */
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
    /**
     * Retrieve a flight record using the flight ID associated with the parent object.
     *
     * @param {object} parent - The parent object.
     * @param {any} args - The arguments object.
     * @param {Context} context - The context object.
     * @throws Will throw an error if no flight is found with the given ID.
     * @returns {Promise<object>} - A Promise that resolves to the flight record.
     */
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

/**
 * Formats the given date by adding 2 hours to the provided time and returning it as a Date object.
 * @function
 * @param {any} date - The date to be formatted.
 * @returns {Date} - The formatted Date object.
 */
function formatDate(date: any) {
  return moment(date, "DD-MM-YYYY HH:mm:ss").add(2, "hours").toDate();
}

export default dailyUpdateResolver;

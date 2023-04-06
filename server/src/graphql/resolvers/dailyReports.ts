import {
  CreateDailyReportInput,
  UpdateDailyReportInput,
} from "@/types/dailyReports";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";
import moment from "moment";

const dailyReportResolver = {
  Query: {
    /**
     * Returns an array of all daily reports.
     *
     * @async
     * @function
     * @param {Object} parent - The parent object.
     * @param {Object} args - The arguments object.
     * @param {Context} context - The context object.
     * @throws {GraphQLError} If no daily reports are found.
     * @returns {Promise<DailyReport[]>} An array of daily reports.
     */
    dailyReports: async (parent: any, args: any, context: Context) => {
      const dailyReports = await context.prisma.dailyReport
        .findMany()
        .catch((err: any) => {
          throw createGraphQLError(`No dailyReports found`, {
            extensions: {
              code: "404",
            },
          });
        });
      if (!dailyReports) {
        throw createGraphQLError(`No dailyReports found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return dailyReports;
    },

    /**
     * Retrieves a single daily report by its ID.
     * @async
     * @function dailyReport
     * @param {object} parent - The parent object.
     * @param {object} args - The arguments for the query.
     * @param {string} args.id - The ID of the daily report to retrieve.
     * @param {object} context - The context object.
     * @param {object} context.prisma - The Prisma client object.
     * @returns {Promise<object>} - The daily report object.
     * @throws {Error} - Throws an error if the daily report cannot be found.
     */
    dailyReport: async (
      parent: any,
      args: { id: string },
      context: Context
    ) => {
      const dailyReport = await context.prisma.dailyReport
        .findUnique({
          where: { id: parseInt(args.id) },
        })
        .catch((err: any) => {
          throw createGraphQLError(`No dailyReport found with id ${args.id}`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!dailyReport) {
        throw createGraphQLError(`No dailyReport found with id ${args.id}`, {
          extensions: {
            code: "500",
          },
        });
      }
      return dailyReport;
    },
  },
  Mutation: {
    /**
     * Creates a new daily report.
     *
     * @param {object} parent - The parent object.
     * @param {object} args - The arguments object.
     * @param {CreateDailyReportInput} args.data - The data to create the daily report.
     * @param {Context} context - The context object.
     *
     * @returns {Promise<DailyReport>} The created daily report.
     *
     * @throws {GraphQLError} If the daily report could not be created.
     */
    createDailyReport: async (
      parent: any,
      args: { data: CreateDailyReportInput },
      context: Context
    ) => {
      const dailyReport = await context.prisma.dailyReport
        .create({
          data: {
            date: formatDate(args.data.date),
            helicopterId: args.data.helicopterId,
            pilotId: args.data.pilotId,
            hoistId: args.data.hoistOperatorId,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Daily Report could not be created`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!dailyReport) {
        throw createGraphQLError(`Daily Report could not be created`, {
          extensions: {
            code: "500",
          },
        });
      }
      return dailyReport;
    },
    updateDailyReport: async (
      parent: any,
      args: { id: string; data: UpdateDailyReportInput },
      context: Context
    ) => {
      const dailyReport = await context.prisma.dailyReport
        .update({
          where: { id: parseInt(args.id) },
          data: {
            date: formatDate(args.data.date),
            helicopterId: args.data.helicopterId,
            pilotId: args.data.pilotId,
            hoistId: args.data.hoistOperatorId,
          },
        })
        .catch((err: any) => {
          throw createGraphQLError(`Daily Report could not be updated`, {
            extensions: {
              code: "500",
            },
          });
        });
      if (!dailyReport) {
        throw createGraphQLError(`Daily Report could not be updated`, {
          extensions: {
            code: "500",
          },
        });
      }
      return dailyReport;
    },
  },
  DailyReport: {
    pilot: async (parent: any, args: any, context: Context) => {
      const pilot = await context.prisma.dailyReport
        .findUnique({
          where: { id: parent.id },
        })
        .pilot()
        .catch((err: any) => {
          throw createGraphQLError(`No pilot found with id ${parent.id}`, {
            extensions: {
              code: "404",
            },
          });
        });
      if (!pilot) {
        throw createGraphQLError(`No pilot found with id ${parent.id}`, {
          extensions: {
            code: "404",
          },
        });
      }
      return pilot;
    },
    hoistOperator: async (parent: any, args: any, context: Context) => {
      const hoistOperator = await context.prisma.dailyReport
        .findUnique({
          where: { id: parent.id },
        })
        .hoist()
        .catch((err: any) => {
          throw createGraphQLError(
            `No hoistOperator found with id ${parent.id}`,
            {
              extensions: {
                code: "404",
              },
            }
          );
        });
      if (!hoistOperator) {
        throw createGraphQLError(
          `No hoistOperator found with id ${parent.id}`,
          {
            extensions: {
              code: "404",
            },
          }
        );
      }
      return hoistOperator;
    },
    helicopter: async (parent: any, args: any, context: Context) => {
      const helicopter = await context.prisma.dailyReport
        .findUnique({
          where: { id: parent.id },
        })
        .helicopter()
        .catch((err: any) => {
          throw createGraphQLError(`No helicopter found with id ${parent.id}`, {
            extensions: {
              code: "404",
            },
          });
        });
      if (!helicopter) {
        throw createGraphQLError(`No helicopter found with id ${parent.id}`, {
          extensions: {
            code: "404",
          },
        });
      }
      return helicopter;
    },
  },
};

function formatDate(date: any) {
  return moment(date, "DD-MM-YYYY HH:mm:ss").add(2, "hours").toDate();
}

export default dailyReportResolver;

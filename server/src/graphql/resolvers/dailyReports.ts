import {
  CreateDailyReportInput,
  UpdateDailyReportInput,
} from "@/types/dailyReports";
import { Context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";
import moment from "moment";

const dailyReportResolver = {
  Query: {
    dailyReports: async (parent: any, args: any, context: Context) => {
      const dailyReports = await context.prisma.dailyReport.findMany();
      if (!dailyReports) {
        throw createGraphQLError(`No dailyReports found`, {
          extensions: {
            code: "404",
          },
        });
      }
      return dailyReports;
    },
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
    createDailyReport: async (
      parent: any,
      args: { data: CreateDailyReportInput },
      context: Context
    ) => {
      const dailyReport = await context.prisma.dailyReport.create({
        data: {
          date: formatDate(args.data.date),
          helicopterId: args.data.helicopterId,
          pilotId: args.data.pilotId,
          hoistId: args.data.hoistOperatorId,
        },
      });
      if (!dailyReport) {
        throw createGraphQLError(`No dailyReport created`, {
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
      const dailyReport = await context.prisma.dailyReport.update({
        where: { id: parseInt(args.id) },
        data: {
          date: formatDate(args.data.date),
          helicopterId: args.data.helicopterId,
          pilotId: args.data.pilotId,
          hoistId: args.data.hoistOperatorId,
        },
      });
      if (!dailyReport) {
        throw createGraphQLError(`No dailyReport found with id ${args.id}`, {
          extensions: {
            code: "404",
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

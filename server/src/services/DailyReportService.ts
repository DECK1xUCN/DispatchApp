import { context } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

export default {
  getDailyReportById: async (id: number) => {
    const dailyReport = await context.prisma.dailyReport
      .findUnique({
        where: { id },
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("No daily report found");
      });
    return dailyReport;
  },

  getDailyReportByDate: async (date: Date) => {
    const dailyReport = await context.prisma.dailyReport
      .findMany({
        where: { date },
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("No daily report found");
      });
    return dailyReport;
  },

  getDailyReports: async () => {
    const dailyReports = await context.prisma.dailyReport
      .findMany({
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("No daily reports found");
      });
    return dailyReports;
  },
};

import { ctx } from "@/utils/context";
import { createGraphQLError } from "graphql-yoga";

export default {
  getDailyReportById: async (id: number) => {
    const dailyReport = await ctx.prisma.dailyReport
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
    const dailyReport = await ctx.prisma.dailyReport
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
    const dailyReports = await ctx.prisma.dailyReport
      .findMany({
        include: { flights: true },
      })
      .catch(() => {
        throw createGraphQLError("No daily reports found");
      });
    return dailyReports;
  },
};

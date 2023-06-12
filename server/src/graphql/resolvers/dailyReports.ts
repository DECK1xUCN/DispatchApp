import DailyReportService from "../../services/DailyReportService";
import { createGraphQLError } from "graphql-yoga";

const dailyReportResolver = {
  Query: {
    // deprecated
    dailyReportsById: async (_: any, args: { id: number }) => {
      const dailyReport = await DailyReportService.getDailyReportById(args.id);
      if (!dailyReport) throw createGraphQLError("No daily report found");
      return dailyReport;
    },

    // deprecated
    dailyReportByDate: async (_: any, args: { date: string }) => {
      const dailyReport = await DailyReportService.getDailyReportByDate(
        args.date
      );
      if (!dailyReport) throw createGraphQLError("No daily report found");
      return dailyReport;
    },

    dailyReports: async (_: any, args: { date?: string; id?: number }) => {
      // await DailyReportService.createDailyReports();
      let dailyReports;
      if (args.date) {
        dailyReports = await DailyReportService.getDailyReportByDate(args.date);
      } else if (args.id) {
        dailyReports = await DailyReportService.getDailyReportById(args.id);
      } else {
        dailyReports = await DailyReportService.getDailyReports();
      }
      if (!dailyReports) throw createGraphQLError("No daily reports found");
      return dailyReports;
    },
  },

  Mutation: {
    createDailyReports: async () => {
      return await DailyReportService.createDailyReports();
    },
  },
};

export default dailyReportResolver;

import DailyReportService from "@/services/DailyReportService";
import { createGraphQLError } from "graphql-yoga";

const dailyReportResolver = {
  Query: {
    dailyReportById: async (parent: any, args: { id: number }) => {
      const dailyReport = await DailyReportService.getDailyReportById(args.id);
      if (!dailyReport) throw createGraphQLError("No daily report found");
      return dailyReport;
    },

    dailyReportsByDate: async (parent: any, args: { date: Date }) => {
      const dailyReport = await DailyReportService.getDailyReportByDate(
        args.date
      );
      if (!dailyReport) throw createGraphQLError("No daily report found");
      return dailyReport;
    },

    dailyReports: async () => {
      const dailyReports = await DailyReportService.getDailyReports();
      if (!dailyReports) throw createGraphQLError("No daily reports found");
      return dailyReports;
    },
  },
};

export default dailyReportResolver;

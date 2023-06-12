import { Flight } from "@prisma/client";
import { ctx } from "../utils/context";
import { formatDate } from "../utils/dateHelper";
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

  getDailyReportByDate: async (date: string) => {
    const dailyReport = await ctx.prisma.dailyReport
      .findMany({
        where: { date: formatDate(date) },
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

  createDailyReports: async () => {
    const flights = await ctx.prisma.flight.findMany({
      where: {
        editable: false,
        dailyReportId: null,
        date: { lte: new Date() },
      },
    });

    const dailyReports = new Map<Date, Flight[]>();

    flights.forEach((flight) => {
      const date = flight.date;
      if (dailyReports.has(date)) {
        const flightsForDate = dailyReports.get(date);
        if (flightsForDate) {
          flightsForDate.push(flight);
        }
      } else {
        dailyReports.set(date, [flight]);
      }
    });

    for (const [date, flights] of dailyReports.entries()) {
      await ctx.prisma.dailyReport.create({
        data: {
          date,
          flights: { connect: flights.map((flight) => ({ id: flight.id })) },
        },
      });
    }

    return true;
  },
};

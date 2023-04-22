import { Flight } from "@prisma/client";

export type DailyReport = {
  id: number;
  date: Date;
  flights: Flight[];
};

import { Flight } from "./flights";

export type DailyReport = {
  id: number;
  date: Date;
  flights: Flight[];
};

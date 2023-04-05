import { HoistOperator } from "./hoistOperators";
import { Pilot } from "./pilots";

export type DailyReport = {
  id: number;
  date: Date;
  pilot: Pilot;
  hoist: HoistOperator;
};

export interface CreateDailyReportInput {
  date: Date;
  pilotId: number;
  hoistId: number;
}

export interface UpdateDailyReportInput {
  date?: Date;
  pilotId?: number;
  hoist?: number;
}

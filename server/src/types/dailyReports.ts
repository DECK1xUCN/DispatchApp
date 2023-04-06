import { Helicopter } from "@prisma/client";
import { HoistOperator } from "./hoistOperators";
import { Pilot } from "./pilots";

export type DailyReport = {
  id: number;
  date: Date;
  helicopter: Helicopter;
  pilot: Pilot;
  hoistOperator: HoistOperator;
};

export interface CreateDailyReportInput {
  date: Date;
  helicopterId: number;
  pilotId: number;
  hoistOperatorId: number;
}

export interface UpdateDailyReportInput {
  date?: Date;
  helicopterId?: number;
  pilotId?: number;
  hoistOperatorId?: number;
}

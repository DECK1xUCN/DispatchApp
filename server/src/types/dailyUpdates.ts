import { Flight } from "./flights";

export type DailyUpdate = {
  id: number;
  flight: Flight;
  date: Date;
  wasFlight: boolean;
  delayReason: string;
  delayReasonDesc: string;
  maintenace: boolean;
  plannedMaintenance: boolean;
  unplannedMaintenance: boolean;
  otherMaintenance: boolean;
  maintenanceDesc: string;
  baseAndEquipment: boolean;
  note: string;
};

export interface CreateDailyUpdateInput {
  flightId: number;
  date: Date;
  wasFlight: boolean;
  delay: boolean;
  delayReason?: string;
  delayReasonDesc?: string;
  maintenace: boolean;
  plannedMaintenance?: boolean;
  unplannedMaintenance?: boolean;
  otherMaintenance?: boolean;
  maintenanceDesc: string;
  baseAndEquipment: boolean;
  note?: string;
}

export interface UpdateDailyUpdateInput {
  flightId?: number;
  date?: Date;
  wasFlight?: boolean;
  delayReason?: string;
  delayReasonDesc?: string;
  maintenace?: boolean;
  plannedMaintenance?: boolean;
  unplannedMaintenance?: boolean;
  otherMaintenance?: boolean;
  maintenanceDesc?: string;
  baseAndEquipment?: boolean;
  note?: string;
}

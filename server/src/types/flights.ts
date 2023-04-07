import { DailyReport } from "./dailyReports";
import { DailyUpdate } from "./dailyUpdates";
import { Heliport } from "./heliports";
import { Site } from "./sites";

export type Flight = {
  id: number;
  flightNumber: string;
  from: Heliport;
  via: Site[];
  to: Heliport;
  etd: Date;
  rotorStart: Date;
  atd: Date;
  eta: Date;
  rotorStop: Date;
  ata: Date;
  blockTime: number;
  flightTime: number;
  delay: boolean;
  delayMin: number;
  delayCode: DelayCode;
  delayDesc: string;
  pax: number;
  paxTax: number;
  cargoPP: number;
  hoistCycles: number;
  notes: string;
  dailyReport: DailyReport;
  dailyUpdate?: DailyUpdate;
};

export interface CreateFlightInput {
  flightNumber: string;
  fromId: number;
  viaId: number;
  toId: number;
  etd: Date;
  rotorStart: Date;
  atd: Date;
  eta: Date;
  rotorStop: Date;
  ata: Date;
  blockTime: number;
  flightTime: number;
  delay: boolean;
  delayMin: number;
  delayCode: DelayCode;
  delayDesc: string;
  pax: number;
  paxTax: number;
  cargoPP: number;
  hoistCycles: number;
  notes: string;
  dailyReportId: number;
  dailyUpdateId?: number;
}

export interface UpdateFlightInput {
  flightNumber?: string;
  fromId?: number;
  viaId?: number;
  toId?: number;
  etd?: Date;
  rotorStart?: Date;
  atd?: Date;
  eta?: Date;
  rotorStop?: Date;
  ata?: Date;
  blockTime?: number;
  flightTime?: number;
  delay?: boolean;
  delayMin?: number;
  delayCode?: DelayCode;
  delayDesc?: string;
  pax?: number;
  paxTax?: number;
  cargoPP?: number;
  hoistCycles?: number;
  notes?: string;
  dailyReportId?: number;
  dailyUpdateId?: number;
}

export type DelayCode = {
  code: "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J";
};

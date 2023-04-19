import { Helicopter } from "./helicopters";
import { HoistOperator } from "./hoistOperators";
import { Pilot } from "./pilots";
import { Site } from "./sites";

export type Flight = {
  id: number;
  flightNumber: string;
  date: Date;
  helicopter: Helicopter;
  pilot: Pilot;
  hoistOperator: HoistOperator;
  site: Site;
  from: Location;
  via: Location[];
  to: Location;
  etd: Date;
  rotorStart: Date;
  atd: Date;
  eta: Date;
  rotorStop: Date;
  ata: Date;
  flightTime: number;
  blockTime: number;
  delay: boolean;
  delayCode: string;
  delayTime: number;
  delayNote: string;
  pax: number;
  paxTax: number;
  cargoPP: number;
  hoistCycles: number;
  note: string;
  editable: boolean;
};

export interface CreateFlight {
  flightNumber: string;
  date: string;
  helicopterId: number;
  pilotId: number;
  hoistOperatorId: number;
  siteId: number;
  fromId: number;
  viaIds: number[];
  toId: number;
  etd: string;
  rotorStart: string;
  atd: string;
  eta: string;
  rotorStop: string;
  ata: string;
  flightTime: number;
  blockTime: number;
  pax?: number;
  paxTax?: number;
  cargoPP?: number;
  hoistCycles?: number;
  note?: string;
  editable: boolean;
}

export interface UpdateFlight {
  id: number;
  flightNumber: string;
  date: string;
  helicopterId: number;
  pilotId: number;
  hoistOperatorId: number;
  siteId: number;
  fromId: number;
  viaIds: number[];
  toId: number;
  etd: string;
  rotorStart: string;
  atd: string;
  eta: string;
  rotorStop: string;
  ata: string;
  flightTime: number;
  blockTime: number;
  pax?: number;
  paxTax?: number;
  cargoPP?: number;
  hoistCycles?: number;
  note?: string;
  editable: boolean;
}

export type DelayCode = {
  code: "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J";
};

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
  delayReason: string;
  delayDesc: string;
  pax: number;
  paxTax: number;
  cargoPP: number;
  hoistCycles: number;
  notes: string;
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
  delayReason: string;
  delayDesc: string;
  pax: number;
  paxTax: number;
  cargoPP: number;
  hoistCycles: number;
  notes: string;
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
  delayReason?: string;
  delayDesc?: string;
  pax?: number;
  paxTax?: number;
  cargoPP?: number;
  hoistCycles?: number;
  notes?: string;
}

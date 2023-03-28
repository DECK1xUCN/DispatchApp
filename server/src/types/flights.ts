export type FlightCreateInput = {
  flightNumber: string;
  from: string;
  via: string;
  to: string;
  etd: Date;
  rotorStart: Date;
  atd: Date;
  eta: Date;
  rotorStop: Date;
  ata: Date;
  pax: number;
  cargoPP: number;
  hoistCycles: number;
  late: boolean;
  lateNote?: string;
  delayCode?: string;
};

export interface FlightUpdateInput {
  flightNumber: string;
  from: string;
  via: string;
  to: string;
  etd: Date;
  rotorStart: Date;
  atd: Date;
  eta: Date;
  rotorStop: Date;
  ata: Date;
  pax: number;
  cargoPP: number;
  hoistCycles: number;
  late: boolean;
  lateNote?: string;
  delayCode?: string;
}

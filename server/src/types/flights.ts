export type FlightCreateInput = {
  flightNumber: string;
  from: string;
  via: string;
  to: string;
  etd: Date;
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
  pax: number;
  cargoPP: number;
  hoistCycles: number;
  late: boolean;
  lateNote?: string;
  delayCode?: string;
}

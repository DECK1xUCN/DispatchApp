export interface FlightCreateInput {
  from: string;
  flightNumber: string;
  via: string;
  to: string;
  pax: number;
  cargoPP: number;
  hoistCycles: number;
  late: boolean;
  lateNote?: string;
  delayCode?: string;
}

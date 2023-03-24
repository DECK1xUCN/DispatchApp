export interface FlightCreateInput {
  from: string;
  flightNumber: string;
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

export interface FlightUpdateInput {
  from?: string;
  flightNumber?: string;
  via?: string;
  to?: string;
  etd?: Date;
  pax?: number;
  cargoPP?: number;
  hoistCycles?: number;
  late?: boolean;
  lateNote?: string;
  delayCode?: string;
}

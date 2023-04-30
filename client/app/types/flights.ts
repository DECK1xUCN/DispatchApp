namespace Types {
  export interface Flight {
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
    etd: Date | string;
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
  }

  export interface CreateFlight {
    flightNumber: string;
    date: string;
    helicopterId: number | null;
    pilotId: number | null;
    hoistOperatorId: number | null;
    siteId: number | null;
    fromId: number | null;
    viaIds: number[] | null;
    toId: number | null;
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
    editable?: boolean;
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
}

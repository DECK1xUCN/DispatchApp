namespace Types {
  export interface DailyUpdate {
    id: number;
    flight: Flight;
    wasFlight: boolean;
    delay: boolean;
    delayCode: string;
    delayTime: number;
    delayDesc: string;
    maintenance: boolean;
    plannedMaintenance: boolean;
    unplannedMaintenance: boolean;
    otherMaintenance: boolean;
    maintenanceNote: string;
    baseAndEquipment: boolean;
    note: string;
  }

  export interface CreateDailyUpdate {
    flightId: number;
    wasFlight: boolean;
    delay: boolean;
    delayCode?: string;
    delayTime?: number;
    delayDesc?: string;
    maintenace: boolean;
    plannedMaintenance: boolean;
    unplannedMaintenance: boolean;
    otherMaintenance: boolean;
    maintenanceNote?: string;
    baseAndEquipment: boolean;
    note?: string;
  }
}

namespace Types {
  export interface Helicopter {
    id: number;
    manufacturer: string;
    model: string;
    reg: string;
    flights: Flight[];
  }

  export interface CreateHelicopter {
    manufacturer: string;
    model: string;
    reg: string;
  }
}

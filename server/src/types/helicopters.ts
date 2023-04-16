import { Flight } from "./flights";

export type Helicopter = {
  id: number;
  name: string;
  model: string;
  reg: string;
  flights: Flight[];
};

export interface CreateHelicopter {
  name: string;
  model: string;
  reg: string;
}

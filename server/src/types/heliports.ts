import { Flight } from "./flights";

export type Heliport = {
  id: number;
  name: string;
};

export interface HeliportInput {
  name: string;
}

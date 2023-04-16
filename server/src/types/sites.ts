import { Flight } from "./flights";

export type Site = {
  id: number;
  name: string;
};

export interface CreateSite {
  name: string;
}

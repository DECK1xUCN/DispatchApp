export type Location = {
  id: number;
  name: string;
  lat: number;
  long: number;
  type: LocationType;
};

export type LocationType = "HELIPORT" | "AIRPORT" | "VIA" | "OTHER";

export interface CreateLocation {
  name: string;
  lat?: number;
  lng?: number;
  type: LocationType;
  siteId: number;
}

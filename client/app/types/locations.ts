namespace Types {
  export interface Location {
    id: number;
    name: string;
    lat: number;
    lng: number;
    type: string;
    site: Site;
  }

  export type LocationType = "HELIPORT" | "AIRPORT" | "VIA" | "OTHER";
  export const locationTypes: LocationType[] = [
    "HELIPORT",
    "AIRPORT",
    "VIA",
    "OTHER",
  ];

  export interface CreateLocation {
    name: string;
    lat?: number;
    lng?: number;
    type: string;
    siteId: number;
  }

  export interface UpdateLocation {
    name?: string;
    lat?: number;
    lng?: number;
  }
}

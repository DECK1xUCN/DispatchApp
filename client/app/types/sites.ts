namespace Types {
  export interface Site {
    id: number;
    name: string;
    locations: Location[];
  }

  export interface CreateSite {
    name: string;
  }
}

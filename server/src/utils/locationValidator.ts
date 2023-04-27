import { LocationType, locationTypes } from "@/types/locations";

export const isLocationType = (type: string) => {
  return locationTypes.includes(type as LocationType);
};

import LocationService from "../services/LocationService";
import { MockContext, createMockContext } from "../utils/context";
import { createGraphQLError } from "graphql-yoga";

let mockCtx: MockContext;

beforeEach(() => {
  mockCtx = createMockContext();
});

describe("LocationService", () => {
  test("should return a location with id 1 ", async () => {
    // Arrange
    const testLocation = {
      id: 1,
      name: "Location1",
      lat: 1,
      lng: 1,
      type: "HELIPORT",
      siteId: 1,
    };

    mockCtx.prisma.location.findUnique.mockResolvedValue(testLocation);

    // Act
    const location = await LocationService.getLocation(1, mockCtx);

    // Assert
    expect(location).toEqual(testLocation);
  });

  test("get location with id 0 should return null ", async () => {
    // Arrange
    const testLocation = null;
    mockCtx.prisma.location.findUnique.mockResolvedValue(testLocation);

    // Act
    const result = await LocationService.getLocation(0, mockCtx);

    // Assert
    expect(result).toBeNull();
  });

  test("should return all locations", async () => {
    // Arrange
    const testLocations = [
      {
        id: 1,
        name: "Location1",
        lat: 1,
        lng: 1,
        type: "HELIPORT",
        siteId: 1,
      },
      {
        id: 2,
        name: "Location2",
        lat: 2,
        lng: 2,
        type: "AIRPORT",
        siteId: 2,
      },
    ];
    mockCtx.prisma.location.findMany.mockResolvedValue(testLocations);

    // Act
    const locations = await LocationService.getLocations(mockCtx);

    // Assert
    expect(locations.length).toEqual(testLocations.length);
    expect(locations).toEqual(testLocations);
  });

  test("should return all locations of type HELIPORT or AIRPORT per site id 1", async () => {
    // Arrange
    const testLocations = [
      {
        id: 1,
        name: "Location1",
        lat: 1,
        lng: 1,
        type: "HELIPORT",
        siteId: 1,
      },
      {
        id: 2,
        name: "Location2",
        lat: 2,
        lng: 2,
        type: "VIA",
        siteId: 1,
      },
      {
        id: 3,
        name: "Location3",
        lat: 3,
        lng: 3,
        type: "AIRPORT",
        siteId: 1,
      },
      {
        id: 4,
        name: "Location4",
        lat: 4,
        lng: 4,
        type: "HELIPORT",
        siteId: 2,
      },
    ];

    mockCtx.prisma.location.findMany.mockResolvedValue(
      testLocations.filter(
        (location) =>
          (location.type === "HELIPORT" || location.type === "AIRPORT") &&
          location.siteId === 1
      )
    );

    // Act
    const locations = await LocationService.getHeliportsPerSite(1, mockCtx);

    // Assert
    expect(locations.length).toEqual(2);
    expect(locations[0].type).toEqual("HELIPORT");
    expect(locations[1].type).toEqual("AIRPORT");
  });
});

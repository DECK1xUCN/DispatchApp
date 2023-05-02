import SiteService from "../services/SiteService";
import { MockContext, createMockContext } from "../utils/context";
import { createGraphQLError } from "graphql-yoga";

let mockCtx: MockContext;

beforeEach(() => {
  mockCtx = createMockContext();
});

describe("SiteService", () => {
  test("should return a site with id 1 ", async () => {
    // Arrange
    const testSite = {
      id: 1,
      name: "Site1",
      locations: [],
      flights: [],
    };
    mockCtx.prisma.site.findUnique.mockResolvedValue(testSite);

    // Act
    const site = await SiteService.getSite(1, mockCtx);

    // Assert
    expect(site).toEqual(testSite);
  });

  test("get site with id 0 should return null ", async () => {
    // Arrange
    const testSite = null;
    mockCtx.prisma.site.findUnique.mockResolvedValue(testSite);

    // Act
    const result = await SiteService.getSite(0, mockCtx);

    // Assert
    expect(result).toBeNull();
  });

  test("should return all sites", async () => {
    // Arrange
    const testSites = [
      {
        id: 1,
        name: "Site1",
        locations: [],
        flights: [],
      },
      {
        id: 2,
        name: "Site2",
        locations: [],
        flights: [],
      },
    ];
    mockCtx.prisma.site.findMany.mockResolvedValue(testSites);

    // Act
    const sites = await SiteService.getSites(mockCtx);

    // Assert
    expect(sites.length).toEqual(testSites.length);
    expect(sites).toEqual(testSites);
  });

  test("should return empty arr, when no sites", async () => {
    // Arrange
    const testSites: any = [];
    mockCtx.prisma.site.findMany.mockResolvedValue(testSites);

    // Act
    const sites = await SiteService.getSites(mockCtx);

    // Assert
    expect(sites.length).toEqual(testSites.length);
    expect(sites).toEqual(testSites);
  });

  test("should create a site", async () => {
    // Arrange
    const testSite = {
      id: 1,
      name: "Site1",
      locations: [],
      flights: [],
    };
    mockCtx.prisma.site.create.mockResolvedValue(testSite);

    // Act
    const site = await SiteService.createSite(testSite.name, mockCtx);

    // Assert
    expect(site).toEqual(testSite);
  });

  test("should throw error when creating a site with no name", async () => {
    // Arrange
    const testSite = {
      id: 1,
      name: "",
      locations: [],
      flights: [],
    };
    mockCtx.prisma.site.create.mockResolvedValue(testSite);

    // Act & Assert
    await expect(
      SiteService.createSite(testSite.name, mockCtx)
    ).rejects.toThrow(createGraphQLError("Name cannot be empty"));
  });

  test("should update a site", async () => {
    // Arrange
    const testSite = {
      id: 1,
      name: "Site1",
      locations: [],
      flights: [],
    };

    const updatedSite = {
      id: 1,
      name: "Site2",
      locations: [],
      flights: [],
    };

    mockCtx.prisma.site.findUnique.mockResolvedValue(testSite);
    mockCtx.prisma.site.update.mockResolvedValue(updatedSite);

    // Act
    const site = await SiteService.updateSite(
      { id: testSite.id, name: updatedSite.name },
      mockCtx
    );

    // Assert
    expect(site).toEqual(updatedSite);
    expect(site.name).not.toEqual(testSite.name);
    expect(site.id).toEqual(updatedSite.id);
  });

  test("should throw error when updating a site with no name", async () => {
    // Arrange
    const testSite = {
      id: 1,
      name: "Site1",
      locations: [],
      flights: [],
    };

    mockCtx.prisma.site.findUnique.mockResolvedValue(testSite);
    mockCtx.prisma.site.update.mockImplementation();

    // Act & Assert
    await expect(
      SiteService.updateSite({ id: 1, name: "" }, mockCtx)
    ).rejects.toThrow(createGraphQLError("Name cannot be empty"));
  });
});

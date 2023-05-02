import { mock } from "node:test";
import PilotService from "../services/PilotService";
import { MockContext, createMockContext } from "../utils/context";
import { createGraphQLError } from "graphql-yoga";

let mockCtx: MockContext;

beforeEach(() => {
  mockCtx = createMockContext();
});

describe("PilotService", () => {
  test("should return a pilot with id 1 ", async () => {
    // Arrange
    const testPilot = {
      id: 1,
      name: "PLT1",
      flights: [],
    };
    mockCtx.prisma.pilot.findUnique.mockResolvedValue(testPilot);

    // Act
    const pilot = await PilotService.getPilot(1, mockCtx);

    // Assert
    expect(pilot).toEqual(testPilot);
  });

  test("get pilot with id 0 should return null ", async () => {
    // Arrange
    const testPilot = null;
    mockCtx.prisma.pilot.findUnique.mockResolvedValue(testPilot);

    // Act
    const result = await PilotService.getPilot(0, mockCtx);

    // Assert
    expect(result).toBeNull();
  });

  test("should return all pilots", async () => {
    // Arrange
    const testPilots = [
      {
        id: 1,
        name: "PLT1",
        flights: [],
      },
      {
        id: 2,
        name: "PLT2",
        flights: [],
      },
    ];
    mockCtx.prisma.pilot.findMany.mockResolvedValue(testPilots);

    // Act
    const pilots = await PilotService.getPilots(mockCtx);

    // Assert
    expect(pilots.length).toEqual(testPilots.length);
  });

  test("should return empty arr, when no pilots found", async () => {
    // Arrange
    const testPilots = [];
    mockCtx.prisma.pilot.findMany.mockResolvedValue([]);

    // Act
    const result = await PilotService.getPilots(mockCtx);

    // Assert
    expect(result.length).toEqual(testPilots.length);
  });

  test("should create a pilot", async () => {
    // Arrange
    const testPilot = {
      id: 1,
      name: "PLT1",
      flights: [],
    };
    mockCtx.prisma.pilot.create.mockResolvedValue(testPilot);

    // Act
    const pilot = await PilotService.createPilot("PLT1", mockCtx);

    // Assert
    expect(pilot).toEqual(testPilot);
  });

  test("should throw error when creating a pilot with empty name", async () => {
    // Arrange
    mockCtx.prisma.pilot.create.mockImplementation();

    // Act & Assert
    await expect(PilotService.createPilot("", mockCtx)).rejects.toThrow(
      createGraphQLError(
        "Name must be 4 characters or less and cannot be empty"
      )
    );
  });

  test("should throw error when creating a pilot with name longer than 4 characters", async () => {
    // Arrange
    mockCtx.prisma.pilot.create.mockImplementation();

    // Act & Assert
    await expect(PilotService.createPilot("PLT123", mockCtx)).rejects.toThrow(
      createGraphQLError(
        "Name must be 4 characters or less and cannot be empty"
      )
    );
  });

  test("update pilot with id 1", async () => {
    // Arrange
    const testPilot = {
      id: 1,
      name: "PLT1",
      flights: [],
    };
    mockCtx.prisma.pilot.update.mockResolvedValue(testPilot);
  });
});

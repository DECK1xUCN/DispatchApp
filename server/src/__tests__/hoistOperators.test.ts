import HoistOperatorService from "../services/HoistOperatorService";
import { MockContext, createMockContext } from "../utils/context";
import { createGraphQLError } from "graphql-yoga";

let mockCtx: MockContext;

beforeEach(() => {
  mockCtx = createMockContext();
});

describe("HoistOperatorService", () => {
  test("should return a hoistOperator with id 1 ", async () => {
    // Arrange
    const testHoistOperator = {
      id: 1,
      name: "HO1",
      flights: [],
    };
    mockCtx.prisma.hoistOperator.findUnique.mockResolvedValue(
      testHoistOperator
    );

    // Act
    const hoistOperator = await HoistOperatorService.getHoistOperatorById(
      1,
      mockCtx
    );

    // Assert
    expect(hoistOperator).toEqual(testHoistOperator);
  });

  test("get hoistOperator with id 0 should return null ", async () => {
    // Arrange
    const testHoistOperator = null;
    mockCtx.prisma.hoistOperator.findUnique.mockResolvedValue(
      testHoistOperator
    );

    // Act
    const result = await HoistOperatorService.getHoistOperatorById(0, mockCtx);

    // Assert
    expect(result).toBeNull();
  });

  test("should throw an error if hoistOperator is not found", async () => {
    // Arrange
    mockCtx.prisma.hoistOperator.findUnique.mockResolvedValue(null);

    // Act
    const hoistOperator = await HoistOperatorService.getHoistOperatorById(
      0,
      mockCtx
    );

    // Assert
    expect(hoistOperator).toBeNull();
  });

  test("should return all hoistOperators", async () => {
    // Arrange
    const testHoistOperators = [
      {
        id: 1,
        name: "HO1",
        flights: [],
      },
      {
        id: 2,
        name: "HO2",
        flights: [],
      },
    ];
    mockCtx.prisma.hoistOperator.findMany.mockResolvedValue(testHoistOperators);

    // Act
    const hoistOperators = await HoistOperatorService.getHoistOperators(
      mockCtx
    );

    // Assert
    expect(hoistOperators).toEqual(testHoistOperators);
    expect(hoistOperators.length).toEqual(testHoistOperators.length);
  });

  test("should return empty arr if no hoistOperators found", async () => {
    // Arrange
    const testHoistOperators: any = [];
    mockCtx.prisma.hoistOperator.findMany.mockResolvedValue(testHoistOperators);

    // Act
    const hoistOperators = await HoistOperatorService.getHoistOperators(
      mockCtx
    );

    // Assert
    expect(hoistOperators).toEqual(testHoistOperators);
    expect(hoistOperators.length).toEqual(testHoistOperators.length);
  });

  test("should create a hoistOperator", async () => {
    // Arrange
    const testHoistOperator = {
      id: 1,
      name: "HO1",
      flights: [],
    };
    mockCtx.prisma.hoistOperator.create.mockResolvedValue(testHoistOperator);

    // Act
    const hoistOperator = await HoistOperatorService.createHoistOperator(
      testHoistOperator.name,
      mockCtx
    );

    // Assert
    expect(hoistOperator).toEqual(testHoistOperator);
  });

  test("should throw an error if hoistOperator name is not unique", async () => {
    // Arrange
    const testHoistOperator = {
      id: 1,
      name: "HO1",
      flights: [],
    };
    mockCtx.prisma.hoistOperator.findUnique.mockResolvedValue(
      testHoistOperator
    );
    mockCtx.prisma.hoistOperator.create.mockResolvedValue(testHoistOperator);

    // Act
    const hoistOperator = await HoistOperatorService.createHoistOperator(
      testHoistOperator.name,
      mockCtx
    );

    // Assert
    expect(hoistOperator).toEqual(testHoistOperator);
  });

  test("should throw an error if hoistOperator name is empty", async () => {
    // Arrange
    const testHoistOperator = {
      id: 1,
      name: "",
      flights: [],
    };
    mockCtx.prisma.hoistOperator.findUnique.mockResolvedValue(
      testHoistOperator
    );

    // Act & Assert
    await expect(
      HoistOperatorService.createHoistOperator(testHoistOperator.name, mockCtx)
    ).rejects.toThrow(
      createGraphQLError(
        "Name must be 4 characters or less and cannot be empty"
      )
    );
  });

  test("should throw an error if hoistOperator name is more than 4 characters", async () => {
    // Arrange
    const testHoistOperator = {
      id: 1,
      name: "HOIST",
      flights: [],
    };
    mockCtx.prisma.hoistOperator.findUnique.mockResolvedValue(
      testHoistOperator
    );

    // Act & Assert
    await expect(
      HoistOperatorService.createHoistOperator(testHoistOperator.name, mockCtx)
    ).rejects.toThrow(
      createGraphQLError(
        "Name must be 4 characters or less and cannot be empty"
      )
    );
  });

  test("update hoistOperator with  id 1", async () => {
    // Arrange
    const testHoistOperator = {
      id: 1,
      name: "HO1",
      flights: [],
    };

    const updatedHoistOperator = {
      id: 1,
      name: "HO2",
      flights: [],
    };

    mockCtx.prisma.hoistOperator.findUnique.mockResolvedValue(
      testHoistOperator
    );
    mockCtx.prisma.hoistOperator.update.mockResolvedValue(updatedHoistOperator);

    // Act
    const hoistOperator = await HoistOperatorService.updateHoistOperator(
      { id: 1, name: updatedHoistOperator.name },
      mockCtx
    );

    // Assert
    expect(hoistOperator).toEqual(updatedHoistOperator);
  });
});

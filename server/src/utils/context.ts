import { PrismaClient } from "@prisma/client";
import { mockDeep, DeepMockProxy } from "jest-mock-extended";

const prisma = new PrismaClient({
  log: ["query", "info", "warn"],
});

export type Context = {
  prisma: PrismaClient;
};

export const ctx: Context = {
  prisma: prisma,
};

export type MockContext = {
  prisma: DeepMockProxy<PrismaClient>;
};

export const createMockContext = (): MockContext => {
  return {
    prisma: mockDeep<PrismaClient>(),
  };
};

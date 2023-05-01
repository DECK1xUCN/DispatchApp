import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient({
  log: ["query", "info", "warn"],
});

export interface ctx {
  prisma: PrismaClient;
}

export const ctx: ctx = {
  prisma: prisma,
};

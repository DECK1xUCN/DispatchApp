/*
  Warnings:

  - Added the required column `cargoPP` to the `Flights` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hoistCycles` to the `Flights` table without a default value. This is not possible if the table is not empty.
  - Added the required column `late` to the `Flights` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pax` to the `Flights` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Flights" ADD COLUMN     "cargoPP" INTEGER NOT NULL,
ADD COLUMN     "delayCode" TEXT NOT NULL DEFAULT 'N/A',
ADD COLUMN     "hoistCycles" INTEGER NOT NULL,
ADD COLUMN     "late" BOOLEAN NOT NULL,
ADD COLUMN     "lateNote" TEXT NOT NULL DEFAULT 'N/A',
ADD COLUMN     "pax" INTEGER NOT NULL;

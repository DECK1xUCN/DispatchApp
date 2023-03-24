/*
  Warnings:

  - You are about to drop the `Flight` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "Flight";

-- CreateTable
CREATE TABLE "Flights" (
    "id" UUID NOT NULL,
    "from" TEXT NOT NULL,
    "via" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    "flightNumber" TEXT NOT NULL,

    CONSTRAINT "Flights_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Flights_id_key" ON "Flights"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Flights_flightNumber_key" ON "Flights"("flightNumber");

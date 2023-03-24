-- CreateTable
CREATE TABLE "Flight" (
    "id" TEXT NOT NULL,
    "from" TEXT NOT NULL,
    "via" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    "flightNumber" TEXT NOT NULL,

    CONSTRAINT "Flight_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Flight_id_key" ON "Flight"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Flight_flightNumber_key" ON "Flight"("flightNumber");

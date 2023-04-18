import { CreateDailyUpdate } from "@/types/dailyUpdates";
import { context } from "@/utils/context";
import { Flight, DailyUpdate } from "@prisma/client";
import { createGraphQLError } from "graphql-yoga";

export default {
  getDailyUpdateById: async (id: number) => {
    const dailyUpdate = await context.prisma.dailyUpdate.findUnique({
      where: { id },
      include: {
        flight: true,
      },
    });
    return dailyUpdate;
  },

  getAllDailyUpdates: async () => {
    const dailyUpdates = await context.prisma.dailyUpdate.findMany({
      include: {
        flight: true,
      },
    });
    return dailyUpdates;
  },

  createDailyUpdate: async (data: CreateDailyUpdate) => {
    const flight = await context.prisma.flight.findUnique({
      where: { id: data.flightId },
    });
    if (!flight) throw createGraphQLError("No flight found");
    if (flight.editable === false) throw createGraphQLError("Flight is locked");

    try {
      const dailyUpdate = await context.prisma.dailyUpdate.create({
        data: {
          flightId: data.flightId,
          wasFlight: data.wasFlight,
          delay: data.delay,
          delayCode: data.delayCode,
          delayTime: data.delayTime,
          delayDesc: data.delayDesc,
          maintenance: data.maintenace,
          plannedMaintenance: data.plannedMaintenance,
          unplannedMaintenance: data.unplannedMaintenance,
          otherMaintenance: data.otherMaintenance,
          maintenanceNote: data.maintenanceNote,
          baseAndEquipment: data.baseAndEquipment,
          note: data.note,
        },
        include: {
          flight: true,
        },
      });

      await context.prisma.flight
        .update({
          where: { id: data.flightId },
          data: {
            editable: false,
            dailyUpdate: {
              connect: {
                id: dailyUpdate.id,
              },
            },
          },
          include: {
            dailyUpdate: true,
          },
        })
        .catch(() => {
          throw createGraphQLError("Daily update could not be created");
        });

      return dailyUpdate;
    } catch (err: any) {
      throw createGraphQLError("Daily update could not be created");
    }
  },
};

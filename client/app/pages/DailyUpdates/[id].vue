<template>
  <div class="m-14 w-full h-max">
    <PageTitle primaryText="Daily Update" :secondary-text="'ID: ' + id" />
    <form
      class="flex flex-col gap-12 w-max mt-6 bg-white rounded-md shadow-md p-5 lg:px-16 lg:py-10 xl:px-20 xl:py-14"
      v-if="dailyUpdate"
    >
      <div class="flex flex-col gap-4 items-start">
        <div class="flex gap-4 items-center">
          <Label>Was flight?</Label>
          <ToggleSwitch v-model="dailyUpdate.wasFlight" :disabled="true" />
        </div>
        <div v-if="dailyUpdate.wasFlight" class="flex flex-col gap-1">
          <Label>Flight</Label>
          <Input v-model="dailyUpdate.flight.flightNumber" :isDisabled="true" />
        </div>
      </div>
      <div class="flex flex-col gap-3">
        <div v-if="dailyUpdate.wasFlight" class="flex gap-4 items-center">
          <Label>Delay</Label>
          <ToggleSwitch v-model="dailyUpdate.delay" :disabled="true" />
        </div>
        <div v-if="dailyUpdate.delay" class="flex flex-col gap-2">
          <Label>Delay Code</Label>
          <Input v-model="dailyUpdate.delayCode" :isDisabled="true" />
        </div>
        <div v-if="dailyUpdate.delay" class="flex flex-col gap-1">
          <Label>Delay Time (min)</Label>
          <Input
            type="number"
            v-model="dailyUpdate.delayTime"
            :isDisabled="true"
          />
        </div>
        <div v-if="dailyUpdate.delay" class="flex flex-col gap-1">
          <Label>Delay description</Label>
          <TextArea v-model="dailyUpdate.delayDesc" :isDisabled="true" />
        </div>
      </div>

      <div class="flex flex-col gap-3">
        <div class="flex gap-4 items-center">
          <Label>Maintenance</Label>
          <ToggleSwitch v-model="dailyUpdate.maintenance" :disabled="true" />
        </div>
        <div class="flex gap-4 items-center" v-if="dailyUpdate.maintenance">
          <Label>Unplanned Maintenance</Label>
          <ToggleSwitch
            v-model="dailyUpdate.unplannedMaintenance"
            :disabled="true"
          />
        </div>
        <div class="flex gap-4 items-center" v-if="dailyUpdate.maintenance">
          <Label>Planned Maintenance</Label>
          <ToggleSwitch
            v-model="dailyUpdate.plannedMaintenance"
            :disabled="true"
          />
        </div>
        <div class="flex gap-4 items-center" v-if="dailyUpdate.maintenance">
          <Label>Other Maintenance</Label>
          <ToggleSwitch
            v-model="dailyUpdate.otherMaintenance"
            :disabled="true"
          />
        </div>
        <div class="flex flex-col gap-1" v-if="dailyUpdate.maintenance">
          <Label>Maintenance note</Label>
          <TextArea v-model="dailyUpdate.maintenanceNote" :isDisabled="true" />
        </div>
      </div>

      <div class="flex gap-4">
        <Label>Base and Equipment</Label>
        <ToggleSwitch v-model="dailyUpdate.baseAndEquipment" :disabled="true" />
      </div>

      <div class="flex flex-col gap-1">
        <Label>Note</Label>
        <TextArea v-model="dailyUpdate.note" :isDisabled="true" />
      </div>
      <div class="flex self-end gap-x-4">
        <BackButton @click.prevent="router.go(-1)" />
      </div>
    </form>
  </div>
</template>
<script setup lang="ts">
import PageTitle from "@/components/Headers/PageTitle.vue";
import Label from "@/components/Headers/Label.vue";
import TextArea from "@/components/Input/TextArea.vue";
import BackButton from "@/components/Buttons/BackButton.vue";
import ToggleSwitch from "@/components/Input/ToggleSwitch.vue";
import Input from "@/components/Input/Input.vue";
import query from "~/api/dailyUpdateDetails.graphql";

const router = useRouter();
const route = useRoute();

const dailyUpdate: Ref<Types.DailyUpdate | null> = ref(null);

const id = Number(route.params.id);

onBeforeMount(() => {
  getData();
});

async function getData() {
  const { data } = await useAsyncQuery(query, { id: id });
  if (data.value) {
    // @ts-expect-error
    dailyUpdate.value = data.value.dailyUpdate;
  }
}
</script>

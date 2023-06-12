<template>
  <div class="m-14 w-full h-max">
    <HeadersPageTitle
      primaryText="Daily Update"
      :secondary-text="'ID: ' + id"
    />
    <form
      class="flex flex-col gap-12 w-max mt-6 bg-white rounded-md shadow-md p-5 lg:px-16 lg:py-10 xl:px-20 xl:py-14"
      v-if="dailyUpdate && !isLoading"
    >
      <div class="flex flex-col gap-4 items-start">
        <div class="flex gap-4 items-center">
          <HeadersLabel>Was flight?</HeadersLabel>
          <ToggleSwitch v-model="dailyUpdate.wasFlight" :disabled="true" />
        </div>
        <div v-if="dailyUpdate.wasFlight" class="flex flex-col gap-1">
          <HeadersLabel>Flight</HeadersLabel>
          <Input v-model="dailyUpdate.flight.flightNumber" :isDisabled="true" />
        </div>
      </div>
      <div class="flex flex-col gap-3">
        <div v-if="dailyUpdate.wasFlight" class="flex gap-4 items-center">
          <HeadersLabel>Delay</HeadersLabel>
          <ToggleSwitch v-model="dailyUpdate.delay" :disabled="true" />
        </div>
        <div v-if="dailyUpdate.delay" class="flex flex-col gap-2">
          <HeadersLabel>Delay Code</HeadersLabel>
          <Input v-model="dailyUpdate.delayCode" :isDisabled="true" />
        </div>
        <div v-if="dailyUpdate.delay" class="flex flex-col gap-1">
          <HeadersLabel>Delay Time (min)</HeadersLabel>
          <Input
            type="number"
            v-model="dailyUpdate.delayTime"
            :isDisabled="true"
          />
        </div>
        <div v-if="dailyUpdate.delay" class="flex flex-col gap-1">
          <HeadersLabel>Delay description</HeadersLabel>
          <TextArea v-model="dailyUpdate.delayDesc" :isDisabled="true" />
        </div>
      </div>

      <div class="flex flex-col gap-3">
        <div class="flex gap-4 items-center">
          <HeadersLabel>Maintenance</HeadersLabel>
          <ToggleSwitch v-model="dailyUpdate.maintenance" :disabled="true" />
        </div>
        <div class="flex gap-4 items-center" v-if="dailyUpdate.maintenance">
          <HeadersLabel>Unplanned Maintenance</HeadersLabel>
          <ToggleSwitch
            v-model="dailyUpdate.unplannedMaintenance"
            :disabled="true"
          />
        </div>
        <div class="flex gap-4 items-center" v-if="dailyUpdate.maintenance">
          <HeadersLabel>Planned Maintenance</HeadersLabel>
          <ToggleSwitch
            v-model="dailyUpdate.plannedMaintenance"
            :disabled="true"
          />
        </div>
        <div class="flex gap-4 items-center" v-if="dailyUpdate.maintenance">
          <HeadersLabel>Other Maintenance</HeadersLabel>
          <ToggleSwitch
            v-model="dailyUpdate.otherMaintenance"
            :disabled="true"
          />
        </div>
        <div class="flex flex-col gap-1" v-if="dailyUpdate.maintenance">
          <HeadersLabel>Maintenance note</HeadersLabel>
          <TextArea v-model="dailyUpdate.maintenanceNote" :isDisabled="true" />
        </div>
      </div>

      <div class="flex gap-4">
        <HeadersLabel>Base and Equipment</HeadersLabel>
        <ToggleSwitch v-model="dailyUpdate.baseAndEquipment" :disabled="true" />
      </div>

      <div class="flex flex-col gap-1">
        <HeadersLabel>Note</HeadersLabel>
        <TextArea v-model="dailyUpdate.note" :isDisabled="true" />
      </div>
      <div class="flex self-end gap-x-4">
        <ButtonsBackButton @click.prevent="router.go(-1)" />
      </div>
    </form>
    <section v-if="isLoading" class="flex justify-center items-center w-full">
      <LoadersLoader />
    </section>
  </div>
</template>
<script setup lang="ts">
import TextArea from "@/components/Input/TextArea.vue";

import ToggleSwitch from "@/components/Input/ToggleSwitch.vue";
import Input from "@/components/Input/Input.vue";
import query from "~/api/dailyUpdateDetails.graphql";

const router = useRouter();
const route = useRoute();

const dailyUpdate: Ref<Types.DailyUpdate | null> = ref(null);

const id = Number(route.params.id);
const isLoading = ref(false);

onBeforeMount(() => {
  getData();
});

type Response = {
  dailyUpdate: Types.DailyUpdate;
};
async function getData() {
  isLoading.value = true;
  const { data } = await useAsyncQuery<Response>(query, { id: id });
  if (data.value) {
    dailyUpdate.value = data.value.dailyUpdate;
  }
  isLoading.value = false;
}
</script>

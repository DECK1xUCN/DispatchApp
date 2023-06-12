<template>
  <div class="m-14 w-full h-max">
    <HeadersPageTitle primaryText="New Daily Update" />
    <LoadersLoader v-if="isLoading" />
    <form
      class="flex flex-col gap-12 w-max mt-6 bg-white rounded-md shadow-md p-5"
      v-if="!isLoading"
      @submit.prevent="submit()"
    >
      <div class="flex gap-12 items-start">
        <div class="flex gap-4 items-center">
          <HeadersLabel>Was flight?</HeadersLabel>
          <ToggleSwitch v-model="newDailyUpdate.wasFlight" />
        </div>
        <div v-if="newDailyUpdate.wasFlight" class="flex flex-col gap-1">
          <HeadersLabel>Flight</HeadersLabel>
          <select
            v-model="newDailyUpdate.flightId"
            class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg"
          >
            <option value="" selected disabled>Select a flight</option>
            <option
              v-for="option in flights"
              :value="option.id"
              class="text-center"
            >
              {{ option.flightNumber }}
            </option>
          </select>
        </div>
      </div>
      <div class="flex flex-col gap-3">
        <div v-if="newDailyUpdate.wasFlight" class="flex gap-4 items-center">
          <HeadersLabel>Delay</HeadersLabel>
          <ToggleSwitch v-model="newDailyUpdate.delay" />
        </div>
        <div v-if="newDailyUpdate.delay" class="flex flex-col gap-2">
          <HeadersLabel>Delay Code</HeadersLabel>
          <select
            name=""
            id=""
            class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg"
          >
            <option value="" selected disabled>Select a delay code</option>
            <option
              v-for="option in delayCodes"
              :value="option.code"
              class="text-center"
            >
              {{ option.description }}
            </option>
          </select>
        </div>
        <div v-if="newDailyUpdate.delay" class="flex flex-col gap-1">
          <HeadersLabel>Delay Time (min)</HeadersLabel>
          <Input type="number" v-model="newDailyUpdate.delayTime" />
        </div>
        <div v-if="newDailyUpdate.delay" class="flex flex-col gap-1">
          <HeadersLabel>Delay description</HeadersLabel>
          <TextArea v-model="newDailyUpdate.delayDesc" />
        </div>
      </div>

      <div class="flex flex-col gap-3">
        <div class="flex gap-4 items-center">
          <HeadersLabel>Maintenance</HeadersLabel>
          <ToggleSwitch v-model="newDailyUpdate.maintenace" />
        </div>
        <div v-if="newDailyUpdate.maintenace" class="flex gap-4 items-center">
          <HeadersLabel>Unplanned Maintenance</HeadersLabel>
          <ToggleSwitch v-model="newDailyUpdate.unplannedMaintenance" />
        </div>
        <div v-if="newDailyUpdate.maintenace" class="flex gap-4 items-center">
          <HeadersLabel>Planned Maintenance</HeadersLabel>
          <ToggleSwitch v-model="newDailyUpdate.plannedMaintenance" />
        </div>
        <div v-if="newDailyUpdate.maintenace" class="flex gap-4 items-center">
          <HeadersLabel>Other Maintenance</HeadersLabel>
          <ToggleSwitch v-model="newDailyUpdate.otherMaintenance" />
        </div>
        <div v-if="newDailyUpdate.maintenace" class="flex flex-col gap-1">
          <HeadersLabel>Maintenance note</HeadersLabel>
          <TextArea v-model="newDailyUpdate.maintenanceNote" />
        </div>
      </div>

      <div class="flex gap-4">
        <HeadersLabel>Base and Equipment</HeadersLabel>
        <ToggleSwitch v-model="newDailyUpdate.baseAndEquipment" />
      </div>

      <div class="flex flex-col gap-1">
        <HeadersLabel>Note</HeadersLabel>
        <TextArea v-model="newDailyUpdate.note" />
      </div>
      <div class="flex self-end gap-x-4">
        <ButtonsBackButton @click.prevent="router.go(-1)" />
        <ButtonsButtonReusable
          type="submit"
          text="Create daily update"
          :loading="loading"
        />
      </div>
    </form>
    <ResponsesError v-if="isError">{{ errorMessage }}</ResponsesError>
    <ResponsesSuccess v-if="isSuccess"
      >Daily update created successfully!
    </ResponsesSuccess>
  </div>
</template>
<script setup lang="ts">
import ToggleSwitch from "@/components/Input/ToggleSwitch.vue";
import Input from "@/components/Input/Input.vue";
import TextArea from "@/components/Input/TextArea.vue";

import query from "~/api/flightMinDetails.graphql";
import mutation from "~/api/createDailyUpdate.graphql";

const router = useRouter();

const isLoading: Ref<boolean> = ref(false);
const isSuccess: Ref<boolean> = ref(false);
const isError: Ref<boolean> = ref(false);
const errorMessage: Ref<string> = ref("");

const newDailyUpdate: Ref<Types.CreateDailyUpdate> = ref({
  wasFlight: false,
  delay: false,
  maintenace: false,
  unplannedMaintenance: false,
  plannedMaintenance: false,
  otherMaintenance: false,
  baseAndEquipment: false,
} as Types.CreateDailyUpdate);

const flights: Ref<Types.Flight[]> = ref([]);
const selectedFlight: Ref<Types.Flight> = ref({} as Types.Flight);
const selectedDelayCode: Ref<Types.DelayCode> = ref({} as Types.DelayCode);

watch(
  () => selectedFlight.value,
  (newValue) => {
    newDailyUpdate.value.flightId = newValue.id;
  }
);
watch(
  () => selectedDelayCode.value,
  (newValue) => {
    newDailyUpdate.value.delayCode = newValue.code;
  }
);

onBeforeMount(async () => {
  await getData();
});

type Response = {
  flights: Types.Flight[];
};
async function getData() {
  isLoading.value = true;
  const { data } = await useAsyncQuery<Response>({ query });
  if (data.value) {
    flights.value = data.value.flights as Types.Flight[];
  }
  isLoading.value = false;
}

const delayCodes = [
  { id: 1, code: "A", description: "A - Air Traffic Control" },
  { id: 2, code: "B", description: "B - Weather" },
  { id: 3, code: "C", description: "C- Carrier" },
  { id: 4, code: "D", description: "D - National Aviation System" },
  { id: 5, code: "E", description: "E - Security" },
  { id: 6, code: "F", description: "F - Late Arriving Aircraft" },
  { id: 7, code: "G", description: "G - Other" },
  { id: 8, code: "H", description: "H - None" },
  { id: 9, code: "I", description: "I - Unknown" },
  { id: 10, code: "J", description: "J - Not Applicable" },
];

const {
  mutate: submit,
  onError,
  onDone,
  loading,
} = useMutation(mutation, {
  fetchPolicy: "no-cache",
  variables: {
    flightId: newDailyUpdate.value.flightId,
    wasFlight: newDailyUpdate.value.wasFlight,
    delay: newDailyUpdate.value.delay,
    delayCode: newDailyUpdate.value.delayCode,
    delayTime: newDailyUpdate.value.delayTime,
    delayDesc: newDailyUpdate.value.delayDesc,
    maintenance: newDailyUpdate.value.maintenace,
    unplannedMaintenance: newDailyUpdate.value.unplannedMaintenance,
    plannedMaintenance: newDailyUpdate.value.plannedMaintenance,
    otherMaintenance: newDailyUpdate.value.otherMaintenance,
    maintenanceNote: newDailyUpdate.value.maintenanceNote,
    baseAndEquipment: newDailyUpdate.value.baseAndEquipment,
    note: newDailyUpdate.value.note,
  },
});
onError((err) => {
  isError.value = true;
  errorMessage.value = err.message;
});
onDone((data) => {
  isSuccess.value = true;
});
</script>

<template>
  <div class="m-14 w-full h-max">
    <PageTitle primaryText="New Daily Update" />
    <form
      class="flex flex-col gap-12 w-max mt-6 bg-white rounded-md shadow-md p-5"
      @submit.prevent=""
    >
      <div class="flex gap-12 items-start">
        <div class="flex gap-4 items-center">
          <Label>Was flight?</Label>
          <ToggleSwitch v-model="newDailyUpdate.wasFlight" />
        </div>
        <div v-if="newDailyUpdate.wasFlight" class="flex flex-col gap-1">
          <Label>Flight</Label>
          <select
            name=""
            id=""
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
          <Label>Delay</Label>
          <ToggleSwitch v-model="newDailyUpdate.delay" />
        </div>
        <div v-if="newDailyUpdate.delay" class="flex flex-col gap-2">
          <Label>Delay Code</Label>
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
          <Label>Delay Time (min)</Label>
          <Input type="number" v-model="newDailyUpdate.delayTime" />
        </div>
        <div v-if="newDailyUpdate.delay" class="flex flex-col gap-1">
          <Label>Delay description</Label>
          <TextArea v-model="newDailyUpdate.delayDesc" />
        </div>
      </div>

      <div class="flex flex-col gap-3">
        <div class="flex gap-4 items-center">
          <Label>Maintenance</Label>
          <ToggleSwitch v-model="newDailyUpdate.maintenace" />
        </div>
        <div v-if="newDailyUpdate.maintenace" class="flex gap-4 items-center">
          <Label>Unplanned Maintenance</Label>
          <ToggleSwitch v-model="newDailyUpdate.unplannedMaintenance" />
        </div>
        <div v-if="newDailyUpdate.maintenace" class="flex gap-4 items-center">
          <Label>Planned Maintenance</Label>
          <ToggleSwitch v-model="newDailyUpdate.plannedMaintenance" />
        </div>
        <div v-if="newDailyUpdate.maintenace" class="flex gap-4 items-center">
          <Label>Other Maintenance</Label>
          <ToggleSwitch v-model="newDailyUpdate.otherMaintenance" />
        </div>
        <div v-if="newDailyUpdate.maintenace" class="flex flex-col gap-1">
          <Label>Maintenance note</Label>
          <TextArea v-model="newDailyUpdate.maintenanceNote" />
        </div>
      </div>

      <div class="flex gap-4">
        <Label>Base and Equipment</Label>
        <ToggleSwitch v-model="newDailyUpdate.baseAndEquipment" />
      </div>

      <div class="flex flex-col gap-1">
        <Label>Note</Label>
        <TextArea v-model="newDailyUpdate.note" />
      </div>
      <div class="flex self-end gap-x-4">
        <BackButton @click.prevent="router.go(-1)" />
        <ButtonReusable
          type="submit"
          text="Create Flight"
          @click.prevent="mutate"
        />
      </div>
    </form>
  </div>
</template>
<script setup lang="ts">
import Label from "@/components/Headers/Label.vue";
import PageTitle from "@/components/Headers/PageTitle.vue";
import ToggleSwitch from "@/components/Input/ToggleSwitch.vue";
import Input from "@/components/Input/Input.vue";
import TextArea from "@/components/Input/TextArea.vue";
import ButtonReusable from "@/components/Buttons/ButtonReusable.vue";
import BackButton from "@/components/Buttons/BackButton.vue";
import query from "~/api/flightMinDetails.graphql";
import mutation from "~/api/createDailyUpdate.graphql";

const router = useRouter();

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
async function getData() {
  const { data } = await useAsyncQuery({ query });
  if (data.value) {
    // @ts-expect-error
    flights.value = data.value.flights as Types.Flight[];
  }
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

const { mutate, onError, onDone } = useMutation(mutation, {
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
  console.log(err);
});
onDone((data) => {
  console.log(data.data);
  alert(data.data.createDailyUpdate);
});
</script>

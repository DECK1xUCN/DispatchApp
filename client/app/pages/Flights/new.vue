<template>
  <div class="flex flex-col gap-4 m-14 w-full">
    <PageTitle primaryText="Flight" />
    <form
      class="flex flex-col gap-12 w-full mt-6 bg-white rounded-md shadow-md p-5"
      @submit.prevent="submit"
    >
      <!-- Flight number -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <div>
          <Label>Flight Number</Label>
          <Input v-model="newFlight.flightNumber" />
        </div>
        <div>
          <Label>Site</Label>
          <select
            class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg"
            v-model="newFlight.siteId"
          >
            <option value="" selected disabled>Select a site</option>
            <option
              v-for="option in sites"
              :value="option.id"
              class="text-center"
            >
              {{ option.name }}
            </option>
          </select>
        </div>
      </div>
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <div>
          <Label>Pilot</Label>
          <select
            class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg"
            v-model="newFlight.pilotId"
          >
            <option value="" selected disabled>Select a pilot</option>
            <option
              v-for="option in pilots"
              :value="option.id"
              class="text-center"
            >
              {{ option.name }}
            </option>
          </select>
        </div>
        <div>
          <Label>Hoist Operator</Label>
          <select
            class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg"
            v-model="newFlight.hoistOperatorId"
          >
            <option value="" selected disabled>Select a hoist operator</option>
            <option
              v-for="option in hoistOperators"
              :value="option.id"
              class="text-center"
            >
              {{ option.name }}
            </option>
          </select>
        </div>
        <div>
          <Label>Helicopter</Label>
          <select
            class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg"
            v-model="newFlight.helicopterId"
          >
            <option value="" selected disabled>Select a helicopter</option>
            <option
              v-for="option in helicopters"
              :value="option.id"
              class="text-center"
            >
              {{ option.model }}
            </option>
          </select>
        </div>
      </div>
      <!-- Flight number -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <!-- From -->
        <div>
          <Label>From</Label>
          <select
            class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg"
            v-model="newFlight.fromId"
          >
            <option value="" selected disabled>Select a heliport</option>
            <option
              v-for="option in heliports"
              :value="option.id"
              class="text-center"
            >
              {{ option.name }}
            </option>
          </select>
        </div>
        <!-- From -->
        <!-- To -->
        <div>
          <Label>To</Label>
          <select
            class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg"
            v-model="newFlight.toId"
          >
            <option value="" selected disabled>Select a heliport</option>
            <option
              v-for="option in heliports"
              :value="option.id"
              class="text-center"
            >
              {{ option.name }}
            </option>
          </select>
        </div>
        <!-- To -->
        <!-- Via -->
        <div>
          <Label>Via</Label>
          <select
            class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg"
            v-model="newFlight.viaIds"
            multiple
          >
            <option
              v-for="option in via"
              :value="option.id"
              class="text-center"
            >
              {{ option.name }}
            </option>
          </select>
        </div>
        <!-- Via -->
      </div>
      <!-- Time Input -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <div>
          <Label>Date</Label>
          <Input type="date" v-model="newFlight.date" />
        </div>
        <div>
          <Label>ETD</Label>
          <Input type="time" v-model="newFlight.etd" />
        </div>
        <div>
          <Label>ETA</Label>
          <Input type="time" v-model="newFlight.eta" />
        </div>
      </div>

      <!-- PAX and Cargo -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <div>
          <Label>PAX</Label>
          <Input type="number" v-model="newFlight.pax" />
        </div>
        <div>
          <Label>PAX TAX</Label>
          <Input type="number" v-model="newFlight.paxTax" :isDisabled="true" />
        </div>
        <div>
          <Label>Cargo per Person</Label>
          <Input type="number" v-model="newFlight.cargoPP" />
        </div>
        <div>
          <Label>Hoist Cycles</Label>
          <Input type="number" v-model="newFlight.hoistCycles" />
        </div>
      </div>
      <div class="flex self-end gap-x-4">
        <BackButton @click.prevent="router.go(-1)" />
        <ButtonReusable type="submit" text="Create Flight" />
      </div>
    </form>
    <div v-if="success || error">
      <div
        v-if="success"
        class="text-green-600 bg-green-50 w-max text-2xl p-3 py-2 rounded-md"
      >
        Flight created successfully! You will be redirected
      </div>
      <div
        v-if="error"
        class="text-red-600 bg-red-50 w-max text-2xl p-3 py-2 rounded-md"
      >
        {{ errorMessage }}
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import PageTitle from "@/components/Headers/PageTitle.vue";
import Input from "@/components/Input/Input.vue";
import Label from "@/components/Headers/Label.vue";
import dayjs from "dayjs";
import utc from "dayjs/plugin/utc";
import ButtonReusable from "@/components/Buttons/ButtonReusable.vue";
import BackButton from "@/components/Buttons/BackButton.vue";

import detailsQuery from "~/api/createFlightData.graphql";
import optionsQuery from "~/api/createFlightOptions.graphql";
import mutation from "~/api/createFlight.graphql";

dayjs.extend(utc);
const router = useRouter();

const newFlight: Ref<Types.CreateFlight> = ref({} as Types.CreateFlight);
const sites: Ref<Types.Site[]> = ref([]);
const heliports: Ref<Types.Location[]> = ref([]);
const helicopters: Ref<Types.Helicopter[]> = ref([]);
const via: Ref<Types.Location[]> = ref([]);
const pilots: Ref<Types.Pilot[]> = ref([]);
const hoistOperators: Ref<Types.HoistOperator[]> = ref([]);

const success = ref(false);
const error = ref(false);
const errorMessage = ref("");

watch(
  () => newFlight.value.siteId,
  (siteId) => {
    // fix
    if (siteId) {
      getFlightOptions(siteId);
    }
  }
);
watch(
  () => newFlight.value.pax,
  (pax) => {
    if (pax) {
      newFlight.value.pax = Number(pax);
      newFlight.value.paxTax = pax * 10;
    }
  }
);
watch(
  () => newFlight.value.cargoPP,
  (cargoPP) => {
    if (cargoPP) {
      newFlight.value.cargoPP = Number(cargoPP);
    }
  }
);
watch(
  () => newFlight.value.hoistCycles,
  (hoistCycles) => {
    if (hoistCycles) {
      newFlight.value.hoistCycles = Number(hoistCycles);
    }
  }
);

onBeforeMount(() => {
  getData();
});

async function getData() {
  const { data } = (await useAsyncQuery(detailsQuery)) as any;
  if (data.value) {
    sites.value = data.value.sites as Types.Site[];
    pilots.value = data.value.pilots as Types.Pilot[];
    hoistOperators.value = data.value.hoistOperators as Types.HoistOperator[];
    helicopters.value = data.value.helicopters as Types.Helicopter[];
  }
}

async function getFlightOptions(siteId: number) {
  heliports.value = [];
  via.value = [];
  const { data } = (await useAsyncQuery(optionsQuery, {
    siteId,
  })) as any;
  if (data.value) {
    heliports.value = data.value.heliportsPerSite as Types.Location[];
    via.value = data.value.viaPerSite as Types.Location[];
  }
}

function submit() {
  useMutation(mutation, {
    variables: {
      flightNumber: newFlight.value.flightNumber,
      date: newFlight.value.date,
      siteId: newFlight.value.siteId,
      helicopterId: newFlight.value.helicopterId,
      pilotId: newFlight.value.pilotId,
      hoistOperatorId: newFlight.value.hoistOperatorId,
      fromId: newFlight.value.fromId,
      toId: newFlight.value.toId,
      viaIds: newFlight.value.viaIds,
      etd: "2023-05-07T21:00:00.002Z",
      eta: "2023-05-07T21:00:00.002Z",
      pax: newFlight.value.pax,
      paxTax: newFlight.value.paxTax,
      cargoPP: newFlight.value.cargoPP,
      hoistCycles: newFlight.value.hoistCycles,
    },
  })
    .mutate()
    .then(() => {
      success.value = true;
    })
    .catch((err) => {
      error.value = true;
      errorMessage.value = err.message;
    })
    .finally(() => {
      setTimeout(() => {
        success.value = false;
        error.value = false;
        errorMessage.value = "";
        router.push("/flights");
      }, 4000);
    });
}
</script>

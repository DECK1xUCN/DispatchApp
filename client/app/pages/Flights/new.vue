<template>
  <div class="flex flex-col gap-4 m-14 w-full">
    <HeadersPageTitle primaryText="Flight" />
    <form
      class="flex flex-col gap-12 w-full mt-6 bg-white rounded-md shadow-md p-5"
      @submit.prevent="submit"
    >
      <!-- Flight number -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <div>
          <HeadersLabel>Flight Number</HeadersLabel>
          <Input v-model="newFlight.flightNumber" />
        </div>
        <div>
          <HeadersLabel>Site</HeadersLabel>
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
          <HeadersLabel>Pilot</HeadersLabel>
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
          <HeadersLabel>Hoist Operator</HeadersLabel>
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
          <HeadersLabel>Helicopter</HeadersLabel>
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
          <HeadersLabel>From</HeadersLabel>
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
          <HeadersLabel>To</HeadersLabel>
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
          <HeadersLabel>Via</HeadersLabel>
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
          <HeadersLabel>Date</HeadersLabel>
          <Input type="date" v-model="newFlight.date" />
        </div>
        <div>
          <HeadersLabel>ETD</HeadersLabel>
          <Input type="time" v-model="newFlight.etd" />
        </div>
        <div>
          <HeadersLabel>ETA</HeadersLabel>
          <Input type="time" v-model="newFlight.eta" />
        </div>
      </div>

      <!-- PAX and Cargo -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <div>
          <HeadersLabel>PAX</HeadersLabel>
          <Input type="number" v-model="newFlight.pax" />
        </div>
        <div>
          <HeadersLabel>PAX TAX</HeadersLabel>
          <Input type="number" v-model="newFlight.paxTax" :isDisabled="true" />
        </div>
        <div>
          <HeadersLabel>Cargo per Person</HeadersLabel>
          <Input type="number" v-model="newFlight.cargoPP" />
        </div>
        <div>
          <HeadersLabel>Hoist Cycles</HeadersLabel>
          <Input type="number" v-model="newFlight.hoistCycles" />
        </div>
      </div>
      <div class="flex self-end gap-x-4">
        <ButtonsBackButton @click.prevent="router.go(-1)" />
        <ButtonsButtonReusable
          type="submit"
          text="Create Flight"
          :loading="isLoading"
        />
      </div>
    </form>
    <div v-if="isSuccess || isError">
      <ResponsesSuccess v-if="isSuccess">
        Flight was successfully created!
      </ResponsesSuccess>
      <ResponsesError v-if="isError">
        {{ errorMessage }}
      </ResponsesError>
    </div>
  </div>
</template>
<script setup lang="ts">
import dayjs from "dayjs";
import utc from "dayjs/plugin/utc";

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

const isLoading = ref(false);
const isSuccess = ref(false);
const isError = ref(false);
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

type DataResponse = {
  sites: Types.Site[];
  pilots: Types.Pilot[];
  hoistOperators: Types.HoistOperator[];
  helicopters: Types.Helicopter[];
};
async function getData() {
  const { data } = await useAsyncQuery<DataResponse>(detailsQuery);
  if (data.value) {
    sites.value = data.value.sites;
    pilots.value = data.value.pilots;
    hoistOperators.value = data.value.hoistOperators;
    helicopters.value = data.value.helicopters;
  }
}

type OptionsResponse = {
  heliportsPerSite: Types.Location[];
  viaPerSite: Types.Location[];
};
async function getFlightOptions(siteId: number) {
  heliports.value = [];
  via.value = [];
  const { data } = await useAsyncQuery<OptionsResponse>(optionsQuery, {
    siteId,
  });
  if (data.value) {
    heliports.value = data.value.heliportsPerSite;
    via.value = data.value.viaPerSite;
  }
}

function submit() {
  isLoading.value = true;
  isSuccess.value = false;
  isError.value = false;
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
      etd: newFlight.value.date + "T" + newFlight.value.etd + ":00.002Z",
      eta: newFlight.value.date + "T" + newFlight.value.eta + ":00.002Z",
      pax: newFlight.value.pax,
      paxTax: newFlight.value.paxTax,
      cargoPP: newFlight.value.cargoPP,
      hoistCycles: newFlight.value.hoistCycles,
    },
  })
    .mutate()
    .then(() => {
      isSuccess.value = true;
    })
    .catch((err) => {
      isError.value = true;
      errorMessage.value = err.message;
    })
    .finally(() => {
      isLoading.value = false;
    });
}
</script>

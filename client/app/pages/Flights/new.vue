<template>
  <div class="m-14 w-full">
    <PageTitle primaryText="Flight" />
    <form class="flex flex-col gap-12 w-full mt-6" @submit.prevent="submit">
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
      newFlight.value.paxTax = pax * 10;
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
      siteId: newFlight.value.siteId,
      helicopterId: newFlight.value.helicopterId,
      fromId: newFlight.value.fromId,
      toId: newFlight.value.toId,
      viaIds: newFlight.value.viaIds,
      date: newFlight.value.date,
      etd: newFlight.value.etd,
      eta: newFlight.value.eta,
      pax: newFlight.value.pax,
      paxTax: newFlight.value.paxTax,
      cargoPP: newFlight.value.cargoPP,
      hoistCycles: newFlight.value.hoistCycles,
    },
  })
    .mutate()
    .then((data) => {
      console.log(data);
    })
    .catch((err) => {
      console.log(err);
    });
}
</script>

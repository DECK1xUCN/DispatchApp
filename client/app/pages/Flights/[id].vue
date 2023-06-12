<template>
  <section class="m-14 h-max" v-if="flight">
    <div class="flex justify-between">
      <HeadersPageTitle
        primaryText="Flight"
        :secondaryText="flight?.flightNumber"
      />
      <ButtonsButtonReusable
        v-if="flight && flight.editable"
        text="Edit"
        :editBtn="true"
        :displayIcon="false"
        @click.prevent="router.push(`/flights/edit/${flight.id}`)"
      />
    </div>
    <div
      class="flex flex-col gap-12 w-full mt-6 bg-white rounded-md shadow-md p-5"
      v-if="flight"
    >
      <!-- Flight number -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <div>
          <HeadersLabel>Site</HeadersLabel>
          <Input v-model="flight.site.name" :isDisabled="true" />
        </div>
        <div>
          <HeadersLabel>Pilot</HeadersLabel>
          <Input v-model="flight.pilot.name" :isDisabled="true" />
        </div>
        <div>
          <HeadersLabel>Hoist Operator</HeadersLabel>
          <Input v-model="flight.hoistOperator.name" :isDisabled="true" />
        </div>
      </div>
      <!-- Flight number -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <!-- From -->
        <div class="flex flex-col gap-1">
          <HeadersLabel>From</HeadersLabel>
          <ButtonsInputButton :isSelected="true" :isDisabled="true">
            {{ flight.from.name }}
          </ButtonsInputButton>
        </div>
        <!-- From -->
        <!-- To -->
        <div class="flex flex-col gap-1">
          <HeadersLabel>To</HeadersLabel>
          <ButtonsInputButton
            v-model="flight.to"
            :isSelected="true"
            :isDisabled="true"
          >
            {{ flight.to.name }}
          </ButtonsInputButton>
        </div>
        <!-- To -->
      </div>
      <!-- Via -->
      <div class="flex flex-col gap-1">
        <HeadersLabel>Via</HeadersLabel>
        <div class="flex flex-wrap gap-x-10 gap-y-4">
          <div v-for="location in flight.via">
            <ButtonsInputButton
              :isDisabled="true"
              :isSelected="true"
              :key="location.id"
            >
              {{ location.name }}
            </ButtonsInputButton>
          </div>
        </div>
      </div>
      <!-- Via -->
      <!-- Time Input -->
      <div>
        <HeadersLabel>Date</HeadersLabel>
        <input
          type="text"
          v-model="formattedDate"
          class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg text-center"
          disabled
        />
      </div>

      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <InputTimeInput :value="timeFormat(flight.etd)" :isDisabled="true">
          ETD
        </InputTimeInput>
        <InputTimeInput
          :value="timeFormat(flight.rotorStart)"
          :isDisabled="true"
          >Rotor Start
        </InputTimeInput>
        <InputTimeInput :value="timeFormat(flight.etd)" :isDisabled="true">
          ETD
        </InputTimeInput>
      </div>
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <InputTimeInput :value="timeFormat(flight.atd)" :isDisabled="true">
          ATD
        </InputTimeInput>
        <InputTimeInput :value="timeFormat(flight.rotorStop)" :isDisabled="true"
          >Rotor Stop
        </InputTimeInput>
        <InputTimeInput :value="timeFormat(flight.ata)" :isDisabled="true">
          ATA
        </InputTimeInput>
      </div>
      <!-- Time input -->
      <!-- Block and flight time -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <div class="flex flex-col gap-1">
          <HeadersLabel>Block Time</HeadersLabel>
          <Input v-model="flight.blockTime" :isDisabled="true" />
        </div>
        <div class="flex flex-col gap-1">
          <HeadersLabel>Flight Time</HeadersLabel>
          <Input v-model="flight.flightTime" :isDisabled="true" />
        </div>
      </div>
      <!-- Block and flight time -->
      <!-- Delay -->
      <div class="flex gap-6 items-center">
        <HeadersLabel>Delay</HeadersLabel>
        <InputToggleSwitch :modelValue="flight.delay" class="mt-1.5" />
        <span
          v-if="flight.delay === false"
          class="text-green-700 bg-green-50 p-2 px-3 rounded-md"
          >on time</span
        >
      </div>

      <div
        class="flex flex-wrap gap-x-10 gap-y-4"
        v-if="flight && flight.delay"
      >
        <div class="flex flex-col gap-1">
          <HeadersLabel>Delay (min)</HeadersLabel>
          <Input v-model="flight.delayTime" :isDisabled="true" />
        </div>
        <div class="flex flex-col gap-1">
          <HeadersLabel>Delay Reason</HeadersLabel>
          <select
            v-model="flight.delayCode"
            disabled
            class="border-2 border-gray-100 w-64 h-10 rounded-md text-lg"
          >
            <option value="" disabled>select a reason</option>
            <option value="A">A - Weather</option>
            <option value="B">B - GE Weather</option>
            <option value="C">C - PAX Late</option>
            <option value="D">D - Heli Crew</option>
            <option value="E">E - Ground Stop</option>
            <option value="F">F - Heli Technical</option>
            <option value="G">G - GE Reason</option>
            <option value="H">H - Others</option>
            <option value="I">I - Flight Canceled</option>
            <option value="J">J - Flight Aborted</option>
          </select>
        </div>
      </div>
      <!-- Delay -->
      <!-- Delay Description -->
      <div class="flex flex-col gap-1" v-if="flight && flight.delay">
        <HeadersLabel>Delay Description</HeadersLabel>
        <InputTextArea
          v-if="flight.delay"
          :value="flight.delayNote ? flight.delayNote : ''"
          :isDisabled="true"
        ></InputTextArea>
      </div>
      <!-- Delay Description -->
      <!-- PAX and Cargo -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <div class="flex flex-col gap-1">
          <HeadersLabel>PAX</HeadersLabel>
          <Input v-model="flight.pax" :isDisabled="true" />
        </div>
        <div class="flex flex-col gap-1">
          <HeadersLabel>PAX TAX</HeadersLabel>
          <Input v-model="flight.paxTax" :isDisabled="true" />
        </div>
        <div class="flex flex-col gap-1">
          <HeadersLabel>Cargo per Person</HeadersLabel>
          <Input v-model="flight.cargoPP" :isDisabled="true" />
        </div>
        <div class="flex flex-col gap-1">
          <HeadersLabel>Hoist Cycles</HeadersLabel>
          <Input v-model="flight.hoistCycles" :isDisabled="true" />
        </div>
      </div>
      <div class="flex self-end gap-x-4">
        <ButtonsBackButton @click.prevent="router.go(-1)" />
      </div>
    </div>
  </section>

  <!-- loader -->
  <section v-if="isLoading" class="flex justify-center items-center w-full">
    <LoadersLoader />
  </section>
</template>

<script setup lang="ts">
import query from "~/api/flightDetails.graphql";
import { timeFormat } from "@/utils/dateFormat";

const route = useRoute();
const router = useRouter();

const id = Number(route.params.id);

const flight: Ref<Types.Flight | null> = ref(null);
const isLoading = ref(false);

onBeforeMount(() => {
  getData();
});

type Response = {
  flightById: Types.Flight;
};
async function getData() {
  isLoading.value = true;
  const { data } = await useAsyncQuery<Response>(query, { id: id });
  if (data) {
    flight.value = data.value.flightById as Types.Flight;
  }
  isLoading.value = false;
}

const formattedDate = computed(() => {
  if (flight.value) {
    return new Date(flight.value.date).toLocaleDateString().slice(0, 10);
  }
});
</script>

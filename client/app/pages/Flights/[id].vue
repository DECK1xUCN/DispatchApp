<template>
  <section class="m-14 h-max" v-if="flight">
    <div class="flex justify-between">
      <PageTitle primaryText="Flight" :secondaryText="flight?.flightNumber" />
      <ButtonReusable
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
          <Label>Site</Label>
          <Input v-model="flight.site.name" :isDisabled="true" />
        </div>
        <div>
          <Label>Pilot</Label>
          <Input v-model="flight.pilot.name" :isDisabled="true" />
        </div>
        <div>
          <Label>Hoist Operator</Label>
          <Input v-model="flight.hoistOperator.name" :isDisabled="true" />
        </div>
      </div>
      <!-- Flight number -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <!-- From -->
        <div class="flex flex-col gap-1">
          <Label>From</Label>
          <InputButton :isSelected="true" :isDisabled="true">
            {{ flight.from.name }}
          </InputButton>
        </div>
        <!-- From -->
        <!-- To -->
        <div class="flex flex-col gap-1">
          <Label>To</Label>
          <InputButton
            v-model="flight.to"
            :isSelected="true"
            :isDisabled="true"
          >
            {{ flight.to.name }}
          </InputButton>
        </div>
        <!-- To -->
      </div>
      <!-- Via -->
      <div class="flex flex-col gap-1">
        <Label>Via</Label>
        <div class="flex flex-wrap gap-x-10 gap-y-4">
          <div v-for="location in flight.via">
            <InputButton
              :isDisabled="true"
              :isSelected="true"
              :key="location.id"
            >
              {{ location.name }}
            </InputButton>
          </div>
        </div>
      </div>
      <!-- Via -->
      <!-- Time Input -->
      <div>
        <Label>Date</Label>
        <DateInput :value="flight.date" :isDisabled="true" />
      </div>

      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <TimeInput :value="timeFormat(flight.etd)" :isDisabled="true">
          ETD
        </TimeInput>
        <TimeInput :value="timeFormat(flight.rotorStart)" :isDisabled="true"
          >Rotor Start
        </TimeInput>
        <TimeInput :value="timeFormat(flight.etd)" :isDisabled="true">
          ETD
        </TimeInput>
      </div>
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <TimeInput :value="timeFormat(flight.atd)" :isDisabled="true">
          ATD
        </TimeInput>
        <TimeInput :value="timeFormat(flight.rotorStop)" :isDisabled="true"
          >Rotor Stop
        </TimeInput>
        <TimeInput :value="timeFormat(flight.ata)" :isDisabled="true">
          ATA
        </TimeInput>
      </div>
      <!-- Time input -->
      <!-- Block and flight time -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <div class="flex flex-col gap-1">
          <Label>Block Time</Label>
          <Input v-model="flight.blockTime" :isDisabled="true" />
        </div>
        <div class="flex flex-col gap-1">
          <Label>Flight Time</Label>
          <Input v-model="flight.flightTime" :isDisabled="true" />
        </div>
      </div>
      <!-- Block and flight time -->
      <!-- Delay -->
      <div class="flex gap-6 items-center">
        <Label>Delay</Label>
        <ToggleSwitch :modelValue="flight.delay" class="mt-1.5" />
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
          <Label>Delay (min)</Label>
          <Input v-model="flight.delayTime" :isDisabled="true" />
        </div>
        <div class="flex flex-col gap-1">
          <Label>Delay Reason</Label>
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
        <Label>Delay Description</Label>
        <TextArea
          v-if="flight.delay"
          :value="flight.delayNote ? flight.delayNote : ''"
          :isDisabled="true"
        ></TextArea>
      </div>
      <!-- Delay Description -->
      <!-- PAX and Cargo -->
      <div class="flex flex-wrap gap-x-10 gap-y-4">
        <div class="flex flex-col gap-1">
          <Label>PAX</Label>
          <Input v-model="flight.pax" :isDisabled="true" />
        </div>
        <div class="flex flex-col gap-1">
          <Label>PAX TAX</Label>
          <Input v-model="flight.paxTax" :isDisabled="true" />
        </div>
        <div class="flex flex-col gap-1">
          <Label>Cargo per Person</Label>
          <Input v-model="flight.cargoPP" :isDisabled="true" />
        </div>
        <div class="flex flex-col gap-1">
          <Label>Hoist Cycles</Label>
          <Input v-model="flight.hoistCycles" :isDisabled="true" />
        </div>
      </div>
      <div class="flex self-end gap-x-4">
        <BackButton @click.prevent="router.go(-1)" />
      </div>
    </div>
  </section>

  <!-- loader -->
  <section v-if="isLoading" class="flex justify-center items-center w-full">
    <Loader />
  </section>
</template>

<script setup lang="ts">
import query from "~/api/flightDetails.graphql";
import PageTitle from "@/components/Headers/PageTitle.vue";
import Input from "@/components/Input/Input.vue";
import InputButton from "@/components/Buttons/InputButton.vue";
import Label from "@/components/Headers/Label.vue";
import TimeInput from "@/components/Input/TimeInput.vue";
import Select from "@/components/Select/Select.vue";
import TextArea from "@/components/Input/TextArea.vue";
import BackButton from "@/components/Buttons/BackButton.vue";
import ToggleSwitch from "@/components/Input/ToggleSwitch.vue";
import { timeFormat } from "@/utils/dateFormat";
import DateInput from "@/components/Input/DateInput.vue";
import Loader from "~/components/Loaders/Loader.vue";
import ButtonReusable from "@/components/Buttons/ButtonReusable.vue";

const route = useRoute();
const router = useRouter();

const id = Number(route.params.id);

const flight: Ref<Types.Flight | null> = ref(null);
const isLoading = ref(false);

onBeforeMount(() => {
  getData();
});

async function getData() {
  isLoading.value = true;
  const { data } = await useAsyncQuery(query, { id: id });
  if (data) {
    // @ts-expect-error
    flight.value = data.value.flightById as Types.Flight;
  }
  isLoading.value = false;
}
</script>

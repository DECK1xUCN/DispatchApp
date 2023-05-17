<template>
  <section class="flex flex-col m-14 gap-12 w-full" v-if="!isLoading.flights">
    <div class="flex justify-between items-end">
      <PageTitle
        primaryText="Flights"
        secondaryText="for date"
        class="flex flex-col gap-0.5"
      >
        <form @submit.prevent="getData">
          <input
            type="date"
            id="date"
            name="date"
            v-model="inputSearchDate"
            class="border-2 border-gray-100 w-64 h-10 rounded-md text-lg text-center"
          />
          <div class="flex gap-2 mt-2 items-center">
            <BackButton
              text="Reset"
              type="button"
              :displayIcon="false"
              @click.prevent="resetFlights"
            />
            <ButtonReusable
              text="Search"
              type="submit"
              :loading="isLoading.flights"
              :displayIcon="false"
            />
          </div>
        </form>
      </PageTitle>
      <ButtonReusable
        text="New Flight"
        @click.prevent="router.push('flights/new')"
      />
    </div>
    <Table :tableHeaders="tableHeaders" :tableData="flights">
      <TableRow
        v-for="flight in flights"
        :key="flight.id"
        class="flex-auto bg-gray-50 hover:cursor-pointer text-center border-t border-slate-150 h-12"
        @click.prevent="() => $router.push(`/flights/${flight.id}`)"
      >
        <TableData>{{ flight.flightNumber }}</TableData>
        <TableData>{{ flight.from.name }} </TableData>
        <TableData>{{ flight.to.name }}</TableData>
        <TableData><TimeFormat :time="flight.etd" /></TableData>
        <TableData><TimeFormat :time="flight.eta" /></TableData>
        <TableData>{{ flight.site.name }}</TableData>
        <TableData>
          <span
            v-if="flight.delay === false"
            class="bg-green-100 text-green-700 p-1 px-3 rounded-md"
            >on time</span
          >
          <span v-else class="bg-red-100 text-red-700 p-1 px-3 rounded-md"
            >delayed</span
          >
        </TableData>
      </TableRow>
      <TableBody v-if="flights && flights.length === 0">
        <TableRow
          class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12"
        >
          <TableData colspan="7">No flights found</TableData>
        </TableRow>
      </TableBody>
    </Table>
  </section>
  <section
    v-if="isLoading.flights"
    class="flex justify-center items-center w-full"
  >
    <Loader />
  </section>
</template>
<script lang="ts" setup>
import PageTitle from "@/components/Headers/PageTitle.vue";
import ButtonReusable from "@/components/Buttons/ButtonReusable.vue";
import Table from "@/components/Tables/TableReusable.vue";
import TableBody from "@/components/Tables/TableBody.vue";
import TableRow from "@/components/Tables/TableRow.vue";
import TableData from "@/components/Tables/TableData.vue";
import { Ref, onBeforeMount, ref } from "vue";
import TimeFormat from "@/components/Helpers/TimeFormat.vue";
import BackButton from "@/components/Buttons/BackButton.vue";
import Loader from "@/components/Loaders/Loader.vue";
import { validateEmptyString } from "@/utils/validators";
import query from "~/api/flights.graphql";
import perDateQuery from "~/api/flightsPerDate.graphql";

const router = useRouter();

const flights: Ref<Types.Flight[]> = ref([]);

const inputSearchDate: Ref<string> = ref("");

const isLoading = ref({
  flights: false,
});
const response = ref({
  success: false,
  error: false,
});

onBeforeMount(() => {
  getData();
});

async function getData() {
  isLoading.value.flights = true;
  flights.value = [];
  if (validateEmptyString(inputSearchDate.value)) {
    const { data } = await useAsyncQuery(perDateQuery, {
      date: inputSearchDate.value,
    });
    if (data.value)
      // @ts-expect-error
      flights.value = data.value.flights as Types.Flight[];
  } else {
    const { data } = await useAsyncQuery(query);
    if (data.value)
      // @ts-expect-error
      flights.value = data.value.flights as Types.Flight[];
  }
  isLoading.value.flights = false;
}

function resetFlights() {
  flights.value = [];
  inputSearchDate.value = "";
  getData();
}

const tableHeaders: Types.TableHeader = {
  flightNumber: "Flight Number",
  from: "From",
  to: "To",
  ETD: "ETD",
  ETA: "ETA",
  site: "Site",
  delay: "Delay",
};
</script>

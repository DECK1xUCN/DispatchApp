<template>
  <div class="flex flex-col m-14 gap-12 w-full">
    <div class="flex justify-between items-end">
      <PageTitle
        primaryText="Flights"
        secondaryText="for date"
        class="flex flex-col gap-0.5"
      >
        <input
          type="date"
          id="date"
          name="date"
          v-model="searchDate"
          class="border-2 border-gray-100 w-64 h-10 rounded-md text-lg text-center"
        />
        <div class="flex gap-2 mt-2 items-center">
          <BackButton
            text="Reset"
            :displayIcon="false"
            @click.prevent="resetFlights"
          />
          <ButtonReusable
            text="Search"
            :loading="isLoading.flights"
            :displayIcon="false"
            @click.prevent="getData"
          />
        </div>
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
      <TableBody v-if="flights.length === 0">
        <TableRow
          class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12"
        >
          <TableData colspan="7">No flights found</TableData>
        </TableRow>
      </TableBody>
    </Table>
  </div>
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
import { graphqlDateFormat } from "@/utils/dateFormat";
import BackButton from "@/components/Buttons/BackButton.vue";
import query from "~/api/flights.graphql";

const router = useRouter();

const flights: Ref<Types.Flight[]> = ref([]);

const searchDate: Ref<string> = ref(graphqlDateFormat(new Date()));

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
  const { data } = await useAsyncQuery(query);
  if (data.value)
    // @ts-expect-error
    flights.value = data.value.flights as Types.Flight[];
}

function resetFlights() {
  flights.value = [];
  searchDate.value = graphqlDateFormat(new Date());
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

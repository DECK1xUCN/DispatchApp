<template>
  <section class="flex flex-col m-14 gap-12 w-full">
    <div class="flex justify-between items-end">
      <HeadersPageTitle
        primaryText="Flights"
        secondaryText="for date"
        class="flex flex-col gap-0.5"
      >
        <form @submit.prevent="searchFlights">
          <input
            type="date"
            id="date"
            name="date"
            v-model="inputSearchDate"
            class="border-2 border-gray-100 w-64 h-10 rounded-md text-lg text-center"
          />
          <div class="flex gap-2 mt-2 items-center">
            <ButtonsBackButton
              text="Reset"
              type="button"
              :displayIcon="false"
              @click.prevent="resetFlights"
            />
            <ButtonsButtonReusable
              text="Search"
              type="submit"
              :loading="isLoading"
              :displayIcon="false"
            />
          </div>
        </form>
      </HeadersPageTitle>
      <ButtonsButtonReusable
        text="New Flight"
        @click.prevent="router.push('flights/new')"
      />
    </div>
    <TablesTableReusable
      :tableHeaders="tableHeaders"
      :tableData="flights"
      v-if="!isLoading"
    >
      <TablesTableRow
        v-for="flight in flights"
        :key="flight.id"
        class="flex-auto bg-gray-50 hover:cursor-pointer text-center border-t border-slate-150 h-12"
        @click.prevent="() => $router.push(`/flights/${flight.id}`)"
      >
        <TablesTableData>
          <TablesTableId> {{ flight.flightNumber }}</TablesTableId>
        </TablesTableData>
        <TablesTableData>{{ flight.from.name }} </TablesTableData>
        <TablesTableData>{{ flight.to.name }}</TablesTableData>
        <TablesTableData>
          <HelpersTimeFormat :time="flight.etd" />
        </TablesTableData>
        <TablesTableData>
          <HelpersTimeFormat :time="flight.eta" />
        </TablesTableData>
        <TablesTableData>{{ flight.site.name }}</TablesTableData>
        <TablesTableData>
          <span
            v-if="flight.delay === false"
            class="bg-green-100 text-green-700 p-1 px-3 rounded-md"
            >on time
          </span>
          <span v-else class="bg-red-100 text-red-700 p-1 px-3 rounded-md">
            delayed
          </span>
        </TablesTableData>
        <TablesTableData>{{ dateFormat(flight.date) }}</TablesTableData>
      </TablesTableRow>
      <TablesTableBody v-if="flights && flights.length === 0">
        <TablesTableRow
          class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12"
          ><TablesTableData colspan="7">No flights found</TablesTableData>
        </TablesTableRow>
      </TablesTableBody>
    </TablesTableReusable>
    <section v-if="isLoading" class="flex justify-center items-center w-full">
      <LoadersLoader />
    </section>
  </section>
</template>
<script lang="ts" setup>
import { Ref, onBeforeMount, ref } from "vue";
import { validateEmptyString } from "@/utils/validators";
import query from "~/api/flights.graphql";
import perDateQuery from "~/api/flightsPerDate.graphql";
import { dateFormat } from "~/utils/dateFormat";

const router = useRouter();

const flights: Ref<Types.Flight[]> = ref([]);

const inputSearchDate: Ref<string> = ref("");

const response = ref({
  success: false,
  error: false,
});

onBeforeMount(() => {
  getData();
});

type Response = {
  flights: Types.Flight[];
};

const isLoading = ref(false);
async function getData() {
  isLoading.value = true;
  flights.value = [];
  if (validateEmptyString(inputSearchDate.value)) {
    const { data } = await useAsyncQuery<Response>(perDateQuery, {
      date: inputSearchDate.value,
    });
    if (data.value) flights.value = data.value.flights as Types.Flight[];
  } else {
    const { data } = await useAsyncQuery<Response>(query);
    if (data.value) flights.value = data.value.flights as Types.Flight[];
  }
  isLoading.value = false;
}

function resetFlights() {
  flights.value = [];
  inputSearchDate.value = "";
  getData();
}

function searchFlights() {
  flights.value = [];
  console.log(inputSearchDate.value);
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
  date: "Date",
};
</script>

<template>
  <div class="m-14 w-full">
    <div class="flex justify-between items-end">
      <HeadersPageTitle
        :primaryText="'Daily Report'"
        :secondaryText="
          dailyReport && dailyReport.date ? dateFormat(dailyReport.date) : ''
        "
      />
    </div>
    <div class="flex flex-col gap-12 w-full mt-6" v-if="dailyReport">
      <div class="flex gap-6">
        <div>
          <HeadersLabel>ID</HeadersLabel>
          <Input v-model="dailyReport.id" :isDisabled="true" />
        </div>
        <div>
          <HeadersLabel>Date</HeadersLabel>
          <DateInput :value="dailyReport.date" :isDisabled="true" />
        </div>
      </div>
      <TableReusable
        :tableHeaders="tableHeaders"
        :tableData="dailyReport.flights"
      >
        <TablesTableRow
          v-for="flight in flights"
          :key="flight.id"
          @click.prevent="router.push(`/flights/${flight.id}`)"
          class="flex-auto bg-gray-50 hover:cursor-pointer text-center border-t border-slate-150 h-12"
        >
          <TablesTableData>
            <TablesTableId>{{ flight.flightNumber }}</TablesTableId>
          </TablesTableData>
          <TablesTableData>{{ flight.from.name }} </TablesTableData>
          <TablesTableData>
            {{ flight.to.name }}
          </TablesTableData>
          <TablesTableData>
            <HelpersTimeFormat :time="flight.eta" />
          </TablesTableData>
          <TablesTableData>
            <HelpersTimeFormat :time="flight.etd" />
          </TablesTableData>
          <TablesTableData>
            {{ flight.site.name }}
          </TablesTableData>
          <TablesTableData>
            <span
              v-if="flight.delay === false"
              class="bg-green-100 text-green-700 p-1 px-3 rounded-md"
              >on time</span
            >
            <span v-else class="bg-red-100 text-red-700 p-1 px-3 rounded-md"
              >delayed</span
            >
          </TablesTableData>
        </TablesTableRow>
        <TablesTableBody v-if="flights && flights.length === 0">
          <TablesTableRow
            class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12"
          >
            <TablesTableData colspan="7">No flights found</TablesTableData>
          </TablesTableRow>
        </TablesTableBody>
      </TableReusable>
      <ButtonsBackButton @click.prevent="router.go(-1)" class="flex self-end" />
    </div>
  </div>
</template>
<script setup lang="ts">
import TableReusable from "@/components/Tables/TableReusable.vue";
import Input from "@/components/Input/Input.vue";
import { useRouter } from "vue-router";
import { useRoute } from "vue-router";
import { Ref, onBeforeMount, ref } from "vue";
import { dateFormat, graphqlDateFormat } from "@/utils/dateFormat";
import DateInput from "@/components/Input/DateInput.vue";

import query from "~/api/dailyReportDetails.graphql";
import flightQuery from "~/api/flightsPerDate.graphql";

const route = useRoute();
const router = useRouter();

const id = Number(route.params.id);

const dailyReport: Ref<Types.DailyReport | null> = ref(null);
const flights: Ref<Types.Flight[] | null> = ref(null);

onBeforeMount(() => {
  getData();
});

async function getData() {
  const { data } = await useAsyncQuery(query, { id: id });
  if (data.value) {
    // @ts-expect-error
    dailyReport.value = data.value.dailyReportsById;
  }
  if (dailyReport.value && dailyReport.value.date) {
    getFlightData(dailyReport.value.date);
  }
}

async function getFlightData(date: Date) {
  const { data } = await useAsyncQuery(flightQuery, {
    date: graphqlDateFormat(date),
  });
  if (data.value) {
    // @ts-expect-error
    flights.value = data.value.flightsPerDay;
  }
}

const tableHeaders: Types.TableHeader = {
  flightNumber: "Flight Number",
  from: "From",
  to: "To",
  ETA: "ETA",
  ETD: "ETD",
  site: "Site",
  delay: "Delay",
};
</script>

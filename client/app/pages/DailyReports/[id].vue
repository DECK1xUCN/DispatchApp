<template>
  <div class="m-14 w-full">
    <div class="flex justify-between items-end">
      <PageTitle
        :primaryText="'Daily Report'"
        :secondaryText="
          dailyReport && dailyReport.date ? dateFormat(dailyReport.date) : ''
        "
      />
    </div>
    <div class="flex flex-col gap-12 w-full mt-6" v-if="dailyReport">
      <div class="flex gap-6">
        <div>
          <Label>ID</Label>
          <Input v-model="dailyReport.id" :isDisabled="true" />
        </div>
        <div>
          <Label>Date</Label>
          <DateInput :value="dailyReport.date" :isDisabled="true" />
        </div>
      </div>
      <TableReusable
        :tableHeaders="tableHeaders"
        :tableData="dailyReport.flights"
      >
        <TableRow
          v-for="flight in flights"
          :key="flight.id"
          @click.prevent="router.push(`/flights/${flight.id}`)"
          class="flex-auto bg-gray-50 hover:cursor-pointer text-center border-t border-slate-150 h-12"
        >
          <TableData>{{ flight.flightNumber }}</TableData>
          <TableData>{{ flight.from.name }} </TableData>
          <TableData>
            {{ flight.to.name }}
          </TableData>
          <TableData>
            <TimeFormat :time="flight.eta" />
          </TableData>
          <TableData>
            <TimeFormat :time="flight.etd" />
          </TableData>
          <TableData>
            {{ flight.site.name }}
          </TableData>
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
      </TableReusable>
      <BackButton @click.prevent="router.go(-1)" class="flex self-end" />
    </div>
  </div>
</template>
<script setup lang="ts">
import PageTitle from "@/components/Headers/PageTitle.vue";
import TableReusable from "@/components/Tables/TableReusable.vue";
import Label from "@/components/Headers/Label.vue";
import Input from "@/components/Input/Input.vue";
import { useRouter } from "vue-router";
import { useRoute } from "vue-router";
import { Ref, onBeforeMount, ref } from "vue";
import { dateFormat, graphqlDateFormat } from "@/utils/dateFormat";
import DateInput from "@/components/Input/DateInput.vue";
import TableRow from "@/components/Tables/TableRow.vue";
import TableData from "@/components/Tables/TableData.vue";
import TableBody from "@/components/Tables/TableBody.vue";
import TimeFormat from "@/components/Helpers/TimeFormat.vue";
import BackButton from "@/components/Buttons/BackButton.vue";
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

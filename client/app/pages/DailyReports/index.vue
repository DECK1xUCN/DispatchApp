<template>
  <div class="flex flex-col m-14 gap-12 w-full">
    <PageTitle primaryText="Daily Reports" />
    <Table
      :tableHeaders="tableHeaders"
      :tableData="dailyReports"
      :reports="true"
    >
      <TableRow
        v-for="dailyReport in dailyReports"
        class="flex-auto bg-gray-50 hover:cursor-pointer text-center border-t border-slate-150 h-12"
        @click.prevent="router.push(`/dailyReports/${dailyReport.id}`)"
      >
        <TableData>{{ dailyReport.id }}</TableData>
        <TableData>
          <span v-if="dailyReport.date">
            {{ dateFormat(dailyReport.date) }}
          </span>
          <span v-else>N/A</span>
        </TableData>
        <TableData>
          <span v-if="dailyReport.flights">
            {{ dailyReport.flights.length }}
          </span>
          <span v-else>N/A</span>
        </TableData>
      </TableRow>
      <TableBody v-if="dailyReports.length === 0">
        <TableRow
          class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12"
        >
          <TableData colspan="3">No Daily reports found</TableData>
        </TableRow>
      </TableBody>
    </Table>
  </div>
</template>
<script setup lang="ts">
import PageTitle from "@/components/Headers/PageTitle.vue";
import Table from "@/components/Tables/TableReusable.vue";
import { Ref, onBeforeMount, ref } from "vue";
import { dateFormat } from "@/utils/dateFormat";
import TableRow from "@/components/Tables/TableRow.vue";
import TableBody from "@/components/Tables/TableBody.vue";
import TableData from "@/components/Tables/TableData.vue";
import query from "~/api/dailyReports.graphql";

const dailyReports: Ref<Types.DailyReport[]> = ref([]);

const router = useRouter();

onBeforeMount(() => {
  getData();
});

const isLoading = ref(false);

async function getData() {
  const { data } = await useAsyncQuery(query);
  if (data.value)
    //@ts-expect-error
    dailyReports.value = data.value.dailyReports as Types.DailyReport[];
}

const tableHeaders: Types.TableHeader = {
  id: "ID",
  date: "Date",
  flights: "Flights",
};
</script>

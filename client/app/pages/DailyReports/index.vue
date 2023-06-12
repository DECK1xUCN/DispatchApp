<template>
  <section class="flex flex-col m-14 gap-12 w-full" v-if="!isLoading">
    <HeadersPageTitle primaryText="Daily Reports" />
    <TablesTableReusable
      :tableHeaders="tableHeaders"
      :tableData="dailyReports"
      :reports="true"
    >
      <TablesTableRow
        v-for="dailyReport in dailyReports"
        class="flex-auto bg-gray-50 hover:cursor-pointer text-center border-t border-slate-150 h-12"
        @click.prevent="router.push(`/dailyReports/${dailyReport.id}`)"
      >
        <TablesTableData>
          <TablesTableId>{{ dailyReport.id }}</TablesTableId>
        </TablesTableData>
        <TablesTableData>
          <span v-if="dailyReport.date">
            {{ dateFormat(dailyReport.date) }}
          </span>
          <span v-else>N/A</span>
        </TablesTableData>
        <TablesTableData>
          <span v-if="dailyReport.flights">
            {{ dailyReport.flights.length }}
          </span>
          <span v-else>N/A</span>
        </TablesTableData>
      </TablesTableRow>
      <TablesTableBody v-if="dailyReports.length === 0">
        <TablesTableRow
          class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12"
        >
          <TablesTableData colspan="3">No Daily reports found</TablesTableData>
        </TablesTableRow>
      </TablesTableBody>
    </TablesTableReusable>
  </section>
  <section v-if="isLoading" class="flex justify-center items-center w-full">
    <LoadersLoader />
  </section>
</template>
<script setup lang="ts">
import { Ref, onBeforeMount, ref } from "vue";
import { dateFormat } from "@/utils/dateFormat";
import query from "~/api/dailyReports.graphql";

const dailyReports: Ref<Types.DailyReport[]> = ref([]);

const router = useRouter();

onBeforeMount(() => {
  getData();
});

const isLoading = ref(false);

type Response = {
  dailyReports: Types.DailyReport[];
};
async function getData() {
  isLoading.value = true;
  const { data } = await useAsyncQuery<Response>(query);
  if (data.value)
    dailyReports.value = data.value.dailyReports as Types.DailyReport[];
  isLoading.value = false;
}

const tableHeaders: Types.TableHeader = {
  id: "ID",
  date: "Date",
  flights: "Flights",
};
</script>

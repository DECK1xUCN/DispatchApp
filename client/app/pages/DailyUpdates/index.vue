<template>
  <section class="flex flex-col m-14 gap-12 w-full" v-if="!isLoading">
    <div class="flex justify-between items-end">
      <HeadersPageTitle primaryText="Daily Updates" />
      <ButtonsButtonReusable
        text="New Update"
        @click.prevent="router.push('dailyUpdates/new')"
      />
    </div>
    <TablesTableReusable :tableHeaders="tableHeaders">
      <TablesTableRow
        v-for="dailyUpdate in dailyUpdates"
        :key="dailyUpdate.id"
        class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12 cursor-pointer"
        @click.prevent="router.push(`/dailyUpdates/${dailyUpdate.id}`)"
      >
        <TablesTableData>
          <TablesTableId> {{ dailyUpdate.id }}</TablesTableId>
        </TablesTableData>
        <TablesTableData>{{ dailyUpdate.flight.flightNumber }}</TablesTableData>
        <TablesTableData>
          <HelpersDateFormat :date="dailyUpdate.flight.date" />
        </TablesTableData>
        <TablesTableData>
          <span
            v-if="dailyUpdate.delay === false"
            class="bg-green-100 text-green-700 p-1 px-3 rounded-md"
            >on time
          </span>
          <span v-else class="bg-red-100 text-red-700 p-1 px-3 rounded-md">
            delayed
          </span>
        </TablesTableData>
      </TablesTableRow>
      <TablesTableBody v-if="dailyUpdates.length === 0">
        <TablesTableRow
          class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12"
        >
          <TablesTableData colspan="4">No daily updates found</TablesTableData>
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
import query from "~/api/dailyUpdates.graphql";

const router = useRouter();

const dailyUpdates: Ref<Types.DailyUpdate[]> = ref([]);
const isLoading = ref(false);

onBeforeMount(() => {
  getData();
});

type Response = {
  dailyUpdates: Types.DailyUpdate[];
};
async function getData() {
  isLoading.value = true;
  const { data } = await useAsyncQuery<Response>(query);
  if (data.value)
    dailyUpdates.value = data.value.dailyUpdates as Types.DailyUpdate[];
  isLoading.value = false;
}

const tableHeaders: Types.TableHeader = {
  id: "ID",
  flightNumber: "Flight Number",
  date: "Date",
  delay: "Delay",
};
</script>

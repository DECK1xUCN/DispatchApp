<template>
  <section class="flex flex-col m-14 gap-12 w-full" v-if="!isLoading">
    <div class="flex justify-between items-end">
      <PageTitle primaryText="Daily Updates" />
      <ButtonReusable
        text="New Update"
        @click.prevent="router.push('dailyUpdates/new')"
      />
    </div>
    <Table :tableHeaders="tableHeaders">
      <TableRow
        v-for="dailyUpdate in dailyUpdates"
        :key="dailyUpdate.id"
        class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12 cursor-pointer"
        @click.prevent="router.push(`/dailyUpdates/${dailyUpdate.id}`)"
      >
        <TableData>{{ dailyUpdate.id }}</TableData>
        <TableData>{{ dailyUpdate.flight.flightNumber }}</TableData>
        <TableData><DateFormat :date="dailyUpdate.flight.date" /></TableData>
        <TableData>
          <span
            v-if="dailyUpdate.delay === false"
            class="bg-green-100 text-green-700 p-1 px-3 rounded-md"
            >on time</span
          >
          <span v-else class="bg-red-100 text-red-700 p-1 px-3 rounded-md"
            >delayed</span
          >
        </TableData>
      </TableRow>
      <TableBody v-if="dailyUpdates.length === 0">
        <TableRow
          class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12"
        >
          <TableData colspan="4">No daily updates found</TableData>
        </TableRow>
      </TableBody>
    </Table>
  </section>
  <section v-if="isLoading" class="flex justify-center items-center w-full">
    <Loader />
  </section>
</template>
<script setup lang="ts">
import PageTitle from "@/components/Headers/PageTitle.vue";
import ButtonReusable from "@/components/Buttons/ButtonReusable.vue";
import Table from "@/components/Tables/TableReusable.vue";
import TableBody from "@/components/Tables/TableBody.vue";
import TableRow from "@/components/Tables/TableRow.vue";
import TableData from "@/components/Tables/TableData.vue";
import { Ref, onBeforeMount, ref } from "vue";
import DateFormat from "@/components/Helpers/DateFormat.vue";
import Loader from "@/components/Loaders/Loader.vue";
import query from "~/api/dailyUpdates.graphql";

const router = useRouter();

const dailyUpdates: Ref<Types.DailyUpdate[]> = ref([]);
const isLoading = ref(false);

onBeforeMount(() => {
  getData();
});

async function getData() {
  isLoading.value = true;
  const { data } = await useAsyncQuery(query);
  if (data.value)
    //@ts-expect-error
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

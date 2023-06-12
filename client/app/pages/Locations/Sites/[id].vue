<template>
  <div class="m-14 w-full">
    <div class="flex justify-between items-end">
      <HeadersPageTitle :primaryText="'Location'" :secondaryText="site?.name" />
    </div>
    <div class="flex flex-col gap-12 w-full mt-6" v-if="site && !isLoading">
      <div class="flex gap-6 flex-wrap">
        <div>
          <HeadersLabel>ID</HeadersLabel>
          <Input v-model="site.id" :isDisabled="true" />
        </div>
        <div>
          <HeadersLabel>Name</HeadersLabel>
          <Input v-model="site.name" :isDisabled="true" />
        </div>
      </div>
      <div class="flex flex-col gap-2">
        <HeadersLabel><span class="text-2xl">Locations</span></HeadersLabel>
        <TableReusable :tableHeaders="tableHeaders">
          <TablesTableRow
            v-for="location in site.locations"
            :key="location.id"
            @click.prevent="router.push(`/locations/${location.id}`)"
            class="flex-auto bg-gray-50 hover:cursor-pointer text-center border-t border-slate-150 h-12"
          >
            <TablesTableData>
              <TablesTableId> {{ location.id }}</TablesTableId>
            </TablesTableData>
            <TablesTableData>{{ location.name }}</TablesTableData>
            <TablesTableData>{{ location.type }}</TablesTableData>
          </TablesTableRow>
          <TablesTableBody v-if="site.locations && site.locations.length === 0">
            <TablesTableRow
              class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12"
            >
              <TablesTableData colspan="4">No locations found</TablesTableData>
            </TablesTableRow>
          </TablesTableBody>
        </TableReusable>
      </div>
      <ButtonsBackButton class="flex self-end" @click="router.go(-1)" />
    </div>
    <section v-if="isLoading" class="flex justify-center items-center w-full">
      <LoadersLoader />
    </section>
  </div>
</template>
<script setup lang="ts">
import Input from "@/components/Input/Input.vue";
import TableReusable from "@/components/Tables/TableReusable.vue";

import query from "~/api/siteDetails.graphql";

const router = useRouter();
const route = useRoute();

const id = Number(route.params.id);
const isLoading = ref(false);

const site: Ref<Types.Site | null> = ref(null);

onBeforeMount(() => {
  getData();
});

type Response = {
  site: Types.Site;
};
async function getData() {
  isLoading.value = true;
  const { data } = await useAsyncQuery<Response>(query, { id });
  if (data.value) {
    site.value = data.value.site;
  }
  isLoading.value = false;
}

const tableHeaders: Ref<Types.TableHeader> = ref({
  id: "ID",
  name: "Name",
  type: "Type",
});
</script>

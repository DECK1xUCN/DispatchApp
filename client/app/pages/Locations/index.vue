<template>
  <div class="m-14 w-full">
    <div class="flex justify-between items-center">
      <div class="flex flex-col gap-2">
        <PageTitle :primaryText="'Locations'" />
        <div class="flex gap-2">
          <TabButton
            id="tab-active"
            :selected="activeTab === 'sites'"
            @click="activeTab = 'sites'"
          >
            Sites
            <span class="opacity-50">{{ sites.length }}</span>
          </TabButton>
          <TabButton
            id="tab-active"
            :selected="activeTab === 'heliports'"
            @click="activeTab = 'heliports'"
          >
            Heliports
            <span class="opacity-50">{{ heliports.length }}</span>
          </TabButton>
          <TabButton
            id="tab-active"
            :selected="activeTab === 'other'"
            @click="activeTab = 'other'"
          >
            Other
            <span class="opacity-50">{{ via.length }}</span>
          </TabButton>
        </div>
      </div>
      <ButtonReusable
        text="New Location"
        @click.prevent="router.push('/locations/new')"
      />
    </div>
    <div class="flex flex-col gap-12 w-full mt-4">
      <Table :tableHeaders="tableHeaders">
        <TableRow
          v-for="location in tableData"
          :key="location.id"
          class="flex-auto bg-gray-50 hover:cursor-pointer text-center border-t border-slate-150 h-12"
          @click="navigate(location.id, location.type)"
        >
          <TableData>{{ location.id }}</TableData>
          <TableData>{{ location.name }}</TableData>
          <TableData v-if="location.type">
            {{ location.type }}
          </TableData>
          <TableData v-if="location.lng != null">
            {{ location.lng }}
          </TableData>
          <TableData v-if="location.lat != null">
            {{ location.lat }}
          </TableData>
        </TableRow>
        <TableBody v-if="tableData && tableData.length === 0">
          <TableRow
            class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12"
          >
            <TableData colspan="3">No locations found</TableData>
          </TableRow>
        </TableBody>
      </Table>
    </div>
  </div>
</template>
<script setup lang="ts">
import PageTitle from "@/components/Headers/PageTitle.vue";
import ButtonReusable from "@/components/Buttons/ButtonReusable.vue";
import Table from "@/components/Tables/TableReusable.vue";
import TableRow from "@/components/Tables/TableRow.vue";
import TableData from "@/components/Tables/TableData.vue";
import TabButton from "@/components/Buttons/TabButton.vue";
import query from "~/api/locations.graphql";

const router = useRouter();

const tableData: Ref<any> = ref([]);
const sites: Ref<Types.Site[]> = ref([]);
const heliports: Ref<Types.Location[]> = ref([]);
const via: Ref<Types.Location[]> = ref([]);

const activeTab: Ref<"sites" | "heliports" | "other"> = ref("sites");
const tableHeaders: Ref<Types.TableHeader> = ref({});

onBeforeMount(() => {
  getData();
});

async function getData() {
  const { data } = await useAsyncQuery(query);
  if (data.value) {
    //@ts-expect-error
    sites.value = data.value.sites as Types.Site[];
    //@ts-expect-error
    heliports.value = data.value.heliportsPerSite as Types.Location[];
    //@ts-expect-error
    via.value = data.value.viaPerSite as Types.Location[];
  }
  tableData.value = sites.value;
  tableHeaders.value = {
    id: "ID",
    name: "Name",
  };
}

watch(activeTab, (newVal) => {
  if (newVal === "sites") {
    tableData.value = sites.value;
    tableHeaders.value = {
      id: "ID",
      name: "Name",
    };
  } else if (newVal === "heliports") {
    tableData.value = heliports.value;
    tableHeaders.value = {
      id: "ID",
      name: "Name",
      type: "Type",
    };
  } else {
    tableData.value = via.value;
    tableHeaders.value = {
      id: "ID",
      name: "Name",
      type: "Type",
      lng: "Longitude",
      lat: "Latitude",
    };
  }
});

const navigate = (id: number, type: string) => {
  if (type) {
    router.push("locations/" + id);
  } else {
    router.push("locations/sites/" + id);
  }
};
</script>

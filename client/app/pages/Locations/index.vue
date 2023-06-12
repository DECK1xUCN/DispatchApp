<template>
  <section v-if="loading" class="flex justify-center items-center w-full">
    <LoadersLoader />
  </section>
  <section class="m-14 w-full" v-if="!loading">
    <div class="flex justify-between items-center">
      <div class="flex flex-col gap-2">
        <HeadersPageTitle :primaryText="'Locations'" />
        <div class="flex gap-2">
          <ButtonsTabButton
            id="tab-active"
            :selected="activeTab === 'sites'"
            @click="activeTab = 'sites'"
            >Sites
            <span class="opacity-50">{{ sites.length }}</span>
          </ButtonsTabButton>
          <ButtonsTabButton
            id="tab-active"
            :selected="activeTab === 'heliports'"
            @click="activeTab = 'heliports'"
          >
            Heliports
            <span class="opacity-50">{{ heliports.length }}</span>
          </ButtonsTabButton>
          <ButtonsTabButton
            id="tab-active"
            :selected="activeTab === 'other'"
            @click="activeTab = 'other'"
          >
            Other
            <span class="opacity-50">{{ via.length }}</span>
          </ButtonsTabButton>
        </div>
      </div>
      <ButtonsButtonReusable
        text="New Location"
        @click.prevent="router.push('/locations/new')"
      />
    </div>
    <div class="flex flex-col gap-12 w-full mt-4">
      <TablesTableReusable :tableHeaders="tableHeaders">
        <TablesTableRow
          v-for="location in tableData"
          :key="location.id"
          class="flex-auto bg-gray-50 hover:cursor-pointer text-center border-t border-slate-150 h-12"
          @click="navigate(location.id, location.type)"
        >
          <TablesTableData>
            <TablesTableId> {{ location.id }}</TablesTableId>
          </TablesTableData>
          <TablesTableData>{{ location.name }}</TablesTableData>
          <TablesTableData v-if="location.type">
            {{ location.type }}
          </TablesTableData>
          <TablesTableData v-if="location.lng != null">
            {{ location.lng }}
          </TablesTableData>
          <TablesTableData v-if="location.lat != null">
            {{ location.lat }}
          </TablesTableData>
        </TablesTableRow>
        <TablesTableBody v-if="tableData && tableData.length === 0">
          <TablesTableRow
            class="flex-auto bg-gray-50 text-center border-t border-slate-150 h-12"
          >
            <TablesTableData
              :colspan="activeTab !== 'sites' || 'heliport' ? 5 : 3"
              >No locations found
            </TablesTableData>
          </TablesTableRow>
        </TablesTableBody>
      </TablesTableReusable>
    </div>
  </section>
</template>

<script setup lang="ts">
import query from "~/api/locations.graphql";

const router = useRouter();

const tableData: Ref<Types.Site[] | Types.Location[] | any[]> = ref([]);
const sites: Ref<Types.Site[]> = ref([]);
const heliports: Ref<Types.Location[]> = ref([]);
const via: Ref<Types.Location[]> = ref([]);

const activeTab: Ref<"sites" | "heliports" | "other"> = ref("sites");
const tableHeaders: Ref<Types.TableHeader> = ref({});

const isLoading = ref(false);

type Promise = {
  sites: Types.Site[];
  heliportsPerSite: Types.Location[];
  viaPerSite: Types.Location[];
};
const { data: result, pending: loading } = useAsyncQuery<Promise>(query, {
  fetchPolicy: "no-cache",
});

watchEffect(() => {
  if (result.value) {
    sites.value = result.value?.sites as Types.Site[];
    heliports.value = result.value?.heliportsPerSite as Types.Location[];
    via.value = result.value?.viaPerSite as Types.Location[];
    tableData.value = sites.value;
    tableHeaders.value = {
      id: "ID",
      name: "Name",
    };
  }
});

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

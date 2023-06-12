<template>
  <div class="m-14 w-max h-max">
    <HeadersPageTitle
      :primaryText="'New location'"
      class="flex justify-between items-end"
    />
    <div
      class="flex flex-col gap-12 w-full mt-6 bg-white rounded-md shadow-md p-5 lg:px-16 lg:py-10 xl:px-20 xl:py-14"
    >
      <div class="flex flex-col">
        <HeadersHeadersLabel>Location Type</HeadersHeadersLabel>
        <select
          v-model="selectedType"
          class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg"
        >
          <option disabled selected value="">Please select one</option>
          <option
            v-for="item in locationTypes"
            :key="item.id"
            :value="item.value"
          >
            {{ item.value }}
          </option>
        </select>
      </div>

      <form
        v-if="selectedType === 'SITE'"
        class="flex flex-col gap-y-4"
        @submit.prevent="submit"
      >
        <div>
          <HeadersLabel>Name</HeadersLabel>
          <Input v-model="newSite.name" />
        </div>
        <ButtonsButtonReusable
          :primaryText="'Submit'"
          type="submit"
          :loading="isLoading"
        />
      </form>

      <form
        v-else-if="
          selectedType === 'HELIPORT' ||
          selectedType === 'AIRPORT' ||
          selectedType === 'VIA'
        "
        @submit.prevent="submit()"
        class="flex flex-col gap-y-4"
      >
        <div>
          <HeadersLabel>Name</HeadersLabel>
          <Input v-model="newLocation.name" type="text" />
        </div>
        <div class="flex flex-col gap-x-6">
          <HeadersLabel><span class="text-2xl">Coordinates</span></HeadersLabel>
          <div class="flex flex-wrap gap-x-6">
            <div>
              <HeadersLabel>Latitude</HeadersLabel>
              <Input v-model="newLocation.lat" type="number" />
            </div>
            <div>
              <HeadersLabel>Longitude</HeadersLabel>
              <Input v-model="newLocation.lng" type="number" />
            </div>
          </div>
        </div>
        <div class="flex flex-col gap-1">
          <HeadersLabel>Site</HeadersLabel>
          <!-- <VueMultiselect
            v-model="selectedHeliport"
            :options="sites"
            track-by="id"
            HeadersLabel="name"
            style="min-width: 16rem; max-width: 16rem"
          /> -->
          <select
            v-model="selectedHeliport"
            class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg"
          >
            <option disabled value="">Please select one</option>
            <option v-for="site in sites" :key="site.id" :value="site">
              {{ site.name }}
            </option>
          </select>
        </div>
        <ButtonsButtonReusable
          :primaryText="'Submit'"
          type="submit"
          :loading="isLoading"
        />
      </form>
      <ResponsesError v-if="isError">
        {{ errorMessage }}
      </ResponsesError>
      <ResponsesSuccess v-if="isSuccess">
        Location created successfully!
      </ResponsesSuccess>
    </div>
  </div>
</template>

<script setup lang="ts">
import query from "~/api/sitesMinDetails.graphql";
import createSite from "~/api/createSite.graphql";
import createLocation from "~/api/createLocation.graphql";

const selectedType: Ref<string | null> = ref(null);
const newSite: Ref<Types.CreateSite> = ref({} as Types.Site);

const selectedHeliport: Ref<Types.Location | null> = ref(null);
const newLocation: Ref<Types.CreateLocation> = ref({} as Types.CreateLocation);

const sites: Ref<Types.Site[]> = ref([]);

onBeforeMount(() => {
  getData();
});

type Response = {
  sites: Types.Site[];
};
async function getData() {
  isLoading.value = true;
  const { data } = await useAsyncQuery<Response>({
    query,
  });
  if (data.value) {
    sites.value = data.value.sites;
  }
  isLoading.value = false;
}

watch(
  () => selectedHeliport.value,
  (val) => {
    if (val) {
      newLocation.value.siteId = val.id;
    }
  }
);
watch(
  () => selectedType.value,
  (val) => {
    if (val && (val === "HELIPORT" || val === "AIRPORT" || val === "VIA"))
      newLocation.value.type = val;
  }
);

const isLoading = ref(false);
const isSuccess = ref(false);
const isError = ref(false);
const errorMessage = ref("");

function submit() {
  isLoading.value = true;
  if (selectedType.value === "SITE") {
    useMutation(createSite, {
      variables: {
        siteName: newSite.value.name,
      },
    })
      .mutate()
      .then((res) => {
        isSuccess.value = true;
      })
      .catch((err) => {
        isError.value = true;
        errorMessage.value = err.message;
      })
      .finally(() => {
        isLoading.value = false;
      });
  } else {
    useMutation(createLocation, {
      variables: {
        name: newLocation.value.name,
        lat: Number(newLocation.value.lat),
        lng: Number(newLocation.value.lng),
        type: newLocation.value.type,
        siteId: newLocation.value.siteId,
      },
    })
      .mutate()
      .then((res) => {
        isSuccess.value = true;
      })
      .catch((err) => {
        isError.value = true;
        errorMessage.value = err.message;
      })
      .finally(() => {
        isLoading.value = false;
      });
  }
}

const delayCodes = [
  { id: 1, code: "A", description: "A - Air Traffic Control" },
  { id: 2, code: "B", description: "B - Weather" },
  { id: 3, code: "C", description: "C- Carrier" },
  { id: 4, code: "D", description: "D - National Aviation System" },
  { id: 5, code: "E", description: "E - Security" },
  { id: 6, code: "F", description: "F - Late Arriving Aircraft" },
  { id: 7, code: "G", description: "G - Other" },
  { id: 8, code: "H", description: "H - None" },
  { id: 9, code: "I", description: "I - Unknown" },
  { id: 10, code: "J", description: "J - Not Applicable" },
];

const locationTypes = [
  { id: 1, value: "SITE" },
  { id: 2, value: "HELIPORT" },
  { id: 3, value: "AIRPORT" },
  { id: 4, value: "VIA" },
];
</script>

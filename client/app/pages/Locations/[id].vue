<template>
  <div class="m-14 w-max">
    <HeadersPageTitle
      :primaryText="'Location'"
      :secondaryText="location?.name"
    />
    <div
      class="flex flex-col gap-12 w-full mt-6 bg-white rounded-md shadow-md p-5 lg:px-16 lg:py-10 xl:px-20 xl:py-14"
      v-if="location && !isLoading"
    >
      <div>
        <HeadersLabel>ID</HeadersLabel>
        <Input v-model="location.id" :isDisabled="true" />
      </div>
      <div>
        <HeadersLabel>Name</HeadersLabel>
        <Input v-model="location.name" :isDisabled="true" />
      </div>
      <div>
        <HeadersLabel><span class="text-2xl">Coordinates</span></HeadersLabel>
        <div class="flex gap-x-6 flex-wrap gap-3">
          <div>
            <HeadersLabel>Latitude</HeadersLabel>
            <Input v-model="location.lat" :isDisabled="true" />
          </div>
          <div>
            <HeadersLabel>Longitude</HeadersLabel>
            <Input v-model="location.lng" :isDisabled="true" />
          </div>
        </div>
      </div>
      <div>
        <HeadersLabel>Type</HeadersLabel>
        <Input v-model="location.type" :isDisabled="true" />
      </div>
      <div>
        <HeadersLabel><span class="text-2xl">Site</span></HeadersLabel>
        <div class="flex flex-wrap gap-6">
          <div class="flex flex-col">
            <HeadersLabel>ID</HeadersLabel>
            <Input v-model="location.site.id" :isDisabled="true" />
          </div>
          <div class="flex flex-col">
            <HeadersLabel>Name</HeadersLabel>
            <Input v-model="location.site.name" :isDisabled="true" />
          </div>
        </div>
      </div>
      <ButtonsBackButton
        class="flex self-end lg:mt-4 xl:mt-4 2xl:mt-4"
        @click.prevent="router.go(-1)"
      />
    </div>
    <section v-if="isLoading" class="flex justify-center items-center w-full">
      <LoadersLoader />
    </section>
  </div>
</template>
<script setup lang="ts">
import Input from "@/components/Input/Input.vue";

import query from "~/api/locationDetails.graphql";

const route = useRoute();
const router = useRouter();

const id = Number(route.params.id);
const isLoading = ref(false);

const location: Ref<Types.Location | null> = ref(null);

onBeforeMount(() => {
  getData();
});

type Response = {
  location: Types.Location;
};
async function getData() {
  isLoading.value = true;
  const { data } = await useAsyncQuery<Response>(query, { id: id });
  if (data.value) {
    location.value = data.value.location;
  }
  isLoading.value = false;
}
</script>

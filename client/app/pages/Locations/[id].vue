<template>
  <div class="m-14 w-max">
    <PageTitle :primaryText="'Location'" :secondaryText="location?.name" />
    <div
      class="flex flex-col gap-12 w-full mt-6 bg-white rounded-md shadow-md p-5 lg:px-16 lg:py-10 xl:px-20 xl:py-14"
      v-if="location"
    >
      <div>
        <Label>ID</Label>
        <Input v-model="location.id" :isDisabled="true" />
      </div>
      <div>
        <Label>Name</Label>
        <Input v-model="location.name" :isDisabled="true" />
      </div>
      <div>
        <Label><span class="text-2xl">Coordinates</span></Label>
        <div class="flex gap-x-6 flex-wrap gap-3">
          <div>
            <Label>Latitude</Label>
            <Input v-model="location.lat" :isDisabled="true" />
          </div>
          <div>
            <Label>Longitude</Label>
            <Input v-model="location.lng" :isDisabled="true" />
          </div>
        </div>
      </div>
      <div>
        <Label>Type</Label>
        <Input v-model="location.type" :isDisabled="true" />
      </div>
      <div>
        <Label><span class="text-2xl">Site</span></Label>
        <div class="flex flex-wrap gap-6">
          <div class="flex flex-col">
            <Label>ID</Label>
            <Input v-model="location.site.id" :isDisabled="true" />
          </div>
          <div class="flex flex-col">
            <Label>Name</Label>
            <Input v-model="location.site.name" :isDisabled="true" />
          </div>
        </div>
      </div>
      <BackButton
        class="flex self-end lg:mt-4 xl:mt-4 2xl:mt-4"
        @click.prevent="router.go(-1)"
      />
    </div>
  </div>
</template>
<script setup lang="ts">
import PageTitle from "@/components/Headers/PageTitle.vue";
import Label from "@/components/Headers/Label.vue";
import Input from "@/components/Input/Input.vue";
import BackButton from "@/components/Buttons/BackButton.vue";
import query from "~/api/locationDetails.graphql";

const route = useRoute();
const router = useRouter();

const id = Number(route.params.id);

const location: Ref<Types.Location | null> = ref(null);

onBeforeMount(() => {
  getData();
});

async function getData() {
  const { data } = await useAsyncQuery(query, { id: id });
  if (data.value) {
    // @ts-expect-error
    location.value = data.value.location;
  }
}
</script>

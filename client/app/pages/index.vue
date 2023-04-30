<template>
  <div class="flex flex-col m-14 gap-12 w-full">
    <PageTitle :primaryText="`Welcome, ${name}!`" :secondaryText="position" />
    <div class="mt-72">
      <h1 class="font-bold text-2xl mb-8">Today</h1>
      <div
        class="flex flex-wrap md:justify-center gap-8 lg:grid lg:grid-cols-2 lg:gap-12 xl:grid xl:grid-cols-2 xl:gap-12 2xl:grid 2xl:grid-cols-2 2xl:gap-12"
      >
        <CardReusable />
        <CardReusable />
        <CardReusable />
        <CardReusable />
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import PageTitle from "~/components/Headers/PageTitle.vue";

const name = "Jim Nielsen";
const position = "Airpot Flight Officer";
</script>

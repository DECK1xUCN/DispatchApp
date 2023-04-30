<template>
  <div
    class="px-7 py-6 rounded-xl border border-gray-200 shadow-md bg-white flex"
  >
    <img
      :src="`/icons/Helicopter.svg`"
      class="initial loading w-20 h-20 bg-purple-50 p-4 rounded-full"
      data-was-processed="true"
    />
    <div class="ml-8">
      <h1 class="font-bold text-2xl">card name</h1>
      <h2 class="text-lg">description</h2>
    </div>
  </div>
</template>
<script setup lang="ts">
import.meta.glob("@/@/public/icons/Helicopter.svg", {
  as: "raw",
});
</script>

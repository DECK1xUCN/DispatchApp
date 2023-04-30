<template>
  <select
    name=""
    id=""
    class="border-2 border-gray-100 w-64 h-10 rounded-md text-lg"
  >
    <option v-for="option in options" value="">
      {{ option }}
    </option>
  </select>
</template>

<script setup lang="ts">
defineProps<{
  options: string[] | any;
}>();
</script>

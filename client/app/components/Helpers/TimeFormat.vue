<template>
  <div v-if="time">
    {{ timeFormat(time) }}
  </div>
  <div v-else class="text-gray-400">None</div>
</template>
<script setup lang="ts">
import { timeFormat } from "@/utils/dateFormat";

defineProps<{
  time: string | any;
}>();
</script>

<template>
  <div v-if="date">
    {{ dateFormat(date) }}
  </div>
  <div v-else class="text-gray-400">None</div>
</template>
<script setup lang="ts">
import { dateFormat } from "@/utils/dateFormat";

defineProps<{
  date: string | Date;
}>();
</script>

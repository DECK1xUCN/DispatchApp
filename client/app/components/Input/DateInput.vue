<template>
  <div class="flex flex-col gap-1">
    <HeadersLabel>
      <slot></slot>
    </HeadersLabel>
    <input
      type="date"
      id="date"
      name="date"
      required
      :disabled="isDisabled"
      :value="graphqlDateFormat(value)"
      class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg text-center"
    />
  </div>
</template>

<script setup lang="ts">
import { graphqlDateFormat } from "@/utils/dateFormat";

const props = defineProps<{
  isDisabled?: boolean;
  value: string | Date;
}>();
</script>

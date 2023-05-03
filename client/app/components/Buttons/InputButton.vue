<template>
  <div class="flex flex-col gap-1">
    <label for="" class="font-medium text-2xl">
      {{ label }}
    </label>
    <button
      class="border border-gray-100 w-64 h-12 rounded-md text-lg bg-white shadow-sm cursor-pointer"
      :class="{
        'border-violet-300 border-2': isSelected,
        'cursor-loading': isDisabled,
      }"
      :disabled="isDisabled"
    >
      <slot></slot>
    </button>
  </div>
</template>
<script setup lang="ts">
defineProps<{
  label?: string;
  isSelected?: boolean;
  isDisabled?: boolean;
}>();
</script>

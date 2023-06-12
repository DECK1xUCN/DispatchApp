<template>
  <div class="flex flex-col gap-1">
    <HeadersLabel>
      <slot />
    </HeadersLabel>
    <input
      type="time"
      id="appt"
      name="appt"
      required
      class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg text-center"
      :disabled="isDisabled"
      :value="value"
    />
  </div>
</template>

<script setup lang="ts">
defineProps<{
  value?: string;
  isDisabled?: boolean;
}>();
</script>

<template>
  <div>
    <h1 class="font-bold text-3xl">{{ primaryText }}</h1>
    <h2 v-if="secondaryText" class="text-xl text-gray-500">
      {{ secondaryText }}
    </h2>
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  primaryText: string;
  secondaryText?: string;
}>();
</script>

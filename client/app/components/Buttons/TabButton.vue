<template>
  <button
    :aria-selected="selected"
    class="px-3 py-2 font-medium text-sm rounded-md cursor-pointer"
    :class="[selected ? 'bg-indigo-100 shadow ' : 'border']"
  >
    <slot></slot>
  </button>
</template>
<script setup lang="ts">
interface Props {
  selected?: boolean | undefined;
}
const props = withDefaults(defineProps<Props>(), {
  selected: undefined,
});
</script>

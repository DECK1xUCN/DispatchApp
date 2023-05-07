<template>
  <div class="flex flex-col gap-1">
    <input
      :value="modelValue"
      :type="type ? type : 'text'"
      class="border-2 border-gray-200 w-64 h-10 rounded-md text-lg text-center"
      :disabled="isDisabled"
      :placeholder="placeholder"
      v-on:input="
        $emit(
          'update:modelValue',
          //@ts-expect-error
          $event.target?.value
        )
      "
    />
  </div>
</template>
<script setup lang="ts">
defineProps<{
  type?: string;
  modelValue?: string | number;
  isDisabled?: boolean;
  placeholder?: string;
}>();
</script>

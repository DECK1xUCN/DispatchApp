<template>
  <div class="flex flex-col gap-1 w-fit">
    <textarea
      name=""
      id=""
      class="border-2 border-gray-200 rounded-md text-lg w-96"
      :value="modelValue"
      :disabled="isDisabled"
      v-on:input="
        $emit(
          'update:modelValue',
          //@ts-expect-error
          $event.target?.value
        )
      "
    ></textarea>
  </div>
</template>
<script setup lang="ts">
defineProps<{
  modelValue?: string | number;
  isDisabled?: boolean;
  placeholder?: string;
}>();
</script>

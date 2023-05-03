<template>
  <SwitchGroup as="div" class="flex items-center">
    <Switch
      :disabled="disabled"
      v-model="enabled"
      @update:model-value="$emit('update:modelValue', enabled)"
      :class="[
        modelValue ? 'bg-indigo-600' : 'bg-gray-200',
        'relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2',
      ]"
    >
      <span
        aria-hidden="true"
        :class="[
          modelValue ? 'translate-x-5' : 'translate-x-0',
          'pointer-events-none inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out',
        ]"
      ></span>
    </Switch>
    <SwitchLabel as="span" class="ml-3">
      <slot></slot>
    </SwitchLabel>
  </SwitchGroup>
</template>

<script setup lang="ts">
import { ref, toRefs } from "vue";
import { Switch, SwitchGroup, SwitchLabel } from "@headlessui/vue";

const props = withDefaults(
  defineProps<{
    modelValue: boolean;
    disabled?: boolean;
  }>(),
  {
    disabled: false,
  }
);
const enabled = ref(props.modelValue);
</script>

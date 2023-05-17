<!-- Unless otherwise specified, type will default to "button" -->
<template>
  <button
    :disabled="disabled === true || loading === true || success === true"
    :aria-disabled="disabled === true || loading === true || success === true"
    :aria-pressed="pressed"
    :type="props.type"
    :class="{
      'bg-indigo-700': loading === true || disabled === true,
      'cursor-wait': loading === true,
      'bg-red-600 hover:bg-red-700 shadow-md focus:ring-red-700':
        warningBtn === true,
      'bg-gray-300 hover:bg-gray-400 shadow-md focus:ring-gray-400':
        cancelBtn === true,
      'bg-stone-300 hover:bg-stone-400 shadow-md focus:ring-stone-400':
        editBtn === true,
    }"
    class="inline-flex items-center rounded-lg border border-transparent bg-[#00426A] px-4 py-2 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 h-fit w-fit"
  >
    <div v-if="props.success === true && displayIcon">
      <Icon name="icon-park-outline:check-small" />
    </div>
    <div v-else-if="props.loading === true && displayIcon" class="mr-2">
      <svg
        class="animate-spin h-5 w-5 text-white"
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 24 24"
      >
        <circle
          class="opacity-25"
          cx="12"
          cy="12"
          r="10"
          stroke="currentColor"
          stroke-width="4"
        ></circle>
        <path
          class="opacity-75"
          fill="currentColor"
          d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
        ></path>
      </svg>
    </div>
    <span v-if="props.loading === false">{{ props.text }}</span>
    <span v-else>{{ props.loadingText }}</span>
    <slot></slot>
    <div v-if="props.loading === false && props.displayIcon === true">
      <Icon name="ion:arrow-right-c" />
    </div>
  </button>
</template>

<script setup lang="ts">
import { ButtonHTMLAttributes } from "vue";

interface Props {
  type?: ButtonHTMLAttributes["type"];
  pressed?: boolean | undefined;
  disabled?: boolean;
  loading?: boolean;
  success?: boolean;
  text?: string;
  loadingText?: string;
  warningBtn?: boolean;
  cancelBtn?: boolean;
  editBtn?: boolean;
  displayIcon?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  type: "button",
  pressed: undefined,
  disabled: false,
  loading: false,
  success: false,
  text: "Submit",
  loadingText: "Loading...",
  warningBtn: false,
  cancelBtn: false,
  displayIcon: true,
});
</script>

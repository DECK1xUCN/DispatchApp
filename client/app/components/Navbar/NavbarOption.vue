<template>
  <NuxtLink
    v-if="option.replaceAll(' ', '') === currentRoute"
    class="flex bg-[#222] text-white items-center rounded-xl w-full"
    :to="{ name: option.replaceAll(' ', '') }"
  >
    <div class="flex items-center px-1.5 py-1">
      <img
        :src="`/icons/${option.replaceAll(' ', '')}-selected.svg`"
        alt=""
        class="w-10 p-2"
      />
      <span class="mr-4">{{ option }}</span>
    </div>
  </NuxtLink>

  <NuxtLink
    v-else
    :to="{ name: option.replaceAll(' ', '') }"
    class="flex items-center w-full"
  >
    <div class="flex items-center px-1.5 py-1">
      <img
        :src="`/icons/${option.replaceAll(' ', '')}.svg`"
        alt=""
        class="w-10 p-2"
      />
      <span class="flex flex-nowrap mr-4">{{ option }}</span>
    </div>
  </NuxtLink>
</template>
<script setup lang="ts">
defineProps<{
  option: string;
  currentRoute: any;
}>();
</script>

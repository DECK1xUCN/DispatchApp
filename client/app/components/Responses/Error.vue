<template>
  <div
    class="flex gap-2 text-red-600 bg-red-100 w-max text-lg p-3 py-2 rounded-lg items-center"
  >
    <Icon name="heroicons-solid:exclamation-circle" />
    <span><slot /></span>
  </div>
</template>

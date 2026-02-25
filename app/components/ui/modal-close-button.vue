<template>
  <button class="button" @click="$emit('click')">
    <div v-for="i in 2" :key="i" class="button__child" />
  </button>
</template>

<script setup>
defineEmits(['click']);
</script>

<style lang="scss" scoped>
.button {
  @include mix.flex-center;
  width: max(4rem, 35px);
  height: max(4rem, 35px);
  border-radius: 50%;
  background-color: #ffcc00;
  position: relative;
  transition: background 0.4s;
  &:hover {
    background-color: #deb201;
    & > * {
      &:first-child {
        rotate: -44deg;
      }
      &:last-child {
        rotate: 44deg;
      }
    }
  }
  &__child {
    transition: all 0.4s;
    position: absolute;
    width: 35%;
    height: 1.5px;
    background-color: #000;
    border-radius: 5px;

    &:first-child {
      rotate: 44deg;
    }
    &:last-child {
      rotate: -44deg;
    }
  }
}
</style>

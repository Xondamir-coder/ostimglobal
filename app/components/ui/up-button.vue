<template>
  <button class="up-button" @click="goUp">
    <IconsArrowUpShort />
  </button>
</template>

<script setup>
const { $lenis, $gsap } = useNuxtApp();

onMounted(() => {
  $gsap.from('.up-button', {
    opacity: 0,
    scrollTrigger: {
      trigger: '.home',
      start: 'top top',
      toggleActions: 'play none none reverse'
    }
  });
});

const goUp = () => {
  $lenis.scrollTo(0);
};
</script>

<style lang="scss" scoped>
.up-button {
  @include mix.flex-center;
  position: fixed;
  right: 34px;
  bottom: 34px;
  z-index: 5;
  width: 55px;
  height: 55px;
  border-radius: 50%;
  border: 2px solid #000;
  background: #fc0;
  fill: none;
  transition: background 0.4s;
  &:hover {
    background: #fff;
  }
}
</style>

<template>
  <div class="default">
    <LayoutHeader />
    <LayoutMenu />
    <slot />
    <LayoutFooter />
    <UiFormPopup />
  </div>
</template>

<script setup>
const router = useRouter();
const { $lenis } = useNuxtApp();

router.beforeEach(() => {
  if ($lenis) {
    $lenis.stop();
  }
});
router.afterEach(() => {
  if ($lenis) {
    $lenis.start();
  }
});
</script>

<style lang="scss" scoped>
.default {
  background-color: #1d1d1d;
  color: #fff;
}
</style>

<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>

<script setup>
const router = useRouter();
const { $lenis } = useNuxtApp();

router.beforeEach((to, from, next) => {
  if ($lenis) {
    $lenis.stop();
  }
  next();
});
router.afterEach((to, from, next) => {
  if ($lenis) {
    $lenis.start();
  }
  next();
});
</script>

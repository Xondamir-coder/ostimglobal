<template>
  <picture class="my-picture">
    <!-- 0–575 -->
    <source
      :srcset="`/images/576/${splittedName}.avif`"
      type="image/avif"
      media="(max-width: 575px)"
    />

    <!-- 576–1023 -->
    <source
      :srcset="`/images/1024/${splittedName}.avif`"
      type="image/avif"
      media="(min-width: 576px) and (max-width: 1023px)"
    />

    <!-- ≥1024 -->
    <source
      :srcset="`/images/1440/${splittedName}.avif`"
      type="image/avif"
      media="(min-width: 1024px)"
    />

    <!-- Fallback compressed -->
    <img
      :src="`/images/compressed/${src}`"
      :alt="alt"
      :class="imageClass"
      class="my-picture__image"
    />
  </picture>
</template>

<script setup>
const props = defineProps({
  src: {
    type: String,
    required: true
  },
  alt: {
    type: String,
    default: 'banner'
  },
  imageClass: {
    type: String,
    default: ''
  }
});

const splittedName = computed(() => props.src.replace(/\.[^/.]+$/, ''));
</script>

<style lang="scss" scoped>
.my-picture {
  display: flex;
  overflow: hidden;
  width: 100%;
}
</style>

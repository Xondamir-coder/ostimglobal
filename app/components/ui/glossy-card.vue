<template>
  <div class="glossy-card">
    <button class="glossy-card__button">
      <IconsPlus class="glossy-card__button-icon" />
    </button>
    <p class="glossy-card__text">{{ description }}</p>
    <h3 class="glossy-card__title">{{ title }}</h3>
  </div>
</template>

<script setup>
defineProps({
  description: {
    type: String,
    required: true
  },
  title: {
    type: String,
    required: true
  }
});
</script>

<style lang="scss" scoped>
.glossy-card {
  display: flex;
  flex-direction: column;
  padding: max(1.5rem, 10px);
  padding-left: max(4rem, 30px);
  padding-bottom: max(4rem, 30px);
  border-radius: 3rem;
  border: 1px solid rgba(255, 255, 255, 0.15);
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(15px);
  &__title {
    font-size: max(3.6rem, 24px);
    font-weight: 400;
    line-height: 138.889%;
    letter-spacing: -0.18rem;
    margin-top: max(3rem, 20px);
  }
  &__text {
    font-size: max(2rem, 14px);
    padding-right: 10px;
  }
  &__button {
    align-self: flex-end;
    width: max(4rem, 30px);
    height: max(4rem, 30px);
    border-radius: 50%;
    background-color: #111;
    fill: #fff;
    transition: background 0.3s, fill 0.3s;
    @include mix.flex-center;
    &:hover {
      background-color: #fff;
      fill: #111;
    }
    &-icon {
      width: 37.5%;
    }
  }
}
</style>

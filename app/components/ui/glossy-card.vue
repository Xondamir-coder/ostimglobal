<template>
  <div class="glossy-card">
    <button class="glossy-card__button">
      <IconsArrowUpright class="glossy-card__button-icon" />
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
  border-radius: 30px;
  border: 1px solid rgba(255, 255, 255, 0.15);
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(15px);
  padding: 15px;
  padding-bottom: 50px;

  display: grid;
  grid-auto-columns: 1fr auto;
  grid-template-areas:
    '. icon'
    'text .'
    'title title';
  @media screen and (max-width: vars.$bp-md) {
    gap: 20px;
    grid-template-areas:
      'title icon'
      'text .';
  }
  &__title {
    margin-top: 3rem;
    grid-area: title;
    font-size: 36px;
    font-weight: 400;
    line-height: 138.889%;
    letter-spacing: -0.18rem;
    padding-left: max(2.5rem, 5px);
    @media screen and (max-width: vars.$bp-md) {
      margin-top: 0;
    }
  }
  &__text {
    padding-left: max(2.5rem, 5px);
    grid-area: text;
    font-size: max(2rem, 16px);
  }
  &__button {
    grid-area: icon;
    align-self: flex-end;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: #111;
    stroke: #fff;
    transition:
      background 0.3s,
      stroke 0.3s;
    @include mix.flex-center;

    @media screen and (max-width: vars.$bp-md) {
      align-self: flex-start;
    }
    &:hover {
      background-color: #fff;
      stroke: #111;
    }
    &-icon {
      width: 37.5%;
      fill: none;
    }
  }
}
</style>

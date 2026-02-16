<template>
  <NuxtLink :to="$localePath(`/news/${data.id}`)" class="news-card">
    <UiPicture :src="`news-${data.id}.jpg`" :alt="data.title" class="news-card__pic" />
    <div class="news-card__content">
      <ClientOnly>
        <div class="news-card__labels">
          <span>{{ Intl.DateTimeFormat('ru-RU').format(new Date(data.date)) }}</span>
          <span
            v-for="label in data.labels"
            :key="label"
            :style="{
              color: `rgba(${randomColor()}, ${randomColor()}, ${randomColor()}, 1)`
            }"
            >{{ label }}</span
          >
        </div>
      </ClientOnly>
      <p>
        {{ data.title }}
      </p>
    </div>
  </NuxtLink>
</template>

<script setup>
defineProps({
  data: {
    type: Object,
    required: true
  }
});
</script>

<style lang="scss" scoped>
.news-card {
  display: grid;
  gap: max(4rem, 20px);
  grid-template-columns: max(20%, 250px) 3.57fr;
  align-items: center;
  border-radius: max(1.6rem, 16px);
  border: 1px solid transparent;
  transition: all 0.4s;
  @media screen and (max-width: vars.$bp-md) {
    grid-template-columns: 1fr;
  }
  &:hover {
    border-color: rgba(255, 255, 255, 0.15);
    background: rgba(255, 255, 255, 0.05);
    backdrop-filter: blur(15px);
  }
  &__labels {
    display: flex;
    column-gap: max(1.4rem, 14px);
    row-gap: 5px;
    font-size: max(1.4rem, 14px);
    font-weight: 500;
    text-transform: uppercase;
    flex-wrap: wrap;
    & > * {
      position: relative;
      &:not(:last-child)::after {
        content: '';
        position: absolute;
        width: 4px;
        height: 4px;
        border-radius: 50%;
        background-color: #d8d8d8;
        top: 50%;
        right: -7px;
        translate: 50% -50%;
      }
    }
  }
  &__content {
    display: flex;
    flex-direction: column;
    gap: max(2rem, 20px);
  }
  p {
    font-weight: 500;
  }
  &__pic {
    border-radius: max(1.6rem, 16px);
    aspect-ratio: 24.6/20;
    @media screen and (max-width: vars.$bp-md) {
      aspect-ratio: 28.5/14.6;
    }
  }
}
</style>

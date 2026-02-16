<template>
  <main class="news">
    <section class="news__header">
      <h1 class="heading-lg">
        {{ $t('news.header.title') }}
      </h1>
      <p>
        {{ $t('news.header.text') }}
      </p>
    </section>
    <section class="news__container">
      <h3 class="news__container-label">
        {{ $t('news.label') }}
      </h3>
      <div class="news__list">
        <UiNewsCard
          v-for="(card, i) in useMapRt('news.items')"
          :key="i"
          :data="card"
          class="news__item"
        />
      </div>
    </section>
    <UiSectionCta />
  </main>
</template>

<script setup></script>

<style lang="scss" scoped>
.news {
  padding-top: max(9.4rem, 30px);
  display: flex;
  flex-direction: column;
  gap: max(10rem, 50px);

  &__container {
    display: flex;
    flex-direction: column;
    gap: max(3rem, 20px);
    padding-inline: var(--spacing-inline);
    &-label {
      text-transform: uppercase;
      font-size: max(3rem, 25px);
      font-weight: 700;
    }
  }
  &__list {
    display: flex;
    flex-direction: column;
    gap: max(6rem, 60px);
  }
  &__header {
    display: flex;
    flex-wrap: wrap;
    align-items: flex-start;
    border-bottom: 2px solid #fff;
    padding-bottom: max(6rem, 50px);
    margin-inline: var(--spacing-inline);
    gap: max(5rem, 20px);
    justify-content: space-between;
    h1 {
      max-width: 17ch;
    }
    p {
      max-width: 60ch;
    }
  }
}
</style>

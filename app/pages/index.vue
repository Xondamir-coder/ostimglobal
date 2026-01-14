<template>
  <main class="home">
    <section class="hero">
      <UiPicture src="hero-banner.jpg" class="hero__banner" />
      <span class="hero__label">{{ $t('home.hero.label') }}</span>
      <h1 class="hero__title">{{ $t('home.hero.title') }}</h1>
      <div class="hero__cards">
        <UiGlossyCard
          v-for="card in $tm('home.hero.cards')"
          :key="$rt(card.title)"
          :title="$rt(card.title)"
          :description="$rt(card.description)"
        />
      </div>
    </section>
  </main>
</template>

<style lang="scss" scoped>
.hero {
  position: relative;
  border-radius: max(3rem, 20px);
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  padding-inline: max(2.4rem, 20px);
  margin-top: 26px;
  padding-bottom: 18px;
  overflow: hidden;
  aspect-ratio: 144/67.9;
  @media screen and (max-width: vars.$bp-md) {
    aspect-ratio: 37.5/38.5;
    flex-direction: column;
    justify-content: space-between;
    align-items: flex-start;
    padding-top: 40px;
    padding-inline: var(--spacing-inline);
    padding-bottom: 30px;
  }
  &__label {
    z-index: 1;
    font-size: 16px;
    font-weight: 500;
    @media screen and (min-width: vars.$bp-md) {
      display: none;
    }
  }
  &__banner {
    position: absolute;
    inset: 0;
    &::after {
      content: '';
      position: absolute;
      inset: 0;
      background-color: #00000080;
    }
  }
  &__cards {
    display: flex;
    gap: 5px;
    @media screen and (max-width: vars.$bp-md) {
      display: none;
    }
    & > * {
      &:first-child {
        width: max(35.6rem, 250px);
      }
      &:last-child {
        width: max(23.6rem, 200px);
      }
    }
  }
  &__title {
    z-index: 1;
    font-family: vars.$font-unbounded;
    font-size: max(5.4rem, 36px);
    font-weight: 300;
    max-width: 15ch;
    @media screen and (max-width: vars.$bp-md) {
      font-family: vars.$font-base;
      line-height: 123%;
    }
  }
}
</style>

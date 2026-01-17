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
    <section class="industrial">
      <h2 class="heading-lg">
        {{ $t('home.industrial.title') }}
      </h2>
      <p>
        {{ $t('home.industrial.text-1') }}
      </p>
      <div class="industrial__line" />
      <ul class="industrial__boxes">
        <li>
          <div class="industrial__box">
            <span>{{ $t('logistics') }}</span>
            <IconsStar class="industrial__box-icon" />
          </div>
        </li>
        <li>
          <div class="industrial__box">
            <span>{{ $t('sport-complex') }}</span>
            <IconsStar class="industrial__box-icon" />
          </div>
          <div class="industrial__box">
            <span>{{ $t('college') }}</span>
            <IconsStar class="industrial__box-icon" />
          </div>
        </li>
        <li>
          <div class="industrial__box">
            <span>{{ $t('clinics') }}</span>
            <IconsStar class="industrial__box-icon" />
          </div>
          <div class="industrial__box">
            <span>{{ $t('stations') }}</span>
            <IconsStar class="industrial__box-icon" />
          </div>
          <div class="industrial__box">
            <span>{{ $t('schools') }}</span>
            <IconsStar class="industrial__box-icon" />
          </div>
        </li>
      </ul>
      <div class="industrial__content">
        <h3 class="industrial__content-title">
          {{ $t('home.industrial.subtitle') }}
        </h3>
        <p>
          {{ $t('home.industrial.text-2') }}
        </p>
      </div>
    </section>
  </main>
</template>

<script setup></script>

<style lang="scss" scoped>
.industrial {
  display: grid;
  grid-template-areas:
    'title text-1'
    'line line'
    'boxes content';
  grid-template-columns: 1fr 1.2fr;
  margin-inline: var(--spacing-inline);
  margin-block: 12rem;
  position: relative;
  row-gap: 6.2rem;
  column-gap: 8rem;

  h2 {
    grid-area: title;
  }
  &__line {
    grid-area: line;
    background-color: #fff;
    height: 1px;
  }
  &__content {
    display: flex;
    flex-direction: column;
    gap: 10px;
    &-title {
      font-size: 3.6rem;
      font-weight: 400;
      letter-spacing: -0.18rem;
    }
  }
  &__boxes {
    display: flex;
    flex-direction: column;
    gap: 4px;
    li {
      display: flex;
      gap: 4px;
      &:first-child > * {
        width: max(22rem, 19px);
      }
      &:nth-child(2) > * {
        &:first-child {
          width: max(19.2rem, 18px);
        }
        &:last-child {
          width: 160px;
        }
      }
      &:last-child > * {
        &:first-child {
          width: max(17.7rem, 18px);
        }
        &:nth-child(2) {
          width: max(18.7rem);
        }
        &:last-child {
          width: max(12.7rem);
        }
      }
    }
  }
  &__box {
    font-size: 1.6rem;
    font-weight: 900;
    display: inline-flex;
    justify-content: space-between;
    align-items: center;
    border-radius: 5rem;
    border: 1px solid #fff;
    padding-block: 7px;
    padding-right: 12px;
    span {
      flex: 1;
      text-align: center;
    }
    &-icon {
      width: 13px;
      fill: #fff;
    }
  }
}
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
    padding-bottom: 4.4rem;
    padding-left: 2.8rem;

    @media screen and (max-width: vars.$bp-md) {
      padding-left: 0;
      padding-bottom: 0;
      font-family: vars.$font-base;
      line-height: 123%;
    }
  }
}
</style>

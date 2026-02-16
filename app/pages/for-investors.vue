<template>
  <main class="investors">
    <section class="hero">
      <div class="hero__card--big">
        <span class="hero__card-label">
          {{ $t('investors.hero.big.label') }}
        </span>
        <div class="hero__card-content">
          <p class="hero__card-text">
            {{ $t('investors.hero.big.text') }}
          </p>
          <h2 class="hero__card-title">
            {{ $t('investors.hero.big.title') }}
          </h2>
        </div>
      </div>
      <div v-for="(card, i) in heroCards" :key="i" class="hero__card">
        <component :is="card.logo" class="hero__card-logo" />
        <p class="hero__card-text">
          {{ card.text }}
        </p>
      </div>
    </section>
    <section class="future">
      <h2 class="heading-lg">
        {{ $t('investors.future.title') }}
      </h2>
      <ul class="future__labels">
        <li v-for="label in useMapRt('investors.future.labels')" :key="label" class="future__label">
          <span>{{ label }}</span>
          <IconsStar class="future__label-icon" />
        </li>
      </ul>
      <p v-for="text in useMapRt('investors.future.texts')" :key="text">
        {{ text }}
      </p>
    </section>
    <section class="numbers">
      <div class="numbers__card">
        <p>
          {{ $t('investors.numbers.card-1.text') }}
        </p>
        <h3 class="numbers__card-title">
          {{ $t('investors.numbers.card-1.title') }}
        </h3>
      </div>
      <div class="numbers__card--big">
        <span class="numbers__card-label">
          {{ $t('investors.numbers.card-2.label') }}
        </span>
        <p>
          {{ $t('investors.numbers.card-2.text') }}
        </p>
        <SvgYellowStrokes class="numbers__card-logo" />
        <h3 class="numbers__card-name">
          {{ $t('investors.numbers.card-2.title') }}
        </h3>
      </div>
      <div class="numbers__card">
        <p>
          {{ $t('investors.numbers.card-3.text') }}
        </p>
        <h3 class="numbers__card-title">
          {{ $t('investors.numbers.card-3.title') }}
        </h3>
      </div>
      <div class="numbers__card">
        <p>
          {{ $t('investors.numbers.card-4.text') }}
        </p>
        <div class="numbers__card-content">
          <h3 class="numbers__card-title">
            {{ $t('investors.numbers.card-4.title') }}
          </h3>
          <h4 class="numbers__card-subtitle">
            {{ $t('investors.numbers.card-4.subtitle') }}
          </h4>
        </div>
      </div>
    </section>
    <section class="overview">
      <h2 class="heading-lg">
        {{ $t('investors.overview.title') }}
      </h2>
      <div class="overview__container">
        <div class="overview__texts">
          <p v-for="text in useMapRt('investors.overview.texts')" :key="text">
            {{ text }}
          </p>
        </div>
        <ul class="overview__labels">
          <li
            v-for="label in useMapRt('investors.overview.labels')"
            :key="label"
            class="overview__label"
          >
            <span>{{ label }}</span>
            <IconsStar class="overview__label-icon" />
          </li>
        </ul>
      </div>
    </section>
  </main>
</template>

<script setup>
import {
  SvgInvestorsHero1,
  SvgInvestorsHero2,
  SvgInvestorsHero3,
  SvgInvestorsHero4
} from '#components';

const heroLogos = [SvgInvestorsHero1, SvgInvestorsHero2, SvgInvestorsHero3, SvgInvestorsHero4];
const heroCards = computed(() =>
  useMapRt('investors.hero.cards')?.map((el, i) => ({
    text: el,
    logo: heroLogos[i]
  }))
);
</script>

<style lang="scss" scoped>
@use 'sass:list';

.overview {
  display: flex;
  flex-direction: column;
  gap: 11rem;
  padding-inline: var(--spacing-inline);
  @media screen and (max-width: vars.$bp-lg) {
    gap: max(5rem, 41px);
  }
  & > *:not(.overview__ball) {
    z-index: 1;
  }
  h2 {
    max-width: 25ch;
  }
  &__labels {
    display: flex;
    flex-direction: column;
    gap: 5px;
    @media screen and (max-width: vars.$bp-md) {
      order: 2;
      padding-top: 20px;
      border-top: 2px solid #fff;
      flex-direction: row;
      flex-wrap: wrap;
    }
  }
  &__texts {
    display: flex;
    flex-direction: column;
    gap: 3rem;
  }
  &__label {
    font-size: max(3.6rem, 16px);
    font-weight: 400;
    display: flex;
    gap: 5.7rem;
    align-items: center;
    justify-content: space-between;
    padding-inline: max(3rem, 18px);
    padding-block: max(0.75rem, 8px);
    fill: #fff;
    border-radius: max(10rem, 50px);
    border: 1px solid #fff;
    @media screen and (max-width: vars.$bp-sm) {
      flex: 1;
    }
    span {
      margin-bottom: 0.25em;
    }
    &-icon {
      width: max(2.9rem, 13px);
      height: max(2.9rem, 13px);
    }
  }
  &__container {
    display: flex;
    gap: max(24.6rem, 40px);
    padding-top: 6rem;
    border-top: 1px solid #fff;
    @media screen and (max-width: vars.$bp-xl) {
      gap: max(7rem, 20px);
    }
    @media screen and (max-width: vars.$bp-md) {
      padding-top: 0;
      flex-direction: column;
      border-top: none;
    }
  }
}
.numbers {
  display: grid;
  grid-template-areas:
    'card-1 card-1 card-2 card-2'
    'card-3 card-4 card-4 .';
  //
  // 12 = 1fr
  grid-auto-columns: 3.975fr 1fr 5fr 2fr;
  grid-auto-rows: auto 348px;
  gap: 5px;
  @media screen and (max-width: vars.$bp-lg) {
    grid-auto-columns: 1fr;
    grid-template-areas:
      'card-1 card-2'
      'card-3 card-4';
  }
  @media screen and (max-width: vars.$bp-md) {
    grid-auto-rows: 390px 226px 226px 276px;
    grid-template-areas:
      'card-2'
      'card-1'
      'card-3'
      'card-4';
  }
  &__card {
    padding: max(4rem, 20px);
    display: flex;
    flex-direction: column;
    justify-content: flex-end;

    @media screen and (max-width: vars.$bp-md) {
      justify-content: flex-start;
      gap: 20px;
      &:not(:last-child) {
        margin-bottom: -150px;
      }
    }
    &:first-child {
      @media screen and (min-width: vars.$bp-lg) {
        justify-content: space-between;
        min-height: 70%;
        align-self: flex-end;
        p {
          max-width: 25ch;
          align-self: flex-end;
        }
      }
    }
    &:last-child {
      color: #000;
      gap: max(5rem, 10px);
    }
    &--big {
      padding: max(5rem, 40px) max(10rem, 18px) max(5rem, 24px) max(5rem, 20px);
      display: flex;
      flex-direction: column;
      @media screen and (max-width: vars.$bp-md) {
        gap: 25px;
        padding-bottom: 24px;
      }
      h3 {
        @media screen and (min-width: vars.$bp-md) {
          margin-top: max(5rem, 30px);
        }
      }
      p {
        margin-bottom: 3rem;
        max-width: 25ch;
        align-self: flex-end;
        @media screen and (max-width: vars.$bp-md) {
          align-self: flex-start;
          margin-bottom: 0;
        }
      }
    }
    &-content {
      display: flex;
      align-items: flex-end;
      gap: max(4rem, 16px);
      @media screen and (max-width: vars.$bp-md) {
        flex-direction: column;
        align-items: flex-start;
        order: -1;
      }
    }
    &-name {
      font-size: max(5.5rem, 36px);
      font-weight: 400;
      line-height: 100%;
      letter-spacing: min(-0.22rem, -1.44px);
      @media screen and (max-width: vars.$bp-md) {
        order: -1;
        margin-top: 5px;
      }
    }
    &-label {
      font-size: 16px;
      font-weight: 500;
      order: -2;
      @media screen and (max-width: vars.$bp-md) {
        margin-bottom: auto;
      }
    }
    &-subtitle {
      font-size: 36px;
      font-weight: 400;
      letter-spacing: -1.8px;
    }
    &-title {
      font-size: max(9.6rem, 64px);
      font-weight: 300;
      letter-spacing: min(-0.384rem, -2.56px);
      line-height: 90%;
      @media screen and (max-width: vars.$bp-md) {
        order: -1;
      }
    }
    &-logo {
      width: max(11.9rem, 61px);
      @media screen and (max-width: vars.$bp-md) {
        order: -1;
      }
    }
  }
  & > * {
    $colors: #cf2025, #222, #4800e2, #ffc700;
    border-radius: max(3rem, 20px);
    @for $i from 1 through 4 {
      &:nth-child(#{$i}) {
        background-color: list.nth($colors, $i);
        grid-area: card-#{$i};
      }
    }
  }
}
.future {
  padding-inline: var(--spacing-inline);
  display: grid;
  grid-template-areas:
    'title labels'
    'text-1 text-2';
  grid-auto-columns: 1fr;
  row-gap: 9.6rem;
  position: relative;
  @media screen and (max-width: vars.$bp-xl) {
    row-gap: 25px;
    grid-template-areas:
      'title'
      'labels'
      'text-1'
      'text-2';
  }
  &__label {
    border-radius: 50px;
    border: 1px solid var(--white, #fff);
    display: flex;
    align-items: center;
    gap: 26px;
    padding-block: 9px;
    padding-inline: 21px;
    font-size: 16px;
    font-weight: 900;
    span {
      margin-bottom: 0.15em;
    }
    &-icon {
      width: 13px;
      fill: #fff;
    }
  }
  &__labels {
    align-self: flex-end;
    grid-area: labels;
    display: flex;
    justify-content: flex-end;
    flex-wrap: wrap;
    gap: 5px;
    padding-bottom: max(6rem, 30px);
    border-bottom: 2px solid #fff;
    @media screen and (max-width: vars.$bp-xl) {
      margin-top: 40px - 25px;
      justify-content: flex-start;
    }
  }
  h2 {
    @media screen and (min-width: vars.$bp-xl) {
      padding-bottom: max(6rem, 30px);
      border-bottom: 2px solid #fff;
    }
  }
  p {
    @media screen and (min-width: vars.$bp-xl) {
      max-width: 90%;
      &:last-child {
        justify-self: flex-end;
      }
    }
    @for $i from 1 through 2 {
      &:nth-of-type(#{$i}) {
        grid-area: text-#{$i};
      }
    }
  }
}
.hero {
  display: grid;
  gap: 4px;
  grid-auto-columns: 2.02fr 1fr 1fr;
  grid-template-areas:
    'big card-1 .'
    'big card-1 card-3'
    'big card-2 card-3'
    'big card-2 card-4'
    '. . card-4';
  @media screen and (max-width: vars.$bp-lg) {
    grid-auto-rows: 338px 207px 207px 207px 207px;
    grid-auto-columns: 1fr;
    grid-template-areas:
      'big'
      'card-3'
      'card-1'
      'card-2'
      'card-4';
  }
  &__card {
    $bg-colors: #222, #4800e2, #cf2025, #fff;
    border-radius: max(3rem, 20px);
    color: #fff;
    padding: max(4rem, 20px);
    display: flex;
    justify-content: center;
    flex-direction: column;
    gap: 30px;
    @media screen and (min-width: vars.$bp-lg) {
      aspect-ratio: 35.6/23;
    }
    @media screen and (max-width: vars.$bp-lg) {
      justify-content: flex-start;
      &:nth-child(2) {
        z-index: 1;
      }
      &:nth-child(3) {
        z-index: 2;
      }
      &:last-child {
        z-index: 3;
      }
      &:not(:last-child) {
        margin-bottom: -30px;
      }
    }
    @for $i from 2 through 5 {
      &:nth-child(#{$i}) {
        grid-area: card-#{$i - 1};
        background-color: list.nth($bg-colors, $i - 1);
      }
    }
    &:last-child {
      color: #000;
    }
    &--big {
      grid-area: big;
      color: #000;
      background: var(--yellow, #ffc700);
      border-radius: max(3rem, 20px);
      padding: 15px;
      padding-bottom: max(5rem, 40px);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      h2 {
        max-width: 20ch;
      }
      h2,
      p {
        padding-left: calc(max(5rem, 20px) - 15px);
      }
    }
    &-label {
      @include mix.flex-center;
      font-size: 16px;
      font-weight: 900;
      color: #fff;
      border-radius: max(3rem, 20px);
      background: var(--black, #111);
      width: 137px;
      height: 41px;
    }
    &-text {
      font-weight: 500;
    }
    &-title {
      font-size: max(5.5rem, 36px);
      font-weight: 400;
      line-height: 103%;
      letter-spacing: min(-0.22rem, -1.44px);
    }
    &-content {
      display: flex;
      flex-direction: column;
      gap: max(3.5rem, 20px);
    }
    &-logo {
      width: max(4.5rem, 30px);
    }
  }
}
.investors {
  display: flex;
  flex-direction: column;
  gap: max(12rem, 100px);
  padding-top: max(9.4rem, 30px);
}
</style>

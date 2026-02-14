<template>
  <main class="home">
    <section class="hero">
      <UiPicture src="hero-banner.jpg" class="hero__banner" />
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
            <span>{{ $t('industrial-facilities') }}</span>
            <IconsStar class="industrial__box-icon" />
          </div>
          <div class="industrial__box">
            <span>{{ $t('education') }}</span>
            <IconsStar class="industrial__box-icon" />
          </div>
        </li>
        <li>
          <div class="industrial__box">
            <span>{{ $t('healthcare') }}</span>
            <IconsStar class="industrial__box-icon" />
          </div>
          <div class="industrial__box">
            <span>{{ $t('roads') }}</span>
            <IconsStar class="industrial__box-icon" />
          </div>
          <div class="industrial__box">
            <span>{{ $t('services') }}</span>
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
    <section class="revolution">
      <div class="revolution__top">
        <div class="revolution__big">
          <UiPicture src="revolution-banner.jpg" alt="banner" class="revolution__big-banner" />
          <span class="revolution__label">
            {{ $t('roads') }}
          </span>
          <div class="revolution__big-container">
            <SvgOvalStack class="revolution__big-stack" />
            <div class="revolution__big-content">
              <h2 class="heading-lg">{{ $t('home.revolution.title') }}</h2>
              <p>{{ $t('home.revolution.desc') }}</p>
            </div>
          </div>
        </div>
        <div class="revolution__download">
          <h3 class="revolution__download-title">{{ $t('home.revolution.download-cat') }}</h3>
          <div class="revolution__download-circle">
            <span>↓</span>
          </div>
        </div>
      </div>
      <div class="revolution__bottom">
        <div class="revolution__card">
          <span class="revolution__label">
            {{ $t('healthcare') }}
          </span>
          <p>
            {{ $t('home.revolution.healthcare-desc') }}
          </p>
        </div>
        <div class="revolution__card">
          <span class="revolution__label">
            {{ $t('retail') }}
          </span>
          <div class="revolution__card-content">
            <h3>
              {{ $t('home.revolution.retail-title') }}
            </h3>
            <p>
              {{ $t('home.revolution.retail-desc') }}
            </p>
          </div>
        </div>
        <div class="revolution__card">
          <span class="revolution__label">
            {{ $t('roads') }}
          </span>
          <p>
            {{ $t('home.revolution.roads-desc') }}
          </p>
        </div>
        <div class="revolution__card">
          <span class="revolution__label">
            {{ $t('services') }}
          </span>
          <p>
            {{ $t('home.revolution.services-desc') }}
          </p>
        </div>
      </div>
    </section>
    <section class="overview">
      <UiPicture class="overview__ball" src="ball.png" alt="ball" />
      <h2 class="heading-lg">
        {{ $t('home.overview.title') }}
      </h2>
      <div class="overview__container">
        <ul class="overview__labels">
          <li
            v-for="label in $tm('home.overview.labels')"
            :key="$rt(label)"
            class="overview__label"
          >
            <span>{{ $rt(label) }}</span>
            <IconsStar class="overview__label-icon" />
          </li>
        </ul>
        <div class="overview__texts">
          <p v-for="text in $tm('home.overview.texts')" :key="$rt(text)">
            {{ $rt(text) }}
          </p>
        </div>
      </div>
    </section>
    <section class="network">
      <div class="network__card">
        <IconsRecCirc class="network__card-icon" />
        <p>{{ $t('home.network.coop') }}</p>
      </div>
      <div class="network__card">
        <UiPicture src="map.jpg" alt="map" class="network__card-banner" />
        <div class="network__card-box">
          <span>{{ $t('neural-networks') }}</span>
          <IconsStar class="network__card-box-icon" />
        </div>
      </div>
      <div class="network__card">
        <IconsTwoLines class="network__card-icon" />
        <p>{{ $t('home.network.struc') }}</p>
      </div>
      <div class="network__card">
        <IconsBlackRecWhiteCirc class="network__card-icon" />
        <p>{{ $t('home.network.integ') }}</p>
      </div>
    </section>
    <UiSectionCta />
    <button class="home__up" @click="goUp">
      <IconsArrowUpShort />
    </button>
  </main>
</template>

<script setup>
const goUp = () => {
  window.scrollTo({
    top: 0,
    behavior: 'smooth'
  });
};
</script>

<style lang="scss" scoped>
.network {
  z-index: 2;
  display: grid;
  grid-template-areas:
    'card-1 card-1 card-2 card-2'
    '. card-3 card-3 card-4';
  grid-auto-columns: 4.2fr 1fr 4.2fr 3.1fr; // 1fr = 11.5rem
  grid-auto-rows: max(54.3rem, 220px) max(23.1rem, 220px);
  gap: 5px;
  @media screen and (max-width: vars.$bp-lg) {
    grid-auto-columns: 1fr;
    grid-template-areas:
      'card-1 card-1 card-2 card-2'
      'card-3 card-3 card-4 card-4';
  }
  @media screen and (max-width: vars.$bp-md) {
    grid-auto-rows: 224px;
    grid-template-areas:
      'card-2'
      'card-1'
      'card-3'
      'card-4';
  }
  &__card {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    justify-content: space-between;
    gap: 30px;
    border-radius: max(3rem, 20px);
    font-weight: 500;
    color: #000;
    padding-block: 40px;
    padding-inline: max(4rem, 20px);

    &:first-child {
      grid-area: card-1;
      background-color: #4800e2;
      color: #fff;
      align-self: flex-end;
      height: 58%;
      @media screen and (max-width: vars.$bp-lg) {
        height: 80%;
      }
      @media screen and (max-width: vars.$bp-md) {
        height: 100%;
      }
    }
    &:nth-child(2) {
      grid-area: card-2;
      position: relative;
      overflow: hidden;
    }
    &:nth-child(3) {
      grid-area: card-3;
      background-color: #fff;
    }
    &:nth-child(4) {
      grid-area: card-4;
      background-color: #ffc700;
    }
    &-icon {
      flex-shrink: 0;
      width: auto;
    }
    &-banner {
      position: absolute;
      inset: 0;
      &::after {
        content: '';
        position: absolute;
        inset: 0;
        background: rgba(0, 0, 0, 0.4);
      }
    }
    &-box {
      align-self: flex-end;
      z-index: 1;
      fill: #fff;
      color: #fff;
      padding-block: 7px;
      padding-inline: 16px;
      font-size: max(1.6rem, 12px);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 1rem;
      border-radius: 5rem;
      border: 1px solid #fff;
      @media screen and (max-width: vars.$bp-md) {
        display: none;
      }
      span {
        margin-bottom: 0.3em;
      }
      &-icon {
        width: 13px;
      }
    }
  }
}
.overview {
  display: flex;
  flex-direction: column;
  gap: 11rem;
  padding-inline: var(--spacing-inline);
  position: relative;
  @media screen and (max-width: vars.$bp-lg) {
    gap: max(5rem, 41px);
  }
  & > *:not(.overview__ball) {
    z-index: 1;
  }
  &__ball {
    position: absolute;
    right: 0;
    top: -70%;
    width: 95%;
    @media screen and (max-width: vars.$bp-md) {
      display: none;
    }
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
.revolution {
  z-index: 2;
  display: flex;
  flex-direction: column;
  gap: 5px;
  &__label {
    --bg-clr: #fff;
    --text-clr: #fff;
    padding-block: max(0.9rem, 7px);
    font-size: max(1.6rem, 14px);
    font-weight: 900;
    padding-inline: max(2.1rem, 21px);
    border-radius: 50px;
    background-color: var(--bg-clr);
    color: var(--text-clr);
    align-self: flex-start;
  }
  &__labels {
    display: flex;
    gap: 3px;
  }
  &__card {
    border-radius: max(3rem, 20px);
    padding: 15px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    font-size: 18px;
    @media screen and (max-width: vars.$bp-md) {
      min-height: 250px;
      font-size: 20px;
      &:not(:first-child) {
        margin-top: -46px;
      }
      &:not(:last-child) {
        padding-bottom: 65px;
      }
    }
    & > *:last-child {
      padding-inline: calc(4rem - 1.5rem);
      padding-bottom: calc(4rem - 1.5rem);
    }
    &-content {
      display: flex;
      align-items: flex-end;
      gap: max(3rem, 15px);
      font-weight: 500;
      @media screen and (max-width: vars.$bp-lg) {
        flex-wrap: wrap;
        flex-direction: column;
        align-items: flex-start;
        padding: 0;
      }
      h3 {
        font-size: 35px;
        font-weight: 400;
        @media screen and (min-width: vars.$bp-lg) {
          max-width: 10ch;
        }
      }
      p {
        @media screen and (min-width: vars.$bp-lg) {
          max-width: 20ch;
        }
      }
    }
    & > p {
      font-weight: 500;
      padding-bottom: 2rem;
    }
    &:first-child {
      background-color: #cf2025;

      .revolution__label {
        --text-clr: #cf2025;
      }
    }
    &:nth-child(2) {
      background-color: #142751;
      @media screen and (min-width: vars.$bp-md) {
        grid-column: span 2;
      }

      .revolution__label {
        --text-clr: #4800e2;
      }
    }
    &:nth-child(3) {
      background-color: #fff;

      p {
        color: #000;
      }
      .revolution__label {
        --bg-clr: #111;
      }
    }
    &:nth-child(4) {
      background-color: #fc0;

      p {
        color: #000;
      }
      .revolution__label {
        --bg-clr: #111;
      }
    }
  }
  &__bottom {
    display: grid;
    grid-auto-rows: 231px;
    grid-template-columns: 1fr 1fr 0.74fr;
    gap: 5px;
    margin-left: 45.7rem;
    @media screen and (max-width: vars.$bp-lg) {
      margin-left: 0;
    }
    @media screen and (max-width: vars.$bp-md) {
      display: flex;
      flex-direction: column;
    }
  }
  &__top {
    display: grid;
    grid-template-columns: 3.3fr 1fr;
    align-items: flex-end;
    gap: 4px;
    @media screen and (max-width: vars.$bp-lg) {
      grid-template-columns: 1fr 250px;
    }
    @media screen and (max-width: vars.$bp-md) {
      grid-template-columns: 1fr;
      gap: 5px;
    }
  }
  &__download {
    background-color: #222;
    border-radius: max(3rem, 15px);
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: max(4rem, 15px);
    @media screen and (min-width: vars.$bp-md) {
      height: 77%;
    }
    @media screen and (max-width: vars.$bp-md) {
      flex-direction: row;
      align-items: center;
    }
    &-title {
      color: #ffc700;
    }
    &-circle {
      @include mix.flex-center;
      flex-shrink: 0;
      width: max(7.4rem, 51px);
      height: max(7.4rem, 51px);
      border-radius: 50%;
      color: #ffc700;
      border: 1px solid #ffc700;
      span {
        font-size: max(3rem, 26px);
      }
    }
  }
  &__big {
    height: max(46.6rem, 338px);
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    border-radius: max(3rem, 20px);
    overflow: hidden;
    padding: max(1.5rem, 15px);
    & > *:not(.revolution__big-banner) {
      z-index: 1;
    }
    &-content {
      flex: 1;
      display: flex;
      flex-wrap: wrap;
      gap: 30px;
      align-items: flex-end;
      justify-content: space-between;
      h2 {
        max-width: 15ch;
      }
      p {
        max-width: 28ch;
      }
    }
    &-container {
      display: flex;
      flex-direction: column;
      gap: 2.6rem;
      padding: calc(5rem - 1.5rem);
      @media screen and (max-width: vars.$bp-md) {
        padding: 0;
        padding-bottom: 50px - 15px;
      }
    }
    &-stack {
      fill: #fff;
      width: 6.7rem;
      @media screen and (max-width: vars.$bp-lg) {
        display: none;
      }
    }
    &-banner {
      position: absolute;
      inset: 0;
      &::after {
        content: '';
        position: absolute;
        inset: 0;
        background-color: rgba(0, 0, 0, 0.5);
      }
    }
    .revolution__label {
      --bg-clr: #000;
      --text-clr: #ffc700;
    }
  }
}
.industrial {
  display: grid;
  grid-template-areas:
    'title text-1'
    'line line'
    'boxes content';
  grid-auto-columns: 1fr 1.2fr;
  margin-inline: var(--spacing-inline);
  position: relative;
  row-gap: max(6.2rem, 20px);
  column-gap: 8rem;
  @media screen and (max-width: vars.$bp-md) {
    grid-auto-columns: 1fr;
    grid-template-areas:
      'title'
      'text-1'
      'line'
      'boxes';
  }

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
    gap: 20px;
    &-title {
      font-size: 36px;
      font-weight: 400;
      letter-spacing: -1.8px;
      line-height: 122.2%;
    }
  }
  &__boxes {
    display: flex;
    flex-direction: column;
    gap: 4px;
    li {
      display: flex;
      gap: 4px;
      @media screen and (max-width: vars.$bp-md) {
        flex-wrap: wrap;
      }
      &:first-child > * {
        width: max(22rem, 192px);
        @media screen and (max-width: vars.$bp-md) {
          margin-inline: auto;
        }
      }
      &:nth-child(2) > * {
        &:first-child {
          width: max(19.2rem, 177px);
        }
        &:last-child {
          width: max(16rem, 150px);
        }
      }
      &:last-child > * {
        &:first-child {
          width: max(17.7rem, 127px);
        }
        &:nth-child(2) {
          width: max(18.7rem, 187px);
        }
        &:last-child {
          width: 12.7rem;
          @media screen and (max-width: vars.$bp-md) {
            width: max(12.7rem, 220px);
          }
        }
      }
    }
  }
  &__box {
    font-size: 16px;
    font-weight: 900;
    display: inline-flex;
    justify-content: space-between;
    align-items: center;
    border-radius: 50px;
    border: 1px solid #fff;
    padding-block: 5px;
    padding-right: 12px;
    span {
      flex: 1;
      text-align: center;
      margin-bottom: 0.2em;
    }
    &-icon {
      width: 13px;
      fill: #fff;
    }
  }
}
.hero {
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  padding-inline: max(2.4rem, 20px);
  padding-bottom: 18px;
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
  @media screen and (max-width: vars.$bp-md) {
    padding: 0;
    justify-content: flex-end;
    gap: 34px;
    h1 {
      padding-left: 20px;
    }
  }
  @media screen and (max-width: vars.$bp-sm) {
    aspect-ratio: initial;
    min-height: calc(100vh - 120px);
  }
  &__banner {
    border-radius: max(3rem, 20px);
    overflow: hidden;
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
      display: grid;
      align-self: stretch;
      grid-auto-rows: auto 50px auto;
      margin-bottom: -10px;
    }
    & > * {
      @media screen and (max-width: vars.$bp-md) {
        grid-column: 1 / 2;
        &:first-child {
          grid-row: 2 / 4;
          z-index: 2;
        }
        &:last-child {
          padding-bottom: 90px;
          grid-row: 1 / 3;
        }
      }
      @media screen and (min-width: vars.$bp-md) {
        min-width: 250px;
        &:first-child {
          max-width: 35.6rem;
        }
        &:last-child {
          max-width: 23.6rem;
        }
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
.home {
  display: flex;
  flex-direction: column;
  gap: max(14rem, 100px);
  &__up {
    @include mix.flex-center;
    width: 55px;
    height: 55px;
    border-radius: 50%;
    border: 2px solid #000;
    background: #fc0;
    align-self: flex-end;
    margin-right: var(--spacing-inline);
    transition: opacity 0.4s;
    margin-top: calc((max(14rem, 100px) - 57px) * -1);
    margin-bottom: calc((max(9.4rem, 94px) - 37px) * -1);
    &:hover {
      opacity: 0.5;
    }
  }
}
</style>

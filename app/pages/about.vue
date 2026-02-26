<template>
  <main class="about">
    <section class="hero">
      <h1 class="heading-lg">
        {{ $t('about.hero.title') }}
      </h1>
      <div class="hero__texts">
        <p v-for="text in useMapRt('about.hero.texts')" :key="text">
          <span v-for="item in text.split('/endline/')" :key="item">
            {{ item }}
          </span>
        </p>
      </div>
    </section>
    <section class="social">
      <UiPicture src="ball.png" alt="ball" class="social__ball" />
      <div class="social__row">
        <UiPicture src="footer-banner.jpg" alt="banner" class="social__banner" />
        <div class="social__card">
          <svg
            class="social__card-icon"
            viewBox="0 0 57 56"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M28.5 1.16666C13.4158 1.16666 1.1875 13.1794 1.1875 28C1.1875 42.8186 13.4158 54.8333 28.5 54.8333C43.5842 54.8333 55.8125 42.8186 55.8125 28C55.8125 13.1794 43.5842 1.16666 28.5 1.16666ZM0 56V-3.8147e-06H57V56H0Z"
              fill="white"
            />
          </svg>
          <span class="social__card-label">
            {{ $t('social') }}
          </span>
          <p class="social__card-desc">
            {{ $t('about.social.card-1.text') }}
          </p>
          <p class="social__card-title">
            {{ $t('about.social.card-1.title') }}
          </p>
        </div>
      </div>
      <div class="social__row">
        <div class="social__card">
          <svg
            class="social__card-icon"
            viewBox="0 0 52 56"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M0 16C0 24.6385 23.0978 31.6778 52 32V0C23.0978 0.322214 0 7.3615 0 16Z"
              fill="white"
            />
            <path d="M52 56V32H0C0 44.9577 23.0978 55.5155 52 56Z" fill="white" />
          </svg>

          <span class="social__card-label">
            {{ $t('social') }}
          </span>
          <p class="social__card-desc">
            {{ $t('about.social.card-2.text') }}
          </p>
          <p class="social__card-title">
            {{ $t('about.social.card-2.title') }}
          </p>
        </div>
        <UiPicture src="school.jpg" alt="banner" class="social__banner" />
      </div>
      <div class="social__row">
        <UiPicture src="sports.jpg" alt="banner" class="social__banner" />
        <div class="social__card">
          <svg
            class="social__card-icon"
            viewBox="0 0 57 57"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M57 0C36.8129 1.78125 4.73621 10.5034 4.73225 37.052C4.73423 37.4201 4.73619 57 4.73619 57H0C0 57 0 37.2736 0 37.0124C0 8.90625 35.6254 0 57 0Z"
              fill="white"
            />
            <path
              d="M57 0C44.1221 3.59615 14.7069 13.6563 14.7069 37.0757V57H10.0235V38.1425C10.0117 37.7526 10 37.3805 10 37.0065C10 10.6875 41.7409 2.96875 57 0Z"
              fill="white"
            />
            <path
              d="M57 0C46.9539 4.78365 23.7318 19.287 23.7318 38.1425V57H19V37.0757C19 14.8438 49.8847 2.375 57 0Z"
              fill="white"
            />
            <path
              d="M57 0C47.394 7.15865 32.8083 23.089 32.8083 37.0757V57H28V37.0757C28 19.5938 49.2016 4.78365 57 0Z"
              fill="white"
            />
            <path
              d="M57 0C52.3095 5.3774 42.7128 21.4086 42.7128 36.8125V57H38C38 57 38.1358 45.4892 38.1358 36.8461C38.1358 22.036 50.5378 5.97115 57 0Z"
              fill="white"
            />
            <path
              d="M57 0C53.3351 7.7524 52.1016 16.6586 51.9209 35.6586C51.7537 53.2079 51.9209 57 51.9209 57H47V35.6586C47 21.941 52.1016 7.15865 57 0Z"
              fill="white"
            />
          </svg>

          <span class="social__card-label">
            {{ $t('social') }}
          </span>
          <p class="social__card-desc">
            {{ $t('about.social.card-3.text') }}
          </p>
          <p class="social__card-title">
            {{ $t('about.social.card-3.title') }}
          </p>
        </div>
      </div>
    </section>
    <section class="partners">
      <div class="partners__header">
        <h2 class="heading-lg">
          {{ $t('about.partners.title') }}
        </h2>
        <p>
          {{ $t('about.partners.text') }}
        </p>
      </div>
      <ul class="partners__list">
        <li v-for="item in 8" :key="item" class="partners__item">
          <UiPicture
            :src="`partner-${((item - 1) % 5) + 1}.png`"
            alt="partner"
            class="partners__item-pic"
          />
        </li>
      </ul>
    </section>
    <section class="info">
      <div class="info__header">
        <h2 class="heading-lg">
          {{ $t('about.info.title') }}
        </h2>
        <p>
          {{ $t('about.info.text') }}
        </p>
      </div>
      <ul class="info__cards">
        <li v-for="(card, i) in useMapRt('about.info.cards')" :key="card.label" class="info__card">
          <UiPicture
            v-if="i > 1"
            :src="i === 2 ? 'truck.png' : 'builder.png'"
            class="info__card-banner"
          />
          <span class="info__card-label">
            {{ card.label }}
          </span>
          <div class="info__card-content">
            <h3 class="info__card-title">
              {{ card.title }}
            </h3>
            <p class="info__card-text">
              {{ card.text }}
            </p>
          </div>
        </li>
      </ul>
    </section>
    <UiSectionCta />
  </main>
</template>

<script setup></script>

<style lang="scss" scoped>
.info {
  margin-top: max(9rem, 90px);
  margin-bottom: 100px;
  display: flex;
  flex-direction: column;
  gap: max(6.7rem, 50px);
  @media screen and (max-width: vars.$bp-md) {
    gap: 90px;
  }
  &__card {
    position: relative;
    display: flex;
    flex-direction: column;
    padding: 15px;
    border-radius: max(3rem, 20px);
    justify-content: space-between;
    overflow: hidden;
    & > *:not(picture) {
      z-index: 1;
    }
    @for $i from 1 through 4 {
      &:nth-child(#{$i}) {
        grid-area: card-#{$i};
      }
    }
    &:first-child {
      color: #000;
      background-color: #ffc700;
      .info__card-content {
        flex-direction: row;
        flex-wrap: wrap;
        align-items: flex-end;
        p {
          max-width: 40ch;
        }
        h3 {
          max-width: 10ch;
        }
      }
      .info__card-label {
        color: #fff;
        background-color: #000;
      }
    }
    &:nth-child(2) {
      background-color: #ff383c;
      .info__card-content {
        flex-direction: row;
        flex-wrap: wrap;
        align-items: flex-end;
        p {
          max-width: 40ch;
        }
        h3 {
          max-width: 10ch;
        }
      }
      color: #fff;
      .info__card-label {
        background-color: #000;
      }
    }
    &:nth-child(3) {
      background-color: #ffc700;
      color: #fff;
      .info__card-title {
        font-size: 36px;
      }
      .info__card-label {
        background-color: #fff;
        color: #000;
      }
    }
    &:last-child {
      background-color: #ffc700;
      color: #fff;
      .info__card-title {
        font-size: 36px;
      }
      .info__card-label {
        background-color: #fff;
        color: #000;
      }
    }
    &-title {
      font-size: max(5.6rem, 36px);
      font-weight: 400;
      letter-spacing: min(-0.28rem, -1.8px);
    }
    &-content {
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      gap: max(2rem, 4px);
      padding-left: calc(4rem - 15px);
      padding-bottom: calc(40px - 15px);
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
    &-label {
      @include mix.flex-center;
      font-size: 16px;
      font-weight: 900;
      flex-shrink: 0;
      width: 86px;
      height: 41px;
      border-radius: max(5rem, 30px);
      @media screen and (max-width: vars.$bp-md) {
        width: 104px;
      }
    }
  }
  &__cards {
    display: grid;
    grid-auto-columns: 1.56fr 1fr;
    grid-auto-rows: 352px 133px 150px 256px;
    grid-template-areas:
      'card-1 card-3'
      'card-2 card-3'
      'card-2 card-4'
      '. card-4';
    gap: 5px;
    @media screen and (max-width: vars.$bp-xl) {
      grid-auto-rows: 362px;
      grid-template-areas:
        'card-3'
        'card-4'
        'card-1'
        'card-2';
    }
  }
  &__header {
    margin-inline: var(--spacing-inline);
    gap: 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    border-bottom: 1px solid #fff;
    padding-bottom: max(6rem, 30px);
    @media screen and (max-width: vars.$bp-md) {
      padding-bottom: 0;
      border-bottom: none;
    }
    h2 {
      max-width: 20ch;
    }
    p {
      max-width: 40ch;
    }
  }
}
.partners {
  margin-top: max(15.9rem, 100px);
  padding-inline: var(--spacing-inline);
  display: flex;
  flex-direction: column;
  gap: max(13.2rem, 50px);
  &__list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(max(25.8rem, 150px), 1fr));
    gap: max(3rem, 14px);
  }
  &__item {
    @include mix.flex-center;
    aspect-ratio: 27.8/10.8;
    border-radius: 10px;
    background: #fff;
    box-shadow: 0 20px 50px 0 rgba(49, 49, 49, 0.05);
    &:nth-child(4) {
      .partners__item-pic {
        max-width: 30%;
      }
    }
    &-pic {
      max-width: 60%;
    }
  }
  &__header {
    display: flex;
    align-items: flex-start;
    flex-wrap: wrap;
    gap: 24px;
    justify-content: space-between;
    p {
      max-width: 50ch;
    }
  }
}
.social {
  display: flex;
  flex-direction: column;
  gap: 5px;
  margin-top: max(10rem, 40px);
  position: relative;
  & > *:not(.social__ball) {
    z-index: 1;
  }
  &__ball {
    position: absolute;
    right: -5%;
    top: 25%;
    width: 100%;
    @media screen and (max-width: vars.$bp-md) {
      display: none;
    }
  }
  &__row {
    display: grid;
    grid-auto-flow: column;
    gap: 5px;
    @media screen and (max-width: vars.$bp-md) {
      grid-auto-flow: row;
      grid-auto-rows: 350px;
    }
    @media screen and (min-width: vars.$bp-md) {
      &:first-of-type {
        grid-auto-columns: 1fr 1.2fr;
        max-width: max(92%, 1200px);
        .social__banner {
          aspect-ratio: 59.8/46.6;
        }
        .social__card {
          align-self: flex-end;
          min-height: 73.3%;
        }
      }
      &:nth-of-type(2) {
        grid-auto-columns: 1fr 1.27fr;
        align-self: flex-end;
        max-width: max(75.5%, 1000px);
        .social__banner {
          aspect-ratio: 60.5/46.6;
        }
      }
      &:last-of-type {
        grid-auto-columns: 1fr 1.01fr;
        align-self: flex-end;
        max-width: max(83.5%, 1100px);
        .social__banner {
          aspect-ratio: 60.3/46.6;
        }
        .social__card {
          align-self: flex-start;
          min-height: 74.7%;
        }
      }
    }
    &:first-of-type {
      .social__card {
        background-color: #142751;
      }
    }
    &:nth-of-type(2) {
      .social__card {
        background-color: #222;
        order: -1;
      }
    }
    &:last-of-type {
      .social__card {
        background-color: #fc0;
        color: #000;
      }
    }
  }
  &__banner {
    border-radius: max(3rem, 20px);
    position: relative;
    @media screen and (max-width: vars.$bp-md) {
      margin-bottom: -60px;
    }
    &::after {
      content: '';
      position: absolute;
      inset: 0;
      background-color: rgba(0, 0, 0, 0.2);
    }
  }
  &__card {
    color: #fff;
    position: relative;
    border-radius: max(3rem, 20px);
    padding: 15px;
    padding-bottom: 40px;
    display: flex;
    flex-direction: column;
    gap: 20px;
    @media screen and (max-width: vars.$bp-sm) {
      padding-bottom: 50px;
    }
    &-icon {
      width: max(5.7rem, 45px);
      position: absolute;
      right: max(4rem, 15px);
      top: max(4rem, 15px);
    }
    &-label {
      @include mix.flex-center;
      width: max(13.5rem, 85px);
      height: 41px;
      border-radius: max(5rem, 30px);
      background: var(--white, #fff);
      color: #000;
      font-size: 16px;
      font-weight: 900;
    }
    &-desc {
      margin-top: auto;
      padding-left: calc(max(4rem, 20px) - 15px);
      font-size: 16px;
      font-weight: 500;
    }
    &-title {
      padding-left: calc(max(4rem, 20px) - 15px);
      font-family: 'Zen Maru Gothic';
      font-size: 36px;
      font-weight: 400;
      line-height: 138%;
      letter-spacing: -1.8px;
    }
  }
}
.hero {
  padding-inline: var(--spacing-inline);
  display: flex;
  flex-direction: column;
  gap: max(5rem, 20px);
  margin-top: calc(max(12rem, 83px) - 26px);
  h1 {
    max-width: 20ch;
  }
  &__texts {
    display: flex;
    gap: max(7.4rem, 25px);
    border-bottom: 1px solid #fff;
    padding-bottom: max(9rem, 40px);
    @media screen and (max-width: vars.$bp-md) {
      flex-direction: column;
      border-bottom: none;
    }
    p {
      display: flex;
      flex-direction: column;
      &:first-child {
        @media screen and (max-width: vars.$bp-md) {
          border-bottom: 1px solid #fff;
          padding-bottom: 25px;
        }
      }
    }
  }
}
.about {
  overflow: hidden;
  display: flex;
  flex-direction: column;
  & > *:not(.social) {
    z-index: 2;
  }
}
</style>

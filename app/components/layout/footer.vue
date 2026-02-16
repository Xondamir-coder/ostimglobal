<template>
  <footer class="footer">
    <UiPicture src="footer-banner.jpg" alt="banner" class="footer__banner" />
    <div class="footer__top">
      <span>/ {{ new Date().getFullYear() }}</span>
      <span>/ Ostim Global</span>
    </div>
    <div class="footer__left">
      <h2 class="footer__title">{{ $t('footer.title') }}</h2>
      <div class="footer__partners">
        <span>{{ $t('footer.partners') }}:</span>
        <div class="footer__partners-list">
          <UiPicture
            v-for="image in 4"
            :key="image"
            :src="`partner-${image}.png`"
            alt="partner"
            class="footer__partners-image"
          />
        </div>
      </div>
    </div>
    <div class="footer__content">
      <div class="footer__box">
        <h4 class="footer__box-title">{{ $t('footer.office') }}</h4>
        <ul class="footer__box-list">
          <li class="footer__box-item">
            {{ $t('footer.address-1') }}
          </li>
          <li class="footer__box-item">
            <a class="footer__box-link" href="tel:+998 55 055 10 10">+998 55 055 10 10 </a>
          </li>
          <li class="footer__box-item">
            {{ $t('footer.address-2') }}
          </li>
        </ul>
      </div>
      <div v-for="box in boxes" :key="box.title" class="footer__box">
        <h4 class="footer__box-title">{{ box.title }}</h4>
        <nav class="footer__box-list">
          <div v-for="link in box.links" :key="link.label" class="footer__box-item">
            <a
              v-if="link.link.includes('https')"
              class="footer__box-link"
              :href="link.link"
              target="_blank"
              rel="noopener noreferrer"
            >
              {{ link.label }}
            </a>
            <NuxtLink v-else class="footer__box-link" :to="link.link" active-class="active">
              {{ link.label }}
            </NuxtLink>
          </div>
        </nav>
      </div>
    </div>
    <p class="footer__bottom-text">
      {{ $t('footer.copyright', { year: new Date().getFullYear() }) }}
    </p>
    <div class="footer__bottom">
      <nav class="footer__bottom-nav">
        <NuxtLink
          v-for="(link, i) in tm('footer.links')"
          :key="i"
          :to="`/${rt(link).split(' ').join('-').toLowerCase()}`"
        >
          {{ rt(link) }}
        </NuxtLink>
      </nav>
      <div class="footer__dev">
        <span>{{ $t('footer.dev') }}</span>
        <a
          href="https://spacelabs.studio"
          target="_blank"
          rel="noopener noreferrer"
          class="footer__dev-link"
        >
          <SvgSpacelabs class="footer__dev-logo" />
        </a>
      </div>
    </div>
  </footer>
</template>

<script setup>
const { t, tm, rt } = useI18n();

const boxes = computed(() => [
  {
    title: t('footer.navigation'),
    links: tm('header.links').map(el => ({
      label: rt(el),
      link: `/${rt(el).split(' ').join('-').toLowerCase()}`
    }))
  },
  {
    title: t('footer.social-media'),
    links: [
      {
        label: 'Facebook',
        link: 'https://www.facebook.com'
      },
      {
        label: 'Instagram',
        link: 'https://www.instagram.com'
      },
      {
        label: 'Linkedin',
        link: 'https://www.linkedin.com'
      },
      {
        label: 'Telegram',
        link: 'https://telegram.org/'
      }
    ]
  }
]);
</script>

<style lang="scss" scoped>
.footer {
  position: relative;
  margin-top: max(9.4rem, 94px);
  padding-top: max(3.7rem, 17px);
  display: grid;
  grid-auto-columns: 1fr;
  row-gap: 20px;
  grid-template-areas:
    'top top'
    'left content'
    'copyright bottom';
  font-size: max(1.4rem, 12px);
  @media screen and (max-width: vars.$bp-md) {
    grid-template-areas:
      'top'
      'left'
      'content'
      'copyright'
      'bottom';
    row-gap: 25px;
  }
  &::after {
    content: '';
    position: absolute;
    right: 0;
    top: 0;
    width: 50%;
    height: 100%;
    border: 1px solid rgba(255, 255, 255, 0.15);
    background: rgba(255, 255, 255, 0.05);
    backdrop-filter: blur(15px);
    @media screen and (max-width: vars.$bp-md) {
      inset-inline: 0;
      top: auto;
      bottom: 0;
      width: 100%;
      height: 67%;
    }
  }
  &__box {
    font-family: vars.$font-inter-tight;
    display: flex;
    flex-direction: column;
    gap: 20px;

    &-list {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }
    &-link[href*='spacelabs'] {
      font-weight: 700;
    }
    &-link.active {
      font-weight: 700;
    }
    &-title {
      font-size: max(2rem, 17px);
      font-weight: 400;
    }
    &-item {
      max-width: 17ch;
    }
  }
  &__content {
    grid-area: content;
    align-self: flex-end;
    padding-right: var(--spacing-inline);
    padding-left: max(5.4rem, 20px);
    padding-bottom: calc(7.7rem - 20px);
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: max(5rem, 36px);
    @media screen and (max-width: vars.$bp-md) {
      padding-bottom: 0;
    }
    @media screen and (max-width: vars.$bp-sm) {
      flex-direction: column;
    }
  }
  &__left {
    grid-area: left;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    gap: max(30rem, 40px);
    padding-top: calc(7.9rem - 20px);
    @media screen and (max-width: vars.$bp-md) {
      gap: 57px;
      padding-top: calc(44px - 25px);
      padding-bottom: 100px;
    }
  }
  &__left,
  &__top {
    padding-inline: var(--spacing-inline);
  }
  &__bottom {
    grid-area: bottom;
    border-top: 0.5px solid #999;

    color: #9c9c9c;
    display: flex;
    flex-wrap: wrap;
    gap: 47px;
    justify-content: space-between;
    align-items: center;
    padding-inline: max(5.4rem, 20px);
    padding-block: max(4rem, 25px);

    @media screen and (max-width: vars.$bp-md) {
      border-top: none;
      padding-top: 0;
    }
    @media screen and (max-width: vars.$bp-sm) {
      justify-content: center;
    }
    &-text {
      grid-area: copyright;

      border-top: 0.5px solid #999;
      display: flex;
      align-items: center;
      justify-content: flex-start;
      padding-left: var(--spacing-inline);
      @media screen and (max-width: vars.$bp-md) {
        padding-top: 20px;
        padding-inline: 0;
        margin-inline: 20px;
        justify-content: center;
      }
    }
    &-nav {
      display: flex;
      gap: max(3.5rem, 30px);
      & > * {
        text-decoration-line: underline;
      }
    }
    p {
      color: #fff;
    }
  }
  &__top {
    grid-area: top;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: max(2rem, 20px);
  }
  & > *:not(.footer__banner) {
    z-index: 1;
  }
  &__dev {
    display: flex;
    align-items: center;
    gap: 10px;
    &-logo {
      width: max(7.6rem, 45px);
    }
    &-link {
      display: flex;
    }
  }
  &__partners {
    font-weight: 700;
    display: flex;
    align-items: center;
    gap: max(3.7rem, 10px);
    flex-wrap: wrap;
    @media screen and (max-width: vars.$bp-sm) {
      flex-direction: column;
      align-items: flex-start;
    }

    &-list {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    &-image {
      width: 56px;
      &:first-child {
        filter: brightness(7.5);
      }
    }
  }
  &__banner {
    position: absolute;
    inset: 0;
    &::after {
      content: '';
      position: absolute;
      inset: 0;
      background-color: rgba(0, 0, 0, 0.6);
    }
  }
  &__title {
    font-size: max(5.4rem, 44px);
    line-height: 100%;
    letter-spacing: -1.76px;
    text-transform: uppercase;
    font-weight: 500;
  }
}
</style>

<template>
  <div class="error">
    <LayoutHeader />
    <LayoutMenu />
    <div class="error__container">
      <div class="error__content">
        <h1 class="error__title">404</h1>
        <h2 class="error__subtitle">
          {{ $t('error.subtitle') }}
        </h2>
        <p class="error__text">
          {{ $t('error.text') }}
        </p>
      </div>
      <footer class="error__footer">
        <p>
          {{
            $t('footer.copyright', {
              year: new Date().getFullYear()
            })
          }}
        </p>
        <nav class="error__footer-nav">
          <NuxtLink
            v-for="(link, i) in useMapRt('footer.links')"
            :key="i"
            :to="`/${link.split(' ').join('-').toLowerCase()}`"
          >
            {{ link }}
          </NuxtLink>
        </nav>
        <SvgSpacelabs class="error__footer-logo" />
      </footer>
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  layout: false
});
</script>

<style lang="scss" scoped>
.error {
  background: #1d1d1d;
  color: var(--white, #fff);
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  &__footer {
    gap: 16.6rem;
    display: flex;
    font-family: Helvetica;
    font-size: max(1.4rem, 12px);
    font-weight: 400;
    flex-wrap: wrap;
    padding-bottom: 30px;
    p {
      line-height: 1.6;
    }
    @media screen and (max-width: vars.$bp-xl) {
      gap: 8rem;
    }
    @media screen and (max-width: vars.$bp-md) {
      gap: max(4rem, 20px);
    }
    @media screen and (max-width: vars.$bp-sm) {
      flex-direction: column;
    }
    &-nav {
      display: flex;
      gap: max(2.7rem, 10px);
      & > * {
        text-decoration: underline;
      }
    }
    &-logo {
      width: 100px;
      @media screen and (min-width: vars.$bp-sm) {
        margin-left: auto;
      }
    }
  }
  &__container {
    flex: 1;
    display: flex;
    flex-direction: column;
    padding-inline: var(--spacing-inline);
  }
  &__content {
    margin-block: auto;
    padding-bottom: 10%;
    align-self: center;
    display: flex;
    flex-direction: column;
    gap: 12px;
    @media screen and (min-width: vars.$bp-md) {
      max-width: 54%;
    }
  }
  &__text {
    font-size: max(1.8rem, 14px);
    font-weight: 400;
    letter-spacing: -0.72px;
  }
  &__subtitle {
    font-size: max(5.6rem, 30px);
    font-weight: 400;
    line-height: 101%;
    letter-spacing: -2.24px;
  }
  &__title {
    color: #d9d9d9;
    font-size: max(19.7rem, 140px);
    font-weight: 400;
    line-height: 90%;
    letter-spacing: -7.88px;
  }
}
</style>

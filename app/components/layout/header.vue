<template>
  <header class="header">
    <SvgLogo class="header__logo" />
    <nav class="header__nav">
      <NuxtLink
        v-for="link in links"
        :key="link.to"
        :to="$localePath(link.to)"
        class="header__nav-link"
      >
        <span>{{ link.label }}</span>
      </NuxtLink>
    </nav>
    <div class="header__right">
      <div class="header__lang">
        <button class="header__lang-button">
          <span>{{ $i18n.locale }}</span>
        </button>
      </div>
      <NuxtLink class="header__button" :to="$localePath('/project')">
        <span>{{ $t('project') }}</span>
      </NuxtLink>
    </div>
    <button class="header__opener">
      <span>{{ $t('menu') }}</span>
    </button>
  </header>
</template>

<script setup>
const { tm, rt } = useI18n();

const links = computed(() =>
  tm('header.links').map(el => ({
    label: rt(el),
    to: `/${rt(el).split(' ').join('-').toLowerCase()}`
  }))
);
</script>

<style lang="scss" scoped>
.header {
  font-size: max(1.6rem, 14px);
  font-weight: 900;
  padding-inline: var(--spacing-inline);
  padding-top: 4.2rem;
  position: relative;
  display: grid;
  grid-template-columns: 1fr 4fr 1fr;
  align-items: center;
  justify-items: center;
  // position: fixed;
  // inset-inline: 0;
  // z-index: 100;
  @media screen and (max-width: vars.$bp-md) {
    grid-template-columns: max-content max-content;
    justify-content: space-between;
  }
  &__opener {
    @include mix.flex-center;
    border-radius: 5rem;
    background-color: #fff;
    color: #111;
    width: 70px;
    height: 30px;
    span {
      margin-bottom: 0.2em;
    }
    @media screen and (min-width: vars.$bp-md) {
      display: none;
    }
  }
  &__button {
    transition:
      background 0.3s,
      color 0.3s;
    background-color: #fff;
    color: #111;
    border-radius: max(5rem, 40px);
    width: max(11.4rem, 70px);
    @include mix.flex-center;
    &:hover {
      background-color: #111;
      color: #fff;
    }
    span {
      margin-bottom: 0.3em;
    }
  }
  &__right {
    display: flex;
    gap: 2rem;
    @media screen and (max-width: vars.$bp-md) {
      display: none;
    }
  }
  &__lang {
    &-button {
      @include mix.flex-center;
      border: 1px solid #fff;
      border-radius: 50%;
      width: max(4.1rem, 30px);
      height: max(4.1rem, 30px);
      transition:
        background 0.3s,
        color 0.3s;
      &:hover {
        background-color: #fff;
        color: #111;
      }
      span {
        margin-bottom: 0.3em;
      }
    }
  }
  &__nav {
    display: flex;
    align-items: center;
    gap: 4.3rem;
    @media screen and (max-width: vars.$bp-md) {
      display: none;
    }

    // &-link {
    // }
    // @media screen and (min-width: 1100px) {
    //   position: absolute;
    //   top: 70%;
    //   left: 50%;
    //   translate: -50% -50%;
    // }
  }
  &__logo {
    width: 106px;
    fill: none;
  }
}
</style>

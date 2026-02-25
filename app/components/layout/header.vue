<template>
  <header class="header" :class="{ 'menu-shown': showMenu }">
    <NuxtLink :to="$localePath('/home')">
      <SvgLogo class="header__logo" />
    </NuxtLink>
    <nav class="header__nav">
      <NuxtLink
        v-for="link in links"
        :key="link.to"
        :to="$localePath(link.to)"
        active-class="active"
        class="header__nav-link"
        :class="{ active: $route.name.includes(link.label.toLowerCase()) }"
      >
        <span>{{ link.label }}</span>
      </NuxtLink>
    </nav>
    <div class="header__right">
      <div class="header__lang">
        <button class="header__lang-button" @click="showLangDropdown = !showLangDropdown">
          <span>{{ $i18n.locale }}</span>
        </button>
        <div class="header__lang-dropdown" :class="{ hidden: !showLangDropdown }">
          <button
            v-for="code in availableLocales.filter(el => el !== $i18n.locale)"
            :key="code"
            class="header__lang-label"
            @click="changeLang(code)"
          >
            <span>{{ code }}</span>
          </button>
        </div>
      </div>
      <NuxtLink class="header__button" :to="$localePath('/')">
        <span>{{ $t('project') }}</span>
      </NuxtLink>
      <button class="header__opener" @click="showMenu = !showMenu">
        <span v-if="!showMenu">{{ $t('menu') }}</span>
        <span v-else>{{ $t('close') }}</span>
      </button>
    </div>
  </header>
</template>

<script setup>
const { availableLocales, setLocale } = useI18n();

const paths = ['/home', '/about', '/for-investors', '/faq', '/news', '/contacts'];

const links = computed(() =>
  useMapRt('header.links').map((el, i) => ({
    label: el,
    to: paths[i]
  }))
);

const showLangDropdown = ref(false);
const showMenu = useState('showMenu');

const changeLang = code => {
  setLocale(code);
  showLangDropdown.value = false;
};

onMounted(() => {
  document.addEventListener('click', e => {
    if (e.target.closest('.header__lang')) return;
    showLangDropdown.value = false;
  });
});
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
  position: sticky;
  top: 0;
  z-index: 20;
  backdrop-filter: blur(5px);
  background-color: rgba(#1d1d1d, 0.3);
  padding-bottom: 26px;
  // position: fixed;
  // inset-inline: 0;
  @media screen and (max-width: vars.$bp-lg) {
    grid-template-columns: max-content max-content;
    justify-content: space-between;
  }
  transition: background-color 0.5s;
  &.menu-shown {
    background-color: #cf2025;
  }
  &__opener {
    @include mix.flex-center;
    border-radius: 50px;
    background-color: #fff;
    color: #111;
    width: 70px;
    height: 30px;
    span {
      margin-bottom: 0.2em;
    }
    @media screen and (min-width: vars.$bp-lg) {
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
    text-transform: lowercase;
    @include mix.flex-center;
    &:hover {
      background-color: #111;
      color: #fff;
    }
    span {
      margin-bottom: 0.3em;
    }
    @media screen and (max-width: vars.$bp-lg) {
      display: none;
    }
  }
  &__right {
    display: flex;
    gap: max(2rem, 10px);
  }
  &__lang {
    position: relative;
    &-dropdown {
      $br: 50px;
      position: absolute;
      width: 100%;
      top: 100%;
      left: 0;
      border-radius: $br;
      border-bottom: 1px solid #fff;
      display: flex;
      flex-direction: column;
      z-index: 5;
      padding-bottom: 0.6rem;
      transition: 0.4s;
      &.hidden {
        opacity: 0;
        pointer-events: none;
        translate: 0 -10px;
      }
      &::after {
        content: '';
        position: absolute;
        inset-inline: 0;
        top: -18%;
        height: 20%;
        border-inline: 1px solid #fff;
        pointer-events: none;
      }
      &::before {
        content: '';
        position: absolute;
        inset: 0;
        border-inline: 1px solid #fff;
        border-bottom-left-radius: $br;
        border-bottom-right-radius: $br;
        pointer-events: none;
      }
      & > * {
        @include mix.flex-center;
        padding-block: 4px;
        transition: color 0.3s;
        &:hover {
          color: #fc0;
        }
        span {
          margin-bottom: 0.3em;
        }
      }
    }
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
    @media screen and (max-width: vars.$bp-lg) {
      display: none;
    }

    &-link {
      transition: color 0.3s;
      &.active {
        color: #fc0;
      }
    }
  }
  &__logo {
    width: 106px;
    fill: none;
  }
}
</style>

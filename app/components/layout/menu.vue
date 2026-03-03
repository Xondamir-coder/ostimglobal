<template>
  <Transition name="appear">
    <div v-if="showMenu" class="menu">
      <UiPicture src="ball-menu.png" alt="ball" class="menu__ball" />
      <nav class="menu__nav">
        <NuxtLink
          :to="$localePath('/')"
          class="menu__nav-link"
          active-class="active"
          @click="showMenu = !showMenu"
        >
          <span>{{ $t('project')[0].toUpperCase() + $t('project').slice(1) }}</span>
        </NuxtLink>
        <NuxtLink
          v-for="link in links"
          :key="link.to"
          :to="$localePath(link.to)"
          class="menu__nav-link"
          active-class="active"
          @click="showMenu = !showMenu"
        >
          <span>{{ link.label }}</span>
        </NuxtLink>
      </nav>
      <div class="menu__bottom">
        <span>{{ $t('call-us') }}</span>
        <p>{{ $t('day-times') }}</p>
        <a href="tel:+998 77 124 10 10" class="menu__bottom-call">77 124 10 10</a>
      </div>
    </div>
  </Transition>
</template>

<script setup>
const linkTos = ['/home', '/about', '/for-investors', '/faq', '/news', '/contacts', '/'];

const links = computed(() =>
  useMapRt('header.links')?.map((el, i) => ({
    label: el,
    to: linkTos[i]
  }))
);

const showMenu = useState('showMenu', () => false);
</script>

<style lang="scss" scoped>
.menu {
  position: fixed;
  z-index: 20;
  inset: 0;
  margin-top: 110px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding-inline: 29px;
  padding-bottom: 34px;
  background-color: #cf2025;
  color: #fff;
  &__ball {
    position: absolute;
    right: 0;
    bottom: 0;
    width: 43% !important;
    pointer-events: none;
  }
  &__bottom {
    display: flex;
    flex-direction: column;
    font-size: 16px;
    gap: 4px;
    animation: slide-from-bottom-20 0.5s backwards 0.4s + (0.1 * 2);
    span {
      font-weight: 700;
    }
    p {
      color: #cacaca;
    }
    &-call {
      font-size: 36px;
      letter-spacing: -1.44px;
    }
  }
  &__nav {
    display: flex;
    flex-direction: column;
    &-link {
      font-size: 28px;
      line-height: 170%;
      letter-spacing: -1.12px;
      animation: slide-from-left-20 0.5s backwards;
      @for $i from 1 through 10 {
        &:nth-child(#{$i}) {
          animation-delay: $i * 0.1s;
        }
      }
      &.active {
        font-weight: 700;
      }
    }
  }
}
.appear-enter-active,
.appear-leave-active {
  transition: opacity 0.5s;
}
.appear-enter-from,
.appear-leave-to {
  opacity: 0;
}
</style>

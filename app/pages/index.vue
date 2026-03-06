<template>
  <div class="project">
    <UiPreloader />
    <LayoutHeader class="project__header" />
    <LayoutMenu />
    <UiOverlayMap ref="mapOverlay" />
    <UiMasterplanFilter @click-path="handleClick" />
    <button class="project__hangar" @click="showHangarModal = true">
      <span>{{ $t('about-hangars') }}</span>
      <span>{{ $t('hangars') }}</span>
      <div class="project__hangar-iconbox">
        <IconsPlus class="project__hangar-icon" />
      </div>
    </button>
    <button class="project__back" :class="{ hidden: !route.query?.zone }" @click="handleBack">
      <div class="project__back-iconbox">
        <IconsLongArrowLeft class="project__back-icon" />
        <IconsLongArrowLeft class="project__back-icon" />
      </div>
      <span>{{ $t('back') }}</span>
    </button>
    <UiSocialModal />
    <UiHangarModal />
    <UiFormPopup />
  </div>
</template>

<script setup>
const route = useRoute();

const showHangarModal = useState('showHangarModal', () => false);
useState('showSocialModal', () => false);

const mapOverlay = ref();

const handleBack = () => {
  if (route.query?.hangar) {
    replacePath({
      zone: 'industrial',
      block: route.query.block
    });
  } else if (route.query?.block) {
    replacePath({
      zone: 'industrial'
    });
  } else if (route.query?.place) {
    replacePath({
      zone: 'social'
    });
  } else {
    replacePath();
  }
};
const handleClick = id => {
  mapOverlay.value.focusZone(id);
};

definePageMeta({
  layout: false
});

usePageSEO('project');
</script>

<style lang="scss" scoped>
.project {
  position: relative;
  overflow: hidden;
  width: 100vw;
  height: 100dvh;
  @media screen and (min-width: vars.$bp-xl) {
    &:has(path:hover) {
      & > *:nth-child(4) > * {
        backdrop-filter: blur(15px) opacity(0.5);
        pointer-events: none;
      }
    }
  }

  &__back {
    position: absolute;
    left: var(--spacing-inline);
    top: max(15.2rem, 104px);
    border: 1px solid rgba(255, 255, 255, 0.15);
    background: rgba(255, 255, 255, 0.05);
    backdrop-filter: blur(15px);
    display: flex;
    align-items: center;
    gap: 5px;
    width: max(13.7rem, 100px);
    height: max(4.4rem, 35px);
    padding-inline: 11px;
    border-radius: 30px;
    transition: all 0.4s;

    &:hover {
      background-color: rgba(255, 255, 255, 0.25);
      .project__back-icon:first-child {
        translate: -150%;
        scale: 1 0.25;
        opacity: 0;
      }
      .project__back-icon:last-child {
        translate: 0;
        scale: 1;
        opacity: 1;
      }
    }
    &.hidden {
      opacity: 0;
    }
    @media screen and (max-width: vars.$bp-md) {
      top: 104px;
      left: max(2rem, 20px);
    }
    span {
      margin-inline: auto;
      margin-bottom: 0.2em;
      font-size: max(1.5rem, 14px);
      font-weight: 500;
      color: #fff;
    }
    &-iconbox {
      @include mix.flex-center;
      width: max(2.6rem, 20px);
      height: max(2.6rem, 20px);
      border-radius: 50%;
      background-color: #ffcd01;
      display: grid;
      place-items: center;
      overflow: hidden;
    }
    &-icon {
      grid-area: 1/1/2/2;
      width: 58%;
      transition: all 0.4s;
      &:last-child {
        translate: 150%;
        scale: 1 0.25;
        opacity: 0;
      }
    }
  }
  &__hangar {
    position: absolute;
    right: 2.5rem;
    bottom: 3rem;
    display: flex;
    align-items: center;
    gap: 5px;
    width: max(22.7rem, 70px);
    height: max(5.6rem, 28px);
    border-radius: 30px;
    border: 1px solid rgba(255, 255, 255, 0.15);
    background: rgba(255, 255, 255, 0.05);
    backdrop-filter: blur(15px);
    color: #fff;
    padding-inline: max(0.9rem, 5px);
    @media screen and (max-width: vars.$bp-md) {
      top: 104px;
      right: max(2rem, 20px);
    }
    &:hover .project__hangar-iconbox {
      background-color: #deb201;
      rotate: 90deg;
    }
    span {
      font-size: max(1.6rem, 10px);
      font-weight: 500;
      margin-inline: auto;
      margin-bottom: 0.2em;
      &:last-of-type {
        @media screen and (min-width: vars.$bp-md) {
          display: none;
        }
      }
      &:first-of-type {
        @media screen and (max-width: vars.$bp-md) {
          display: none;
        }
      }
    }
    &-iconbox {
      @include mix.flex-center;
      flex-shrink: 0;
      width: max(3.8rem, 15px);
      height: max(3.8rem, 15px);
      background-color: #ffcc00;
      border-radius: 50%;
      transition: all 0.4s;
    }
    &-icon {
      width: 37%;
      margin-left: 2px;
    }
  }
  &__header {
    position: fixed;
    inset-inline: 0;
    color: #fff;
    background-color: transparent;
    backdrop-filter: none;
    pointer-events: none;
    > * {
      pointer-events: all;
    }
  }
}
</style>

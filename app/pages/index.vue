<template>
  <div class="project">
    <LayoutHeader class="project__header" />
    <UiOverlayMap />
    <UiMasterplanFilter />
    <button class="project__hangar" @click="showHangarModal = true">
      <span>{{ $t('about-hangars') }}</span>
      <span>{{ $t('hangars') }}</span>
      <div class="project__hangar-iconbox">
        <IconsPlus class="project__hangar-icon" />
      </div>
    </button>
    <UiSocialModal />
    <UiHangarModal />
  </div>
</template>

<script setup>
const showHangarModal = useState('showHangarModal', () => false);
useState('showSocialModal', () => false);
useState('selectedZoneID', () => '');
useState('selectedPathID', () => '');
useState('selectedBlockID', () => '');

definePageMeta({
  layout: false
});
</script>

<style lang="scss" scoped>
.project {
  position: relative;
  overflow: hidden;
  width: 100vw;
  height: 100vh;
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
    padding-bottom: 2.6rem;
  }
}
</style>

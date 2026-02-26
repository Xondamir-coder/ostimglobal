<template>
  <div class="project">
    <LayoutHeader class="project__header" />
    <UiOverlayMap :zone="selectedZoneID" />
    <div class="project__action">
      <form class="project__search" @submit.prevent="">
        <button class="project__search-iconbox">
          <IconsSearch class="project__search-icon" />
        </button>
        <input type="text" class="project__search-input" :placeholder="$t('search')" />
      </form>
      <button class="project__button" @click="showActions = !showActions">
        <IconsThreeLines class="project__button-icon" />
      </button>
      <div class="project__items" :class="{ hidden: !showActions }">
        <button
          v-for="(zone, i) in useMapRt('genplan.zones')"
          :key="zone"
          class="project__item"
          :class="{ active: i === selectedZoneID }"
          @click="selectedZoneID = i"
        >
          <span>{{ zone }}</span>
        </button>
      </div>
    </div>
    <button class="project__hangar" @click="showHangarsModal = true">
      <span>{{ $t('about-hangars') }}</span>
      <span>{{ $t('hangars') }}</span>
      <div class="project__hangar-iconbox">
        <IconsPlus class="project__hangar-icon" />
      </div>
    </button>
    <UiHangarModal v-model="showHangarsModal" />
    <UiSocialModal v-model="showSocialModal" />
  </div>
</template>

<script setup>
const showHangarsModal = ref(false);
const showSocialModal = ref(false);
const selectedZoneID = ref(null);
const showActions = ref(true);

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
  &__spotlight {
    position: absolute;
    inset: 0;
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
  &__items {
    position: absolute;
    bottom: 100%;
    left: 0;
    width: calc(100% - max(1.1rem, 8px) - max(6.3rem, 50px));
    display: flex;
    flex-direction: column;
    transition: all 0.4s;
    &.hidden {
      opacity: 0;
      pointer-events: none;
    }
  }
  &__item {
    @include mix.flex-center;
    color: #fff;
    font-size: max(3rem, 20px);
    font-weight: 500;
    letter-spacing: -1.5px;
    border-radius: 15px;
    height: max(7.1rem, 57px);
    transition: all 0.4s;
    border: 1px solid transparent;
    &.active {
      border-color: rgba(255, 255, 255, 0.15);
    }
  }
  &__button {
    @include mix.flex-center;
    flex-shrink: 0;
    width: max(6.3rem, 50px);
    &-icon {
      width: 40%;
      stroke: #fff;
    }
  }
  &__search {
    padding: 5px;
    display: flex;
    &-input {
      width: 100%;
      padding-inline: 10px;
      margin-bottom: 0.2em;
      color: #fff;
      font-size: max(3rem, 20px);
      font-weight: 500;
      letter-spacing: -1.5px;
      &::placeholder {
        opacity: 0.85;
        color: inherit;
        text-align: center;
      }
    }
    &-icon {
      width: 40%;
      fill: #fff;
    }
    &-iconbox {
      @include mix.flex-center;
      flex-shrink: 0;
      width: max(5.8rem, 45px);
      border-radius: 15px;
      border: 1px solid rgba(255, 255, 255, 0.15);
      background: rgba(255, 255, 255, 0.05);
      backdrop-filter: blur(15px);
    }
  }
  &__action {
    width: 100%;
    max-width: max(36rem, 250px);
    height: max(7.1rem, 57px);
    position: absolute;
    bottom: max(2.9rem, 8px);
    left: 50%;
    translate: -50%;
    display: flex;
    gap: max(1.1rem, 8px);
    & > * {
      border-radius: 15px;
      border: 1px solid rgba(255, 255, 255, 0.15);
      background: rgba(255, 255, 255, 0.05);
      backdrop-filter: blur(15px);
    }
  }
  &__header {
    position: fixed;
    inset-inline: 0;
    color: #fff;
    background-color: rgba(0, 0, 0, 0.15);
    backdrop-filter: blur(2px);
    padding-bottom: 2.6rem;
  }
}
</style>

<template>
  <Transition name="slide">
    <div v-if="showHangarModal" class="container" @click.self="showHangarModal = false">
      <div class="modal">
        <div class="modal__top">
          <UiPicture src="hangars.jpg" alt="hangars" class="modal__top-banner" />
          <UiModalCloseButton class="modal__top-button" @click="showHangarModal = false" />
        </div>
        <div class="modal__content">
          <div class="modal__content-header">
            <h2 class="heading-lg modal__content-title">
              {{ $t('hangar.title') }}
            </h2>
            <p>
              {{ $t('hangar.text') }}
            </p>
          </div>
          <div class="modal__content-info">
            <div class="modal__content-info-items">
              <span v-for="item in useMapRt('hangar.info')" :key="item">
                {{ item }}
              </span>
            </div>
            <ul class="modal__content-icons">
              <li v-for="icon in icons" :key="icon" class="modal__content-icon">
                <component :is="icon" class="modal__content-icon-child" />
              </li>
            </ul>
          </div>
          <div class="modal__content-utils">
            <h3 class="modal__content-subtitle">
              {{ $t('hangar.subtitle') }}
            </h3>
            <ul class="modal__content-utils-items">
              <li
                v-for="item in useMapRt('hangar.utils')"
                :key="item"
                class="modal__content-utils-item"
              >
                {{ item }}
              </li>
            </ul>
          </div>
          <UiPicture src="hangar-schema.jpg" alt="schema" class="modal__content-schema" />
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup>
import { IconsBulb, IconsFlame, IconsMagnet, IconsPipe, IconsWifi } from '#components';

const showHangarModal = useState('showHangarModal');

const icons = [IconsFlame, IconsBulb, IconsMagnet, IconsWifi, IconsPipe];
</script>

<style lang="scss" scoped>
.modal {
  width: max(50%, 600px);
  border-radius: 30px;
  border: 1px solid rgba(255, 255, 255, 0.15);
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(15px);
  display: flex;
  flex-direction: column;
  gap: 5px;
  padding: 12px;
  transition: all 1s;
  @media screen and (max-width: vars.$bp-sm) {
    overflow-y: auto;
    display: grid;
    grid-auto-rows: 338px auto;
    max-height: 80vh;
    align-self: flex-end;
    gap: 9px;
  }

  &__top {
    flex: 1;
    border-radius: max(3rem, 20px);
    position: relative;
    overflow: hidden;
    display: flex;
    &-button {
      position: absolute;
      right: 10px;
      top: 16px;
    }
  }
  &__content {
    padding-left: max(4rem, 10px);
    padding-right: 15px;
    padding-top: 15px;
    padding-bottom: 25px;
    border-radius: max(3rem, 20px);
    background: #fff;
    display: grid;
    row-gap: max(4.4rem, 25px);
    column-gap: 4rem;
    grid-auto-columns: 1fr 1.6fr;
    grid-template-areas:
      'header info'
      'utils schema';
    @media screen and (max-width: vars.$bp-sm) {
      grid-template-areas:
        'header'
        'info'
        'schema'
        'utils';
    }
    &-schema {
      grid-area: schema;
      align-self: flex-end;
    }
    &-title {
      font-weight: 500;
      letter-spacing: -2.8px;
    }
    &-subtitle {
      font-weight: 500;
      font-size: 25px;
      letter-spacing: -1.25px;
      line-height: 1.04;
    }
    &-utils {
      grid-area: utils;
      display: flex;
      flex-direction: column;
      gap: 14px;
      &-item {
        font-size: 10px;
      }
      &-items {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
      }
    }
    &-icon {
      @include mix.flex-center;
      border-radius: 50%;
      width: 34px;
      height: 34px;
      background-color: #007a0c;
      &:last-child > * {
        width: 70%;
      }
      &-child {
        width: 50%;
      }
    }
    &-icons {
      display: flex;
      gap: 11px;
    }
    &-info {
      grid-area: info;
      display: flex;
      flex-direction: column;
      gap: 20px;
      @media screen and (min-width: vars.$bp-sm) {
        justify-self: flex-end;
      }
      &-items {
        display: flex;
        flex-direction: column;
        font-size: 20px;
        font-weight: 700;
      }
    }
    &-header {
      grid-area: header;
      display: flex;
      flex-direction: column;
      gap: 22px;
      font-size: 10px;
    }
  }
}
.container {
  position: fixed;
  inset: 0;
  z-index: 50;
  display: flex;
  justify-content: flex-end;
  background-color: rgba(0, 0, 0, 0.6);
}
.slide-enter-active,
.slide-leave-active {
  transition: all 1s;
}
.slide-enter-from,
.slide-leave-to {
  background-color: transparent;
  & > * {
    translate: 100%;
    @media screen and (max-width: vars.$bp-sm) {
      translate: 0 100%;
    }
  }
}
</style>

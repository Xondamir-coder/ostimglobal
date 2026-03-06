<template>
  <Transition name="slide">
    <div v-if="showHangarModal" class="container" @click.self="showHangarModal = false">
      <div class="modal" data-lenis-prevent>
        <div class="modal__top">
          <div class="modal__top-container">
            <button
              v-for="label in ['prev', 'next']"
              :key="label"
              :disabled="
                (label === 'prev' && currentSlide === 1) || (label === 'next' && currentSlide === 3)
              "
              class="modal__top-arrow"
              @click="handleSlide(label)"
            >
              <IconsArrowRight class="modal__top-arrow-icon" />
              <IconsArrowRight class="modal__top-arrow-icon" />
            </button>
            <UiPicture
              v-for="i in 3"
              :key="i"
              :class="{
                current: i === currentSlide,
                next: i > currentSlide,
                prev: i < currentSlide
              }"
              src="hangars.jpg"
              alt="place banner"
              class="modal__top-banner"
            />
          </div>
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

const currentSlide = ref(1);
const isAnimating = ref(false);

const handleSlide = dir => {
  if (isAnimating.value) return;

  if (dir === 'prev' && currentSlide.value > 1) {
    currentSlide.value--;
  } else if (dir === 'next' && currentSlide.value < 3) {
    currentSlide.value++;
  }

  isAnimating.value = true;

  setTimeout(() => {
    isAnimating.value = false;
  }, 700);
};
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
    &-arrow {
      border-radius: 50%;
      position: absolute;
      width: max(4rem, 35px);
      height: max(4rem, 35px);
      border: 1px solid rgba(255, 255, 255, 0.15);
      background: rgba(255, 255, 255, 0.05);
      backdrop-filter: blur(15px);
      z-index: 2;
      top: 50%;
      translate: 0 -50%;
      overflow: hidden;
      display: grid;
      place-items: center;
      transition: background 0.4s;
      &:not(:disabled):hover {
        background: rgba(255, 255, 255, 0.25);
        .modal__top-arrow-icon {
          &:first-child {
            translate: 125%;
            scale: 1 0.25;
            opacity: 0;
          }
          &:last-child {
            translate: 0;
            scale: 1;
            opacity: 1;
          }
        }
      }
      &:disabled {
        opacity: 0.75;
      }
      &:first-of-type {
        left: max(2.1rem, 10px);
        rotate: 180deg;
      }
      &:last-of-type {
        right: max(2.1rem, 10px);
      }
      &-icon {
        grid-area: 1/1/2/2;
        width: 50%;
        fill: #fff;
        transition: all 0.4s;
        &:last-child {
          translate: -125%;
          scale: 1 0.25;
          opacity: 0;
        }
      }
    }
    &-container {
      flex: 1;
      position: relative;
      display: grid;
    }
    &-banner {
      --gap: max(1.4rem, 10px);
      grid-area: 1/1/2/2;
      transition: translate 0.8s;
      &.prev {
        translate: calc(-100% - var(--gap));
      }
      &.next {
        translate: calc(100% + var(--gap));
      }
      &::after {
        content: '';
        position: absolute;
        inset: 0;
        background-color: rgba(0, 0, 0, 0.1);
      }
    }
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

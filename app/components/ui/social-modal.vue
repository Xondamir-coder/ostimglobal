<template>
  <Transition name="slide">
    <div v-if="showSocialModal" class="container" @click.self="closeModal">
      <div class="modal">
        <div class="modal__top">
          <div class="modal__top-container">
            <button
              v-for="label in ['prev', 'next']"
              :key="label"
              :disabled="
                (label === 'prev' && currentSlide === 0) ||
                (label === 'next' && currentSlide === currentPlace?.images.length - 1)
              "
              class="modal__top-arrow"
              @click="handleSlide(label)"
            >
              <IconsArrowRight class="modal__top-arrow-icon" />
              <IconsArrowRight class="modal__top-arrow-icon" />
            </button>
            <UiPicture
              v-for="(image, i) in currentPlace?.images"
              :key="i"
              :class="{
                current: i === currentSlide,
                next: i > currentSlide,
                prev: i < currentSlide
              }"
              :src="image"
              alt="place banner"
              class="modal__top-banner"
            />
          </div>
          <UiModalCloseButton class="modal__top-button" @click="closeModal" />
        </div>
        <div class="modal__content">
          <h2 class="modal__content-title">
            {{ currentPlace.title }}
          </h2>
          <p class="modal__content-text">
            {{ currentPlace.text }}
          </p>
          <ul class="modal__content-list">
            <li v-for="area in currentPlace.areas" :key="area.label" class="modal__content-item">
              <strong>{{ area.label }}</strong>
              <span>{{ area.text }}</span>
            </li>
          </ul>
          <button class="modal__content-button" @click="handleBook">
            <span>{{ $t('book') }}</span>
          </button>
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup>
const showSocialModal = useState('showSocialModal');
const showFormPopup = useState('showFormPopup');

const route = useRoute();

const currentSlide = ref(0);
const isAnimating = ref(false);

const place = computed(() => route.query?.place);
const socialPlaces = computed(() => useMapRt('genplan.social-places'));
const currentPlace = computed(() => socialPlaces.value.find(el => el.id === place.value));

const closeModal = () => {
  showSocialModal.value = false;
  currentSlide.value = 0;
};
const handleSlide = dir => {
  if (isAnimating.value) return;

  if (dir === 'prev' && currentSlide.value > 0) {
    currentSlide.value--;
  } else if (dir === 'next' && currentSlide.value < currentPlace.value?.images.length) {
    currentSlide.value++;
  }

  isAnimating.value = true;

  setTimeout(() => {
    isAnimating.value = false;
  }, 700);
};
const handleBook = () => {
  showSocialModal.value = false;
  showFormPopup.value = true;
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
  padding: 12px;
  padding-bottom: 20px;
  align-self: flex-end;
  gap: 30px;
  margin: max(1rem, 5px);
  transition: all 0.7s;
  @media screen and (max-width: vars.$bp-sm) {
    margin: 0;
  }
  &__content {
    padding-left: calc(max(4.6rem, 24px) - 12px);
    font-size: max(2rem, 12px);
    color: #fff;
    display: grid;
    justify-content: space-between;
    grid-auto-columns: 0.7fr max-content max-content;
    grid-template-areas:
      'title title title'
      'text list button';
    row-gap: 20px;
    @media screen and (max-width: vars.$bp-sm) {
      padding-right: calc(51px - 12px);
      grid-auto-columns: 0.9fr max-content;
      grid-template-areas:
        'title title'
        'text list'
        'button button';
    }
    &-button {
      @include mix.flex-center;
      align-self: flex-end;
      grid-area: button;
      width: 143px;
      height: 41px;
      border-radius: 30px;
      background: #fff;
      font-size: 16px;
      font-weight: 900;
      position: relative;
      overflow: hidden;
      transition:
        color 0.4s,
        scale 0.4s;
      &:hover {
        color: #34c759;
        scale: 1.02;
        &::before {
          transform: translate3d(100%, 0, 0);
        }
      }
      @media screen and (max-width: vars.$bp-sm) {
        place-self: center;
      }
      &::before {
        content: '';
        background: #34c759;
        width: 120%;
        height: 100%;
        transform: skew(30deg);
        transition: transform 0.4s cubic-bezier(0.3, 1, 0.8, 1);
        position: absolute;
        top: 0;
        left: -10%;
      }
      span {
        margin-bottom: 0.25em;
        z-index: 1;
      }
    }
    &-text {
      padding-bottom: 3rem;
      grid-area: text;
    }
    &-item {
      display: flex;
      flex-direction: column;
    }
    &-list {
      padding-bottom: 3rem;
      grid-area: list;
      display: flex;
      flex-direction: column;
    }
    &-title {
      grid-area: title;
      line-height: 1;
      font-size: max(5rem, 36px);
      font-weight: 500;
    }
  }
  &__top {
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
      aspect-ratio: 68.6/36.1;
      transition: translate 0.8s;
      &.prev {
        translate: calc(-100% - var(--gap));
      }
      &.next {
        translate: calc(100% + var(--gap));
      }
      @media screen and (max-width: vars.$bp-sm) {
        aspect-ratio: 35.1/19.7;
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
}
.container {
  position: fixed;
  inset: 0;
  z-index: 20;
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

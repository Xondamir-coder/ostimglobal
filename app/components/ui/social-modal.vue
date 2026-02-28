<template>
  <Transition name="slide">
    <div v-if="showSocialModal" class="container" @click.self="showSocialModal = false">
      <div class="modal">
        <div class="modal__top">
          <UiPicture
            :src="`${currentPlace.id}.jpg`"
            alt="sports complex"
            class="modal__top-banner"
          />
          <UiModalCloseButton class="modal__top-button" @click="showSocialModal = false" />
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
          <button class="modal__content-button">
            <span>{{ $t('book') }}</span>
          </button>
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup>
const showSocialModal = useState('showSocialModal');
const selectedPathID = useState('selectedPathID');

const socialPlaces = computed(() => useMapRt('genplan.social-places'));
const currentPlace = computed(() => socialPlaces.value.find(el => el.id === selectedPathID.value));
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
      background: #34c759;
      font-size: 16px;
      font-weight: 900;
      transition: all 0.4s;
      @media screen and (max-width: vars.$bp-sm) {
        place-self: center;
      }
      &:hover {
        opacity: 0.6;
      }
      span {
        margin-bottom: 0.25em;
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
    &-banner {
      aspect-ratio: 68.6/36.1;
      @media screen and (max-width: vars.$bp-sm) {
        aspect-ratio: 35.1/19.7;
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

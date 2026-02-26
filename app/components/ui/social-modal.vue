<template>
  <Transition name="slide">
    <div v-if="model" class="container" @click.self="model = false">
      <div class="modal">
        <div class="modal__top">
          <UiPicture src="sport.jpg" alt="sports complex" class="modal__top-banner" />
          <UiModalCloseButton class="modal__top-button" @click="model = false" />
        </div>
        <div class="modal__content">
          <h2 class="modal__content-title">Sport complex</h2>
          <p class="modal__content-text">
            The Sport Complex serves as a modern multi-functional facility designed. Dynamic working
            environment within the OSTIM Global zone.
          </p>
          <ul class="modal__content-list">
            <li v-for="item in items" :key="item.label" class="modal__content-item">
              <strong>{{ item.label }}</strong>
              <span>{{ item.text }}</span>
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
const items = [
  {
    label: 'Area:',
    text: '5000 m2'
  },
  {
    label: 'Capacity:',
    text: '1000 people'
  },
  {
    label: 'Location:',
    text: 'Tashkent'
  }
];
const model = defineModel({
  type: Boolean
});
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
  transition: all 1s;
  align-self: flex-end;
  gap: 30px;
  margin: max(1rem, 5px);
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
      @media screen and (max-width: vars.$bp-sm) {
        place-self: center;
      }
      span {
        margin-bottom: 0.25em;
      }
    }
    &-text {
      grid-area: text;
    }
    &-item {
      display: flex;
      flex-direction: column;
    }
    &-list {
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

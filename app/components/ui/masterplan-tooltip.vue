<template>
  <div class="tooltip" :class="{ hidden: !hangar }">
    <div class="tooltip__box">
      <Transition name="fade">
        <span :key="hangar" class="tooltip__title">
          {{ hangar }}
        </span>
      </Transition>
    </div>
    <button class="tooltip__button">
      <span>{{ $t('book') }}</span>
    </button>
  </div>
</template>

<script setup>
const route = useRoute();
const hangar = computed(() => route.query?.hangar);
</script>

<style lang="scss" scoped>
.tooltip {
  position: absolute;
  display: flex;
  flex-direction: column;
  left: 50%;
  top: 50%;
  display: flex;
  width: 241px;
  padding-inline: 49px;
  padding-top: 20px;
  padding-bottom: 15px;
  flex-direction: column;
  justify-content: flex-end;
  align-items: center;
  gap: 23px;
  border-radius: 30px;
  border: 1px solid rgba(255, 255, 255, 0.15);
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(15px);
  transition: all 0.4s;
  &__box {
    display: grid;
    & > * {
      grid-area: 1/1/2/2;
    }
  }
  &.hidden {
    translate: 0 15px;
    opacity: 0;
  }
  &__title {
    color: #fff;
    font-size: max(3.6rem, 24px);
    font-style: normal;
    font-weight: 500;
    letter-spacing: -1.8px;
  }
  &__button {
    @include mix.flex-center;
    width: 143px;
    height: 32px;
    border-radius: 30px;
    background: #34c759;
    span {
      font-weight: 900;
      font-size: 16px;
      color: #fff;
      margin-bottom: 0.2em;
    }
  }
}
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s;
}
.fade-leave-to,
.fade-enter-from {
  opacity: 0;
}
</style>

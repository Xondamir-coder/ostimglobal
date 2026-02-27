<template>
  <div class="filter">
    <form class="filter__search" @submit.prevent="">
      <button class="filter__search-iconbox">
        <IconsSearch class="filter__search-icon" />
      </button>
      <input type="text" class="filter__search-input" :placeholder="$t('search')" />
    </form>
    <button class="filter__button" @click="showContainer = !showContainer">
      <IconsThreeLines class="filter__button-icon" />
    </button>
    <div class="filter__container" :class="{ hidden: !showContainer }">
      <!-- Show zones -->
      <div v-if="selectedZoneID < 0" class="filter__items">
        <button
          v-for="(zone, i) in useMapRt('genplan.zones')"
          :key="zone"
          class="filter__item"
          :class="{ active: i === selectedZoneID }"
          @click="selectedZoneID = i"
        >
          <span>{{ zone }}</span>
        </button>
      </div>

      <!-- Show social places -->
      <div v-if="selectedZoneID === 1" class="filter__items">
        <button
          v-for="place in socialPlaces"
          :key="place.id"
          class="filter__item"
          :class="{ active: place.id === selectedSocialID }"
          @click="selectSocial(place.id)"
        >
          <span>{{ place.title }}</span>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  socialPlaces: {
    required: true,
    type: Array
  }
});

const showContainer = ref(true);
const selectedZoneID = useState('selectedZoneID');
const selectedSocialID = useState('selectedSocialID');
const showSocialModal = useState('showSocialModal');

const selectSocial = id => {
  selectedSocialID.value = id;
  showSocialModal.value = true;
};
</script>

<style lang="scss" scoped>
.filter {
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
  &__container {
    position: absolute;
    overflow: hidden;
    bottom: 100%;
    left: 0;
    width: calc(100% - max(1.1rem, 8px) - max(6.3rem, 50px));
    transition: all 0.4s;

    &.hidden {
      opacity: 0;
      pointer-events: none;
    }
  }
  &__items {
    display: flex;
    flex-direction: column;
    max-height: calc(max(7.1rem, 57px) * 3);
    overflow-y: auto;
    scrollbar-width: thin;
    scrollbar-color: rgba(255, 255, 255, 0.9) rgba(255, 255, 255, 0.15);
    scroll-snap-type: y mandatory;
    &::-webkit-scrollbar {
      width: 8px;
    }
    &::-webkit-scrollbar-track {
      background: rgba(255, 255, 255, 0.15);
      border-radius: 999px;
    }
    &::-webkit-scrollbar-thumb {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 999px;
      min-height: 40px;
    }
  }

  &__item {
    @include mix.flex-center;
    scroll-snap-align: start;
    flex-shrink: 0;
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
}
</style>

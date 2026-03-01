<template>
  <div class="filter">
    <form class="filter__search" @submit.prevent="">
      <button class="filter__search-iconbox">
        <IconsSearch class="filter__search-icon" />
      </button>
      <input v-model="query" type="text" class="filter__search-input" :placeholder="$t('search')" />
    </form>
    <button class="filter__button" @click="showContainer = !showContainer">
      <IconsThreeLines class="filter__button-icon" />
    </button>
    <div ref="containerRef" class="filter__container" :class="{ hidden: !showContainer }">
      <!-- Show search results -->
      <div v-if="query && searchResults.length" class="filter__items" data-lenis-prevent>
        <button
          v-for="result in searchResults"
          :key="result.id"
          class="filter__item"
          @click="selectResult(result)"
        >
          <span>{{ result.id }}</span>
        </button>
      </div>

      <!-- Show no answer if no results -->
      <div v-else-if="query && !searchResults.length" class="filter__items" data-lenis-prevent>
        <button class="filter__item">
          <span>no result</span>
        </button>
      </div>

      <!-- Show zones -->
      <div v-else-if="!selectedZoneID" class="filter__items" data-lenis-prevent>
        <button
          v-for="zone in zones"
          :key="zone.id"
          class="filter__item"
          :class="{ active: selectedZoneID === zone.id }"
          @click="replacePath({ zone: zone.id })"
        >
          <span>{{ zone.label }}</span>
        </button>
      </div>

      <!-- Show social zone labels -->
      <div v-else-if="selectedZoneID === 'social'" class="filter__items" data-lenis-prevent>
        <button
          v-for="place in socialPlaces"
          :key="place.id"
          class="filter__item"
          :class="{ active: place.id === selectedPlaceID }"
          @click="selectSocial(place.id)"
        >
          <span>{{ place.title }}</span>
        </button>
      </div>

      <!-- Show industrial zone blocks -->
      <div v-else-if="selectedZoneID === 'industrial'" class="filter__items" data-lenis-prevent>
        <button
          v-for="block in industrialBlocks"
          :key="block.id"
          class="filter__item"
          :class="{ active: block.id === selectedBlockID }"
          @click="selectBlock(block.id)"
        >
          <span>{{ block.id }}</span>
        </button>
      </div>

      <!-- Show industrial zone hangars -->
      <div v-else class="filter__items" data-lenis-prevent>
        <button
          v-for="hangar in industrialHangars"
          :key="hangar.id"
          class="filter__item"
          :class="{ active: hangar.id === selectedHangarID }"
          @click="selectHangar(hangar)"
        >
          <span>{{ hangar.id }}</span>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
const route = useRoute();

const zonesID = ['industrial', 'social'];
const searchItems = genplanData.filter(el => el.zone.includes('industrial'));

const zones = computed(() =>
  useMapRt('genplan.zones')?.map((el, i) => ({
    label: el,
    id: zonesID[i]
  }))
);
const socialPlaces = computed(() => useMapRt('genplan.social-places'));
const industrialBlocks = genplanData
  .filter(el => el.zone === 'industrial' && !el.block)
  .sort((a, b) => a.id.localeCompare(b.id, undefined, { numeric: true }));
const industrialHangars = computed(() =>
  genplanData
    .filter(el => el.zone === 'industrial-hangars' && el.block === route.query?.block)
    .sort((a, b) => a.id.localeCompare(b.id, undefined, { numeric: true }))
);
const searchResults = computed(() =>
  searchItems
    .filter(s => s.id.includes(query.value.toUpperCase()))
    .sort((a, b) => a.id.localeCompare(b.id, undefined, { numeric: true }))
);
const selectedPlaceID = computed(() => route.query?.place);
const selectedHangarID = computed(() => route.query?.hangar);
const selectedZoneID = computed(() => route.query?.zone);
const selectedBlockID = computed(() => route.query?.block);

const containerRef = ref();
const showContainer = ref(true);
const query = ref('');

const showSocialModal = useState('showSocialModal');

const selectResult = res => {
  replacePath({
    zone: res.zone,
    ...(res.block && { block: res.block, hangar: res.id }),
    ...(!res.block && { block: res.id })
  });
};
const selectSocial = id => {
  replacePath({ zone: 'social', place: id });
  showSocialModal.value = true;
};
const selectBlock = id => {
  replacePath({ zone: 'industrial-hangars', block: id });
};
const selectHangar = hangar => {
  replacePath({ zone: 'industrial-hangars', block: hangar.block, hangar: hangar.id });
};

watch(
  [selectedZoneID, selectedBlockID, selectedHangarID, selectedPlaceID],
  () => {
    if (!showContainer.value) return;

    const el = containerRef.value?.querySelector('.filter__item.active');

    el?.scrollIntoView({
      block: 'start',
      inline: 'nearest',
      behavior: 'smooth'
    });
  },
  { flush: 'post' }
);
</script>

<style lang="scss" scoped>
.filter {
  width: 100%;
  max-width: max(36rem, 250px);
  height: max(7.1rem, 57px);
  position: absolute;
  bottom: max(2.9rem, 8px);
  display: flex;
  gap: max(1.1rem, 8px);
  left: max(2.5rem, 25px);

  @media screen and (max-width: vars.$bp-lg) {
    left: 50%;
    translate: -50%;
  }

  & > * {
    transition: all 0.4s;
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

<template>
  <div ref="root" class="overlay">
    <div ref="wrapper" class="overlay__wrapper">
      <div ref="layer" class="overlay__layer" :style="layerStyle">
        <UiPicture src="genplan.jpg" alt="overlay banner" class="overlay__picture" />
        <svg
          class="overlay__container"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 1440 812"
          preserveAspectRatio="xMidYMid slice"
          :class="selectedZoneID"
        >
          <path
            v-for="(item, index) in genplanData"
            :key="index"
            :d="item.path"
            :data-zone="item.zone"
            :data-block="item.block"
            class="overlay__container-path"
            :class="{ active: item.id === selectedPathID || item.id === selectedBlockID }"
            @click="handlePathClick(item)"
          />
        </svg>
        <svg
          v-for="spotlight in spotlights"
          :key="spotlight.id"
          class="overlay__spotlight"
          :class="{ active: selectedZoneID.includes(spotlight.id) }"
          viewBox="0 0 1440 812"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path :d="spotlight.path" fill="black" fill-opacity="0.6" />
        </svg>
      </div>
    </div>
  </div>
</template>

<script setup>
import gsap from 'gsap';

const spotlights = [
  {
    path: 'M1440 812H0V0H1440V812ZM70.5 130L361 691L525 666L626 633L563 494L1010 362.5L1154 509L1311 451L1136.5 309.5L881.5 62L70.5 130Z',
    id: 'industrial'
  },
  {
    path: 'M1440 812H0V0H1440V812ZM562.5 515L670.5 681.5L1145.5 515L1008.5 365.5L562.5 515Z',
    id: 'social'
  }
];

const props = defineProps({
  overscale: { type: Number, default: 1.1 },
  breakpoint: { type: Number, default: 1280 }
});

const selectedPathID = useState('selectedPathID');
const selectedZoneID = useState('selectedZoneID');
const selectedBlockID = useState('selectedBlockID');
const showSocialModal = useState('showSocialModal', () => false);
const showHangarModal = useState('showHangarModal', () => false);

const handlePathClick = item => {
  if (item.zone === 'social') {
    showSocialModal.value = true;
  } else if (item.zone === 'industrial') {
    selectedBlockID.value = item.id;
    selectedZoneID.value = 'industrial-hangars';
  } else {
    selectedBlockID.value = item.block;
    showHangarModal.value = true;
  }
  selectedPathID.value = item.id;
};

/* refs */
const root = ref(null);
const wrapper = ref(null);
const layer = ref(null);

/* constants */
const ASPECT_W = 1440;
const ASPECT_H = 812;

/* reactive state */
const state = reactive({
  vw: 0,
  vh: 0,
  scale: 1,
  scaledWidth: ASPECT_W,
  scaledHeight: ASPECT_H,
  overflowX: 0,
  overflowY: 0,
  desktop: false
});

/* exposed for template binding */
const layerStyle = ref({ width: `${ASPECT_W}px`, height: `${ASPECT_H}px` });

const applyScrollMode = () => {
  if (state.desktop) {
    // desktop: lock page scroll, let overlay manage visual
    document.documentElement.style.overflow = 'hidden';
    document.body.style.overflow = 'hidden';
    if (root.value) {
      root.value.style.overflow = 'hidden';
      root.value.style.touchAction = 'none';
    }
  } else {
    // mobile/tablet: allow overlay to scroll internally
    document.documentElement.style.overflow = '';
    document.body.style.overflow = '';
    if (root.value) {
      root.value.style.overflow = '';
      root.value.style.touchAction = '';
    }
  }
};

/* recalc sizes and mode */
const recalc = () => {
  state.vw = window.innerWidth;
  state.vh = window.innerHeight;
  state.desktop = state.vw >= props.breakpoint;

  // scale to cover and then overscale so both axes overflow
  const scaleX = state.vw / ASPECT_W;
  const scaleY = state.vh / ASPECT_H;
  const baseScale = Math.max(scaleX, scaleY);
  state.scale = baseScale * props.overscale;

  state.scaledWidth = Math.round(ASPECT_W * state.scale);
  state.scaledHeight = Math.round(ASPECT_H * state.scale);

  state.overflowX = Math.max(0, state.scaledWidth - state.vw);
  state.overflowY = Math.max(0, state.scaledHeight - state.vh);

  // set layer style depending on mode
  if (state.desktop) {
    layerStyle.value = {
      position: 'absolute',
      left: '50%',
      top: '50%',
      transform: 'translate(-50%, -50%)',
      width: `${state.scaledWidth}px`,
      height: `${state.scaledHeight}px`
    };
    // reset transform
    if (layer.value) {
      gsap.killTweensOf(layer.value);
      gsap.set(layer.value, { x: 0, y: 0 });
    }
  } else {
    // mobile/tablet: flow content normally inside scrollable wrapper.
    // use margin: 0 auto to center horizontally and allow scroll on both sides.
    layerStyle.value = {
      position: 'relative',
      left: 'auto',
      top: 'auto',
      transform: 'none',
      margin: '0 auto',
      width: `${state.scaledWidth}px`,
      height: `${state.scaledHeight}px`
    };
    // reset any leftover transforms
    if (layer.value) {
      gsap.killTweensOf(layer.value);
      gsap.set(layer.value, { x: 0, y: 0 });
    }
  }

  applyScrollMode();

  // when switching to mobile, center the initial scroll so user can pan both directions
  if (!state.desktop && wrapper.value) {
    // allow layout to update first
    nextTick(() => {
      // give the browser one frame to layout
      requestAnimationFrame(() => {
        try {
          wrapper.value.scrollLeft = Math.round(state.overflowX / 2);
          wrapper.value.scrollTop = Math.round(state.overflowY / 2);
        } catch (err) {
          // ignore if not scrollable yet
          console.log(err);
        }
      });
    });
  }
};

/* parallax handlers (arrow functions) */
const handleParallax = e => {
  if (!state.desktop || !layer.value) return;

  const nx = (e.clientX / state.vw - 0.5) * 2; // -1..1
  const ny = (e.clientY / state.vh - 0.5) * 2; // -1..1

  // move opposite to pointer up to half of overflow
  const targetX = -nx * (state.overflowX / 2);
  const targetY = -ny * (state.overflowY / 2);

  gsap.to(layer.value, {
    x: Math.round(targetX),
    y: Math.round(targetY),
    duration: 0.9,
    ease: 'power3.out',
    overwrite: true
  });
};

const resetParallax = () => {
  if (!layer.value) return;
  gsap.to(layer.value, {
    x: 0,
    y: 0,
    duration: 0.8,
    ease: 'power3.out'
  });
};

/* resize debounce */
let resizeTimer = null;
const onResize = () => {
  clearTimeout(resizeTimer);
  resizeTimer = setTimeout(recalc, 120);
};

/* lifecycle */
onMounted(() => {
  recalc();
  window.addEventListener('resize', onResize, { passive: true });
  window.addEventListener('orientationchange', recalc, { passive: true });

  // global pointermove toggles parallax only on desktop
  window.addEventListener('pointermove', handleParallax);
  window.addEventListener('pointerleave', resetParallax);
  window.addEventListener('blur', resetParallax);
});

onUnmounted(() => {
  window.removeEventListener('resize', onResize);
  window.removeEventListener('orientationchange', recalc);
  window.removeEventListener('pointermove', handleParallax);
  window.removeEventListener('pointerleave', resetParallax);
  window.removeEventListener('blur', resetParallax);
  clearTimeout(resizeTimer);

  // restore page
  document.documentElement.style.overflow = '';
  document.body.style.overflow = '';
  if (root.value) {
    root.value.style.overflow = '';
    root.value.style.touchAction = '';
  }
});
</script>

<style lang="scss" scoped>
.overlay {
  user-select: none;
  position: fixed;
  inset: 0;
  width: 100vw;
  height: 100vh;
  overflow: hidden; // toggled by JS
  z-index: 0;

  &::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 20%;
    background: linear-gradient(180deg, rgba(0, 0, 0, 0) 0%, #000000 100%);
    opacity: 0.8;
    z-index: 10;
    pointer-events: none;
    @media screen and (min-width: 1280px) {
      display: none;
    }
  }
  &__close {
    position: absolute !important;
    right: var(--block-spacing);
    top: calc(var(--header-height) + max(3.2rem, 20px));
    z-index: 60;
  }

  &__wrapper {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    -webkit-overflow-scrolling: touch;

    // mobile/tablet: let the wrapper scroll and keep layer flowable inside
    @media screen and (max-width: 1279px) {
      position: absolute; /* still fills viewport */
      overflow: auto;
      display: block;
      -webkit-overflow-scrolling: touch;
      touch-action: auto;
      scrollbar-width: 0;
      &::-webkit-scrollbar {
        display: none;
      }
    }
  }

  /* layer will receive transform from GSAP on desktop.
     On mobile it becomes a block with margin:auto so wrapper.scrollLeft can center it.
  */
  &__layer {
    position: absolute; /* overwritten inline in mobile mode */
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    will-change: transform;
    pointer-events: auto;
    z-index: 10;

    @media screen and (max-width: 1279px) {
      position: relative;
      left: auto;
      top: auto;
      transform: none;
      margin: 0 auto;
    }
  }
  &__picture {
    &::after {
      content: '';
      position: absolute;
      inset: 0;
      background-color: rgba(0, 0, 0, 0.2);
      pointer-events: none;
    }
  }

  &__spotlight,
  &__picture,
  &__container {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    display: block;
  }
  &__spotlight {
    opacity: 0;
    transition: opacity 0.5s;
    pointer-events: none;
    &.active {
      opacity: 1;
      pointer-events: all;
    }
  }

  /* image must not capture pointer events so SVG remains interactive */
  &__picture {
    object-fit: cover;
    pointer-events: none;
    user-select: none;
  }

  &__container {
    z-index: 20;
    pointer-events: auto;

    &.social > *[data-zone='social'],
    &.industrial > *[data-zone='industrial'],
    &.industrial-hangars > *[data-zone='industrial-hangars'] {
      cursor: pointer;
      pointer-events: auto;
    }
    &-path {
      --fill-opacity: 0.25;
      transition: fill 160ms ease;
      fill: transparent;
      pointer-events: none;
      &:hover,
      &.active {
        fill: rgba(255, 255, 255, var(--fill-opacity));
      }
      &[data-zone='industrial'] {
        --fill-opacity: 0.5;
      }
      &[data-zone='industrial-hangars'] {
        --fill-opacity: 1;
      }
    }
  }
}
</style>

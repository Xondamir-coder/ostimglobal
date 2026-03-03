<template>
  <div
    ref="tooltipRef"
    class="tooltip"
    :class="{ active: hangar }"
    :style="{ top: `${coords.y}px`, left: `${coords.x}px` }"
  >
    <div class="tooltip__box">
      <Transition name="fade">
        <span :key="hangar" class="tooltip__title">
          {{ hangar }}
        </span>
      </Transition>
    </div>
    <button class="tooltip__button" @click="handleBook">
      <span>{{ $t('book') }}</span>
    </button>
  </div>
</template>

<script setup>
const route = useRoute();
const hangar = computed(() => route.query?.hangar);

const tooltipRef = ref(null);
const showFormPopup = useState('showFormPopup');

const coords = ref({ x: 0, y: 0 });

const GAP = 12;
const VIEWPORT_PADDING = 12;

const handleBook = () => {
  showFormPopup.value = true;
};

const getActivePath = () => {
  return document.querySelector('.overlay__container-path.active[data-block]');
};

const updateCoords = () => {
  const path = getActivePath();
  const popup = tooltipRef.value;
  if (!path || !popup) return;

  // 🔹 1. point in SVG space
  const length = path.getTotalLength();
  const svgPoint = path.getPointAtLength(length / 2);

  // 🔹 2. SVG → screen space
  const ctm = path.getScreenCTM();

  const screenX = svgPoint.x * ctm.a + ctm.e;
  const screenY = svgPoint.y * ctm.d + ctm.f;

  // 🔹 3. measure popup
  const popupRect = popup.getBoundingClientRect();

  const vw = window.innerWidth;
  const vh = window.innerHeight;

  // 🔹 4. preferred position = top-right
  let x = screenX + GAP + popupRect.width * 0.05;
  let y = screenY - popupRect.height - GAP;

  // flip horizontally if needed
  if (x + popupRect.width > vw - VIEWPORT_PADDING) {
    x = screenX - popupRect.width;
  }

  // clamp left
  if (x < VIEWPORT_PADDING) {
    x = VIEWPORT_PADDING;
  }

  // flip vertically if no space above
  if (y < VIEWPORT_PADDING) {
    y = screenY + GAP;
  }

  // clamp bottom
  if (y + popupRect.height > vh - VIEWPORT_PADDING) {
    y = vh - popupRect.height - VIEWPORT_PADDING;
  }

  coords.value = { x, y };
};

let rafId = null;

const startTracking = () => {
  if (rafId) return;

  const loop = () => {
    updateCoords();
    rafId = requestAnimationFrame(loop);
  };

  rafId = requestAnimationFrame(loop);
};

const stopTracking = () => {
  cancelAnimationFrame(rafId);
  rafId = null;
};

watch(hangar, async val => {
  await nextTick();

  if (val) {
    updateCoords();
    startTracking();
  } else {
    stopTracking();
  }
});

onMounted(() => {
  if (hangar.value) {
    updateCoords();
    startTracking();
  }

  window.addEventListener('resize', updateCoords);
  window.addEventListener('scroll', updateCoords, true);
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', updateCoords);
  window.removeEventListener('scroll', updateCoords, true);
});
</script>

<style lang="scss" scoped>
.tooltip {
  position: absolute;
  top: 0;
  left: 0;

  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 23px;

  width: max(24.1rem, 241px);
  padding: max(2rem, 20px) max(4.9rem, 49px) max(1.5rem, 15px);

  border-radius: 30px;
  border: 1px solid rgba(255, 255, 255, 0.15);
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(15px);

  transition:
    opacity 0.3s,
    transform 0.3s;

  opacity: 0;
  pointer-events: none;
  transform: translateY(15px);

  z-index: 30;

  &.active {
    opacity: 1;
    pointer-events: auto;
    transform: translateY(0);
  }

  &__box {
    display: grid;

    & > * {
      grid-area: 1 / 1 / 2 / 2;
    }

    color: #fff;
    font-size: max(3.6rem, 24px);
    font-weight: 500;
    letter-spacing: -1.8px;
  }

  &__button {
    @include mix.flex-center;
    width: max(14.3rem, 143px);
    height: max(3.2rem, 32px);
    border-radius: 30px;
    background: #fff;
    position: relative;
    overflow: hidden;
    transition: scale 0.4s;
    &:hover {
      scale: 1.02;
      &::before {
        transform: translate3d(100%, 0, 0);
      }
      span {
        color: #34c759;
      }
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
      z-index: 2;
      font-weight: 900;
      font-size: max(1.6rem, 16px);
      color: #fff;
      margin-bottom: 0.2em;
      transition: color 0.4s;
    }
  }
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>

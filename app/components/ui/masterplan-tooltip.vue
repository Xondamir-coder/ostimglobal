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
const { query } = useClientRoute();

const hangar = computed(() => query.value.hangar);

const tooltipRef = ref(null);
const showFormPopup = useState('showFormPopup');

const coords = ref({ x: 0, y: 0 });

const handleBook = () => {
  showFormPopup.value = true;
};

const clampTooltipToViewport = () => {
  const tooltip = tooltipRef.value;
  if (!tooltip) return;

  const rect = tooltip.getBoundingClientRect();

  let dx = 0;
  let dy = 0;

  if (rect.right > window.innerWidth) {
    dx = window.innerWidth - rect.right - 12;
  }

  if (rect.left < 0) {
    dx = -rect.left + 12;
  }

  if (rect.top < 0) {
    dy = -rect.top + 12;
  }

  if (rect.bottom > window.innerHeight) {
    dy = window.innerHeight - rect.bottom - 12;
  }

  coords.value.x += dx;
  coords.value.y += dy;
};
const updateTooltipPosition = async () => {
  const path = document.querySelector(`.overlay__container-path.active#${hangar.value}`);

  const layer = document.querySelector('.overlay__layer');

  if (!path || !layer || !tooltipRef.value) return;

  const pathRect = path.getBoundingClientRect();
  const layerRect = layer.getBoundingClientRect();

  const offsetX = pathRect.right - layerRect.left;
  const offsetY = pathRect.top - layerRect.top;

  coords.value = {
    x: offsetX,
    y: offsetY - tooltipRef.value.offsetHeight
  };

  await nextTick();
  clampTooltipToViewport();
};

watch(hangar, updateTooltipPosition);

onMounted(async () => {
  await nextTick();

  requestAnimationFrame(() => {
    updateTooltipPosition();
  });

  window.addEventListener('resize', updateTooltipPosition);
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
    transform 0.3s,
    backdrop-filter 0.3s;

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
    background: #34c759;
    color: #fff;
    position: relative;
    overflow: hidden;
    transition:
      scale 0.4s,
      background 0.4s,
      color 0.4s;
    &:hover {
      scale: 1.02;
      background-color: #fff;
      color: #34c759;
    }

    span {
      z-index: 2;
      font-weight: 500;
      font-size: max(1.4rem, 14px);
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

<template>
  <main class="faq">
    <section class="faq__header">
      <h2 class="heading-lg">
        {{ $t('faq.hero.title') }}
      </h2>
      <p>
        {{ $t('faq.hero.text') }}
      </p>
    </section>
    <section class="faq__container">
      <ul class="accordions">
        <li
          v-for="(accordion, i) in accordions"
          :key="accordion.question"
          class="accordions__item"
          :class="{ active: i === activeAccordion }"
        >
          <button class="accordions__item-button" @click="toggleAccordion(i)">
            <div class="accordions__item-top">
              <span class="accordions__item-question">
                {{ accordion.question }}
              </span>
              <div class="accordions__item-icon" />
            </div>
            <p class="accordions__item-answer">
              {{ accordion.answer }}
            </p>
          </button>
        </li>
      </ul>
      <button
        v-if="sliceIndex !== allAccordions.length"
        class="faq__button"
        @click="showAllAccordions"
      >
        <span>{{ $t('faq.see-all') }}</span>
        <IconsArrowRight class="faq__button-icon" />
      </button>
    </section>
    <UiSectionCta />
  </main>
</template>

<script setup>
const sliceIndex = ref(5);
const activeAccordion = ref(-1);

const allAccordions = useMapRt('faq.accordions');

const accordions = computed(() => allAccordions.slice(0, sliceIndex.value));

const showAllAccordions = () => {
  sliceIndex.value = allAccordions.length;
};
const hideAnswers = () => {
  document.querySelectorAll('.accordions__item-answer').forEach(el => {
    el.style.height = '';
  });
};
const toggleAccordion = i => {
  activeAccordion.value = i;
  hideAnswers();
  const answerEl = event.target
    .closest('.accordions__item')
    .querySelector('.accordions__item-answer');
  answerEl.style.height = `${answerEl.scrollHeight}px`;
};
const hideAccordions = e => {
  if (e.target.closest('.accordions__item-button')) return;
  activeAccordion.value = -1;
  hideAnswers();
};

onMounted(() => {
  document.addEventListener('click', hideAccordions);
});

onBeforeUnmount(() => {
  document.removeEventListener('click', hideAccordions);
});
</script>

<style lang="scss" scoped>
.accordions {
  display: flex;
  flex-direction: column;
  gap: 16px;
  max-width: max(64%, 600px);
  align-self: center;
  &__item {
    display: flex;
    animation: slide-from-bottom-20 0.5s backwards;
    &.active {
      .accordions__item-button {
        gap: max(2.4rem, 10px);
      }
      .accordions__item-icon::after {
        scale: 0 1;
        rotate: 90deg;
      }
      .accordions__item-icon::before {
        rotate: 90deg;
      }
    }
    &-button {
      gap: 0;
      display: flex;
      flex-direction: column;
      flex: 1;
      padding: 24px;
      border-radius: 16px;
      background: rgba(255, 255, 255, 0.03);
      text-align: start;
      transition: gap 0.6s;
    }
    &-icon {
      position: relative;
      width: 16px;
      height: 16px;

      &::before,
      &::after {
        content: '';
        position: absolute;
        background-color: rgba(255, 255, 255, 0.8);
        transition: all 0.6s;
      }

      /* horizontal line */
      &::after {
        left: 50%;
        top: 50%;
        width: 100%;
        height: 1px;
        translate: -50% -50%;
      }

      /* vertical line */
      &::before {
        left: 50%;
        top: 50%;
        width: 1px;
        height: 100%;
        translate: -50% -50%;
      }
    }
    &-top {
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    &-question {
      font-size: 18px;
      font-weight: 500;
      color: rgba(255, 255, 255, 0.8);
    }
    &-answer {
      color: rgba(255, 255, 255, 0.4);
      font-size: 15px;
      line-height: 158%;
      align-self: flex-start;
      overflow: hidden;
      height: 0;
      transition: all 0.6s;
    }
  }
}
.faq {
  padding-top: max(9.4rem, 30px);
  display: flex;
  flex-direction: column;
  gap: max(10rem, 50px);
  &__button {
    border-radius: 4px;
    background: rgba(255, 255, 255, 0.03);
    align-self: center;
    display: flex;
    padding: 8px 12px 8px 12px;
    gap: 13px;
    font-size: 14px;
    font-weight: 500;
    transition: background 0.3s;
    &:hover {
      background: rgba(255, 255, 255, 0.1);
    }
    &-icon {
      width: 12px;
      fill: #fff;
    }
  }
  &__container {
    display: flex;
    flex-direction: column;
    gap: 24px;
    padding-inline: var(--spacing-inline);
  }
  &__header {
    margin-inline: var(--spacing-inline);
    display: flex;
    align-items: flex-end;
    gap: max(5rem, 20px);
    border-bottom: 2px solid #fff;
    justify-content: space-between;
    padding-bottom: max(6rem, 50px);
    @media screen and (max-width: vars.$bp-lg) {
      flex-direction: column;
      align-items: flex-start;
    }
    h2 {
      flex: 1;
    }
    p {
      flex: 1;
      max-width: 60ch;
    }
  }
}
</style>

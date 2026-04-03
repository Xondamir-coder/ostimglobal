<template>
  <div class="box" :class="{ shown: showDropdown }">
    <button class="box__label" @click="handleDownload">
      <span>{{ $i18n.locale[0].toUpperCase() + $i18n.locale.slice(1) }}</span>
      <svg
        class="box__label-icon"
        viewBox="0 0 25 21"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M11.3125 4.75V14.9238L9.16309 12.7744C8.79697 12.4083 8.20303 12.4083 7.83691 12.7744C7.4708 13.1405 7.4708 13.7345 7.83691 14.1006L10.7031 16.9668C11.5574 17.8209 12.9426 17.8209 13.7969 16.9668L16.6631 14.1006C17.0292 13.7345 17.0292 13.1405 16.6631 12.7744C16.297 12.4083 15.703 12.4083 15.3369 12.7744L13.1875 14.9238V4.75H20C22.7613 4.75012 25 6.98865 25 9.75V16C24.9998 18.7612 22.7612 20.9999 20 21H5C2.2387 21 0.000201007 18.7613 0 16V9.75C0 6.98858 2.23858 4.75 5 4.75H11.3125ZM12.25 0C12.7678 8.42358e-07 13.1875 0.419734 13.1875 0.9375V4.75H11.3125V0.9375C11.3125 0.419733 11.7322 5.96046e-08 12.25 0Z"
          fill="white"
        />
      </svg>
    </button>
    <div class="box__dropdown">
      <a
        v-for="item in items"
        :key="item.label"
        :href="`/${item.link}.pdf`"
        class="box__dropdown-button"
        download
        @click="showDropdown = false"
      >
        {{ item.label[0].toUpperCase() + item.label.slice(1) }}
      </a>
    </div>
  </div>
</template>

<script setup>
const { availableLocales, locale } = useI18n();
const showDropdown = ref(false);

const pdfMap = {
  en: 'Catalog OSTIM Global 2026',
  tr: 'OSTIM Global 2026 Kataloğu',
  ru: 'Каталог OSTIM Global 2026',
  uz: 'OSTIM Global 2026 katalogi'
};
const items = computed(() =>
  availableLocales
    ?.filter(el => el !== locale.value)
    .map(el => ({
      label: el,
      link: pdfMap[el]
    }))
);

const handleDownload = () => {
  if (!showDropdown.value) {
    showDropdown.value = true;
  } else {
    const link = document.createElement('a');
    link.href = `/${pdfMap[locale.value]}.pdf`;
    link.download = `${pdfMap[locale.value]}.pdf`;
    link.click();
    showDropdown.value = false;
  }
};
const toggleDropdown = event => {
  if (event.target.closest('.box')) return;
  showDropdown.value = false;
};

onMounted(() => {
  document.addEventListener('click', toggleDropdown);
});

onBeforeUnmount(() => {
  document.removeEventListener('click', toggleDropdown);
});
</script>

<style lang="scss" scoped>
.box {
  position: relative;
  align-self: flex-start;
  display: flex;
  &.shown {
    .box__label {
      border-color: #fff;
      gap: max(4.1rem, 38px);
      span {
        width: max(1.8rem, 18px);
      }
    }
    .box__dropdown {
      opacity: 1;
      pointer-events: all;
      translate: 0 0;
    }
  }
  &__dropdown {
    z-index: 2;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding-top: max(4.1rem, 41px);
    border-radius: max(2rem, 20px);
    border: 1px solid rgba(255, 255, 255, 0.15);
    background: rgba(255, 255, 255, 0.05);
    backdrop-filter: blur(15px);
    opacity: 0;
    translate: 0 10px;
    pointer-events: none;
    transition: all 0.4s;
    &-button {
      display: flex;
      align-items: center;
      height: max(4.1rem, 41px);
      padding-inline: max(1.7rem, 17px);
      font-weight: 500;
      font-size: max(1.6rem, 16px);
      border-radius: max(5rem, 50px);
      border: 1px solid transparent;
      transition: all 0.3s;
      &:hover {
        border-color: rgba(255, 255, 255, 0.15);
        background: rgba(255, 255, 255, 0.05);
      }
    }
  }
  &__label {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 0;
    height: max(4.1rem, 41px);
    padding-inline: max(1.7rem, 17px);
    border-radius: max(5rem, 50px);
    border: 1px solid rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(15px);
    z-index: 4;
    transition: all 0.3s;
    &:hover {
      border-color: #fff;
    }
    span {
      transition: width 0.4s;
      width: 0;
      font-weight: 500;
      font-size: max(1.6rem, 16px);
      overflow: hidden;
    }
    &-icon {
      width: max(2.5rem, 25px);
    }
  }
}
</style>

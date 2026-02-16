<template>
  <main class="wrapper">
    <div class="container">
      <div class="header">
        <ClientOnly>
          <div class="header__labels">
            <span>{{ Intl.DateTimeFormat('ru-RU').format(new Date(currentItem.date)) }}</span>
            <span
              v-for="label in currentItem.labels"
              :key="label"
              :style="{
                color: `rgba(${randomColor()}, ${randomColor()}, ${randomColor()}, 1)`
              }"
              >{{ label }}</span
            >
          </div>
        </ClientOnly>
        <h1 class="header__title">
          {{ currentItem.title }}
        </h1>
      </div>
      <UiPicture :src="`news-${currentItem.id}.jpg`" alt="banner" class="container__banner" />
      <div class="container__box">
        <p>
          Lorem ipsum dolor sit amet consectetur, adipisicing elit. Harum tempora nam nobis
          possimus? Doloribus recusandae non modi porro rerum accusantium hic! Et minus nulla facere
          iusto dolorem distinctio, voluptate, alias accusamus dolore fuga ullam dolor aut
          temporibus perferendis? Dignissimos, expedita. Quisquam reprehenderit, adipisci odit
          doloribus unde tempora natus ipsa recusandae porro, laudantium aliquid sed quam? Debitis,
          ut rem? Labore tempora blanditiis eos quos, similique excepturi impedit quaerat est sit
          tempore odit dolores repudiandae corporis necessitatibus pariatur? Repudiandae ratione
          veniam ea, ut perspiciatis, qui voluptatibus accusantium pariatur inventore molestiae
          reiciendis cum expedita quia? Sit, sunt distinctio! Tempora cumque itaque sed cum.
        </p>
        <UiPicture src="school.jpg" alt="school" class="container__box-pic" />
        <p>
          Lorem ipsum dolor sit amet consectetur, adipisicing elit. Harum tempora nam nobis
          possimus? Doloribus recusandae non modi porro rerum accusantium hic! Et minus nulla facere
          iusto dolorem distinctio, voluptate, alias accusamus dolore fuga ullam dolor aut
          temporibus perferendis? Dignissimos, expedita. Quisquam reprehenderit, adipisci odit
          doloribus unde tempora natus ipsa recusandae porro, laudantium aliquid sed quam? Debitis,
          ut rem? Labore tempora blanditiis eos quos, similique excepturi impedit quaerat est sit
          tempore odit dolores repudiandae corporis necessitatibus pariatur? Repudiandae ratione
          veniam ea, ut perspiciatis, qui voluptatibus accusantium pariatur inventore molestiae
          reiciendis cum expedita quia? Sit, sunt distinctio! Tempora cumque itaque sed cum.
        </p>
        <p>
          Lorem ipsum dolor sit amet consectetur, adipisicing elit. Harum tempora nam nobis
          possimus? Doloribus recusandae non modi porro rerum accusantium hic! Et minus nulla facere
          iusto dolorem distinctio, voluptate, alias accusamus dolore fuga ullam dolor aut
          temporibus perferendis? Dignissimos, expedita. Quisquam reprehenderit, adipisci odit
          doloribus unde tempora natus ipsa recusandae porro, laudantium aliquid sed quam? Debitis,
          ut rem? Labore tempora blanditiis eos quos, similique excepturi impedit quaerat est sit
          tempore odit dolores repudiandae corporis necessitatibus pariatur? Repudiandae ratione
          veniam ea, ut perspiciatis, qui voluptatibus accusantium pariatur inventore molestiae
          reiciendis cum expedita quia? Sit, sunt distinctio! Tempora cumque itaque sed cum.
        </p>
      </div>
    </div>
    <section class="other">
      <h3 class="other__label">
        {{ $t('news.other') }}
      </h3>
      <div class="other__list">
        <UiNewsCard v-for="item in useMapRt('news.items')" :key="item.title" :data="item" />
      </div>
    </section>
    <UiSectionCta />
  </main>
</template>

<script setup>
const route = useRoute();

const currentItem = useMapRt('news.items').find(el => el.id === +route.params.id);
</script>

<style lang="scss" scoped>
.other {
  padding-inline: var(--spacing-inline);
  display: flex;
  flex-direction: column;
  gap: max(4rem, 14px);
  &__label {
    font-size: max(3rem, 18px);
    font-weight: 400;
  }
  &__list {
    display: flex;
    flex-direction: column;
    & > * {
      position: relative;
      &:not(:last-child) {
        margin-bottom: max(3rem, 20px);
        &::after {
          content: '';
          position: absolute;
          bottom: calc(max(3rem, 20px) * -1);
          inset-inline: 0;
          width: 100%;
          height: 1px;
          background-color: #d8d8d8;
        }
      }
      &:not(:first-child) {
        margin-top: max(3rem, 20px);
      }
    }
  }
}
.container {
  padding-inline: var(--spacing-inline);
  display: flex;
  flex-direction: column;
  gap: max(4rem, 30px);
  @media screen and (max-width: vars.$bp-md) {
    padding-inline: 0;
  }
  &__box {
    padding-inline: 15.3rem;
    display: flex;
    flex-direction: column;
    gap: max(4rem, 30px);
    p {
      font-size: max(2rem, 14px);
    }
    @media screen and (max-width: vars.$bp-lg) {
      padding-inline: max(7rem, 20px);
    }
    &-pic {
      border-radius: max(2rem, 12px);
      aspect-ratio: 89.4/36;
      @media screen and (max-width: vars.$bp-md) {
        aspect-ratio: 31.6/16.2;
      }
    }
  }
  &__banner {
    aspect-ratio: 12/5;
    border-radius: 1.2rem;
    @media screen and (max-width: vars.$bp-md) {
      aspect-ratio: 37.5/20;
    }
  }
}
.header {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: max(3rem, 10px);
  &__labels {
    display: flex;
    font-size: max(1.4rem, 9px);
    column-gap: max(1.4rem, 14px);
    row-gap: 5px;
    font-weight: 500;
    text-transform: uppercase;
    flex-wrap: wrap;
    & > * {
      position: relative;
      &:not(:last-child)::after {
        content: '';
        position: absolute;
        width: 4px;
        height: 4px;
        border-radius: 50%;
        background-color: #d8d8d8;
        top: 50%;
        right: -7px;
        translate: 50% -50%;
      }
    }
  }
  &__title {
    text-align: center;
    font-size: max(5.6rem, 20px);
    font-weight: 400;
    line-height: 101%;
    letter-spacing: -2.24px;
  }
}
.wrapper {
  padding-top: max(9.4rem, 30px);
  display: flex;
  flex-direction: column;
  gap: max(10rem, 50px);
}
</style>

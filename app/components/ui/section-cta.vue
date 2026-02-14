<template>
  <section class="cta">
    <h2 class="heading-lg">
      {{ $t('section-cta.title') }}
    </h2>
    <p>{{ $t('section-cta.text') }}</p>
    <button class="cta__button" @click="showFormPopup = true">
      {{ $t('contact-us') }}
    </button>
    <a href="tel:+998 77 124 10 10" class="cta__button">
      {{ $t('call-us') }}
    </a>
  </section>
</template>

<script setup>
const showFormPopup = useState('showFormPopup');
</script>

<style lang="scss" scoped>
.cta {
  display: flex;
  align-items: flex-start;
  gap: max(5.4rem, 22px);
  padding-bottom: max(6rem, 20px);
  margin-inline: var(--spacing-inline);
  border-bottom: 2px solid #fff;
  flex-wrap: wrap;
  @media screen and (max-width: vars.$bp-sm) {
    border-bottom: none;
    padding-bottom: 0;
  }
  h2 {
    max-width: 16ch;
  }
  p {
    max-width: 50ch;
  }
  &__button {
    margin-left: auto;
    border-radius: 50px;
    background: #fff;
    font-size: 16px;
    font-weight: 900;
    color: #000;
    padding-block: max(1.4rem, 10px);
    padding-inline: max(2.4rem, 20px);
    transition: all 0.3s;
    &:hover {
      background: #000;
      color: #fff;
    }
    &:nth-child(3) {
      @media screen and (max-width: vars.$bp-lg) {
        display: none;
      }
    }
    &:last-child {
      @media screen and (min-width: vars.$bp-lg) {
        display: none;
      }
    }
    @media screen and (max-width: vars.$bp-md) {
      margin-left: initial;
    }
  }
}
</style>

<template>
  <main class="contacts">
    <div class="contacts__wrapper">
      <div class="contacts__header">
        <h1 class="heading-lg">
          {{ $t('contacts.title') }}
        </h1>
        <p>
          {{ $t('contacts.text') }}
        </p>
      </div>
      <section class="contacts__container">
        <iframe
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d8760.294963872191!2d69.18524444903481!3d41.19745780073663!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x38ae63001169696f%3A0xaad2fe04d02f32fb!2sOstim%20Global!5e0!3m2!1sen!2s!4v1771239907902!5m2!1sen!2s"
          style="border: 0"
          allowfullscreen=""
          loading="lazy"
          referrerpolicy="no-referrer-when-downgrade"
          class="contacts__frame"
        />
        <div class="contacts__card">
          <span class="contacts__card-label">
            {{ $t('office') }}
          </span>
          <svg
            class="contacts__card-icon"
            viewBox="0 0 57 56"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M28.5 1.16666C13.4158 1.16666 1.1875 13.1794 1.1875 28C1.1875 42.8186 13.4158 54.8333 28.5 54.8333C43.5842 54.8333 55.8125 42.8186 55.8125 28C55.8125 13.1794 43.5842 1.16666 28.5 1.16666ZM0 56V-3.8147e-06H57V56H0Z"
              fill="white"
            />
          </svg>
          <div class="contacts__card-texts">
            <p
              v-for="text in $t('contacts.address-1').split('/endline/')"
              :key="text"
              class="contacts__card-text"
            >
              {{ text }}
            </p>
            <a href="tel:+998 77 124 10 10" class="contacts__card-text"> +998 77 124 10 10 </a>
            <p class="contacts__card-text">
              {{ $t('contacts.address-2') }}
            </p>
          </div>
        </div>
      </section>
    </div>
    <UiSectionCta />
  </main>
</template>

<script setup></script>

<style lang="scss" scopedc>
.contacts {
  padding-top: max(9.4rem, 30px);
  display: flex;
  flex-direction: column;
  gap: max(10rem, 50px);
  &__container {
    margin-right: var(--spacing-inline);
    display: grid;
    grid-template-columns: 1fr 1.2fr;
    gap: 5px;
    @media screen and (max-width: vars.$bp-lg) {
      grid-template-columns: 1fr;
      margin-inline: var(--spacing-inline);
    }
  }
  &__card {
    align-self: flex-end;
    border-radius: max(3rem, 20px);
    background: #cf2025;
    padding-inline: max(4rem, 20px);
    padding-block: max(4rem, 25px);
    display: flex;
    gap: max(8.7rem, 61px);
    flex-direction: column;
    position: relative;
    justify-content: space-between;
    &-texts {
      display: flex;
      flex-direction: column;
      font-weight: 500;
      max-width: 30ch;
    }
    &-label {
      @include mix.flex-center;
      border-radius: max(5rem, 30px);
      background: var(--white, #fff);
      color: #000;
      text-align: center;
      font-size: 16px;
      width: max(13.5rem, 111px);
      height: 41px;
      font-weight: 900;
    }
    &-icon {
      width: max(5.7rem, 41px);
      position: absolute;
      right: max(4rem, 20px);
      top: max(4rem, 25px);
    }
  }
  &__frame {
    width: 100%;
    height: max(46.6rem, 338px);
    border-radius: max(3rem, 20px);
  }
  &__header {
    margin-inline: var(--spacing-inline);
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    align-items: flex-end;
    border-bottom: 2px solid #fff;
    padding-bottom: max(6rem, 50px);
    justify-content: space-between;
    h1 {
      max-width: 15ch;
    }
    p {
      max-width: 60ch;
    }
  }
  &__wrapper {
    display: flex;
    flex-direction: column;
    gap: max(6rem, 50px);
  }
}
</style>

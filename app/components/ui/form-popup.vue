<template>
  <Transition name="appear">
    <div v-if="showFormPopup" class="overlay" @click.self="showFormPopup = false">
      <div class="form-popup">
        <button class="form-popup__close" @click="showFormPopup = false">
          <IconsX />
        </button>
        <h2 class="form-popup__title">
          {{ $t('form-popup.title') }}
        </h2>
        <form class="form-popup__form" @submit.prevent="">
          <input
            id="name"
            v-model="name"
            class="form-popup__input"
            type="text"
            :placeholder="$t('form-popup.name')"
          />
          <input
            id="phone"
            v-model="phone"
            class="form-popup__input"
            type="tel"
            :placeholder="$t('form-popup.phone')"
            @input="cleanPhone"
          />
          <p class="form-popup__text">
            <span>{{ $t('form-popup.rights-1') }}</span>
            <span>{{ $t('form-popup.rights-2') }}</span>
          </p>
          <button class="form-popup__button" :disabled="!name || phone.length < 1">
            {{ $t('send') }}
          </button>
        </form>
      </div>
    </div>
  </Transition>
</template>

<script setup>
const showFormPopup = useState('showFormPopup', () => false);

const name = ref('');
const phone = ref('');

const cleanPhone = () => {
  phone.value = phone.value.replace(/[^\d\s\+]/g, '');
};
</script>

<style lang="scss" scoped>
.form-popup {
  width: max(42rem, 500px);
  border-radius: 15px;
  border: 1px solid rgba(255, 255, 255, 0.15);
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(15px);
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 14px;
  transition: all 0.5s;
  &__input {
    letter-spacing: 1px;
    border-bottom: 2px solid rgba(255, 255, 255, 0.4);
    padding-bottom: 10px;
    &::placeholder {
      text-transform: uppercase;
      color: rgba(255, 255, 255, 0.7);
    }
  }
  &__title {
    font-size: 38px;
    font-weight: 500;
    line-height: 131%;
    letter-spacing: -1.9px;
    text-transform: uppercase;
    align-self: center;
    text-align: center;
    margin-bottom: calc(82px - 40px);
  }
  &__close {
    @include mix.flex-center;
    align-self: flex-end;
    width: 40px;
    height: 40px;
    background: #fc0;
    border-radius: 50%;
    transition:
      background 0.4s,
      scale 0.4s;
    &:hover {
      background: rgb(185, 148, 2);
      scale: 0.95;
    }
  }
  &__text {
    font-size: 16px;
    line-height: 150%;
    margin-top: calc(70px - 40px);
    text-align: center;
    align-self: center;
    display: flex;
    flex-direction: column;
  }
  &__form {
    display: flex;
    flex-direction: column;
    gap: 40px;
    padding-inline: calc(50px - 14px);
    padding-bottom: calc(29px - 14px);
  }
  &__button {
    margin-top: calc(55px - 40px);
    border-radius: 99px;
    background: #34c759;
    font-weight: 900;
    height: 70px;
    transition: all 0.4s;
    &:hover {
      background: #1d7e45;
      box-shadow: 0 0 20px #1d7e45;
    }
    &:disabled {
      opacity: 0.3;
      cursor: not-allowed;
      pointer-events: none;
    }
  }
}
.overlay {
  @include mix.flex-center;
  background: rgba(0, 0, 0, 0.6);
  position: fixed;
  inset: 0;
  z-index: 100;
}
.appear-enter-active,
.appear-leave-active {
  transition: background 0.5s;
}
.appear-enter-from,
.appear-leave-to {
  background: transparent;
  & > * {
    translate: 0 30px;
    opacity: 0;
  }
}
</style>

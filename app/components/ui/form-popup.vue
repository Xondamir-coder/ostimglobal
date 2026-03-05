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
        <form class="form-popup__form" @submit.prevent="submitForm">
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
            @focus="prependPhone"
            @click="prependPhone"
            @input="checkPhone"
          />
          <p class="form-popup__text">
            <span>{{ $t('form-popup.rights-1') }}</span>
            <span>{{ $t('form-popup.rights-2') }}</span>
          </p>
          <button
            class="form-popup__button"
            :disabled="!name || phone.length < 1 || state !== 'ready'"
          >
            <span v-if="state === 'ready'">{{ $t('send') }}</span>
            <span v-else-if="state === 'loading'" class="loader"></span>
            <span v-else>{{ $t('sent') }} ☑️</span>
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
const state = ref('ready');

const placesMap = {
  sport: 'Спортивный комплекс',
  admin: 'Административный офис',
  hotel: 'Гостиница',
  mall: 'Торговый центр',
  expo: 'Выставочный центр',
  kindergarten: 'Детский сад',
  school: 'Школа',
  university: 'Университет',
  clinic: 'Клиника',
  business: 'Бизнес-центр'
};

const prependPhone = () => {
  if (!phone.value) phone.value = '+';
};
const checkPhone = () => {
  phone.value = phone.value.replace(/[^\d\s+]/g, '');
  if (event.inputType === 'deleteContentBackward' && phone.value.length < 2) phone.value = '+';
};

const submitForm = async () => {
  const { query } = useRoute();
  state.value = 'loading';

  const attrs = {
    name: name.value,
    phone: phone.value,
    ...(query?.place && { item: placesMap[query.place] }),
    ...(query?.hangar && { item: query.hangar })
  };

  await useSendTelegram(attrs);
  state.value = 'sent';

  setTimeout(() => {
    name.value = '';
    phone.value = '';
    state.value = 'ready';
    showFormPopup.value = false;
  }, 1000);
};
</script>

<style lang="scss" scoped>
@keyframes rotation {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

@keyframes rotationBack {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(-360deg);
  }
}

.form-popup {
  max-width: max(42rem, 500px);
  width: 100%;
  // width: max(42rem, 400px);
  border-radius: 15px;
  border: 1px solid rgba(255, 255, 255, 0.15);
  background: rgba(255, 255, 255, 0.05);
  color: #fff;
  backdrop-filter: blur(15px);
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: max(1.4rem, 10px);
  transition: all 0.5s;

  &__input {
    font-size: max(2rem, 18px);
    letter-spacing: 1px;
    border-bottom: 2px solid rgba(255, 255, 255, 0.4);
    padding-bottom: 10px;
    transition: border-color 0.3s;
    border-radius: 0;
    &:focus {
      border-color: #fff;
    }
    &::placeholder {
      text-transform: uppercase;
      color: rgba(255, 255, 255, 0.7);
    }
  }
  &__title {
    font-size: max(3.8rem, 30px);
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
    font-size: max(1.6rem, 12px);
    line-height: 150%;
    margin-top: calc(7rem - 4rem);
    text-align: center;
    align-self: center;
    display: flex;
    flex-direction: column;
  }
  &__form {
    display: flex;
    flex-direction: column;
    gap: max(4rem, 30px);
    padding-inline: calc(max(5rem, 12px) - max(1.4rem, 10px));
    padding-bottom: calc(max(2.9rem, 23px) - max(1.4rem, 10px));
  }
  &__button {
    margin-top: calc(55px - 40px);
    border-radius: 99px;
    background: #34c759;
    font-weight: 900;
    height: max(7rem, 49px);
    transition: all 0.4s;
    font-size: max(2rem, 18px);
    &:hover {
      background: #1d7e45;
      box-shadow: 0 0 20px #1d7e45;
    }
    &:disabled {
      opacity: 0.3;
      cursor: not-allowed;
      pointer-events: none;
    }
    .loader {
      width: max(4rem, 34px);
      height: max(4rem, 34px);
      border-radius: 50%;
      display: inline-block;
      position: relative;
      border: 3px solid;
      border-color: #fff #fff transparent;
      box-sizing: border-box;
      animation: rotation 1s linear infinite;
      &::after {
        content: '';
        box-sizing: border-box;
        position: absolute;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
        margin: auto;
        border: 3px solid;
        border-color: transparent #fc0 #fc0;
        width: 50%;
        height: 50%;
        border-radius: 50%;
        animation: rotationBack 0.5s linear infinite;
        transform-origin: center center;
      }
    }
  }
}
.overlay {
  @include mix.flex-center;
  background: rgba(0, 0, 0, 0.6);
  position: fixed;
  inset: 0;
  z-index: 100;
  @media screen and (max-width: vars.$bp-sm) {
    padding-inline: 20px;
  }
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

import Lenis from 'lenis';

export default defineNuxtPlugin(() => {
  let lenis;
  if (import.meta.client) {
    lenis = new Lenis({
      autoRaf: true
    });
  }

  return {
    provide: {
      lenis
    }
  };
});

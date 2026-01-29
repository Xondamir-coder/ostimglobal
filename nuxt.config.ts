// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  modules: ['@nuxtjs/i18n', '@nuxt/eslint', '@nuxtjs/google-fonts'],
  vite: {
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: `
          @use "~/assets/scss/abstracts/variables" as vars;
          @use "~/assets/scss/abstracts/mixins" as mix;
          `
        }
      }
    }
  },
  css: ['~/assets/scss/main.scss'],
  app: {
    head: {
      title: 'Ostim Global'
    }
  },
  i18n: {
    defaultLocale: 'en',
    detectBrowserLanguage: {
      useCookie: true,
      cookieKey: 'i18n_redirected',
      redirectOn: 'root'
    },
    locales: [
      { code: 'en', language: 'en-US', name: 'English', file: 'en.json' },
      { code: 'ru', language: 'ru-RU', name: 'Русский', file: 'ru.json' },
      { code: 'uz', language: 'uz-UZ', name: "O'zbek", file: 'uz.json' }
    ]
  },
  googleFonts: {
    families: {
      'Zen Maru Gothic': [300, 400, 500, 700, 900],
      'Inter Tight': [400, 700],
      Unbounded: [300]
    }
  }
});

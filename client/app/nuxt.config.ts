// https://nuxt.com/docs/api/configuration/nuxt-config

export default defineNuxtConfig({
  modules: [
    "@nuxtjs/tailwindcss",
    "nuxt-icon",
    "@vite-pwa/nuxt",
    "@nuxtjs/apollo",
  ],
  pwa: {
    manifest: {
      name: "DECK1 Dispatch App",
      short_name: "DECK1 Dispatch App",
      description: "DECK1 Dispatch App",
      lang: "en",
    },
    devOptions: {
      enabled: true,
      type: "module",
    },
  },

  apollo: {
    clients: {
      default: {
        httpEndpoint: process.env.API_URL || "http://localhost:4000/graphql",
      },
    },
  },

  app: {
    head: {
      charset: "utf-16",
      title: "DECK1 Dispatch App",
      meta: [
        {
          name: "description",
          content: "DECK1 Dispatch App",
        },
      ],
    },
  },
});

import { defineNuxtPlugin, useRouter, useRuntimeConfig } from "#app";
import * as Sentry from "@sentry/vue";
import { BrowserTracing } from "@sentry/tracing";

export default defineNuxtPlugin((nuxtApp) => {
  const config = useRuntimeConfig();
  const router = useRouter();

  Sentry.init({
    app: nuxtApp.vueApp,
    dsn: "https://1a5ea833729d4ee9b7d56d8202d8c494@o4504977322868736.ingest.sentry.io/4505104968056832",
    integrations: [
      new BrowserTracing({
        routingInstrumentation: Sentry.vueRouterInstrumentation(router),
      }),
      new Sentry.Replay(),
    ],
    tracesSampleRate: 1.0,
    replaysSessionSampleRate: 0.5,
    replaysOnErrorSampleRate: 1.0,
  });

  return {
    provide: {
      sentry: Sentry,
    },
  };
});

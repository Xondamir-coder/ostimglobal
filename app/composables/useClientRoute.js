// composables/useClientRoute.ts
export const useClientRoute = () => {
  const route = useRoute();
  const clientReady = ref(false);
  onMounted(() => {
    clientReady.value = true;
  });
  const query = computed(() => (clientReady.value ? route.query : {}));
  return { query };
};

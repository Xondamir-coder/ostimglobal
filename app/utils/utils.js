export const randomColor = () => Math.floor(Math.random() * 256);
export const replacePath = query => {
  const router = useRouter();
  router.replace({
    path: router.currentRoute.value.path,
    query
  });
};
export const getDefaultScrollTrigger = (
  trigger,
  { start = 'top 90%', end = 'top 60%', scrub = false, markers = false } = {}
) => ({
  trigger,
  start,
  end,
  markers,
  scrub,
});

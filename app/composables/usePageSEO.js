import en from '~/assets/data/seo/en.json';
import ru from '~/assets/data/seo/ru.json';
import uz from '~/assets/data/seo/uz.json';
import tr from '~/assets/data/seo/tr.json';

const seo = { en, ru, uz, tr };

/**
 * Sets the SEO metadata for a given page.
 *
 * @param {string} pageName - the name of the page
 * @param {import('@unhead/vue').UseSeoMetaInput} [props] - Additional SEO metadata.
 */
export default (pageName, props = {}) => {
  const { locale } = useI18n();
  const seoData = seo[locale.value][pageName];

  useSeoMeta({
    ogSiteName: 'OSTIM Global',
    ...seoData,
    ...props
  });
};

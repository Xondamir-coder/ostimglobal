// primitive val = num, str
// non-primitive = arr (prim), obj (prim), arr (non-prim), obj (non-prim)

const translate = val => {
  const { rt } = useI18n();

  if (val == null) return val; // null / undefined
  if (typeof val === 'number') return val;
  if (typeof val === 'string') return val;
  if (val.loc) return rt(val);
  if (Array.isArray(val)) return val.map(translate);

  return Object.fromEntries(Object.entries(val).map(([k, v]) => [k, translate(v)]));
};

/**
 * Translate a message using the current locale.
 * @param {string} name - The name of the message.
 * @returns {Array} - The translated message.
 */
export default name => {
  const { tm } = useI18n();
  return tm(name).map(translate);
};

// ParsleyConfig definition if not already set
window.ParsleyConfig = window.ParsleyConfig || {};
window.ParsleyConfig.i18n = window.ParsleyConfig.i18n || {};
// Define then the messages
window.ParsleyConfig.i18n.en = $.extend(window.ParsleyConfig.i18n.en || {}, {
  defaultMessage: "Invalid value",
  type: {
    email: "Invalid email",
    url: "Invalid url",
    number: "Invalid number",
    integer: "Invalid integer",
    digits: "Invalid digits",
    alphanum: "Value must be alphanumeric"
  },
  notblank: "Field cannot be blank",
  required: "Field is required",
  pattern: "Invalid format",
  min: "Value must be greater than or equal to %s",
  max: "Value must be lower than or equal to %s",
  range: "Value must be between %s and %s",
  minlength: "Too short (min %s characters)",
  maxlength: "Too long (max %s characters)",
  length: "Invalid length (must be between %s and %s characters)",
  mincheck: "Select at least %s choices.",
  maxcheck: "Select %s choices or fewer.",
  check: "You must select between %s and %s choices.",
  equalto: "This value must be the same."
  });
// If file is loaded after Parsley main file, auto-load locale
if ('undefined' !== typeof window.ParsleyValidator)
window.ParsleyValidator.addCatalog('en', window.ParsleyConfig.i18n.en, true);
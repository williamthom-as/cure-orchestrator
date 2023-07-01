export function configure(config) {
  config.globalResources([
    './value-converters/file-to-text.js',
    './value-converters/json-formatter.js',
    './value-converters/file-list-to-array.js',
    './value-converters/object-keys.js',
    './value-converters/json.js',
    './elements/horizontal-nav',
    './elements/parent',
    './elements/panel',
    './elements/validatable-field',
    './elements/validatable-select',
    './elements/validatable-select2',
    './elements/toasts'
  ]);
}

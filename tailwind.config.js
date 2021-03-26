const colors = require('tailwindcss/colors')

module.exports = {
  purge: false, // Handled by plugins/purgecss_builder.rb

  darkMode: false,

  corePlugins: {
    float: false,
    clear: false,
  },

  theme: {
    container: {
      center: true,
      padding: {
        default: '1rem',
        sm: '2rem',
        lg: '4rem',
        xl: '5rem',
      },
      maxWidth: {
        default: '100%',
        sm: '640px',
        md: '768px',
        lg: '1024px',
        xl: '1024px',
      }
    },

    extend: { // Lock in the colours/fonts we want to define as our colour palette.
      fontWeight: {
        light: '300',
        normal: '400',
        bold: '700',
      },

      opacity: {
        '0': '0',
        '25': '.25',
        '50': '.5',
        '75': '.75',
        '10': '.1',
        '20': '.2',
        '30': '.3',
        '40': '.4',
        '50': '.5',
        '60': '.6',
        '70': '.7',
        '80': '.8',
        '90': '.9',
        '100': '1',
      },

      colors: { // These are the colours we should aim to stick to.
        'cool-gray': colors.coolGray
      },
      screens: {
        dark: { raw: "(prefers-color-scheme: dark)" },
        // dark: { raw: "(prefers-color-scheme: light)" }, // Uncomment this to switch between dark and light.
      }
    }
  },
  variants: {
  },
  plugins: [
    require('@tailwindcss/ui'),
    require('tailwindcss-accessibility')
  ],
}

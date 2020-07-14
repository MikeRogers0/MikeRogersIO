module.exports = {
  purge: {
    enabled: (process.env.NODE_ENV === 'production'),
    content: [
      './src/**/*.html',
      './src/**/*.md',
      './src/**/*.liquid',
    ]
  },
  theme: {

    extend: { // Lock in the colours/fonts we want to define as our colour palette.
      fontWeight: {
        light: '300',
        normal: '400',
        bold: '700',
      },

      colors: { // These are the colours we should aim to stick to.
      },
      screens: {
        dark: { raw: "(prefers-color-scheme: dark)" }
      }
    }
  },
  variants: {
  },
  plugins: [
    require('@tailwindcss/ui')
  ],
}

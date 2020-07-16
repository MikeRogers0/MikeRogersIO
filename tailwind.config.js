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

      colors: { // These are the colours we should aim to stick to.
      },
      screens: {
        dark: { raw: "(prefers-color-scheme: dark)" },
        //dark: { raw: "(prefers-color-scheme: light)" },
      }
    }
  },
  variants: {
  },
  plugins: [
    require('@tailwindcss/ui')
  ],
}

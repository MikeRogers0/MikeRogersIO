module.exports = {
  purge: {
    enabled: (process.env.NODE_ENV === 'production'),
    content: [
      './src/**/*.html',
      './src/**/*.md',
      './src/**/*.liquid',
    ]
  },
  theme: {},
  variants: {},
  plugins: [],
}

let environment = {
  plugins: [
    require('postcss-import'),
    require('tailwindcss'),

    // https://github.com/postcss/postcss-nested
    // Next CSS like SCSS days
    require('postcss-nested'),

    // https://github.com/postcss/postcss-custom-properties
    // Add fallbacks when we use CSS variables
    require('postcss-custom-properties'),
  ]
}

// Only add these in production as they slow down the dev build time a bunch.
if (process.env.BRIDGETOWN_ENV === "production") {
  environment.plugins.push(
    require('cssnano')({ preset: 'default' }),
  )
};

module.exports = environment;

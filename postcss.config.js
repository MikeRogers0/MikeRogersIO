module.exports = {
  plugins: [
    require('postcss-import'),
    require('tailwindcss'),

    // https://github.com/postcss/postcss-nested
    // Next CSS like SCSS days
    require('postcss-nested'),

    // https://github.com/postcss/postcss-custom-properties
    // Add fallsbacks when we use CSS variables
    require('postcss-custom-properties'),
    
    // https://github.com/TrySound/postcss-inline-svg
    // Inline SVGs:
    // background: svg-load('img/arrow-up.svg', fill=#000, stroke=#fff);
    require('postcss-inline-svg'),
    require('postcss-svgo')
  ]
}

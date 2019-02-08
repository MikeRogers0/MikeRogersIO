// This is where it all goes :)
//= require rainbow-code/dist/rainbow.min

// Guess what kind of code sample it could be.
var codeBlocks = document.querySelectorAll('pre code');
codeBlocks.forEach(function(codeBlock){
  if( codeBlock.innerText.includes('<!--') ){
    codeBlock.setAttribute('data-language', 'html')
  } else if ( codeBlock.innerText.includes('<?xml') ) {
    codeBlock.setAttribute('data-language', 'xml')
  } else if ( codeBlock.innerText.includes('#!/') ) {
    codeBlock.setAttribute('data-language', 'shell')
  } else if ( codeBlock.innerText.includes('$') ) {
    codeBlock.setAttribute('data-language', 'css')
  } else if ( codeBlock.innerText.includes('.rb') || codeBlock.innerText.includes(' do')  || codeBlock.innerText.includes('# ') ) {
    codeBlock.setAttribute('data-language', 'ruby')
  } else if ( codeBlock.innerText.includes('$(') ) {
    codeBlock.setAttribute('data-language', 'javascript')
  } else {
    codeBlock.setAttribute('data-language', 'text')
  }
});

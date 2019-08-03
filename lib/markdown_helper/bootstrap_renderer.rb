# From: https://aalvarez.me/posts/custom-markdown-in-middleman/
module MarkdownHelper
  require 'middleman-core/renderers/redcarpet'

  class BootstrapRenderer < Middleman::Renderers::MiddlemanRedcarpetHTML
    include Middleman::Syntax::RedcarpetCodeRenderer

    def initialize(options = {})
      super
    end

    def table(header, body)
      "<table class=' table table-striped table-bordered'>" \
        "<thead>#{header}</thead>" \
        "<tbody>#{body}</tbody>" \
        '</table>'
    end

    def block_quote(quote)
      %(<blockquote class="blockquote pl-4 border-left">#{quote}</blockquote>)
    end

    def image(link, title, alt_text)
      if !@local_options[:no_images]
        # We add bootstrap centering and responsive class here
        scope.image_tag(link, title: title, alt: alt_text, class: 'img-fluid rounded mx-auto d-block')
      else
        link_string = link.dup
        link_string << %("#{title}") if title && !title.empty? && title != alt_text
        "![#{alt_text}](#{link_string})"
      end
    end
  end
end

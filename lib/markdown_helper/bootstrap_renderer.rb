module MarkdownHelper
  require 'middleman-core/renderers/redcarpet'

  class BootstrapRenderer < Middleman::Renderers::MiddlemanRedcarpetHTML
    def initialize(options={})
      super
    end

    def table(header, body)
      "<table class=' table table-striped table-bordered'>" \
        "<thead>#{header}</thead>" \
        "<tbody>#{body}</tbody>" \
        "</table>"
    end
  end
end

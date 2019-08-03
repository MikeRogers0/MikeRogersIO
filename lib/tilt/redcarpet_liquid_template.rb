require 'redcarpet'
require 'middleman-core/renderers/redcarpet'

# I could monkey patch this a bit like https://github.com/middleman/middleman-syntax/blob/0377cc9d2219c2a6ffc2acfd39057f833934af9a/lib/middleman-syntax/extension.rb#L21
class Tilt::RedcarpetLiquidTemplate < Middleman::Renderers::RedcarpetTemplate
  def evaluate(scope, _)
    @data = Liquid::Template.parse(@data).render

    super
  end
end

require 'kramdown'
require 'middleman-core/renderers/kramdown'

class Tilt::KramerLiquidTemplate < Middleman::Renderers::KramdownTemplate
  def evaluate(context, *)
    output = super
    template = Liquid::Template.parse(output)
    template.render() 
  end
end

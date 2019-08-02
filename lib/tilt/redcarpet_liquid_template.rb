require 'redcarpet'
require 'middleman-core/renderers/redcarpet'

class Tilt::RedcarpetLiquidTemplate < Middleman::Renderers::RedcarpetTemplate
  def evaluate(context, *)
    output = super

    output.gsub!('<p>{', '{')
    output.gsub!('}</p>', '}')

    template = Liquid::Template.parse(output)
    template.render() 
  end
end

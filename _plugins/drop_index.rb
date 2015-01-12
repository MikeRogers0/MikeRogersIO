module DropIndexFilter

  def drop_index(path)
    path.sub!('/index.html', '/') if path
    path
  end

  Liquid::Template.register_filter self

end

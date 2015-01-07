# from: http://51bits.com/writing/estimated-reading-times-in-jekyll/

module ReadTimeFilter

  def readtime(post)
    characters = post['content'].size
    charcount = 4.5
    wpm = 180

    rt = (characters.to_f/charcount/wpm).round
    rt += post['video_length'] if post['video_length']
    rt = 1 if rt < 1
    rt
  end

  Liquid::Template.register_filter self

end

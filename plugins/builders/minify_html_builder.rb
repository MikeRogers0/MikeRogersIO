require 'htmlcompressor'

class MinifyHtmlBuilder < SiteBuilder
  def build
    return if config[:watch]

    hook :site, :post_write, priority: :low do
      minify_html_files
    end
  end

  private

  def minify_html_files
    html_files.each do |file_path|
      minify_file(file_path)
    end
    Bridgetown.logger.info 'Minify HTML', "Complete, Processed #{html_files.count} file(s)"
  end

  def minify_file(file_path)
    File.open(file_path, File::RDWR) do |file|
      compressed_contents = compressor.compress(file.read)
      file.rewind
      file.write(compressed_contents)
      file.truncate(file.pos)
    end
  end

  def html_files
    @html_files ||= Bridgetown::Utils.safe_glob(site.in_dest_dir, ['**', '*.html'], File::FNM_DOTMATCH)
  end

  def compressor
    @compressor ||= HtmlCompressor::Compressor.new(options)
  end

  def options
    {
      enabled: true,
      remove_spaces_inside_tags: true,
      remove_multi_spaces: true,
      remove_comments: true,
      remove_intertag_spaces: false,
      remove_quotes: false,
      compress_css: false,
      compress_javascript: false,
      simple_doctype: false,
      remove_script_attributes: false,
      remove_style_attributes: false,
      remove_link_attributes: false,
      remove_form_attributes: false,
      remove_input_attributes: false,
      remove_javascript_protocol: false,
      remove_http_protocol: false,
      remove_https_protocol: false,
      preserve_line_breaks: false,
      simple_boolean_attributes: false,
      compress_js_templates: false
    }
  end
end

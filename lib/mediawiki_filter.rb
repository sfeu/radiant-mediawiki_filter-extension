require 'mediacloth'

class MediawikiFilter < TextFilter

  description_file File.dirname(__FILE__) + "/../mediawiki_markup.html"

  cattr_accessor :config

  def filter(text)
    @config = {
      :add_blank? => Radiant::Config['mediawiki_filter.add_blank?'] || true,
      :images_directory => Radiant::Config['mediawiki_filter.images_directory'] || '/images',
      :media_directory => Radiant::Config['mediawiki_filter.media_directory'] || nil,
      :enable_workarounds? => Radiant::Config['mediawiki_filter.enable_workarounds?'] || true
    }
    MediaCloth::wiki_to_html(apply_workarounds(apply_enhancements(text)))
  end

  def apply_enhancements(text)
    # Open absolute [links] in blank browser window.
    if @config[:add_blank?]
      text.gsub!(/\[h(ttps?:.*?) (.*?)\]/, '<a href="&#104;\1" target="_blank">\2</a>')
    end
    # Allow [[Image]] markup.
    if !@config[:images_directory].blank?
      text.gsub!(/\[\[Image:([^\]]+)\.(.+?)\]\]/i) do
        if File.exists?("public/#{@config[:images_directory]}/#{$1}_zoomed.#{$2}")
          "<a href=\"#{@config[:images_directory]}/#{$1}_zoomed.#{$2}\" rel=\"lightbox[zoomables]\"><img src=\"#{@config[:images_directory]}/#{$1}.#{$2}\" alt="" /></a>"
        else
          "<img src=\"#{@config[:images_directory]}/#{$1}.#{$2}\" alt="" />"
        end
      end
    end
    # Allow [[Media]] markup.
    if !@config[:media_directory].blank?
      text.gsub!(/\[\[Media:(.+?)\|(.+?)\]\]/i, '<a href="' + @config[:media_directory] + '/\1">\2</a>')
    end
    text
  end

  def apply_workarounds(text)
    if @config[:enable_workarounds?]
      # MediaCloth 0.0.3 not handling !! in tables properly.
      text.gsub!(/(\w)!!(\w)/, '\1||\2')
      # MediaCloth 0.0.3 not handling local [links] properly.
      text.gsub!(/\[(\/.*?) (.*?)\]/, '<a href="\1">\2</a>')
      # Make spaces inside <pre> blocks non-breaking.
      text.gsub!(/<pre>.*?<\/pre>/m) do |m|
        m.gsub!(/ /, '&#160;')
      end
    end
    text
  end

end

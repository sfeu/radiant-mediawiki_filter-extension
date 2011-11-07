class MediawikiFilterExtension < Radiant::Extension
  version "0.3.0"
  description "Adds support for Mediawiki markup."
  url "https://github.com/sfeu/radiant-mediawiki_filter-extension"
  
  def activate
    MediawikiFilter
  end
end

class MediawikiFilterExtension < Radiant::Extension
  version "0.2.0"
  description "Adds support for Mediawiki markup."
  url "http://www.bitcetera.com/en/products/mediawiki_filter"
  
  def activate
    MediawikiFilter
  end
end

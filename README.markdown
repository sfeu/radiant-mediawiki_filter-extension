Mediawiki Filter
================

Created by Sven Schwyn, [Bitcetera](http://www.bitcetera.com).
Inspired by the Markdown extension.

This Radiant extension adds support for Mediawiki markup.

Installation
------------

1. Install or update the [MediaCloth gem](http://mediacloth.rubyforge.org): 

   $ gem install mediacloth

2. Install the extension:

   $ cd vendor/extensions
   $ git clone git://github.com/svoop/radiant-mediawiki_filter-extension.git mediawiki_filter

3. Restart the server

Configuration
-------------

The configuration of this extension is stored in the 'Radiant::Config' model. Either set the 
values on the script/console or open a database administration tool and do it directly on the
'config' table.

Workarounds
-----------

The mediawiki_filter implements a few workarounds as MediaCloth is everything but a complete
Mediawiki markup parser:

* Handle !! in table headers correctly.
* Allow local links, example: `[/profiles/kafka Franz Kafka]`
* Convert spaces inside `<pre>` blocks to non-breaking.

Enhancements
------------

*mediawiki_filter.add_blank?* (default: true)
This enhancement makes sure all external URLs are opened in a blank browser window.

*mediawiki_filter.image_directory* (default: '/images')
Set this to the path of the images directory (which must be relative to the 'public' directory)
if you wish to use `[[Image]]` markup. Example: If this key is set to '/images' the markup
`[[Image:me.jpg]]` will render `<img src="/images/me.jpg" alt="" />`. If an image with the postfix
'_zoomed' exists as well (me_zoomed.jpg in this case), the image is rendered as click-to-zoom
`<a href="/images/me_zoomed.jpg" rel="lightbox[zoomables]"><img src="/images/me.jpg" alt="" /></a>`.
Of course, [Lightbox2 must be installed](http://www.huddletogether.com) for this to work.

*mediawiki_filter.media_directory* (default: nil)
Set this to the path of the media directory (which mus be relative to the 'public' directory)
if you wish to use `[[Media]]` markup. Example: If this key is set to '/media' the markup
`[[Media:download.zip|download]]` will render `<a href="/my_media/download.zip">download</a>`.

*mediawiki_filter.enable_workarounds?* (default: true)
Enable all workarounds mentioned in the workarounds chapter above.

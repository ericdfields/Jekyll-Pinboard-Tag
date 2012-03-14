#
# Pinboard Tag
#
# Generates a list of links to a user's public bookmarks
#
# Usage:
#
#   {% pinboard user:username limit:# %}
#
# Example:
#
#   {% pinboard user:ericdfields limit:12 %}
#
# All paramaters are optional, e.g.:
#
#   {% pinboard user:ericdfields %}
#
# Default Configuration (override in _config.yml):
#
#   Pinboard_set:
#     user:            'ericdfields'
#     limit:  15
#     list_tag:     'ol'
#     list_class:   'pinboard_list'
#     a_target:        '_blank'
#
#
# Author: Eric D. Fields
# Site: http://ericdfields.com
# Twitter: @ericdfields
# Email: ericdfields.com
# Plugin Source: http://github.com/ericdfields/jekyll_Pinboard_set_tag
# Plugin License: MIT
#

require 'net/http'
require 'json'

module Jekyll
  class Pinboard < Liquid::Tag
    def initialize(tag_name, config, token)
      super

      @config = Jekyll.configuration({})['pinboard'] || {}

      userMatch = /(?<=user:)\w+/
      limitMatch = /(?<=limit:)\w+/

      if (config =~ userMatch) 
        @user                    = userMatch.match(config)[0]
      end
      @user                      ||= @config['user']
      @user                      ||= 'ericdfields'

      if (config =~ limitMatch) 
        @limit                   = limitMatch.match(config)[0].to_i
      end
      @limit                     ||= @config['limit']
      @limit                     ||= 10 # max 50

      @config['list_tag']        ||= 'ol'
      @config['list_class']      ||= 'pinboard_list'
      @config['is_list']         ||= true
      @config['a_target']        ||= '_blank'
      
    end

    def render(context)
      <<-EOF
      <#{@config['list_tag']} class="#{@config['list_class']}">
        #{bookmarks.collect {|bookmark| render_bookmark(bookmark)}.join}
      </#{@config['list_tag']}>
      EOF
    end

    def render_bookmark(bookmark)
      <<-EOF
      <li>
        <a href="#{bookmark.url}" target="#{@config['a_target']}">
          #{bookmark.description}
        </a>
      </li>
      EOF
    end

    def bookmarks
      @bookmarks = JSON.parse(json).take(@limit).map { |item| Bookmark.new(item['u'], item['d'], item['n'], item['dt'], item['a'], item['t'])
      }
    end

    # Get feed with username
    def json
      url     = 'http://feeds.pinboard.in/json/v1/u:' + @user
      resp    = Net::HTTP.get_response(URI.parse(url))
      return  resp.body
    end
  end

  class Bookmark

    def initialize(url, description, n, datetime, author, tags)
      @url              = url
      @description      = description
      @n                = n
      @datetime         = datetime
      @author           = author
      @tags             = tags
    end

    def url
      return @url
    end

    def description
      return @description
    end

    def n
      return @n
    end

    def datetime
      return @datetime
    end

    def author
      return @author
    end

    def tags
      return @author
    end
  end
end

Liquid::Template.register_tag('pinboard', Jekyll::Pinboard)
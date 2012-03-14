# Pinboard Tag Plugin for Jekyll

Generates a list of links to a user's public bookmarks

## Usage:

    {% pinboard user:username limit:# %}

## Example:

    {% pinboard user:ericdfields limit:12 %}

## All paramaters are optional, e.g.:

    {% pinboard user:ericdfields %}

## Default Configuration (override in _config.yml):

    Pinboard_set:
      user:            'ericdfields'
      limit:  15
      list_tag:     'ol'
      list_class:   'pinboard_list'
      a_target:        '_blank'

* Author: Eric D. Fields
* Site: http://ericdfields.com
* Twitter: @ericdfields
* Email: ericdfields.com
* Plugin Source: http://github.com/ericdfields/Jekyll-Pinboard-Tag
* Plugin License: MIT

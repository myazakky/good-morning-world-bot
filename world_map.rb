# frozen_string_literal: true

require 'bundler/setup'
require 'worldize'

class WorldMap
  attr_reader :country

  def initialize(country)
    @country = country
  end

  def self.paint(country)
    WorldMap.new(country).print
  end

  def print
    img.write('world_map.png')
  end

  private

  def img
    map = Worldize::Countries.new
    map.draw(
      ocean: '#b0e0e6',
      land: '#faebd7',
      border: 'black',
      'Japan' => '#FE7ECD',
      country => 'red'
    )
  end
end

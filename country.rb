# frozen_string_literal: true

require_relative 'tz_serializer'

class Country
  attr_reader :city

  def initialize(city)
    @city = city
  end

  def self.has(city)
    Country.new(city).find_country
  end

  def find_country
    countries = TZSerializer.new.country_name_wih_idf
    name = countries.find { |_k, v| v.any? { _1.include?(city) } }.first
    remove_wihin_kakko(name)
  end

  private

  def remove_wihin_kakko(str)
    str.chars.take_while { _1 != '(' }.join.gsub(' ', '')
  end
end

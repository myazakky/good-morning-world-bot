# frozen_string_literal: true

require 'tzinfo'

class TZSerializer
  attr_reader :tz, :countries

  def initialize
    @tz = TZInfo::Timezone
    @countries = TZInfo::Country.all
  end

  def country_name_wih_idf
    idf = countries.map(&:zone_info).map { _1.map(&:identifier) }
    names = countries.map(&:name)
    names.zip(idf).to_h
  end

  def zone_infos
    zones = tz.all_country_zone_identifiers.map { |zone| tz.get(zone) }
    add_current_time(zones)
  end

  private

  def add_current_time(zones)
    zones.map do |tz|
      pair = tz.name.split('/')
      now = tz.now
      {
        area: pair.first,
        city: pair.last,
        current_time: now.hour * 60 + now.min
      }
    end
  end
end

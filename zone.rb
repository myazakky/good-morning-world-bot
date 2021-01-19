# frozen_string_literal: true

require_relative 'tz_serializer'

class Zone
  attr_reader :should_get_up_at, :info, :time

  def initialize(should_get_up_at)
    @should_get_up_at = to_min(should_get_up_at)
    @info = zone_infos.last.sample
    @time = zone_infos.first
  end

  def area
    info[:area]
  end

  def city
    info[:city]
  end

  def now
    h_m = time.divmod(60).map(&:to_s)
    { hour: h_m.first, min: h_m.last }
  end

  private

  def zone_infos
    TZSerializer.new.zone_infos
                .group_by { _1[:current_time] }
                .min_by do |k, _v|
      (should_get_up_at - k).abs
    end
  end

  def to_min(hash)
    h = hash[:hour]
    m = hash[:min]
    h * 60 + m
  end
end

#!/usr/bin/env ruby

require 'net/http'
require 'uri'

def get_variable(value)
  puts "Enter #{value}: "
  value = gets.chomp
end

def request_items_data
  uri = URI.parse("http://#{get_variable('Avalon URL')}/admin/collections/#{get_variable('Collection ID')}/items.json")

  request = Net::HTTP::Get.new(uri)
  request["Avalon-Api-Key"] = get_variable("Avalon-Api-Key")

  req_options = {use_ssl: uri.scheme == "https",}

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  if response.code != "200"
    puts "There was a problem with your request. Response code: #{response.code}"  
  else
    return response.body
  end
end

def export_items_data
  File.open("Avalon_Export_List.json","w") do |f|
    f.write(request_items_data)
  end
end

export_items_data

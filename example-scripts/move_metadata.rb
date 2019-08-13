#!/usr/bin/env ruby

require 'net/http'
require 'fileutils'
require 'json'
require 'pry'

def get_variable(value)
  puts "Enter #{value}: "
  value = gets.chomp
end

def retrieve_mods
  file = "Avalon_Export_List.json"
  list = JSON.parse(File.read(file))
  items = list.keys

  url = get_variable("Avalon URL")
  api_key = get_variable("Avalon-Api-Key")

  items.each_with_index do |item, index|
    file_id = items[index]
    uri = URI.parse("http://#{url}/media_objects/#{file_id}/content/descMetadata.json")

    request = Net::HTTP::Get.new(uri.request_uri)
    request["Avalon-Api-Key"] = api_key
    req_options = {use_ssl: uri.scheme == "https",}

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    if response.code != "200"
      puts "There was a problem with your request. Response code: #{response.code}"  
    else
      FileUtils.mkdir_p("#{FileUtils.pwd}/#{file_id}")
      open("#{FileUtils.pwd}/#{item}/#{file_id}.xml", "w") { |file|
        file.write(response.body)
      }
    end
  end
end

retrieve_mods

#!/usr/bin/env ruby

require 'json'

def print_items_list
  listHash = Hash.new {|h,k| h[k]=[]}
  file = File.read("Avalon_Export_List.json")
  json = JSON.parse(file)
  items = json.keys
  collection_name = JSON.parse(json[json.keys.first])["collection"]
  items.each do |item|
    puts "Item '#{JSON.parse(json[item])["title"]}' ID: #{item}"
    listHash[item]
    files = JSON.parse(json[item])["files"]
    files.each do |file|
      file_loc = file["file_location"]
      listHash[listHash.keys[-1]] << file_loc
      puts "  File: #{file_loc}"
    end
  end
end

print_items_list
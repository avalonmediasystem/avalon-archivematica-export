#!/usr/bin/env ruby

require 'fileutils'
require 'json'

list = JSON.parse(File.read("Avalon_Export_List.json")
items = JSON.parse(list).keys

items.each do |item|
  destination = FileUtils.mkdir(item)
  files = JSON.parse(list)[item]
  files.each do |file|
    puts "Moving #{file}"
    FileUtils.cp(file, "#{FileUtils.pwd}/#{item}")
  end
end
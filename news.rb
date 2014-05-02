#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require 'nokogiri'
require 'open-uri'

categories = {
  '政治'       => 'politics',
  '選挙'       => 'election',
  '経済'       => 'economy',
  '社会'       => 'national',
  'IT'         => 'it',
  '国際'       => 'world',
  'スポーツ'   => 'sports',
  'カルチャー' => 'calture',
  '科学'       => 'science',
  '環境'       => 'eco',
}

arg_category = ARGV[0]
category = nil
begin
  category = categories.fetch(arg_category)
rescue IndexError
  category = ARGV[0] if categories.has_value?(ARGV[0])
end

unless category
  puts "Error: 存在しないカテゴリ '#{ARGV[0]}'"
  exit
end

doc = Nokogiri::HTML open("http://www.yomiuri.co.jp/#{category}/?from=ygnav")
ranking_litags = doc.xpath('//div[@id = "leftColumn"]/ul[@class = "list-common list-common-ranking"]/li')

ranking_litags.each_with_index do |node,i|
  puts "[#{(i+1).to_s.rjust(2,' ')}] #{node.child.text}"
end

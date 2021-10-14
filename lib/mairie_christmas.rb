# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require_relative 'result_to_json'

def get_townhall_mail(townhall_url)
  result = {}
  page = Nokogiri::HTML(URI.parse(townhall_url).open)

  town = page.xpath('//main//h1').text.match(/.+(?= - \d{5})/).to_s.capitalize
  mail = page.xpath('//section[2]//tbody/tr[4]/td[2]').text

  result[town] = mail

  puts "\e[36m#{town.ljust(30)} => \e[92m#{mail}\e[0m"

  result
end

def get_townhall_urls(county_url)
  town_urls = []
  page = Nokogiri::HTML(URI.parse(county_url).open)

  page.xpath('//p/a').each { |town| town_urls << "http://annuaire-des-mairies.com#{town['href'][1..]}" }

  town_urls
end

def get_townhall_mails_of(county_url)
  result = []

  get_townhall_urls(county_url).each { |t| result << get_townhall_mail(t) }

  result_to_json('mairies', result)

  result
end

get_townhall_mails_of('http://annuaire-des-mairies.com/val-d-oise.html')

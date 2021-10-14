# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'json'

def get_deputy_infos(url)
  infos = {}

  page = Nokogiri::HTML(URI.parse(url).open)

  names = page.xpath('//div[contains(@class, "titre-bandeau-bleu")]/h1').text

  infos[:first_name] = names.split[1]
  infos[:last_name] = names.split[2..].join(' ')

  begin
    infos[:mail] = page.xpath('//a[contains(@href, "mailto:")]')[0]['href']
                       .match(/((?<=mailto:).+)/).to_s
  rescue StandardError
    infos[:mail] = "\e[31mPas de mail 😢\e[0m"
  end

  puts "\e[36m#{names.ljust(30)} => \e[92m#{infos[:mail]}\e[0m"

  infos
end

def get_deputy_urls
  page = Nokogiri::HTML(URI.parse('https://www2.assemblee-nationale.fr/deputes/liste/alphabetique').open)

  page.xpath('//a[contains(@href, "/deputes/fiche/")]').map do |url|
    "https://www2.assemblee-nationale.fr#{url['href']}"
  end
end

def get_all_deputies_infos
  deputies_list = []

  get_deputy_urls.each { |url| deputies_list << get_deputy_infos(url) }

  result_to_json('deputes', deputies_list)

  deputies_list
end

get_all_deputies_infos

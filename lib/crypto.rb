# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require_relative 'result_to_json'

COIN_MARKET_CAP_URL = 'https://coinmarketcap.com/all/views/all/'

def crypto_scrapper
  page = Nokogiri::HTML(URI.parse(COIN_MARKET_CAP_URL).open)

  currencies = []
  currency_values = []

  page.xpath('//a[contains(@class, "cmc-table__column-name--name")]').each { |c| currencies << c.text }
  page.xpath('//span[contains(@class, "sc-1ow4cwt-0")]').each { |v| currency_values << v.text }

  result = Hash[currencies.zip(currency_values)]

  puts(result.map { |k, v| "\e[36m#{k.ljust(20)} => \e[92m#{v}\e[0m" })

  result_to_json('crypto', result)

  result
end

crypto_scrapper

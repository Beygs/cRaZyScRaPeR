# frozen_string_literal: true

require_relative('../lib/crypto')

describe 'crypto_scrapper method' do
  it 'should not return nil' do
    expect(crypto_scrapper).not_to be_nil
  end

  it 'should return a hash with at least 15 keys' do
    expect(crypto_scrapper).to include('Bitcoin')
    expect(crypto_scrapper['Bitcoin']).to match(/$/)
    expect(crypto_scrapper.keys.length).to be > 15
  end
end

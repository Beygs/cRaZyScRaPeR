# frozen_string_literal: true

require_relative('../lib/mairie_christmas')

describe 'get_townhall_mail method' do
  it 'should not return nil' do
    expect(get_townhall_mail('https://www.annuaire-des-mairies.com/95/avernes.html'))
      .not_to be_nil
  end

  it 'should return a hash with the city and the mail address' do
    expect(get_townhall_mail('https://www.annuaire-des-mairies.com/95/avernes.html'))
      .to eq({ 'Avernes' => 'mairie.avernes@orange.fr' })
  end
end

describe 'get_townhall_urls' do
  it 'should return an array with the urls of all the townhalls of a county' do
    expect(get_townhall_urls('http://annuaire-des-mairies.com/val-d-oise.html'))
      .to_not be_nil
    expect(get_townhall_urls('http://annuaire-des-mairies.com/val-d-oise.html').length)
      .to be > 50
    expect(get_townhall_urls('http://annuaire-des-mairies.com/val-d-oise.html')
    .include?('https://www.annuaire-des-mairies.com/95/avernes.html')).to_not be_nil
  end
end

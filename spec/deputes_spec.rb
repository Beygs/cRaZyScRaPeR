# frozen_string_literal: true

require_relative('../lib/deputes')

describe 'get_deputy_infos method' do
  it 'should not return nil' do
    expect(get_deputy_infos('https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036'))
      .not_to be_nil
  end

  it 'should return a hash with the names and the mail address of the deputy' do
    expect(get_deputy_infos('https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036')[:first_name])
      .to eq('Damien')
    expect(get_deputy_infos('https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036')[:last_name])
      .to eq('Abad')
    expect(get_deputy_infos('https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036')[:mail])
      .to eq('damien.abad@assemblee-nationale.fr')
  end
end

describe 'get_deputy_urls' do
  it 'should not return nil' do
    expect(get_deputy_urls).not_to be_nil
  end

  it 'should return a hash with all deputies urls' do
    expect(get_deputy_urls.length).to be > 50
    expect(get_deputy_urls[0]).to be('https://ww2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036')
    expect(get_deputy_urls[50]).to include('https://ww2.assemblee-nationale.fr/deputes/fiche/')
  end
end

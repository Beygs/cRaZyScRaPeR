# frozen_string_literal: true

def result_to_json(result_name, result)
  File.open("./#{result_name}.json", 'w') do |f|
    f.write(result.to_json)
  end
end

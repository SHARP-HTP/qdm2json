require 'hqmf-parser'

module Converter

  def Converter.to_json(content, version=HQMF::Parser::HQMF_VERSION_1)
    doc = HQMF::Parser.parse(content, version)
  end

end

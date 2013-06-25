require 'hqmf-parser'
require 'nokogiri'

module Converter

  HQMF_ROOT_NODE_NAME = "QualityMeasureDocument"

  def Converter.to_json(content, version=HQMF::Parser::HQMF_VERSION_1)
    validate(content)
    version = get_hqmf_version(content)

    parse_version =
    case version
      when "1"
        HQMF::Parser::HQMF_VERSION_1
      when "2"
        HQMF::Parser::HQMF_VERSION_2
      else
        raise "HQMF Version: #{version} is not recognized."
    end

    doc = HQMF::Parser.parse(content, parse_version)
  end

  private
  def Converter.get_hqmf_version(content)
    doc = Nokogiri::XML(content)
    version = doc.xpath("//hl7v3:QualityMeasureDocument/hl7v3:versionNumber/@value", {"hl7v3" => "urn:hl7-org:v3"}).first.value

    version
  end

  def Converter.validate(content)
    doc = Nokogiri::XML(content)

    if doc.nil? or doc.root.nil? or (not doc.root.respond_to?('name')) or doc.root.name != HQMF_ROOT_NODE_NAME
      raise "XML format is not recognized."
    end

  end

end

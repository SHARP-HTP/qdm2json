require 'hqmf-parser'
require 'nokogiri'

module Converter

  HQMF_ROOT_NODE_NAME = "QualityMeasureDocument"

  def Converter.to_json(content, version=HQMF::Parser::HQMF_VERSION_1)
    validate_doc(content)
    validate_version(version)

    HQMF::Parser.parse(content, version)
  end

  private
  def Converter.validate_version(version)
    if not (version == HQMF::Parser::HQMF_VERSION_1 or version == HQMF::Parser::HQMF_VERSION_2)
      raise "Version: #{version} is not recognized."
    end
  end

  def Converter.validate_doc(content)
    doc = Nokogiri::XML(content)

    if doc.nil? or doc.root.nil? or (not doc.root.respond_to?('name')) or doc.root.name != HQMF_ROOT_NODE_NAME
      raise "XML format is not recognized."
    end

  end

end

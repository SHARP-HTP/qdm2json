require 'json'
require 'rest_client'

$emeasure_descriptions = []

module RestClient

  def RestClient.get_hqmf_xml_by_measure_id(measure_id)
    get_hqmf_xml("MeasureId", measure_id)
  end

  def RestClient.get_hqmf_xml_by_nqf_id(measure_id)
    get_hqmf_xml("nqfId", measure_id)
  end

  def RestClient.get_emeasure_descriptions
    $emeasure_descriptions
  end

  private
  def RestClient.get_hqmf_xml(id_type, id)
    url = "https://ushik.ahrq.gov/rest/meaningfulUse/retrieveHQMFXML?#{id_type}=#{id}&format=hqmf"
    response = RestClient.get(url)

    response.body
  end

end

class Emeasure
  attr_accessor :measure_id, :cms_emeasure_id, :nqf_id, :title

  def initialize(json)
    @cms_emeasure_id = json['cmsEmeasureId']
    @measure_id = json['measureid']
    @nqf_id = json['nqf']
    @title = json['title']
  end

end

emeasures = RestClient.get("https://vsac.nlm.nih.gov/vsac/pc/measure/cmsids").body

JSON.parse(emeasures)['rows'].each { |row|
  $emeasure_descriptions << Emeasure.new(row)
}
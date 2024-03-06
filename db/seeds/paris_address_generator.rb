require 'open-uri'
require 'nokogiri'

class ParisAddressGenerator
  class << self
    def generate(attr = {})
      new(attr).generate
    end
  end

  def initialize(attr = {})
    @nb = attr[:number] || 20
    @filepath = attr[:filepath] || "#{`pwd`.strip}/addresses.txt"
  end

  def generate
    streets = random_addresses
    write_file(streets)
  end

  private

  def random_addresses
    url = "https://www.generatormix.com/random-address-in-paris?number=#{@nb}"
    doc = Nokogiri::HTML(URI.open(url).read)
    selector = 'p.text-left strong:contains("Street:")'
    doc.css(selector).map do |strong_tag|
      strong_tag.parent.text.gsub(/Street:/, "").strip
    end
  end

  def write_file(streets)
    File.open(@filepath, 'w') do |file|
      streets.each { |street| file.write("#{street}\n") }
    end
  end
end

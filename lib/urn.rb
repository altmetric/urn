require 'cgi'

class URN
  PATTERN = 'urn:(?!urn:)[a-z0-9\-]{1,31}:[\S]+'.freeze
  REGEX = /^#{PATTERN}$/i

  attr_reader :urn
  private :urn

  def initialize(urn)
    @urn = urn
  end

  def valid?
    !(urn =~ REGEX).nil?
  end

  def normalize
    return unless valid?

    urn_parts = urn.split(':', 3)

    "#{urn_parts[0].downcase}:#{urn_parts[1].downcase}:#{CGI.unescape(urn_parts[2])}"
  end
end

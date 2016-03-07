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

    _scheme, nid, nss = urn.split(':', 3)

    "urn:#{nid.downcase}:#{nss.gsub(/%([0-9a-f]{2})/i) { |hex| hex.downcase }}"
  end
end

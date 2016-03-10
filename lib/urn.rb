class URN
  PATTERN = %{(?i:urn:(?!urn:)[a-z0-9][a-z0-9\-]{1,31}:} +
            %{(?:[a-z0-9()+,-.:=@;$_!*']|%[0-9a-f]{2})+)}.freeze
  REGEX = /\A#{PATTERN}\z/

  attr_reader :urn
  private :urn

  def initialize(urn)
    @urn = urn
  end

  def valid?
    return @valid if defined?(@valid)
    @valid = !(urn =~ REGEX).nil?
  end

  def normalize
    return unless valid?

    return @normalize if defined?(@normalize)
    @normalize = begin
      _scheme, nid, nss = urn.split(':', 3)
      normalized_nid = nid.downcase
      normalized_nss = nss.gsub(/%([0-9a-f]{2})/i) { |hex| hex.downcase }

      "urn:#{normalized_nid}:#{normalized_nss}"
    end
  end

  def ==(other)
    normalize && other.is_a?(URN) && (normalize == other.normalize)
  end
end

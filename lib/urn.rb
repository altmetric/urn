def URN(urn)
  URN.new(urn)
end

class URN
  InvalidURNError = Class.new(StandardError)

  PATTERN = %{(?i:urn:(?!urn:)[a-z0-9][a-z0-9\-]{1,31}:} +
            %{(?:[a-z0-9()+,-.:=@;$_!*']|%[0-9a-f]{2})+)}.freeze
  REGEX = /\A#{PATTERN}\z/

  attr_reader :urn
  private :urn

  def initialize(urn)
    fail(InvalidURNError, "bad URN(is not URN?): #{urn}") if urn !~ REGEX

    @urn = urn
  end

  def valid?
    warn "[DEPRECATION] `valid?` is deprecated. Validity check is now at object creation."
    true
  end

  def normalize
    _scheme, nid, nss = urn.split(':', 3)
    normalized_nid = nid.downcase
    normalized_nss = nss.gsub(/%([0-9a-f]{2})/i, &:downcase)

    "urn:#{normalized_nid}:#{normalized_nss}"
  end
end

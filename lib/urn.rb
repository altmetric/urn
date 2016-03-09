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
    !(urn =~ REGEX).nil?
  end

  def nid
    return unless valid?

    _scheme, nid, _nss = parse

    nid
  end

  def nss
    return unless valid?

    _scheme, _nid, nss = parse

    nss
  end

  def normalize
    return unless valid?

    _scheme, nid, nss = parse
    normalized_nid = nid.downcase
    normalized_nss = nss.gsub(/%([0-9a-f]{2})/i, &:downcase)

    "urn:#{normalized_nid}:#{normalized_nss}"
  end

  private

  def parse
    urn.split(':', 3)
  end
end

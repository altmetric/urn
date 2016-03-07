class URN
  REGEX = %r{
    \A
    urn:
    (?<nid>
      (?!urn:) # the NID "urn" is reserved and MUST NOT be used
      [A-Za-z0-9] # let-num
      [A-Za-z0-9-]{1,31} # let-num-hyp
    )
    :
    (?<nss>
      (?: # URN chars
        [A-Za-z0-9()+,-.:=@;$_!*'] # trans
        |
        %[0-9A-Fa-f]{2} # hex
      )+
    )
    \z
  }xi

  attr_reader :urn
  private :urn

  def initialize(urn)
    @urn = urn
  end

  def valid?
    REGEX === urn
  end

  def normalize
    return unless valid?

    "urn:#{nid}:#{nss}"
  end

  def nid
    return unless valid?

    urn[REGEX, :nid].downcase
  end

  def nss
    return unless valid?

    urn[REGEX, :nss].gsub(/%([0-9a-f]{2})/i) { |hex| hex.downcase }
  end

  def ==(other)
    other.is_a?(URN) && normalize == other.normalize
  end
end

module Kernel
  def URN(urn)
    URN.new(urn)
  end
end

class URN
  InvalidURNError = Class.new(StandardError)

  PATTERN = %{(?i:urn:(?!urn:)[a-z0-9][\x00-\x7F]{1,31}:} +
            %{(?:[a-z0-9()+,-.:=@;$_!*'/]|%(?:2[1-9a-f]|[3-6][0-9a-f]|7[0-9a-e]))+)}.freeze
  REGEX = /\A#{PATTERN}\z/

  attr_reader :urn, :nid, :nss
  private :urn

  def self.extract(str, &blk)
    str.scan(/\b#{PATTERN}/, &blk)
  end

  def initialize(urn)
    urn = urn.to_s
    fail InvalidURNError, "bad URN(is not URN?): #{urn}" if urn !~ REGEX

    @urn = urn
    _scheme, @nid, @nss = urn.split(':', 3)
  end

  def normalize
    normalized_nid = nid.downcase
    normalized_nss = nss.gsub(/%([0-9a-f]{2})/i) { |hex| hex.downcase }

    URN.new("urn:#{normalized_nid}:#{normalized_nss}")
  end

  def to_s
    urn
  end

  def ===(other)
    if other.respond_to?(:normalize)
      urn_string = other.normalize.to_s
    else
      begin
        urn_string = URN.new(other).normalize.to_s
      rescue URN::InvalidURNError
        return false
      end
    end

    normalize.to_s == urn_string
  end

  def ==(other)
    return false unless other.is_a?(URN)

    normalize.to_s == other.normalize.to_s
  end

  def eql?(other)
    return false unless other.is_a?(URN)

    to_s == other.to_s
  end
end

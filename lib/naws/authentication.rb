require 'naws'
require 'openssl'

# Contains the necessary information to authenticate an AWS request.
#
# The signature generated by this class is generally included in an HTTP
# header or as a query string parameter.
#
# Left as an exercise for the reader: implement a subclass of this class which
# calls out to an external process to perform signing, thus eliminating
# the need to include the authentication data in the app.
#
# This class generates a SHA1 HMAC. If you need SHA256, consider subclassing.
class Naws::Authentication

  attr_reader :access_key_id

  def initialize(aws_id, aws_key)
    @access_key_id = aws_id
    @secret_access_key = aws_key
  end

  def algorithm # :nodoc:
    "SHA1"
  end

  # Signs the provided +string+ with the secret access key. Details on what
  # this does and what +string+ should be are here:
  #
  # http://docs.amazonwebservices.com/Route53/latest/DeveloperGuide/index.html?RESTAuthentication.html
  #
  def aws_signature(string)
    hash = OpenSSL::Digest::Digest.new('sha1')
    [OpenSSL::HMAC.digest(hash, secret_access_key, string)].pack("m").chomp
  end

  protected

    def secret_access_key
      @secret_access_key
    end
end

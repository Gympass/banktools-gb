require "attr_extras/explicit"
require "banktools-gb/errors"

module BankTools
  module GB
    class Account
      extend AttrExtras.mixin

      MIN_LENGTH = 6
      MAX_LENGTH = 10

      pattr_initialize :original_value

      def valid?
        errors.none?
      end

      def errors
        errors = []

        errors << Errors::TOO_SHORT if compacted_value.length < MIN_LENGTH
        errors << Errors::TOO_LONG if compacted_value.length > MAX_LENGTH
        errors << Errors::INVALID_CHARACTERS if any_non_digits?

        errors
      end

      private

      def any_non_digits?
        compacted_value.match(/\D/)
      end

      def compacted_value
        original_value.to_s.gsub(/[\s-]/, "")
      end
    end
  end
end

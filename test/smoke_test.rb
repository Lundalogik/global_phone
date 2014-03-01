require File.expand_path('../test_helper', __FILE__)

module GlobalPhone
  class SmokeTest < TestCase
    test "parsing example numbers" do
      example_numbers.each do |(string, territory_name)|
        assert_parses string, territory_name
      end
    end

    def assert_parses(string, territory_name)
      number = context.parse(string, territory_name)
      assert_kind_of Number, number, "expected #{string} to parse for territory #{territory_name}"
      assert_not_nil number.national_string
      assert_not_nil number.national_format
      assert_not_nil number.international_string
      assert_not_nil number.international_format
    end

    test "parsing example numbers" do
      example_short_numbers.each do |(string, territory_name)|
        assert_can_handle_invalid string, territory_name
      end
    end

    def assert_can_handle_invalid(string, territory_name)
      number = context.parse(string, territory_name)
      assert_equal nil, number, "expected #{string} to fail to parse for territory #{territory_name}"
      normalized = context.normalize(string, territory_name)
      assert_equal nil, normalized, "expected #{string} to fail to normalize for territory #{territory_name}"
    end
  end
end

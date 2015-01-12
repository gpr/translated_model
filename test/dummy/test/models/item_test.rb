require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  fixtures :all

  test "the truth" do
    a = items(:a)
    a_name = translated_model_translations(:a_name)
    a_description = translated_model_translations(:a_description)

    b_name = translated_model_translations(:b_name)
    b_description = translated_model_translations(:b_description)
  end
end

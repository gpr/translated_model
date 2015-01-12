require 'test_helper'

class TranslatedModelTest < ActiveSupport::TestCase

  test "TranslatedModel is a module" do
    assert_kind_of Module, TranslatedModel
  end

  test "acts_as_translated_model loading and reloading" do

    a_name = translated_model_translations(:test_a_name)
    a_description = translated_model_translations(:test_a_description)
    item_a = items(:test_a)
    assert_equal item_a.name, a_name.value
    assert_equal item_a.description, a_description.value
    assert_equal item_a.translated_name, a_name
    assert_equal item_a.translated_description, a_description
    item_a.name = 'New name'
    assert_equal item_a.name, 'New name'
    item_a.reload
    assert_equal item_a.name, a_name.value
    item_a.name = 'New name'
    item_a.save
    a_name.reload
    assert_equal item_a.name, a_name.value
  end

  test "acts_as_translated_model loading other locale" do

    b_name = translated_model_translations(:test_b_name)
    b_description = translated_model_translations(:test_b_description)
    item_b = items(:test_b)
    assert_equal item_b.name, b_name.value
  end

  test "acts_as_translated_model creating translations" do
    item_c = items(:test_c)
    item_c.name = 'Item C Name'
    item_c.description = 'Item C Description'
    item_c.save

    item_c_name = TranslatedModel::Translation.find_by translated: item_c, key: :name
    item_c_description = TranslatedModel::Translation.find_by translated: item_c, key: :description
    assert_equal item_c.name, item_c_name.value
    assert_equal item_c.description, item_c_description.value
  end

  test "acts_as_translated_model creating translated" do
    item_d = Item.new(key: 'test_d', name: 'Item D Name', description: 'Item D Description')
    assert_not_nil item_d.translated_name
    assert_not_nil item_d.translated_description
    item_d.save
    item_d_name = TranslatedModel::Translation.find_by translated: item_d, key: :name
    item_d_description = TranslatedModel::Translation.find_by translated: item_d, key: :description
    assert_equal item_d.name, item_d_name.value
    assert_equal item_d.description, item_d_description.value
  end

end

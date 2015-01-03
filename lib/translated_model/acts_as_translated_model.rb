require 'active_support/concern'

module TranslatedModel
  module ActsAsTranslatedModel
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods

      def acts_as_translated_model(options = {})
        after_initialize :set_key
        after_save :create_translations

        cattr_accessor :translated_fields, :key_field
        self.translated_fields = options[:translated_fields] || [:name, :description]
        self.key_field = options[:key_field] || :name

        self.translated_fields.each do |tfield|
          attr_accessor "#{tfield}"
          define_method "translated_#{tfield}" do
            tm = TranslatedModel::Translation.find_by(key: "#{self.key}_#{tfield}", locale: I18n.locale)
            tm = TranslatedModel::Translation.find_by(key: "#{self.key}_#{tfield}", locale: I18n.default_locale) unless tm
            tm.value if tm
          end
        end

        include TranslatedModel::ActsAsTranslatedModel::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods



      def dehumanize(the_string)
        result = ActiveSupport::Inflector.transliterate(the_string).downcase
        result.gsub(/ +/,'_').gsub(/['"-]/,'')
      end

      def key_value
        send(self.key_field)
      end

      private

      def set_key
        self.key = self.dehumanize(self.key_value) unless self.key or self.key_value.nil?
      end

      def create_translations
        self.translated_fields.each do |tfield|
          next unless send("translated_#{tfield}").nil?
          TranslatedModel::Translation.create(key: "#{self.key}_#{tfield}", locale: I18n.locale, value: send(tfield))
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, TranslatedModel::ActsAsTranslatedModel
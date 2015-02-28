require 'active_support/concern'

module TranslatedModel
  module ActsAsTranslatedModel
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods

      def acts_as_translated_model(options = {})
        after_initialize :set_translated_fields
        after_save :save_translations

        default_scope -> { joins(:translations).where(translated_model_translations: { key: 'name' }).distinct }

        cattr_accessor :translated_fields
        self.translated_fields = options[:translated_fields] || [:name, :description]

        self.translated_fields.each do |tfield|
          has_many :translations, class_name: "TranslatedModel::Translation", as: :translated
          has_many :current_translations, ->{where(locale: I18n.locale)}, class_name: "TranslatedModel::Translation", as: :translated

          define_method "#{tfield}" do

            @translated_fields[tfield].value
          end

          define_method "#{tfield}=" do |value|
            if @translated_fields
              @translated_fields[tfield].value = value
            else
              @field_values ||= Hash.new
              @field_values[tfield] = value
            end
          end

          define_method "translated_#{tfield}" do
            @translated_fields[tfield]
          end

          has_one "t_#{tfield}".to_sym, ->{where(key: tfield).where(locale: I18n.locale)}, class_name: 'TranslatedModel::Translation', as: :translated
        end

        include TranslatedModel::ActsAsTranslatedModel::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods

      def dehumanize(the_string)
        result = ActiveSupport::Inflector.transliterate(the_string).downcase
        result.gsub(/ +/,'_').gsub(/['"-]/,'')
      end

      def get_translated_model(tfield)
        t = self.current_translations.find_by key: "#{tfield}" if self.current_translations
        unless t
          value = @field_values[tfield] if @field_values
          unless value
            tm = TranslatedModel::Translation.find_by(translated: self, key: tfield)
            value = tm.value if tm
          end
          t = TranslatedModel::Translation.new(key: tfield, locale: I18n.locale, value: value)
        end
        t
      end

      def reload(options = nil)
        set_translated_fields
        super
      end

      private

      def set_translated_fields
        @translated_fields ||= Hash.new
        self.translated_fields.each do |tfield|
          @translated_fields[tfield] = get_translated_model(tfield)
        end
      end

      def save_translations
        @translated_fields.each do |tfield, t|
          t.translated ||= self
          t.save
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, TranslatedModel::ActsAsTranslatedModel
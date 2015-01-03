# README

Gem to use when you need to allow your Rails application users to translate some models content.

## Install

Add this line to your Gemfile

    gem 'translated_model', github: 'gpr/translated_model'

## Usage

For each Model that requires some translated fields:

   acts_as_translated_model translated_field: [:name, :description], key_field: :name

## License

This project uses MIT-LICENSE.
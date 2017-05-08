require 'active_record/version'

module Gutentag
  def self.dirtier
    @dirtier
  end

  def self.dirtier=(dirtier)
    @dirtier = dirtier
  end

  def self.normaliser
    @normaliser ||= Gutentag::TagName
  end

  def self.normaliser=(normaliser)
    @normaliser = normaliser
  end

  def self.tag_validations
    @tag_validations ||= Gutentag::TagValidations
  end

  def self.tag_validations=(tag_validations)
    @tag_validations = tag_validations
  end
end

require 'gutentag/active_record'
require 'gutentag/dirty'
require 'gutentag/persistence'
require 'gutentag/tag_name'
require 'gutentag/tag_names'
require 'gutentag/tag_validations'
require 'gutentag/tagged_with_query'

if ActiveRecord::VERSION::MAJOR == 3
  Gutentag.dirtier = Gutentag::Dirty
elsif ActiveRecord::VERSION::MAJOR == 4 && ActiveRecord::VERSION::MINOR < 2
  Gutentag.dirtier = Gutentag::Dirty
end

if defined?(Rails::Engine)
  require 'gutentag/engine'
else
  require 'active_record'
  ActiveRecord::Base.send :include, Gutentag::ActiveRecord
  require_relative '../app/models/gutentag/tag'
  require_relative '../app/models/gutentag/tagging'
end

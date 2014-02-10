#
# Autogenerated by Thrift Compiler (0.9.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'

module Honeybee
  module NumericalComparison
    EQUAL = 1
    NOTEQUAL = 2
    LESSTHAN = 3
    LESSTHANOREQUAL = 4
    GREATERTHAN = 5
    GREATERTHANOREQUAL = 6
    VALUE_MAP = {1 => "EQUAL", 2 => "NOTEQUAL", 3 => "LESSTHAN", 4 => "LESSTHANOREQUAL", 5 => "GREATERTHAN", 6 => "GREATERTHANOREQUAL"}
    VALID_VALUES = Set.new([EQUAL, NOTEQUAL, LESSTHAN, LESSTHANOREQUAL, GREATERTHAN, GREATERTHANOREQUAL]).freeze
  end

  module StringComparison
    EQUAL = 1
    NOTEQUAL = 2
    LESSTHAN = 3
    LESSTHANOREQUAL = 4
    GREATERTHAN = 5
    GREATERTHANOREQUAL = 6
    VALUE_MAP = {1 => "EQUAL", 2 => "NOTEQUAL", 3 => "LESSTHAN", 4 => "LESSTHANOREQUAL", 5 => "GREATERTHAN", 6 => "GREATERTHANOREQUAL"}
    VALID_VALUES = Set.new([EQUAL, NOTEQUAL, LESSTHAN, LESSTHANOREQUAL, GREATERTHAN, GREATERTHANOREQUAL]).freeze
  end

  module BooleanComparison
    EQUAL = 1
    NOTEQUAL = 2
    VALUE_MAP = {1 => "EQUAL", 2 => "NOTEQUAL"}
    VALID_VALUES = Set.new([EQUAL, NOTEQUAL]).freeze
  end

  class Action
    include ::Thrift::Struct, ::Thrift::Struct_Union
    ADDTOCONSTANT = 1
    ADDTOCOEFFICIENT = 2

    FIELDS = {
      ADDTOCONSTANT => {:type => ::Thrift::Types::DOUBLE, :name => 'addToConstant'},
      ADDTOCOEFFICIENT => {:type => ::Thrift::Types::MAP, :name => 'addToCoefficient', :key => {:type => ::Thrift::Types::STRING}, :value => {:type => ::Thrift::Types::DOUBLE}}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class NumericalRestriction
    include ::Thrift::Struct, ::Thrift::Struct_Union
    COMPARISON = 1
    VALUE = 2

    FIELDS = {
      COMPARISON => {:type => ::Thrift::Types::I32, :name => 'comparison', :enum_class => ::Honeybee::NumericalComparison},
      VALUE => {:type => ::Thrift::Types::DOUBLE, :name => 'value'}
    }

    def struct_fields; FIELDS; end

    def validate
      unless @comparison.nil? || ::Honeybee::NumericalComparison::VALID_VALUES.include?(@comparison)
        raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field comparison!')
      end
    end

    ::Thrift::Struct.generate_accessors self
  end

  class StringRestriction
    include ::Thrift::Struct, ::Thrift::Struct_Union
    COMPARISON = 1
    VALUE = 2

    FIELDS = {
      COMPARISON => {:type => ::Thrift::Types::I32, :name => 'comparison', :enum_class => ::Honeybee::StringComparison},
      VALUE => {:type => ::Thrift::Types::STRING, :name => 'value'}
    }

    def struct_fields; FIELDS; end

    def validate
      unless @comparison.nil? || ::Honeybee::StringComparison::VALID_VALUES.include?(@comparison)
        raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field comparison!')
      end
    end

    ::Thrift::Struct.generate_accessors self
  end

  class BooleanRestriction
    include ::Thrift::Struct, ::Thrift::Struct_Union
    COMPARISON = 1
    VALUE = 2

    FIELDS = {
      COMPARISON => {:type => ::Thrift::Types::I32, :name => 'comparison', :enum_class => ::Honeybee::BooleanComparison},
      VALUE => {:type => ::Thrift::Types::BOOL, :name => 'value'}
    }

    def struct_fields; FIELDS; end

    def validate
      unless @comparison.nil? || ::Honeybee::BooleanComparison::VALID_VALUES.include?(@comparison)
        raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field comparison!')
      end
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Restriction < ::Thrift::Union
    include ::Thrift::Struct_Union
    class << self
      def numericalRestriction(val)
        Restriction.new(:numericalRestriction, val)
      end

      def stringRestriction(val)
        Restriction.new(:stringRestriction, val)
      end

      def booleanRestriction(val)
        Restriction.new(:booleanRestriction, val)
      end
    end

    NUMERICALRESTRICTION = 1
    STRINGRESTRICTION = 2
    BOOLEANRESTRICTION = 3

    FIELDS = {
      NUMERICALRESTRICTION => {:type => ::Thrift::Types::STRUCT, :name => 'numericalRestriction', :class => ::Honeybee::NumericalRestriction},
      STRINGRESTRICTION => {:type => ::Thrift::Types::STRUCT, :name => 'stringRestriction', :class => ::Honeybee::StringRestriction},
      BOOLEANRESTRICTION => {:type => ::Thrift::Types::STRUCT, :name => 'booleanRestriction', :class => ::Honeybee::BooleanRestriction}
    }

    def struct_fields; FIELDS; end

    def validate
      raise(StandardError, 'Union fields are not set.') if get_set_field.nil? || get_value.nil?
    end

    ::Thrift::Union.generate_accessors self
  end

  class SatisfiesAll
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SATISFIESALL = 1

    FIELDS = {
      SATISFIESALL => {:type => ::Thrift::Types::LIST, :name => 'satisfiesAll', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Honeybee::Restriction}}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class Rule
    include ::Thrift::Struct, ::Thrift::Struct_Union
    FEATURE = 1
    SATISFIESONE = 2
    CONSEQUENCES = 3
    ACTION = 4

    FIELDS = {
      FEATURE => {:type => ::Thrift::Types::STRING, :name => 'feature'},
      SATISFIESONE => {:type => ::Thrift::Types::LIST, :name => 'satisfiesOne', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Honeybee::SatisfiesAll}},
      CONSEQUENCES => {:type => ::Thrift::Types::LIST, :name => 'consequences', :element => {:type => ::Thrift::Types::STRING}},
      ACTION => {:type => ::Thrift::Types::STRUCT, :name => 'action', :class => ::Honeybee::Action}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class RuleDictionary
    include ::Thrift::Struct, ::Thrift::Struct_Union
    RULEDICTIONARY = 1

    FIELDS = {
      RULEDICTIONARY => {:type => ::Thrift::Types::MAP, :name => 'ruleDictionary', :key => {:type => ::Thrift::Types::STRING}, :value => {:type => ::Thrift::Types::STRUCT, :class => ::Honeybee::Rule}}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class PredictiveModel
    include ::Thrift::Struct, ::Thrift::Struct_Union
    ROOTS = 1
    DICTIONARY = 2

    FIELDS = {
      ROOTS => {:type => ::Thrift::Types::LIST, :name => 'roots', :element => {:type => ::Thrift::Types::STRING}},
      DICTIONARY => {:type => ::Thrift::Types::STRUCT, :name => 'dictionary', :class => ::Honeybee::RuleDictionary}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class NumericalOrNominal < ::Thrift::Union
    include ::Thrift::Struct_Union
    class << self
      def numerical(val)
        NumericalOrNominal.new(:numerical, val)
      end

      def nominal(val)
        NumericalOrNominal.new(:nominal, val)
      end
    end

    NUMERICAL = 1
    NOMINAL = 2

    FIELDS = {
      NUMERICAL => {:type => ::Thrift::Types::DOUBLE, :name => 'numerical'},
      NOMINAL => {:type => ::Thrift::Types::STRING, :name => 'nominal'}
    }

    def struct_fields; FIELDS; end

    def validate
      raise(StandardError, 'Union fields are not set.') if get_set_field.nil? || get_value.nil?
    end

    ::Thrift::Union.generate_accessors self
  end

end

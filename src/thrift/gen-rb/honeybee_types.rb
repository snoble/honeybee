#
# Autogenerated by Thrift Compiler (0.8.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#


module Honeybee
    module ComparisonRelationship
      EQUAL = 1
      NOTEQUAL = 2
      LESSTHAN = 3
      LESSTHANOREQUAL = 4
      GREATERTHAN = 5
      GREATERTHANOREQUAL = 6
      VALUE_MAP = {1 => "EQUAL", 2 => "NOTEQUAL", 3 => "LESSTHAN", 4 => "LESSTHANOREQUAL", 5 => "GREATERTHAN", 6 => "GREATERTHANOREQUAL"}
      VALID_VALUES = Set.new([EQUAL, NOTEQUAL, LESSTHAN, LESSTHANOREQUAL, GREATERTHAN, GREATERTHANOREQUAL]).freeze
    end

    class Action
      include ::Thrift::Struct, ::Thrift::Struct_Union
      ADDTOCONSTANT = 1
      ADDTOCOEFICIENT = 2
      ADDIDENTIFIER = 3
      SETIDENTIFIER = 4

      FIELDS = {
        ADDTOCONSTANT => {:type => ::Thrift::Types::DOUBLE, :name => 'addToConstant'},
        ADDTOCOEFICIENT => {:type => ::Thrift::Types::MAP, :name => 'addToCoeficient', :key => {:type => ::Thrift::Types::STRING}, :value => {:type => ::Thrift::Types::DOUBLE}},
        ADDIDENTIFIER => {:type => ::Thrift::Types::STRING, :name => 'addIdentifier'},
        SETIDENTIFIER => {:type => ::Thrift::Types::STRING, :name => 'setIdentifier'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class ComparisonValue < ::Thrift::Union
      include ::Thrift::Struct_Union
      class << self
        def stringValue(val)
          ComparisonValue.new(:stringValue, val)
        end

        def numericalValue(val)
          ComparisonValue.new(:numericalValue, val)
        end

        def booleanValue(val)
          ComparisonValue.new(:booleanValue, val)
        end
      end

      STRINGVALUE = 1
      NUMERICALVALUE = 2
      BOOLEANVALUE = 3

      FIELDS = {
        STRINGVALUE => {:type => ::Thrift::Types::STRING, :name => 'stringValue'},
        NUMERICALVALUE => {:type => ::Thrift::Types::DOUBLE, :name => 'numericalValue'},
        BOOLEANVALUE => {:type => ::Thrift::Types::BOOL, :name => 'booleanValue'}
      }

      def struct_fields; FIELDS; end

      def validate
        raise(StandardError, 'Union fields are not set.') if get_set_field.nil? || get_value.nil?
      end

      ::Thrift::Union.generate_accessors self
    end

    class Comparison
      include ::Thrift::Struct, ::Thrift::Struct_Union
      RELATIONSHIP = 1
      VALUE = 2

      FIELDS = {
        RELATIONSHIP => {:type => ::Thrift::Types::I32, :name => 'relationship', :enum_class => Honeybee::ComparisonRelationship},
        VALUE => {:type => ::Thrift::Types::STRUCT, :name => 'value', :class => Honeybee::ComparisonValue}
      }

      def struct_fields; FIELDS; end

      def validate
        unless @relationship.nil? || Honeybee::ComparisonRelationship::VALID_VALUES.include?(@relationship)
          raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field relationship!')
        end
      end

      ::Thrift::Struct.generate_accessors self
    end

    class SatisfiesAll
      include ::Thrift::Struct, ::Thrift::Struct_Union
      SATISFIESALL = 1

      FIELDS = {
        SATISFIESALL => {:type => ::Thrift::Types::LIST, :name => 'satisfiesAll', :element => {:type => ::Thrift::Types::STRUCT, :class => Honeybee::Comparison}}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class SingleFeatureRule
      include ::Thrift::Struct, ::Thrift::Struct_Union
      FEATURE = 1
      SATISFIESONE = 2

      FIELDS = {
        FEATURE => {:type => ::Thrift::Types::STRING, :name => 'feature'},
        SATISFIESONE => {:type => ::Thrift::Types::LIST, :name => 'satisfiesOne', :element => {:type => ::Thrift::Types::STRUCT, :class => Honeybee::SatisfiesAll}}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class Rule
      include ::Thrift::Struct, ::Thrift::Struct_Union
      SINGLEFEATURERULES = 1

      FIELDS = {
        SINGLEFEATURERULES => {:type => ::Thrift::Types::LIST, :name => 'singleFeatureRules', :element => {:type => ::Thrift::Types::STRUCT, :class => Honeybee::SingleFeatureRule}}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class Scorer
      include ::Thrift::Struct, ::Thrift::Struct_Union
      SCORER = 1

      FIELDS = {
        SCORER => {:type => ::Thrift::Types::MAP, :name => 'scorer', :key => {:type => ::Thrift::Types::STRUCT, :class => Honeybee::Rule}, :value => {:type => ::Thrift::Types::LIST, :element => {:type => ::Thrift::Types::STRUCT, :class => Honeybee::Action}}}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

  end

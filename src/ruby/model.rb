$:.push('gen-rb')
require 'securerandom'
require 'honeybee_types'

module ModelCreator
  include Honeybee
  def self.create_model(object_array_representation)
    predictive_model = PredictiveModel.new
    object_array_representation.each do |rule|
      add_rule_to_array(rule, predictive_model.roots, predictive_model)
    end
    predictive_model
  end

  def self.add_rule_to_array(rule, target_array, predictive_model)
    model_rule = Rule.new
    key = SecureRandom.uuid
    predictive_model.dictionary[key] = model_rule
    target_array << key
    model_rule.feature = rule[:feature]
    if model[:satisfies]
      model[:satisfies].each do restriction_set
        model_restriction_set = SatisfiesAll.new
        restriction_set.each do |k,v|
          model_restriction = Restriction.new
          restriction = NumericalRestriction.new
          restriction.comparison = k
          restriction.value = v
          model_restriction.numericalRestriction = restriction
          model_restriction_set.satisfiesAll << model_restriction
        end
        model_rule.satisfiesOne << model_restriction_set
      end
    end
    if rule[:children]
      rule[:children].each do |child_rule|
        self.add_rule_to_array(rule, target_array, predictive_model)
      end
    end
  end
end

[
  {
    :feature => 'a',
    :satisfies => [{Honeybee::NumericalComparison::EQUAL => nil}, {Honeybee::NumericalComparison::LESSTHANOREQUAL => 0}],
    :children => [
      {
        :feature => 'b',
        :satisfies => [{Honeybee::NumericalComparison::EQUAL => nil}, {Honeybee::NumericalComparison::LESSTHANOREQUAL => 0}],
        :action => {:constant => 25}
      },
      {
        :feature => 'b',
        :satisfies => [{Honeybee::NumericalComparison::NOTEQUAL => nil, Honeybee::NumericalComparison::GREATERTHAN => 0}],
        :action => {:constant => -30}
      }
    ]
  },
  {
    :feature => 'a',
    :satisfies => [{Honeybee::NumericalComparison::NOTEQUAL => nil, Honeybee::NumericalComparison::GREATERTHAN => 0}],
    :action => {:coefficients => {'b' => 2}}
  }
]
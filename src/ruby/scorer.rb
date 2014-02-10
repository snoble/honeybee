$:.push('gen-rb')
require 'scorer'

class ScorerHandler
  def scoreRow(model, row)
    scoreRowHelper(model.roots, model.dictionary, row)
  end

  def scoreRowHelper(ruleKeys, dictionary, row)
    scores = ruleKeys.map {|k| dictionary[k]}.map do |rule|
      if satisfies_rule(rule, row)
        (rlue.action.addToConstant ? addToConstant : 0) +
        rule.action.addToCoefficient.reduce(0) {|feature, coefficient| row[feature]*coefficient} +
        scoreRowHelper(rule.consequences, dictionary, row)
      else
        0
      end
    end
    scores.flatten.reduce(0, :+)
  end

  def scoreRows(model, rows)
  end

  def satifies_rule(rule, row)
    rule.satisfiesOne.any? do |restrictions|
      restrictions.satisfiesAll.all? do |restriction|
        feature_value = row[rule.feature]
        case
        when restriction.numericalRestriction
          value = restriction.numericalRestriction.value
          case restriction.numericalRestriction.comparison
          when Honeybee::NumericalComparison::EQUAL
            value == feature_value
          when Honeybee::NumericalComparison::NOTEQUAL
            value != feature_value
          when Honeybee::NumericalComparison::LESSTHAN
            value < feature_value
          when Honeybee::NumericalComparison::LESSTHANOREQUAL
            value <= feature_value
          when Honeybee::NumericalComparison::GREATERTHAN
            value > feature_value
          when Honeybee::NumericalComparison::GREATERTHANOREQUAL
            value >= feature_value
          else
            false
          end
        when restriction.stringRestriction
          value = restriction.stringRestriction.value
          case restriction.stringRestriction.comparison
          when Honeybee::StringComparison::EQUAL
            value == feature_value
          when Honeybee::StringComparison::NOTEQUAL
            value != feature_value
          when Honeybee::StringComparison::LESSTHAN
            value < feature_value
          when Honeybee::StringComparison::LESSTHANOREQUAL
            value <= feature_value
          when Honeybee::StringComparison::GREATERTHAN
            value > feature_value
          when Honeybee::StringComparison::GREATERTHANOREQUAL
            value >= feature_value
          else
            false
          end            
        when restriction.booleanRestriction
          value = restriction.booleanRestriction.value
          case restriction.booleanRestriction.comparison
          when Honeybee::BooleanComparison::EQUAL
            value == feature_value
          when Honeybee::BooleanComparison::NOTEQUAL
            value != feature_value
          else
            false
          end
        else
          false
        end
      end
    end
  end
end

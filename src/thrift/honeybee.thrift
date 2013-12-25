namespace java honeybee
namespace rb honeybee

struct Action {
  1: double addToConstant,
  2: map<string, double> addToCoefficient
}

enum ComparisonRelationship {
  EQUAL = 1,
  NOTEQUAL = 2,
  LESSTHAN = 3,
  LESSTHANOREQUAL = 4,
  GREATERTHAN = 5,
  GREATERTHANOREQUAL = 6
}

union ComparisonValue {
  1: string stringValue,
  2: double numericalValue,
  3: bool booleanValue
}

struct Comparison {
  1: ComparisonRelationship relationship,
  2: ComparisonValue value
}

struct SatisfiesAll {
  1: list<Comparison> satisfiesAll
}

struct SingleFeatureRule {
  1: string feature,
  2: list<SatisfiesAll> satisfiesOne
}

struct Rule {
  1: list<SingleFeatureRule> singleFeatureRules
}

struct Scorer {
  1: map<Rule, list<Action>> scorer
}

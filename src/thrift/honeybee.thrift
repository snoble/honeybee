namespace java honeybee
namespace rb honeybee

struct Action {
  1: double addToConstant,
  2: map<string, double> addToCoefficient
}

enum NumericalComparison {
  EQUAL = 1,
  NOTEQUAL = 2,
  LESSTHAN = 3,
  LESSTHANOREQUAL = 4,
  GREATERTHAN = 5,
  GREATERTHANOREQUAL = 6
}

enum StringComparison {
  EQUAL = 1,
  NOTEQUAL = 2,
  LESSTHAN = 3,
  LESSTHANOREQUAL = 4,
  GREATERTHAN = 5,
  GREATERTHANOREQUAL = 6
}

enum BooleanComparison {
  EQUAL = 1,
  NOTEQUAL = 2,
}

struct NumericalRestriction {
  1: NumericalComparison comparison,
  2: double value
}

struct StringRestriction {
  1: StringComparison comparison,
  2: string value
}

struct BooleanRestriction {
  1: BooleanComparison comparison,
  2: bool value
}

union Restriction {
  1: NumericalRestriction numericalRestriction,
  2: StringRestriction stringRestriction,
  3: BooleanRestriction booleanRestriction
}

struct SatisfiesAll {
  1: list<Restriction> satisfiesAll
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

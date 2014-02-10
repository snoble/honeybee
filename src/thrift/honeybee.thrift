namespace java honeybee
namespace rb Honeybee

struct Action {
  1: double addToConstant,
  2: map<string, double> addToCoefficient
}

enum NumericalComparison {
  EQUAL=1,
  NOTEQUAL=2,
  LESSTHAN=3,
  LESSTHANOREQUAL=4,
  GREATERTHAN=5,
  GREATERTHANOREQUAL=6
}

enum StringComparison {
  EQUAL=1,
  NOTEQUAL=2,
  LESSTHAN=3,
  LESSTHANOREQUAL=4,
  GREATERTHAN=5,
  GREATERTHANOREQUAL=6
}

enum BooleanComparison {
  EQUAL=1,
  NOTEQUAL=2,
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

struct Rule {
  1: string feature,
  2: list<SatisfiesAll> satisfiesOne
  3: list<string> consequences
  4: Action action
}

struct RuleDictionary {
  1: map<string, Rule> ruleDictionary
}

struct PredictiveModel {
  1: list<string> roots
  2: RuleDictionary dictionary
}

union NumericalOrNominal {
  1: double numerical,
  2: string nominal
}

service Scorer {
  double scoreRow(1: PredictiveModel model, 2: map<string, NumericalOrNominal> row)
  list<double> scoreRows(1: PredictiveModel model, 2: list<map<string, NumericalOrNominal>> rows)
}

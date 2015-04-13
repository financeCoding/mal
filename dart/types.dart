library mal.types;

abstract class MalType extends Function {
  call() { throw new Error(); }
}

class MalList extends MalType {
  final List<MalType> malTypes;
  MalList(): malTypes = new List<MalType>();
  MalList.fromList(this.malTypes);
  String toString() => "(${malTypes.join(' ')})";
}

// TODO(ADAM): do not inherit from mallist, treat them as two seprate types and then fix the type checks.
class MalVector extends MalList {
  String toString() => "[${malTypes.join(' ')}]";
}

class MalHashMap extends MalType {
  final Map<String, MalType> malHashMap;
  MalHashMap(): malHashMap = new Map<String, MalType>();
  MalHashMap.fromMalList(MalList malList): malHashMap = new Map<String, MalType>() {
    for (int i = 0; i < malList.malTypes.length; i+=2) {
      MalType key = malList.malTypes[i];
      MalType val = malList.malTypes[i+1];
      malHashMap[key.toString()] = val;
    }
  }
  String toString() {
    StringBuffer sb = new StringBuffer();
    malHashMap.forEach((String k,MalType v) {
      sb.write("$k ${v.toString()}");
    });

    return "{${sb.toString()}}";
  }
}

class MalNumber extends MalType {
  final num number;
  MalNumber(this.number);
  String toString() => number.toString();
}

class MalSymbol extends MalType {
  final String symbol;
  MalSymbol(this.symbol);
  String toString() => symbol.toString();

  @override
  bool operator ==(other) {
    if (other.runtimeType == this.runtimeType && other.symbol == this.symbol) {
      return true;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    return symbol.hashCode;
  }
}

class MalKeyword extends MalType {
  final String keyword;
  MalKeyword(this.keyword);

  @override
  String toString() => keyword.toString();

  @override
  bool operator ==(other) {
    if (other.runtimeType == this.runtimeType && other.keyword == this.keyword) {
      return true;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    return keyword.hashCode;
  }
}

final BIND_SYMBOL = new MalSymbol("&");

class MalString extends MalType {
  final String string;
  MalString(this.string);
  String toString() => string.toString();
}

class MalBoolean extends MalType {
  final bool value;
  MalBoolean(this.value);
  String toString() => "${this.value}";
}

class MalTrue extends MalBoolean {
  MalTrue(): super(true);
}

class MalFalse extends MalBoolean {
  MalFalse(): super(false);
}

class MalNil extends MalFalse {
  MalNil(): super();
  String toString() => "nil";
}

final MAL_NIL = new MalNil();
final MAL_TRUE = new MalTrue();
final MAL_FALSE = new MalFalse();

typedef dynamic OnCall(List);

abstract class VarargsFunction extends MalType {
  OnCall _onCall;

  VarargsFunction(this._onCall);

  call() => _onCall([]);

  noSuchMethod(Invocation invocation) {
    final arguments = invocation.positionalArguments;
    return _onCall(arguments);
  }
}

class MalFunction extends VarargsFunction {
  MalFunction(OnCall onCall): super(onCall);
}

class SumBinaryOperator extends VarargsFunction  {
  SumBinaryOperator(OnCall onCall): super(onCall);
}

class MinusBinaryOperator extends VarargsFunction {
  MinusBinaryOperator(OnCall onCall): super(onCall);
}

class MultiplyBinaryOperator extends VarargsFunction {
  MultiplyBinaryOperator(OnCall onCall): super(onCall);
}

class DivideBinaryOperator extends VarargsFunction {
  DivideBinaryOperator(OnCall onCall): super(onCall);
}

class LessThanBinaryOperator extends VarargsFunction {
  LessThanBinaryOperator(OnCall onCall): super(onCall);
}

class LessThanEqualBinaryOperator extends VarargsFunction {
  LessThanEqualBinaryOperator(OnCall onCall): super(onCall);
}

class GreaterThanBinaryOperator extends VarargsFunction {
  GreaterThanBinaryOperator(OnCall onCall): super(onCall);
}

class GreaterThanEqualBinaryOperator extends VarargsFunction {
  GreaterThanEqualBinaryOperator(OnCall onCall): super(onCall);
}

class ToList extends VarargsFunction {
  ToList(OnCall onCall): super(onCall);
}

class IsList extends VarargsFunction {
  IsList(OnCall onCall): super(onCall);
}

class IsEmpty extends VarargsFunction {
  IsEmpty(OnCall onCall): super(onCall);
}

class IsEqual extends VarargsFunction {
  IsEqual(OnCall onCall): super(onCall);
}

class Count extends VarargsFunction {
  Count(OnCall onCall): super(onCall);
}

class PrStr extends VarargsFunction {
  PrStr(OnCall onCall): super(onCall);
}

class Str extends VarargsFunction {
  Str(OnCall onCall): super(onCall);
}

class Prn extends VarargsFunction {
  Prn(OnCall onCall): super(onCall);
}

class PrintLn extends VarargsFunction {
  PrintLn(OnCall onCall): super(onCall);
}

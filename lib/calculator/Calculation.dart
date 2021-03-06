///
/// 计算业务
///
/// @author liujie https://github.com/Handy045
/// @description File Description
/// @date Created in 2018/11/12 9:13 AM
///
class Calculation {
  static final String rem = "%";
  static final String div = "/";
  static final String mul = "*";
  static final String sub = "-";
  static final String add = "+";

  static String delPress(String formulaData) {
    if (formulaData.trim().isNotEmpty) {
      String subString = formulaData.substring(formulaData.length - 2, formulaData.length - 1);
      if (subString != rem && subString != div && subString != mul && subString != sub && subString != add) {
        return formulaData.substring(0, formulaData.length - 1);
      } else {
        return formulaData.substring(0, formulaData.length - 3);
      }
    } else {
      return "";
    }
  }

  static String symbolPress(String formulaData, String symbol) {
    if (formulaData.trim().isNotEmpty) {
      bool canPress = true;
      formulaData += formulaData.substring(formulaData.length - 1, formulaData.length) == "." ? "0" : "";

      if (formulaData.length > 1) {
        String subString = formulaData.substring(formulaData.length - 2, formulaData.length - 1);
        canPress = !(subString == rem || subString == div || subString == mul || subString == sub || subString == add);
      }

      if (canPress) {
        if (symbol == rem) {
          formulaData += " $symbol ";
        } else if (symbol == div) {
          formulaData += " $symbol ";
        } else if (symbol == mul) {
          formulaData += " $symbol ";
        } else if (symbol == sub) {
          formulaData += " $symbol ";
        } else if (symbol == add) {
          formulaData += " $symbol ";
        }
      }
      return formulaData;
    } else {
      return "";
    }
  }

  static bool pointPress(String formulaData) {
    if (formulaData.trim().isEmpty) {
      return true;
    } else {
      String cache = formulaData.replaceAll(rem, "#").replaceAll(div, "#").replaceAll(mul, "#").replaceAll(sub, "#").replaceAll(add, "#");
      List<String> splitString = cache.split("#");
      if (splitString.length == 0) {
        return true;
      } else {
        String lastString = splitString[splitString.length - 1];
        if (lastString.trim().isEmpty) {
          return true;
        } else {
          return lastString.contains(".");
        }
      }
    }
  }

  static String equalPress(String formulaData) {
    if (formulaData.trim().isEmpty) {
      return "0";
    } else {
      List<String> _numData = new List();
      List<String> _symData = new List();
      int cacheIndex = 0;

      print("====================公式拆分====================");
      formulaData = formulaData.replaceAll(" ", "");
      String lastChart = formulaData.substring(formulaData.length - 1, formulaData.length);
      if (lastChart == rem || lastChart == div || lastChart == mul || lastChart == sub || lastChart == add) {
        formulaData = formulaData.substring(0, formulaData.length - 1);
      }

      for (int i = 0; i < formulaData.length; i++) {
        String cache = formulaData[i];
        if (cache == rem || cache == div || cache == mul || cache == sub || cache == add) {
          _symData.add(cache);
          _numData.add(formulaData.substring(cacheIndex, i));
          cacheIndex = i + 1;
        }
      }
      if (cacheIndex < formulaData.length) {
        _numData.add(formulaData.substring(cacheIndex, formulaData.length));
      }

      print("公式拆分，数字：$_numData");
      print("公式拆分，符号：$_symData");
      print("\n");
      print("====================开始计算====================");

      int count = 1;
      while (_symData.length > 0) {
        if (_symData.contains(mul) || _symData.contains(div) || _symData.contains(rem)) {
          for (int i = 0; i < _symData.length; i++) {
            if (_symData[i] == mul || _symData[i] == div || _symData[i] == rem) {
              double X = double.parse(_numData[i]);
              double Y = double.parse(_numData[i + 1]);
              if (_symData[i] == mul) {
                _numData.insert(i, "${X * Y}");
                _numData.removeAt(i + 1);
                _numData.removeAt(i + 1);
              } else if (_symData[i] == div) {
                _numData.insert(i, "${X / Y}");
                _numData.removeAt(i + 1);
                _numData.removeAt(i + 1);
              } else if (_symData[i] == rem) {
                _numData.insert(i, "${X % Y}");
                _numData.removeAt(i + 1);
                _numData.removeAt(i + 1);
              }
              _symData.removeAt(i);

              print("$count 、");
              print("数字：$_numData");
              print("符号：$_symData");
              print("\n");
              i--;
              count++;
            }
          }
        } else {
          for (int i = 0; i < _symData.length; i++) {
            if (_symData[i] == sub || _symData[i] == add) {
              double X = double.parse(_numData[i]);
              double Y = double.parse(_numData[i + 1]);
              if (_symData[i] == sub) {
                _numData.insert(i, "${X - Y}");
                _numData.removeAt(i + 1);
                _numData.removeAt(i + 1);
              } else if (_symData[i] == add) {
                _numData.insert(i, "${X + Y}");
                _numData.removeAt(i + 1);
                _numData.removeAt(i + 1);
              }
              _symData.removeAt(i);

              print("$count 、");
              print("数字：$_numData");
              print("符号：$_symData");
              print("\n");
              i--;
              count++;
            }
          }
        }
      }
      print("计算结果：${_numData[0]}");
      return _numData[0];
    }
  }
}

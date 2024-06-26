import 'package:shared_preferences/shared_preferences.dart';
  bool? value;
  bool? musicValues;
  int? winScore;
  int? drawScore;

  class SharedPref{
  Future<bool>  getSoundValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  value = prefs.getBool('soundValue') ?? true;

  return value!;
  }

  void setSoundValue(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('soundValue', value);
  }

  Future<bool> getMusicValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    musicValues = prefs.getBool('musicValue') ?? false;

    return musicValues!;
  }
  void setMusicValue(bool musicValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('musicValue', musicValue);
  }

  Future<int> getWinValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    winScore = prefs.getInt('winValue');

    return winScore!;
  }
  void setWinValue(int winScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('winValue', winScore);
  }

  Future<int> getDrawValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    drawScore = prefs.getInt('drawValue');

    return drawScore!;
  }
  void setDrawValue(int drawScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('drawValue', drawScore);
  }


}
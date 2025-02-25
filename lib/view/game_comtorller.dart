import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hot_air_balloon/model/game_model.dart';
import 'package:hot_air_balloon/res/app_colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameController with ChangeNotifier {
  int? _nextPeriod;

  int? get nextPeriod => _nextPeriod;

  setNextPeriod(int? value) {
    _nextPeriod = value;
    notifyListeners();
  }
  int _button1=0;

  int get button1 => _button1;

  setButton1(int value) {
    _button1 = value;
    notifyListeners();
  }
  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  setIsExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  bool _betPlaced = false;
  bool _betStop = false;
  // int _countdownSeconds = 30;
  int _selectedNumber = 10;
  // Timer? _countdownTimer;

  final List<int> selectedNumbers = [];
  int _selectedValue = 2;
  // Default risk level
  // final List<List<String>> lowList = [
  //   ['0.5x', '2.38x'], // For 1 selection
  //   ['0.5x', '1.19x', '0.5x'], // For 2 selections
  //   ['0.5x', '0.5x', '2.2x', '20x'], // For 3 selections
  //   ['0.5x', '0.5x', '1.4x', '5x', '40x'], // For 4 selections
  //   ['0.5x', '0.5x', '1x', '2.4x', '15x', '100x'], // For 5 selections
  //   ['0.5x', '0.5x', '0.5x', '2.13x', '7x', '50x', '200x'], // For 6 selections
  //   [
  //     '0.5x',
  //     '0.5x',
  //     '0.5x',
  //     '2x',
  //     '3.48x',
  //     '6x',
  //     '100x',
  //     '5000x'
  //   ], // For 7 selections
  //   [
  //     '1x',
  //     '0.2x',
  //     '0.2x',
  //     '1x',
  //     '5.21x',
  //     '8x',
  //     '30x',
  //     '300x',
  //     '5000x'
  //   ], // For 8 selections
  //   [
  //     '01x',
  //     '0.5x',
  //     '0.5x',
  //     '0.5x',
  //     '2x',
  //     '5.5x',
  //     '20x',
  //     '400x',
  //     '1000x',
  //     '5000x'
  //   ], // For 9 selections
  //   [
  //     '2x',
  //     '0.5x',
  //     '0.5x',
  //     '0.5x',
  //     '0.5x',
  //     '6.37x',
  //     '15x',
  //     '100x',
  //     '500x',
  //     '2000x',
  //     '5000x'
  //   ], // For 10 selections
  //   // Extend this as needed for more selections
  // ];
  // final List<List<String>> mediumList = [
  //   ['0.2x', '3.28x'], // For 1 selection
  //   ['0.2x', '1.18x', '7x'], // For 2 selections
  //   ['0.2x', '0.2x', '2.74x', '3.5x'], // For 3 selections
  //   ['0.2x', '0.2x', '1.5x', '8x', '80x'], // For 4 selections
  //   ['0.2x', '0.2x', '1x', '3.5x', '20x', '250x'], // For 5 selections
  //   ['0.2x', '0.2x', '0.2x', '2.56x', '9x', '120x', '450x'], // For 6 selections
  //   [
  //     '1x',
  //     '0.2x',
  //     '0.2x',
  //     '2x',
  //     '5.3x',
  //     '10x',
  //     '200x',
  //     '1000x'
  //   ], // For 7 selections
  //   [
  //     '1x',
  //     '0.2x',
  //     '0.2x',
  //     '1x',
  //     '5.21x',
  //     '8x',
  //     '30x',
  //     '300x',
  //     '5000x'
  //   ], // For 8 selections
  //   [
  //     '1.5x',
  //     '0.2x',
  //     '0.2x',
  //     '0.2x',
  //     '2x',
  //     '10.07x',
  //     '30x',
  //     '800x',
  //     '2000x',
  //     '10000x'
  //   ], // For 9 selections
  //   [
  //     '2x',
  //     '0.3x',
  //     '0.3x',
  //     '0.3x',
  //     '0.3x',
  //     '6.2x',
  //     '25x',
  //     '300x',
  //     '8000x',
  //     '90000x',
  //     '800000x'
  //   ], // For 10 selections
  //   // Extend this as needed for more selections
  // ];
  // final List<List<String>> highRiskList = [
  //   ['0x', '3.88x'], // For 1 selection
  //   ['0x', '1.17x', '9x'], // For 2 selections
  //   ['0x', '0x', '2.65x', '50x'], // For 3 selections
  //   ['0x', '0x', '1.62x', '10x', '100x'], // For 4 selections
  //   ['0x', '0x', '1x', '3.78x', '25x', '400x'], // For 5 selections
  //   ['0x', '0x', '0x', '2.67x', '10x', '180x', '700x'], // For 6 selections
  //   [
  //     '1x',
  //     '0x',
  //     '0x',
  //     '2x',
  //     '5.3x',
  //     '20x',
  //     '400x',
  //     '2000x'
  //   ], // For 7 selections
  //   ['1', '0x', '0x', '1x', '5.38x', '11x', '50x', '5000x', '10000x'],
  //   ['2x', '0x', '0x', '0x', '2x', '10.86x', '50x', '1000x', '5000x', '25000x'],
  //   [
  //     '2x',
  //     '0x',
  //     '0x',
  //     '0x',
  //     '1x',
  //     '5.57x',
  //     '30x',
  //     '500x',
  //     '1000x',
  //     '5000x',
  //     '10000x'
  //   ],
  // ];

  // Getters
  bool get betPlaced => _betPlaced;
  bool get betStop => _betStop;
  // int get countdownSeconds => _countdownSeconds;
  int get selectedNumber => _selectedNumber;
  int get selectedValue => _selectedValue;

  // Setters
  void setBetPlaced(bool value) {
    _betPlaced = value;
    notifyListeners();
  }

  void setBetStop(bool value) {
    _betStop = value;
    notifyListeners();
  }

  void setSelectedNumber(int value) {
    _selectedNumber = value;
    notifyListeners();
  }

  // Increment/Decrement Selected Number
  void increment() {
    if (_selectedNumber < 100000) {
      _selectedNumber += 10;
      notifyListeners();
    }
  }

  void decrement() {
    if (_selectedNumber > 10) {
      _selectedNumber -= 10;
      notifyListeners();
    }
  }

  int _kinoMinuteTime = 0;
  int get kinoMinuteTime => _kinoMinuteTime;
  int _kinoMinuteStatus = 0;
  int get kinoMinuteStatus => _kinoMinuteStatus;
  setKinoMinutesData(int time, int status) {
    _kinoMinuteTime = time;
    _kinoMinuteStatus = status;
    notifyListeners();
  }

  int _timeData = 0;

  int get timeData => _timeData;

  setTimeData(int value) {
    _timeData = value;
    notifyListeners();
  }
bool _blast =false;

  bool get blast => _blast;

  setBlast(bool value) {
    _blast = value;
    notifyListeners();
  }
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  setSelectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  late IO.Socket _socket;
  dynamic receiveData = {};
  GameModel ?_gameData;
  GameModel ? get gameData=>_gameData;
  setGameData(GameModel value){
    _gameData=value;
    notifyListeners();
  }
  void connectToServer() {
    _socket = IO.io(
      "https://aviatorudaan.com/",
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );
    _socket.on('connect', (_) {
      if (kDebugMode) {
        print("Socket connected successfully");
      }
    });

    _socket.onConnectError((data) {
      if (kDebugMode) {
        print("Socket not connected ");
      }
    });
    _socket.on("xgameaviator", (data) {
      receiveData = jsonDecode(data);
      setGameData(GameModel.fromJson(receiveData));
      gameData?.status==2?setBetPlaced(false):null;
      gameData?.status==2?playAudio():stopAudio();
      gameData?.status==2?playAudio():stopAudio();
      gameData?.status==1?setBlast(false):null;
      button1==2&&gameData?.status==1?setButton1(1):null;
      gameData?.status==0&& nextPeriod==gameData?.period?setButton1(2):null;
      gameData?.status==1&& nextPeriod==gameData?.period?setButton1(1):null;
      gameData?.status==2?setButton1(0):null;



      // setTimeData(receiveData['timerBetTime']);
      // selectedIndex == 0
      //     ? setTimeData(receiveData['timerBetTime'])
      //     : selectedIndex == 1
      //         ? setTimeData(receiveData['oneMinTimer'])
      //         : selectedIndex == 2
      //             ? setTimeData(receiveData['threeMinTimer'])
      //             : selectedIndex == 3
      //                 ? setTimeData(receiveData['fiveMinTimer'])
      //                 : setTimeData(receiveData['tenMinTimer']);
    });
    _socket.connect();
  }
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio() async {
    blast==false?
    await _audioPlayer.play(AssetSource("sound/blast.mp3")):null;
    Future.delayed(Duration(seconds: 1),(){
      setBlast(true);
    });

  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }
  Future<void> disposeAudio() async {
    await _audioPlayer.dispose();
  }
  String formatTime(int seconds, int position) {
    final Duration duration = Duration(seconds: seconds);
    final int minutes = duration.inMinutes;
    final int remainingSeconds = duration.inSeconds % 60;

    return position == 0
        ? minutes.toString().padLeft(2, '0')
        : remainingSeconds.toString().padLeft(2, '0');
  }

  void disConnectToServer(context) async {
    _socket.disconnect();
    _socket.clearListeners();
    _socket.close();
    if (kDebugMode) {
      print('SOCKET DISCONNECT');
    }
  }

  void toggleBetPlaced() {
    _betPlaced = !_betPlaced;
    notifyListeners();
  }

  // void cancelCountdown() {
  //   _countdownTimer?.cancel();
  //   notifyListeners();
  // }
  //
  // @override
  // void dispose() {
  //   cancelCountdown();
  //   super.dispose();
  // }

  // List<String> getDisplayedList() {
  //   if (selectedNumbers.isEmpty) {
  //     return [];
  //   }
  //
  //   int count = selectedNumbers.length;
  //
  //   if (count > mediumList.length) {
  //     return [];
  //   }
  //   switch (_selectedValue) {
  //     case 1:
  //       return lowList[count - 1];
  //     case 2:
  //       return mediumList[count - 1];
  //     case 3:
  //       return highRiskList[count - 1];
  //     default:
  //       return [];
  //   }
  // }

  void setSelectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }
}
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText({
    Key? key,
    required this.text,
    required this.style,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style.copyWith(color: AppColor.white), // Color is ignored due to ShaderMask
      ),
    );
  }
}
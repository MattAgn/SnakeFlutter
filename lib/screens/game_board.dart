import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ecs/components/positions.dart';
import 'package:snake_game/ecs/systems/main.dart';
import 'package:snake_game/widgets/control_button.dart';

class GameBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Game"),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<GameSystem>(
          create: (context) => GameSystem(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              GameBoardWidget(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ControlButton(
                        text: "<",
                        onPress: () {},
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            ControlButton(onPress: () {}, text: "^"),
                            ControlButton(text: "v", onPress: () {}),
                          ],
                        ),
                      ),
                      ControlButton(
                        text: ">",
                        onPress: () {},
                      ),
                    ],
                  ),
                ),
              ),
              LifecycleButtons()
            ],
          ),
        ),
      ),
    );
  }
}

class LifecycleButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton.icon(
          label: Text("Play"),
          icon: Icon(Icons.play_circle_filled),
          onPressed: gameSystem.play,
        ),
        RaisedButton.icon(
          label: Text("Pause"),
          icon: Icon(Icons.pause_circle_filled),
          onPressed: gameSystem.pause,
        ),
        RaisedButton.icon(
          label: Text("Stop"),
          icon: Icon(Icons.stop),
          onPressed: gameSystem.stop,
        )
      ],
    );
  }
}

class GameBoardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameSystem = Provider.of<GameSystem>(context);

    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height * 0.50,
      child: CustomPaint(
        size: Size.infinite,
        painter: BoardPainter(
            appleCoordinates: gameSystem.appleCoordinates,
            snakeCoordinates: gameSystem.snakeCoordinates),
      ),
    );
  }
}

class BoardPainter extends CustomPainter {
  Coordinates snakeCoordinates;
  Coordinates appleCoordinates;

  BoardPainter({this.snakeCoordinates, this.appleCoordinates});

  @override
  void paint(Canvas canvas, Size size) {
    print("snake coord");
    print(this.snakeCoordinates);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(snakeCoordinates.x, snakeCoordinates.y),
            width: 10,
            height: 10),
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.fill);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(appleCoordinates.x, appleCoordinates.y),
            width: 10,
            height: 10),
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

import 'package:flutter/material.dart';
class TapboxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TapboxAState();
  }

}

class TapboxAState extends State<TapboxA>{

  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
      return new GestureDetector(
        onTap: (){_handleTap();},
        child: new Container(
          child: new Center(
            child: new Text(_active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0,
            color: Colors.white),),
          ),
          width: 200.0,
          height: 200.0,
          decoration: new BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600],
          ),
        ),
      );
  }
}


class CustomPainterSample extends CustomPainter {

  double progress;

  CustomPainterSample({this.progress: 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = new Paint();
    p.color = Colors.green;
    p.isAntiAlias = true;
    p.style = PaintingStyle.fill;
    canvas.drawCircle(size.center(const Offset(0.0, 0.0)), size.width / 2 * progress, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SquareFragmentState extends State<SquareFragment> with TickerProviderStateMixin{
  double progress = 0.0;
  @override
  void initState() {
    AnimationController ac = new AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 10000)
    );
    ac.addListener(() {
      this.setState(() {
        this.progress = ac.value;
      });
    });
    ac.forward();
  }
  @override
  build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new CustomPaint(
        painter: new CustomPainterSample(progress: this.progress),
      ),
    );
  }
  
}

class SquareFragment extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new SquareFragmentState();
  }
}
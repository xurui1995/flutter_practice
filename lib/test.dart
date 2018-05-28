import 'package:flutter/material.dart';

class TapboxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TapboxAState();
  }
}

class TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        _handleTap();
      },
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
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
    canvas.drawCircle(
        size.center(const Offset(0.0, 0.0)), size.width / 2 * progress, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SquareFragmentState extends State<SquareFragment>
    with TickerProviderStateMixin {
  double progress = 0.0;
  @override
  void initState() {
    AnimationController ac = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000));
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

class SquareFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SquareFragmentState();
  }
}

class MyAppBar extends StatelessWidget {
  final Widget title;

  MyAppBar({this.title});
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      child: new Row(
        children: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              tooltip: 'Navigation menu',
              onPressed: null),
          new Expanded(
              child: title
          ),
          new IconButton(
              icon: new Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null)
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new Column(
      children: <Widget>[
        new MyAppBar(
            title: new Text(
            "example title",
        )),
        new Expanded(
            child: new Center(
          child: new Text("Hello world！"),
        ))
      ],
    ));
  }
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: null,
            tooltip: 'menu',
        ),
        title: new Text('Example title'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: null
          )
        ],
      ),

      body: new Center(
        child: new Text('Hello World'),
      ),
      
      floatingActionButton: new FloatingActionButton(
          onPressed: null,
          child: new Icon(Icons.add),
      ),
    );
  }

}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        print('MyButton was taped!');
      },
      child: new Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(5.0),
          color: Colors.lightGreen
        ),
        child: new Center(
          child: new Text('Engage'),
        ),
      ),
    );
  }
}

class Product {
  final String name;
  const Product ({this.name});
}

typedef void CartChangeCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: new ObjectKey(product));
  final Product product;
  final bool inCart;
  final CartChangeCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: (){
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(product.name, style: _getTextStyle(context),),
    );
  }
}

class ShoppingList extends StatefulWidget {
  final List<Product> products;

  ShoppingList({Key key, this.products}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return new  ShoppingListState();
  }
}

class ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set<Product>();
  void _handleCartChanged(Product product, bool inCart) {
    setState((){
      if(inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Shopping List"),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product){
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

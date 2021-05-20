import 'package:boats_challenge/Data/boats_data_model.dart';
import 'package:boats_challenge/UI/home.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  final int index;

  const SecondPage({this.index});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _giro;
  Animation<double> _opacity;
  void _listener() {
    setState(() {});
  }

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animationController.addListener(_listener);
    _giro = Tween<double>(begin: 0, end: -1.571).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
        reverseCurve: Curves.easeInOutBack));
    _opacity =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.removeListener(_listener);
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          _animationController.reverse();
          return true;
        },
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Opacity(opacity: _opacity.value, child: AppBarCustom()),
                  Transform.rotate(
                    origin: Offset(-75, -150),
                    angle: _giro.value,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Image.asset(boats[widget.index].image),
                    ),
                  ),
                ],
              ),
              if (_animationController.status == AnimationStatus.completed)
                Positioned(
                  top: 20,
                  left: 20,
                  child: GestureDetector(
                      child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.grey[200], shape: BoxShape.circle),
                          child: Icon(Icons.close, color: Colors.grey)),
                      onTap: () async {
                        _animationController.reverse();
                        Navigator.pop(context);
                      }),
                ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.35,
                  left: 20,
                  right: 20,
                  bottom: 0,
                  child: Opacity(
                    opacity: 1.0 - _opacity.value,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NameBoat(index: widget.index),
                          const SizedBox(height: 20),
                          Text(
                            boats[widget.index].description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "SPEC",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Boat Length",
                                      style: TextStyle(fontSize: 18)),
                                  Text("Beam", style: TextStyle(fontSize: 18)),
                                  Text("Weigth",
                                      style: TextStyle(fontSize: 18)),
                                  Text("Fuel Capacity",
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    boats[widget.index].spec.leng,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    boats[widget.index].spec.beam,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    boats[widget.index].spec.weight,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    boats[widget.index].spec.fuelCapacity,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "GALLERY",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (_, __) =>
                                    SizedBox(width: 10),
                                itemCount: boats[widget.index].boats.length,
                                itemBuilder: (_, index) => ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                        boats[widget.index].boats[index],
                                        width: 200,
                                        fit: BoxFit.cover))),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class NameBoat extends StatelessWidget {
  final int index;
  const NameBoat({this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          boats[index].name,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.subtitle2,
            children: [
              TextSpan(text: 'by '),
              TextSpan(
                  text: '${boats[index].maker}',
                  style: TextStyle(fontWeight: FontWeight.w600))
            ],
          ),
        ),
      ],
    );
  }
}

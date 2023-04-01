import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage cross = AssetImage('images/cross.png');
  AssetImage edit = AssetImage('images/edit.png');
  AssetImage circle = AssetImage('images/circle.png');
  var message = "";
  bool x = true;
  var xo = ["", "", "", "", "", "", "", "", ""];
  @override
  initState() {
    super.initState();
    setState(() {
      this.message = "";
      this.xo = ["", "", "", "", "", "", "", "", ""];
    });
  }

  playGame(int index) {
    if (this.xo[index] == "") {
      setState(() {
        if (this.x) {
          this.xo[index] = "cross";
        } else {
          this.xo[index] = "circle";
        }

        this.x = !this.x;
        this.checkWin();
        this.checker();
      });
    }
  }

  getImage(String value) {
    switch (value) {
      case (''):
        return edit;
        break;
      case ('cross'):
        return cross;
        break;
      case ('circle'):
        return circle;
        break;
    }
  }

  bool win = false;
  checkWin() {
    if ((xo[0] != '') && (xo[0] == xo[1]) && (xo[1] == xo[2])) {
      // if any user Win update the message state
      setState(() {
        this.message = '${this.xo[0]} wins';
        win = true;
      });
    } else if ((xo[3] != '') && (xo[3] == xo[4]) && (xo[4] == xo[5])) {
      setState(() {
        this.message = '${this.xo[3]} wins';
        win = true;
      });
    } else if ((xo[6] != '') && (xo[6] == xo[7]) && (xo[7] == xo[8])) {
      setState(() {
        this.message = 'Yay! ${this.xo[6]} wins!';
        win = true;
      });
    } else if ((xo[0] != '') && (xo[0] == xo[3]) && (xo[3] == xo[6])) {
      setState(() {
        this.message = 'Yay! ${this.xo[0]} wins!';
        win = true;
      });
    } else if ((xo[1] != '') && (xo[1] == xo[4]) && (xo[4] == xo[7])) {
      setState(() {
        this.message = 'Yay! ${this.xo[1]} wins!';
        win = true;
      });
    } else if ((xo[2] != '') && (xo[2] == xo[5]) && (xo[5] == xo[8])) {
      setState(() {
        this.message = 'Yay! ${this.xo[2]} wins!';
        win = true;
      });
    } else if ((xo[0] != '') && (xo[0] == xo[4]) && (xo[4] == xo[8])) {
      setState(() {
        this.message = 'Yay! ${this.xo[0]} wins!';
        win = true;
      });
    } else if ((xo[2] != '') && (xo[2] == xo[4]) && (xo[4] == xo[6])) {
      setState(() {
        this.message = 'Yay! ${this.xo[2]} wins!';
        win = true;
      });
    } else if (!xo.contains('')) {
      setState(() {
        this.message = 'Oops! Game Draw';
        win = true;
      });
    }
  }

  // newGame() {
  //   if (win) {
  //     setState(() async {
  //       await Future.delayed(Duration(seconds: 5));
  //       this.message = "";
  //       this.xo = ["", "", "", "", "", "", "", "", ""];
  //     });
  //   }
  // }
  checker() {
    if (win) {
      setState(() async {
        //will get reset automatically after 5 seconds
        await Future.delayed(Duration(seconds: 5));
        reset();
        win = false;
      });
    }
  }

  reset() {
    setState(() {
      this.message = "";
      this.xo = ["", "", "", "", "", "", "", "", ""];
    });
  }

  nullButton() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: win == true
                    ? () {
                  nullButton();
                }
                    : () {
                  this.playGame(index);
                },
                child: SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                    ),
                    child: Image(
                        image: getImage(xo[index]) == null
                            ? AssetImage('images/edit.png')
                            : getImage(xo[index])),
                  ),
                ),
              );
            },
          ),
        ),
        Text(
          ("${this.message}"),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.deepOrange,
          ),
        ),
        TextButton(
          onPressed: reset,
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Text(
              'Reset Game',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

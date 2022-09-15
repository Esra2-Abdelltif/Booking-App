import 'package:booking_app/presentation/screens/onboarding/model_conrtroller.dart';
import 'package:flutter/material.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: 300,
                        ),
                        Text(
                          contents[i].title,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          contents[i].discription,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => buildDot(index, context),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: MaterialButton(
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  /* Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Home(),
                    ),
                  );*/
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              color: Colors.teal,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text('Login'),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: MaterialButton(
              child: Text('Create Account'),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  /*Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Home(),
                    ),
                  );*/
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              color: Colors.grey[200],
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.teal,
      ),
    );
  }
}

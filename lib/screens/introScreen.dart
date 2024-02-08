import 'package:app/models/businessLayer/baseRoute.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroScreen extends BaseRoute {
  IntroScreen({a, o}) : super(a: a, o: o, r: 'IntroScreen');

  @override
  _IntroScreenState createState() => new _IntroScreenState();
}

class _IntroScreenState extends BaseRouteState {
  PageController? _pageController;
  int _currentIndex = 0;
  List<String> _imageUrl = [
    'assets/images/on1.png',
    'assets/images/on2.png',
    'assets/images/on3.png',
  ];

  _IntroScreenState() : super();

  @override
  Widget build(BuildContext context) {
    List<IntroSH> _titles = [
      IntroSH(
          heading: 'حمل التطبيق',
          title:
              'طريقة ملائمة لتصفح المحترفين وحجز المواعيد في الوقت الذي يناسبك مباشرةً من التقويم الخاص بك.'),
      IntroSH(
          heading: 'حمل التطبيق',
          title:
              'هل أنت مستعد لقص شعرك القادم؟ عندما تقوم بقص شعرك مع أحد هؤلاء الكوافيرن، فهذا أكثر من مجرد قص، إنها تجربة.'),
      IntroSH(
          heading: 'حمل التطبيق',
          title:
              'يمكن للمحترفين أن يفعلوا أي شيء! من التدرج إلى التصاميم، هذا هو المكان الذي تريد أن تحصل فيه على قصة شعرك!')
    ];

    return WillPopScope(
      onWillPop: () {
        return exitAppDialog().then((value) => value as bool);
      },
      child: sc(
        Scaffold(
            body: PageView.builder(
                itemCount: _imageUrl.length,
                controller: _pageController,
                onPageChanged: (index) {
                  _currentIndex = index;
                  setState(() {});
                },
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.asset(
                          _imageUrl[index],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom:        MediaQuery.of(context).size.width/1.5),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: DotsIndicator(
                            dotsCount: _titles.length,
                            position: _currentIndex,
                            onTap: (i) {
                              index = i.toInt();
                              _pageController!.animateToPage(index,
                                  duration: Duration(microseconds: 1),
                                  curve: Curves.easeInOut);
                            },
                            decorator: DotsDecorator(
                              activeSize: const Size(30, 8),
                              size: const Size(12, 8),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0))),
                              activeColor: Theme.of(context).primaryColor,
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: BottomSheet(
                            enableDrag: false,
                            onClosing: () {},
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                height:
                                    MediaQuery.of(context).size.width/1.5,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 0, top: 10),
                                        child: Text(
                                          _titles[index].heading!,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'cairo'),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 20, right: 20),
                                      child: Text(
                                        _titles[index].title!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w100,
                                            fontFamily: 'cairo'
                                        ),
                                      ),
                                    ),
                                    index == 0 || index == 1
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(0),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .transparent)),
                                                  onPressed: () {},
                                                  child: Text('')),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    _pageController!
                                                        .animateToPage(
                                                            _currentIndex + 1,
                                                            duration: Duration(
                                                                microseconds:
                                                                    1),
                                                            curve: Curves
                                                                .easeInOut);
                                                  },
                                                  child: Text(
                                                    'التالي',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Cairo',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(0),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .transparent)),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SignInScreen(
                                                                a: widget
                                                                    .analytics,
                                                                o: widget
                                                                    .observer,
                                                              )),
                                                    );
                                                  },
                                                  child: Text(
                                                    'تخطي',
                                                    style: TextStyle(
                                                      color: Color(0xFF515151),
                                                      fontSize: 15,
                                                      fontFamily: 'Cairo',
                                                      fontWeight: FontWeight.w600,
                                                      height: 0.10,
                                                    )
                                                  ))
                                            ],
                                          )
                                        : ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignInScreen(
                                                          a: widget.analytics,
                                                          o: widget.observer,
                                                        )),
                                              );
                                            },
                                            child: Text(
                                              'ابدا الان',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Cairo',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ),

                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,

                                        child: Image.asset('assets/images/top.png',
                                            width: MediaQuery.of(context).size.width /3),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  );
                })),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }
}

class IntroSH {
  String? heading;
  String? title;

  IntroSH({this.heading, this.title});
}

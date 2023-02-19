import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/src/widgets/page_view.dart';
import 'package:udemy_flutter/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/compenents/compenent.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';

class OnBoardingModel
{
  final String image;
  final String title;
  final String body;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body
  });

}
bool isLast = false;

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
var boardControler = PageController();

  List<OnBoardingModel> boarding = [
    OnBoardingModel(image: 'assets/images/shop.jpg',
        title: 'on boardin 1 title',
        body: 'on boarding 1 body'
    ),
    OnBoardingModel(image: 'assets/images/shop.jpg',
        title: 'on boardin 2 title',
        body: 'on boarding 2 body'
    ),
    OnBoardingModel(image: 'assets/images/shop.jpg',
        title: 'on boardin 3 title',
        body: 'on boarding 3 body'
    ),
  ];

  void submit()
  {
    // CachHelper.pubData(key: 'onBoarding', value: true).then((value)
    // {
    //   if(value)
    //   {
        navigateAndFinish(context,
            ShopLoginScreen());
      //   );
      // }
    // });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: submit,
              child: Text('Skip',
                style: TextStyle(
                  color: Colors.pink.shade700,
          ),)),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                   controller: boardControler,

                 physics: BouncingScrollPhysics(),
                  onPageChanged: (int index)
                  {
                    if(index == boarding.length - 1)
                    {
                      setState(() {
                        isLast = true;
                      });
                    } else
                    {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context,index)=> buildBoardItem(boarding[index % boarding.length]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    expansionFactor: 4,
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  controller: boardControler,
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                {
                  if(isLast)
                  {
                    submit();

                  }else
                  {
                    boardControler.nextPage(
                        duration: Duration(
                            milliseconds: 750
                        ),
                        curve: Curves.linear);
                  }
                },
                child: Icon(Icons.arrow_forward_ios),),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget buildBoardItem(OnBoardingModel model) =>  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
        child: Image.asset('${model.image}')
    ),
    SizedBox(
      height: 20.0,
    ),
    Text('${model.title}',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(
      height: 30.0,
    ),
    Text('${model.body}',
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(
      height: 50.0,
    ),
  ],
);

}

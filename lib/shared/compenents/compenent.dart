import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter/modules/web_view/web_view_screen.dart';


 Widget defaultFormFeild({
  required Function validate(String value),
  required TextEditingController controller,
  required TextInputType type,
  required String label,
}) => TextFormField
(
  controller: controller,
  keyboardType: type,
  decoration: InputDecoration(
  labelText: label,
  border: OutlineInputBorder(),
),

);


Widget myDivider() =>  Container(
  height: 2,
  margin: EdgeInsets.only(
      top: 5, right:10),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    color: Colors.white12,
  ),
);

Widget builderTaskItem() => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircleAvatar(
        radius: 40.0,
        child: Text('02:00 pm',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue[800],
      ),
      SizedBox(
        width: 20.0,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Tilte Tasks',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('2 mars 2022',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),
          ),
        ],
      ),
    ],
  ),
);

//     SizedBox(
//   height: 20.0,
// );

Widget buildArticlesItem(article, context) =>
    InkWell(
      onTap: (){
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,

                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
  ),
),
    );


Widget articlBuilder(list, context,{bool isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    // color scroll
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context,index) => buildArticlesItem(list[index], context),
      separatorBuilder: (context,index) => myDivider(),
      itemCount: 10),
  fallback: (context)=> isSearch ? Container() : Center(child: CircularProgressIndicator()),
);



void navigateTo(context, widget) => Navigator.push(context, MaterialPageRoute(builder: (context)=> widget));


void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context)=>
            widget),
           (router)
        {
          return false;
        }
    );


void showToast({
  required String text,
  required ToastState state,

}) =>  Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 8,
backgroundColor:chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

///enum
enum ToastState {SECCESS, ERROR, WARNING}

///background type Color so we need to create a function

Color chooseToastColor(ToastState state,)
{
  Color color;
  switch(state){
    case ToastState.SECCESS:
      color = Colors.green;
      break;

    case ToastState.ERROR:
      color = Colors.red;
      break;

    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
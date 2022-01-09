import 'package:api_app/main.dart';
import 'package:api_app/models/news_info.dart';
import 'package:api_app/pages/details_screen.dart';
import 'package:api_app/services/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<Welcome> _welcome;

  @override
  void initState() {
    _welcome = API_Manager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: (){
            Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c) => MyApp(),
            transitionDuration: const Duration(seconds: 1),
            ),);
            return Future.value();
          },
          child: FutureBuilder<Welcome>(
            future: _welcome,
            builder: (BuildContext context,snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data!.articles.length,
                    itemBuilder: (context, index) {
                      var article = snapshot.data!.articles[index];
                  return Container(
                    height: 100,
                    margin: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: InkWell(
                                onTap: () async{
                                 await Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(article: article,)));
                                },
                                child: Image.network(article.urlToImage,
                                  fit: BoxFit.cover,
                                ),
                              )),

                        ),

                        SizedBox(width: 16,),

                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(article.title,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Text(article.description,overflow: TextOverflow.ellipsis,maxLines: 2,),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                });
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        ),
    );
  }
}

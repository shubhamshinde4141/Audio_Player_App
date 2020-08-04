import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Audio Player',
      theme: ThemeData.light(),

      home:HomePage(),

      debugShowCheckedModeBanner: false,

    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

AudioPlayer _audioPlayer = AudioPlayer();

bool isplaying = false;

String CurrentTime = "00.00";
String CompleteTime = "00.00";


void initState()
{
  super.initState();

  _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
    setState(() {
      CurrentTime = duration.toString().split(".")[0];
    });
  });
  _audioPlayer.onDurationChanged.listen((Duration duration) {
    setState(() {
      CompleteTime = duration.toString().split(".")[0];
    });
  });

}


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.teal,
      title: Text('Audio Player'),


    ),
    backgroundColor: Colors.black12,
    body: Stack(
      children: <Widget>[
        Image.asset('assets/Nt6v.gif' , fit: BoxFit.cover
        ),


        Container(
          width: MediaQuery.of(context).size.width*0.8,
          height: 80,

          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.6 , left: MediaQuery.of(context).size.width*0.1),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(isplaying ? Icons.pause : Icons.play_arrow),
                onPressed: ()
                {
                  if(isplaying)
                    {
                      _audioPlayer.pause();
                      setState(() {
                        isplaying=false;
                      });
                    }else{
                    _audioPlayer.resume();
                    setState(() {
                      isplaying=true;
                    });
                  }

                },
              ),
              SizedBox(width: 16,),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: ()
                {
                  _audioPlayer.stop();
                  setState(() {
                    isplaying=false;
                  });

                },
              ),
              Text(CurrentTime, style: TextStyle(fontWeight: FontWeight.w700),),
              Text(" | "),

              Text(CompleteTime, style: TextStyle(fontWeight: FontWeight.w300),),



            ],
          ),
        )
      ],
    ),

    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.audiotrack),
      onPressed:  ()
      async {
        String filepath = await FilePicker.getFilePath();
       int status = await _audioPlayer.play(filepath , isLocal: true);
       if(status==1)
         {
           setState(() {
             isplaying=true;
           });

         }


      },
    ),

  );

  }
}

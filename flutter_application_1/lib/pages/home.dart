import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


final assetsAudioPlayer = AssetsAudioPlayer();

 @override
  void initState() {
    // TODO: implement initState

    super.initState();
        initPlayer();
  }

void initPlayer() async {
    await
  assetsAudioPlayer.open(
      Playlist(
        audios: [
          Audio( 'assets/1.mp3' ,metas: Metas(title: 'Song 1')),
          Audio( 'assets/2.mp3' ,metas: Metas(title: 'Song 2')),
          Audio( 'assets/3.mp3' ,metas: Metas(title: 'Song 3')),
          Audio( 'assets/4.mp3' ,metas: Metas(title: 'Song 4')), 
    ]
    ),autoStart: false
  );
setState(() {
  
});
}

String convertSeconds(int seconds) 
{
  String minutes = (seconds ~/ 60).toString();
  String secondsStr =(seconds % 60).toString();
  return '${minutes.padLeft(2,'0')}:${secondsStr.padLeft(2,'0')}';

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: assetsAudioPlayer.realtimePlayingInfos,
          builder: (context, snapShots) {
            // if(snapShots.connectionState == ConnectionState.waiting) {
            //   return const Center(
            //     child:  CircularProgressIndicator(),
            //   );
            // }
            return Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 400,
                  width: 400,
                   
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        assetsAudioPlayer.getCurrentAudioTitle==''?'Please play your song':assetsAudioPlayer.getCurrentAudioTitle, 
                        style: TextStyle(fontSize: 30, color: Colors.white),),
                      const SizedBox(height: 25,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                IconButton(onPressed:
                snapShots.data?.current?.index == 0 ? null :
                 (){assetsAudioPlayer.previous();}, icon: Icon(Icons.skip_previous)),
                 getBtnWidget,
                  IconButton(onPressed:
                     snapShots.data?.current?.index == (assetsAudioPlayer.playlist?.audios.length ??0 )- 1 ? null :
                   (){assetsAudioPlayer.next(keepLoopMode: false);}, icon: Icon(Icons.skip_next))
               ],
             )
             ,const SizedBox(height: 25,),
             Slider(value: snapShots.data?.currentPosition.inSeconds.toDouble()??0.0,min: 0,max:snapShots.data?.duration.inSeconds.toDouble() ??0.0, onChanged: (value){}),
            Text('${convertSeconds(snapShots.data?.currentPosition.inSeconds??0)} / ${convertSeconds(snapShots.data?.duration.inSeconds??0)}'   , style: TextStyle(fontSize: 17, color: Colors.white,fontWeight: FontWeight.w600),),
                    ],
                  )
                ),
                )
                
              ],
            );
          }
        ),
      )
    );
  }


Widget get getBtnWidget => assetsAudioPlayer.builderIsPlaying(builder: (ctx, isPlaying) {
  return FloatingActionButton.large(
    child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
    color: Colors.white,
    size:70), 
    onPressed: () {
      if (isPlaying) {
        assetsAudioPlayer.pause();
      } else {
 

        assetsAudioPlayer.play();

      }
      setState(() {
        
      });
    },shape: CircleBorder(),
  );
});


}


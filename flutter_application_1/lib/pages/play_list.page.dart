import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
class PlayListPage extends StatefulWidget {
  final Playlist playlist;
 
  const PlayListPage({required this.playlist, super.key});
  
  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(  
      appBar: AppBar(
        title: Text('Play List'),
      ),
      body: ListView(
         
        children: [
          for (var song in widget.playlist.audios ?? [])
            ListTile(
              title: Text(song.metas.title ?? 'No Title'),
              subtitle: Text(song.metas.artist  ?? 'No Artist') ,
                      
              onTap: () async{    song.play();       },
            ),
        ]
        
        
      

      ),
    ) 
    ;
  }
}
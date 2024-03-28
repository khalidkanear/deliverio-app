import 'package:flutter/material.dart';

settingModalBottomSheet(context){
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.music_note),
                  title: const Text('Music'),
                  onTap: () => {}
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('Video'),
                onTap: () => {},
              ),
            ],
          ),
        );
      }
  );
}
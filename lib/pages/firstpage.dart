import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_app/pages/features.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final List<File> _videos = [  ];
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialVideos();
  }

  Future<void> _loadInitialVideos() async {
    final appDir = await getApplicationDocumentsDirectory();
    final List<String> videoFiles = [
      'assets/videos/143419-782363231_small.mp4',
      'assets/videos/209424_small.mp4',

    ];

    for (String assetPath in videoFiles) {
      final fileName = assetPath.split('/').last;
      final file = File('${appDir.path}/$fileName');

      if (!file.existsSync()) {
        // Copy from assets to the local directory
        final data = await rootBundle.load(assetPath);
        await file.writeAsBytes(data.buffer.asUint8List());
      }

      _videos.add(file);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List'),
        actions: [
          IconButton(
            icon:  Icon(Icons.videocam),
            onPressed: _recordVideo,
          ),
          IconButton(
            icon:  Icon(Icons.upload_file),
            onPressed: _uploadVideo,
          ),
        ],
      ),

      body: _isLoading ? Center(
          child: CircularProgressIndicator())  : _videos.isEmpty ? Center( child: Text(
          'No videos yet.',
          style: TextStyle( color: Theme.of(context).primaryColor),
        ),
      )  : ( _videos.length ==1 ) ? Center(
        child: Container(
            alignment: Alignment.center,
            padding: _videos.length == 1 ? EdgeInsets.all(24) : EdgeInsets.zero,
            child: VideoPlayerWidget(videoFile: _videos[0])
        ),
      )
          : ListView.builder(
        itemCount: _videos.length, // Ensure this matches the list length
        itemBuilder: (context, index) {
          return VideoPlayerWidget(videoFile: _videos[index]);
        },
      )
    );
  }

  Future<void> _recordVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _videos.add(file);
      });
    }
  }

  Future<void> _uploadVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _videos.add(file);
      });
    }
  }
}

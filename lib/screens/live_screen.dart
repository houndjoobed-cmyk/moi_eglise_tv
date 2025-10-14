import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'about_screen.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({Key? key}) : super(key: key);

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;

  final String streamUrl = 'https://terranoweb.duckdns.org/live/MoiEgliseTV/index.m3u8';


  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _initializePlayer();
    //_initializeViewerTracking();
  }

  
  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(streamUrl),
      );

      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: const Color(0xFFE30613),
          handleColor: const Color(0xFFE30613),
          backgroundColor: Colors.grey,
          bufferedColor: Colors.white30,
        ),
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFE30613),
            ),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Erreur de lecture',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _hasError = false;
                      _isInitialized = false;
                    });
                    _initializePlayer();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE30613),
                  ),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        },
      );

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    }
  }

  void _shareApp() {
    Share.share(
      'Téléchargez l\'application Moi Église TV pour suivre nos cultes en direct !\n'
      'https://play.google.com/store/apps/details?id=com.moieglise.tv',
      subject: 'Moi Église TV - Live Streaming',
    );
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _videoPlayerController.dispose();
    _chewieController?.dispose();
   // _viewerService.leaveAsViewer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header avec logo et bouton partage
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF003399), Color(0xFF3399FF)],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            const Center(
                              child: Text(
                                'me',
                                style: TextStyle(
                                  fontFamily: 'Lobster',
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              top: 4,
                              child: Transform.rotate(
                                angle: 0.1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE30613),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: const Text(
                                    'Tv',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Moi Église TV',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Live Streaming',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Boutons partage et à propos
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.info_outline, color: Colors.white),
                        tooltip: 'À propos',
                      ),
                      IconButton(
                        onPressed: _shareApp,
                        icon: const Icon(Icons.share, color: Colors.white),
                        tooltip: 'Partager l\'application',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Zone vidéo
            Expanded(
              child: Center(
                child: _hasError
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Erreur de connexion',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _hasError = false;
                                _isInitialized = false;
                              });
                              _initializePlayer();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE30613),
                            ),
                            child: const Text('Réessayer'),
                          ),
                        ],
                      )
                    : !_isInitialized
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1a1a2e),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.play_circle_outline,
                                      size: 80,
                                      color: Color(0xFFE30613),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Prêt pour le live',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Cliquez pour commencer',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    CircularProgressIndicator(
                                      color: Color(0xFFE30613),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : _chewieController != null
                            ? Chewie(controller: _chewieController!)
                            : const CircularProgressIndicator(
                                color: Color(0xFFE30613),
                              ),
              ),
            ),
          ],
        ),
      ),     
    );
  }
}
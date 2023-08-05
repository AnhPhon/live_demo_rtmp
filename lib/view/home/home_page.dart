import 'package:demo_live_stream/view/live_stream/live_stream_page.dart';
import 'package:demo_live_stream/view/watch_live_stream/watch_live_stream_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Flutter Live Stream - RTMP'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Colors.blue,
                onPressed: () {
                  //
                  // Go to live stream page.
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LiveStreamPage()));
                },
                child: const Text(
                  'Start live steam',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: Colors.orange,
              onPressed: () {
                //
                // Go to view live stream page.
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WatchLiveStreamPage()));
              },
              child: const Text(
                'Watch live stream',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import 'mini_controller.dart';

void main() {
  runApp(
    MaterialApp(
      home: _App(),
    ),
  );
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        key: const ValueKey<String>('home_page'),
        appBar: AppBar(
          title: const Text('Video player example'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud),
                text: 'Remote',
              ),
              Tab(
                icon: Icon(Icons.cloud),
                text: 'Remote',
              ),
              Tab(
                icon: Icon(Icons.cloud),
                text: 'Remote',
              ),
              Tab(
                icon: Icon(Icons.cloud),
                text: 'Remote',
              ),
              Tab(
                icon: Icon(Icons.cloud),
                text: 'Remote',
              ),
              Tab(icon: Icon(Icons.insert_drive_file), text: 'Asset'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: [
                _BumbleBeeRemoteVideo(),
                _BumbleBeeRemoteVideo(),
                _BumbleBeeRemoteVideo(),
                _BumbleBeeRemoteVideo(),
                _BumbleBeeRemoteVideo(),
                _BumbleBeeRemoteVideo(),
                _BumbleBeeRemoteVideo(),
                _BumbleBeeRemoteVideo(),
                _BumbleBeeRemoteVideo(),
                _BumbleBeeRemoteVideo(),
                _BumbleBeeRemoteVideo(),
              ],
            ),
            _BumbleBeeRemoteVideo(),
            _BumbleBeeRemoteVideo(),
            _BumbleBeeRemoteVideo(),
            _BumbleBeeRemoteVideo(),
            _ButterFlyAssetVideo(),
          ],
        ),
      ),
    );
  }
}

class _ButterFlyAssetVideo extends StatefulWidget {
  @override
  _ButterFlyAssetVideoState createState() => _ButterFlyAssetVideoState();
}

class _ButterFlyAssetVideoState extends State<_ButterFlyAssetVideo> {
  late MiniController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MiniController.asset('assets/Butterfly-209.mp4');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          const Text('With assets mp4'),
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _ControlsOverlay(controller: _controller),
                  VideoProgressIndicator(_controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BumbleBeeRemoteVideo extends StatefulWidget {
  @override
  _BumbleBeeRemoteVideoState createState() => _BumbleBeeRemoteVideoState();
}

class _BumbleBeeRemoteVideoState extends State<_BumbleBeeRemoteVideo> {
  late MiniController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MiniController.network(
      'https://stream.mux.com/NjuTfbP5dy00PTGIM1gXfOKA7pdmRMt00VXGFVRcQ01c018.m3u8?token=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJhdWQiOiJ2Iiwia2lkIjoiaTlJY3lZZkJiVnNUWDgzbXdoNE1iVGt4MkZxTlpjakRmU3lpRWVaaTRLQSIsInN1YiI6Ik5qdVRmYlA1ZHkwMFBUR0lNMWdYZk9LQTdwZG1STXQwMFZYR0ZWUmNRMDFjMDE4IiwiZXhwIjoyMzQ4NzUyNzgwfQ.I_wq0Agqkv6kCAhPEohsEASD0Qj6-sigQZHD9apJQVssHO_Cve-wy2isIjWip4soE1hfCrrK1JNM3X04W8h6z34SbiZdRXA2ovwqavdqsG5tUTqjr6YvF2GITc8XyJAUw5RqjrqrjycjINPs1fb_u0z_61-hXvWlWpKpAvKCP_hkgaUDsE48uLRqNmoQHdKHuHGtWqydQ2gz4agZk0CYHflFlMpzZmTFMg9AXu7dmPlfVzMfIYrf-VCqoyKhDzm12Ijb7K9xiYhSP4QiJGdVxdyM92LaHko09y1DOiCF8Vp8NeY75IGOw3BgyXZ_2U31ywhkp8OhxyOdbuUKour9DQ',
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(padding: const EdgeInsets.only(top: 20.0)),
          const Text('With remote mp4'),
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _ControlsOverlay(controller: _controller),
                  VideoProgressIndicator(_controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});

  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final MiniController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : const ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}

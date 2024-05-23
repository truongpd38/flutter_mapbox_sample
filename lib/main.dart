import 'package:flutter/material.dart';
import 'package:flutter_mapbox_sample/function/camera.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'function/animated_route.dart';
import 'function/animation.dart';
import 'function/circle_annotations.dart';
import 'function/cluster.dart';
import 'function/full_map.dart';
import 'function/geojson_line.dart';
import 'function/gestures.dart';
import 'function/image_source.dart';
import 'function/location.dart';
import 'function/map_interface.dart';
import 'function/ornaments.dart';
import 'function/page.dart';
import 'function/point_annotations.dart';
import 'function/polygon_annotations.dart';
import 'function/polyline_annotations.dart';
import 'function/projection.dart';
import 'function/snapshotter.dart';
import 'function/style.dart';
import 'function/tile_json.dart';
import 'function/traffic-route-line.dart';
import 'function/vector_tile_source.dart';

final List<ExamplePage> _allPages = <ExamplePage>[
  FullMapPage(),
  StylePage(),
  CameraPage(),
  ProjectionPage(),
  MapInterfacePage(),
  StyleClustersPage(),
  AnimationPage(),
  PointAnnotationPage(),
  CircleAnnotationPage(),
  PolylineAnnotationPage(),
  PolygonAnnotationPage(),
  VectorTileSourcePage(),
  DrawGeoJsonLinePage(),
  ImageSourcePage(),
  TileJsonPage(),
  LocationPage(),
  GesturesPage(),
  OrnamentsPage(),
  AnimatedRoutePage(),
  SnapshotterPage(),
  TrafficRouteLinePage(),
];

class MapsDemo extends StatelessWidget {
  // FIXME: You need to pass in your access token via the command line argument
  // --dart-define=ACCESS_TOKEN=pk.eyJ1IjoicXVhbnZhbnRydW9uZzEwIiwiYSI6ImNsZWRtcWxnMjA4YTUzcm16d3VrMnFsc3AifQ.SZsAc4YGdYf5hhbX56st9g

  // It is also possible to pass it in while running the app via an IDE by
  // passing the same args there.
  //
  // Alternatively you can replace `String.fromEnvironment("ACCESS_TOKEN")`
  // in the following line with your access token directly.
  // static const String ACCESS_TOKEN = String.fromEnvironment("ACCESS_TOKEN");
  static const String accessTOKEN = 'pk.eyJ1IjoicXVhbnZhbnRydW9uZzEwIiwiYSI6ImNsd2l1eGF2ZzBvOHkyanFtZDNoNnd4aXYifQ.EDvlFXhkC4G1E6sblftuRw';

  const MapsDemo({super.key});

  void _pushPage(BuildContext context, ExamplePage page) async {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text(page.title)),
              body: page,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapboxMaps examples')),
      body: accessTOKEN.isEmpty || accessTOKEN.contains("YOUR_TOKEN")
          ? buildAccessTokenWarning()
          : ListView.separated(
              itemCount: _allPages.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 1),
              itemBuilder: (_, int index) => ListTile(
                leading: _allPages[index].leading,
                title: Text(_allPages[index].title),
                onTap: () => _pushPage(context, _allPages[index]),
              ),
            ),
    );
  }

  Widget buildAccessTokenWarning() {
    return Container(
      color: Colors.red[900],
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Please pass in your access token with",
            "--dart-define=ACCESS_TOKEN=ADD_YOUR_TOKEN_HERE",
            "passed into flutter run or add it to args in vscode's launch.json",
          ]
              .map((text) => Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MapboxOptions.setAccessToken(MapsDemo.accessTOKEN);
  runApp(MaterialApp(home: MapsDemo()));
}

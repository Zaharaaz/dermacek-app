import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsService {
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};

  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  Set<Marker> get markers => _markers;

  void addMarker(LatLng position, {String? title}) {
    final marker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(title: title ?? 'Lokasi'),
    );
    _markers.add(marker);
  }

  void moveCamera(LatLng target) {
    _controller?.animateCamera(CameraUpdate.newLatLng(target));
  }

  void zoomTo(LatLng target, double zoomLevel) {
    _controller?.animateCamera(CameraUpdate.newLatLngZoom(target, zoomLevel));
  }

  void dispose() {
    _controller?.dispose();
  }
}

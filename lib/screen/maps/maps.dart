import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dermacek/service/maps_service.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final MapsService _mapsService = MapsService();
  Position? _currentPosition;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _loading = true);

    // Cek apakah GPS aktif
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return; // Cegah akses context setelah async
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aktifkan GPS untuk melanjutkan')),
      );
      return;
    }

    // Cek izin lokasi
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Izin lokasi ditolak')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Izin lokasi ditolak permanen')),
      );
      return;
    }

    // ✅ Gunakan LocationSettings alih-alih desiredAccuracy
    final locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    // Ambil posisi terkini
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    if (!mounted) return;

    setState(() {
      _currentPosition = position;
      _loading = false;
    });

    // Tambahkan marker & pindahkan kamera
    final userLatLng = LatLng(position.latitude, position.longitude);
    _mapsService.addMarker(userLatLng, title: "Lokasi Saya");
    _mapsService.moveCamera(userLatLng);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text("Peta Faskes")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_currentPosition == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Peta Faskes")),
        body: const Center(
          child: Text("Tidak bisa mendapatkan lokasi. Aktifkan GPS dan coba lagi."),
        ),
      );
    }

    final userLatLng =
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Peta Faskes Terdekat"),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocation,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _mapsService.onMapCreated,
        initialCameraPosition: CameraPosition(
          target: userLatLng,
          zoom: 15,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _mapsService.markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Contoh: tambah marker dummy
          _mapsService.addMarker(
            LatLng(userLatLng.latitude + 0.001, userLatLng.longitude + 0.001),
            title: "Faskes Dummy",
          );
          setState(() {});
        },
        child: const Icon(Icons.add_location_alt),
      ),
    );
  }

  @override
  void dispose() {
    _mapsService.dispose();
    super.dispose();
  }
}

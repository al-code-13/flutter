import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_mapa_api/src/models/GetAddress/AddressResponse.dart';
import 'package:prueba_mapa_api/src/models/GetCitys/Citys_Response.dart';
import 'package:prueba_mapa_api/src/models/GetLocation/locationResponse.dart';
import 'package:prueba_mapa_api/src/models/Road&type/Road_City.dart';

abstract class CitysState extends Equatable {
  const CitysState();

  @override
  List<Object> get props => [];
}

class LoadingState extends CitysState {
  String toString() => 'Satisfactorio  LA PUTASIMA CARGA';
}

class UpdateMap extends CitysState {}

class LoadedCitysState extends CitysState {
  final Function(GoogleMapController controller) setMapController;
  final CityResponse cityResponse;
  final int idSelected;
  final bool isSecondDRenable;
  final List<SelectedSUBCity> listdep2;
  final List<SelectedCity> listdep;
  final SelectedCity selectionUserCity;
  final SelectedSUBCity selectedSUBCity;
  LoadedCitysState(
      {this.selectionUserCity,
      this.selectedSUBCity,
      this.listdep2,
      this.isSecondDRenable,
      this.idSelected,
      this.setMapController,
      this.cityResponse,
      this.listdep});
}

// ENVIO
class GetLocationState extends CitysState {
  final AddresResponse addresResponse;

  GetLocationState(this.addresResponse);
}

//  ENVIO COORDENADAS LLEGA DIRECCION
class GetAddressLocationState extends CitysState {
  final LocationResponse locationResponse;

  GetAddressLocationState(this.locationResponse);
}

class UpdateMoveCameraState extends CitysState {
  final LocationResponse locationResponse;
  UpdateMoveCameraState(this.locationResponse);
}

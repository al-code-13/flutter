import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prueba_mapa_api/src/models/GetAddress/AddressResponse.dart';
import 'package:prueba_mapa_api/src/models/GetCitys/Citys_Response.dart';
import 'package:prueba_mapa_api/src/models/GetLocation/locationResponse.dart';
import 'package:prueba_mapa_api/src/models/Road&type/Road_City.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class LoadingState extends AddressState {
  String toString() => 'Satisfactorio  LA PUTASIMA CARGA';
}

class UpdateMap extends AddressState {}

class LoadedAddressState extends AddressState {
  final Function(GoogleMapController controller) setMapController;
  final CityResponse cityResponse;
  final int idSelected;
  final int idMapSelected;
  final bool isSecondDRenable;
  final List<SelectedSUBCity> listdep2;
  final List<SelectedCity> listdep;
  final int selectionUserCity;
  final int selectedSUBCity;
  LoadedAddressState(
      {this.selectionUserCity,
      this.selectedSUBCity,
      this.idMapSelected,
      this.listdep2,
      this.isSecondDRenable,
      this.idSelected,
      this.setMapController,
      this.cityResponse,
      this.listdep});
}

// ENVIO
class GetLocationState extends AddressState {
  final AddresResponse addresResponse;

  GetLocationState(this.addresResponse);
}

//  ENVIO COORDENADAS LLEGA DIRECCION
class GetAddressLocationState extends AddressState {
  final LocationResponse locationResponse;

  GetAddressLocationState(this.locationResponse);
}

class UpdateMoveCameraState extends AddressState {
  final LocationResponse locationResponse;
  UpdateMoveCameraState(this.locationResponse);
}

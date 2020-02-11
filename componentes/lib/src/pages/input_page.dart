import 'package:flutter/material.dart';



class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  String _nombre = '';
  String _email = '';
  String _fecha = '';
  String _optSelect = 'Volar';
  List<String> _poderes = ['Volar','Rayos','Fuerza'];
  TextEditingController _inputFieldDate = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inputs'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _createInput(),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearDate(context),
          Divider(),
          _createDropDown(),
          Divider(),
          _crearPersona(),
        ],
     ),
    );
  }
          
          
          Widget _createInput() {
            
              return TextField(
               // autofocus: true,
               textCapitalization: TextCapitalization.sentences,
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20.0)
                 ),
                 counter: Text('Letras  ${_nombre.length}'), 
               hintText: ('TUS DATOS'),
               labelText: 'Nombre',
               helperText: 'Solo es el name',
               suffixIcon: Icon(Icons.accessibility),
               icon: Icon(Icons.account_balance),
             ),
              onChanged: (valor){
                setState(() {
                  _nombre = valor;
                });
               
              },
            );
          }
           Widget _crearPersona(){
          
             return ListTile(
               title: Text('Name = $_nombre' ),
               subtitle: Text('Email = $_email'),
               trailing: Text(_optSelect),
             );
           }
           Widget _crearEmail(){
          
             return TextField(
               keyboardType: TextInputType.emailAddress,
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20.0)
                 ),
               hintText: ('TUS DATOS'),
               labelText: 'Email',
               suffixIcon: Icon(Icons.accessibility),
               icon: Icon(Icons.account_balance),
             ),
              onChanged: (valor){
                setState(() {
                  _email = valor;
                });
               
              },
            );
           }
           Widget _crearPassword(){
             return TextField(
               obscureText: true,
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20.0)
                 ),
               hintText: ('Password'),
               labelText: 'Password',
               helperText: '',
               suffixIcon: Icon(Icons.block),
               icon: Icon(Icons.add),
             ),
              onChanged: (valor){
                setState(() {
                  _email = valor;
                });
               
              },
            );
           }
           Widget _crearDate(BuildContext context){
             return TextField(
               enableInteractiveSelection: false,
               controller: _inputFieldDate,
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20.0)
                 ),
               hintText: ('Fecha'),
               labelText: 'Fecha nacimiento',
               suffixIcon: Icon(Icons.perm_contact_calendar),
               icon: Icon(Icons.calendar_today),
             ),
             onTap: (){
               FocusScope.of(context).requestFocus(new FocusNode());
               _selectDate(context);
             },
              
               
              
            );
           }
           _selectDate(BuildContext context) async{
             DateTime picked =await showDatePicker(
               context: context,
                initialDate: new DateTime.now(),
                firstDate: new DateTime(2018),
                lastDate: new DateTime(2025),
                locale: Locale('es')
             );
             if(picked != null){
               setState(() {
               _fecha = picked.toString();
               _inputFieldDate.text = _fecha;
             });
             }   
           }
          
          
          List<DropdownMenuItem<String>> getOptDropDown(){
            List<DropdownMenuItem<String>> lista = new List();
            _poderes.forEach((poder){
              lista.add(DropdownMenuItem(
                child:Text(poder),
                value: poder,
                ));
            }); 
            return lista;
          }

           Widget _createDropDown() {
            return Row(
              children: <Widget>[
              Icon(Icons.select_all),
              SizedBox(width: 30.0,),
              Expanded(
                 child: DropdownButton(
                 value: _optSelect,
                  items: getOptDropDown(),
                  onChanged: (opt){
                    setState(() {
                      _optSelect = opt;
                    });
                  },
              ),
              )
            ],
          );
            
          }
}
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
class CodeVerification extends StatefulWidget {
  

  final ValueChanged<String> onCompleted;
  final TextInputType keyboardType;
  final int length;
  final double itemSize;
  final BoxDecoration itemDecoration;
  final TextStyle textStyle;
  final bool autofocus;
  CodeVerification(
      {Key key,
      this.onCompleted,
      this.keyboardType = TextInputType.number,
      this.length = 6,
      this.itemDecoration,
      this.itemSize = 50,
      this.textStyle = const TextStyle(fontSize: 25.0, color: Colors.black),
      this.autofocus = true})
      : assert(length > 0),
        assert(itemSize > 0),
        super(key: key);
  @override
  _CodeVerificationState createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerification> {
  final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
      <TextEditingController>[];
  List<String> _code = List();
  int _currentIdex = 0;
  int currentIndex = 1;
  @override
  void initState() {
    if (_listFocusNode.isEmpty) {
      for (var i = 0; i < widget.length; i++) {
        _listFocusNode.add(new FocusNode());
        _listControllerText.add(new TextEditingController());
        _code.add(' ');
      }
    }
    super.initState();
  }

  String _getInputVerify() {
    String verifycode = '';
    for (var i = 0; i < widget.length; i++) {
      for (var index = 0; index < _listControllerText[i].text.length; index++) {
        if (_listControllerText[i].text[index] != ' ') {
          verifycode += _listControllerText[i].text[index];
        }
      }
    }
    return verifycode;
  }


  void _prev(int index) {
    if (index > 0) {
      setState(() {
        if (_listControllerText[index].text.isEmpty) {
          _listControllerText[index - 1].text = ' ';
        }
        _currentIdex = index - 1;
      });
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_listFocusNode[index - 1]);
      });
    }
  }

  void _next(int index) {
    if (index != widget.length) {
      setState(() {
        _currentIdex = index + 1;
      });
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_listFocusNode[index + 1]);
      });
    }
  }

  Widget codeVerification(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.height * 0.16,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Text(
            "Mi código es:",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          left: MediaQuery.of(context).size.width * 0.06,
          child: Text(
            "300 4896662",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.3,
          left: MediaQuery.of(context).size.width * 0.1,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildListWidget(),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.48,
          left: MediaQuery.of(context).size.width * 0.16,
          right: MediaQuery.of(context).size.width * 0.16,
          child: RaisedButton(
              color: Colors.green,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text(
                  "Continuar",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onPressed: () {}),
        ),
      ],
    );
  }
   List<Widget> _buildListWidget() {
    List<Widget> listWidget = List();
    for (int index = 0; index < widget.length; index++) {
      double left = (index == 0) ? 0.0 : (widget.itemSize / 12);
      listWidget.add(
        Container(
            height: widget.itemSize,
            width: widget.itemSize,
            margin: EdgeInsets.only(left: left),
            decoration: widget.itemDecoration,
            child: _buildInputItem(index)),
      );
    }
    return listWidget;
  }

  Widget _buildInputItem(int index) {
    bool border = (widget.itemDecoration == null);
    return TextField(
      showCursor: false,
      keyboardType: widget.keyboardType,
      maxLines: 1,
      maxLength: 2,
      focusNode: _listFocusNode[index],
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 4),
          ),
          border: (border ? null : InputBorder.none),
          enabled: _currentIdex == index,
          counterText: "",
          contentPadding: EdgeInsets.all(((widget.itemSize * 2) / 10)),
          errorMaxLines: 1,
          fillColor: Colors.black),
      onChanged: (String value) {
        if (value.length > 1 && index < widget.length ||
            index == 0 && value.isNotEmpty) {
          if (index == widget.length - 1) {
            widget.onCompleted(_getInputVerify());
            return;
          }
          if (_listControllerText[index + 1].value.text.isEmpty) {
            _listControllerText[index + 1].value =
                new TextEditingValue(text: " ");
          }
          if (value.length == 2) {
            if (value[0] != _code[index]) {
              _code[index] = value[0];
            } else if (value[1] != _code[index]) {
              _code[index] = value[1];
            }
            if (value[0] == " ") {
              _code[index] = value[1];
            }
            _listControllerText[index].text = _code[index];
          }
          _next(index);

          return;
        }
        if (value.isEmpty && index >= 0) {
          if (_listControllerText[index - 1].value.text.isEmpty) {
            _listControllerText[index - 1].value =
                new TextEditingValue(text: " ");
          }
          _prev(index);
        }
      },
      controller: _listControllerText[index],
      maxLengthEnforced: true,
      autocorrect: false,
      textAlign: TextAlign.center,
      autofocus: widget.autofocus,
      style: widget.textStyle,
    );
  }
  @override
  Widget build(BuildContext context) {
    return codeVerification(context);
  }

}
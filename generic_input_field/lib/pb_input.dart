import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PBInput extends StatefulWidget {
  final Function(_PBInputContract pbInputContract, String value) onKeyPressed;
  final Function(String currentText) onPressedSuffixIcon;
  final labelInputText;
  final suffixIcon;
  final obscureText;
  TextInputType keyBoardType;
  final inputFormatters;
  UnderlineInputBorder typeBorder;
  final focusNode;
  final autoCorret;
  final autoFocus;
  final messageBottom;
  final messageIcon;

  PBInput({
    Key key,
    @required this.labelInputText,
    @required this.obscureText,
    @required this.onKeyPressed,
    this.suffixIcon,
    this.onPressedSuffixIcon,
    this.inputFormatters,
    this.typeBorder,
    this.focusNode,
    this.autoCorret,
    this.autoFocus,
    this.keyBoardType,
    this.messageBottom,
    this.messageIcon,
  }) : super(key: key);

  @override
  _PBInputState createState() => _PBInputState();
}

class _PBInputState extends State<PBInput> implements _PBInputContract {
  bool textClean;
  String _messageBottom;
  String _messageBottonIcon;
  bool _messageBottomIsError;
  TextStyle _messageBottomStyle;

  final _controller = TextEditingController();
  TextStyle _labelStyle;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addListener(() {
      _inputData();
    });
    _controller.addListener(() {
      _hasClean();
    });
  }

  void _hasClean() {
    if (_controller.text.toString().isEmpty) {
      setState(() {
        textClean = true;
      });
    } else {
      setState(() {
        textClean = false;
      });
    }
  }

  void _inputData() {
    widget.onKeyPressed(this, _controller.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _controller,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyBoardType,
          decoration: InputDecoration(
            focusedBorder: widget.typeBorder,
            enabledBorder: widget.typeBorder,
            border: widget.typeBorder,
            labelText: widget.labelInputText,
            labelStyle: _labelStyle,
            suffixIcon:
                widget.suffixIcon != null ? _showIcon() : _messageIcon(),
          ),
        ),
        _messageBottom != null
            ? _MessageBottom(
                _messageBottom,
                _MessageBottomIcon(_messageBottonIcon, _messageBottomIsError),
                _messageBottomStyle)
            : Container(height: 0),
      ],
    );
  }

  Widget _messageIcon() {
    print('Dont have Icon Setter');
    return SizedBox(
      height: 0,
    );
  }

  Padding _showIcon() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 0, 0),
      child: IconButton(
        icon: Image.asset(widget.suffixIcon,
            width: 30, height: 30, fit: BoxFit.contain),
        onPressed: () {
          setClearCurrentText();
        },
      ),
    );
  }

  @override
  setLabelStyle(Color color, double fontSize, FontWeight fontWeight,
      double letterSpacing) {
    setState(() {
      _labelStyle = TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing);
    });
  }

  @override
  setMessageBottom(String message) {
    setState(() {
      _messageBottom = message;
    });
  }

  @override
  setMessageBottomIcon(String pathIcon) {
    setState(() {
      _messageBottonIcon = pathIcon;
    });
  }

  @override
  setUnderlineBorder(UnderlineInputBorder underlineInputBorder) {
    setState(() {
      widget.typeBorder = underlineInputBorder;
    });
  }

  @override
  setKeyBoardType(TextInputType textInputType) {
    setState(() {
      widget.keyBoardType = textInputType;
    });
  }

  @override
  setStyleMessageBottom(Color color, double fontSize, FontWeight fontWeight,
      double letterSpacing) {
    setState(() {
      _messageBottomStyle = TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing);
    });
  }

  @override
  setError(
      String messageBottom,
      String pathIconError,
      bool isError,
      UnderlineInputBorder underlineInputBorderError,
      Color colorMessageBottom,
      double fontSizeMessageBottom,
      FontWeight fontWeightMessageBottom) {
    setMessageBottom(messageBottom);
    setStyleMessageBottom(
        colorMessageBottom, fontSizeMessageBottom, fontWeightMessageBottom, .0);
    setMessageBottomIcon(pathIconError);
    setUnderlineBorder(underlineInputBorderError);
    setState(() {
      _messageBottomIsError = isError;
    });
  }

  @override
  setClearCurrentText() {
    setState(() {
      _controller.clear();
    });
  }

  @override
  String getCurrentText() => _controller.text.toString();
}

abstract class _PBInputContract {
  setMessageBottom(String message);

  setMessageBottomIcon(String pathIcon);

  setUnderlineBorder(UnderlineInputBorder underlineInputBorder);

  setLabelStyle(Color color, double fontSize, FontWeight fontWeight,
      double letterSpacing);

  setError(
      String messageBottom,
      String pathIconError,
      bool isError,
      UnderlineInputBorder underlineInputBorderError,
      Color colorMessageBottom,
      double fontSizeMessageBottom,
      FontWeight fontWeightMessageBottom);

  setKeyBoardType(TextInputType textInputType);

  setStyleMessageBottom(Color color, double fontSize, FontWeight fontWeight,
      double letterSpacing);

  setClearCurrentText();

  String getCurrentText();
}

// ignore: must_be_immutable
class _MessageBottom extends StatefulWidget {
  String _messageBottom;
  TextStyle _messageBottomStyle;

  _MessageBottomIcon _messageIcon;

  _MessageBottom(
      this._messageBottom, this._messageIcon, this._messageBottomStyle);

  @override
  _MessageBottomState createState() => _MessageBottomState();
}

class _MessageBottomState extends State<_MessageBottom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text(widget._messageBottom,
                  style: widget._messageBottomStyle),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: widget._messageIcon)
          ]),
    );
  }
}

// ignore: must_be_immutable
class _MessageBottomIcon extends StatefulWidget {
  bool isError;
  String pathIcon;

  _MessageBottomIcon(
    this.pathIcon,
    this.isError,
  );

  @override
  _MessageBottomIconState createState() => _MessageBottomIconState();
}

class _MessageBottomIconState extends State<_MessageBottomIcon> {
  @override
  Widget build(BuildContext context) {
    Widget out;

    widget.isError != null
        ? widget.isError
            ? out = _getIcon()
            : out = _getIconNull()
        : out = _getIconNull();

    return out;
  }

  Padding _getIconNull() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0), child: new Icon(null));
  }

  Padding _getIcon() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: new Icon(
          Icons.error,
          size: 20,
          color: const Color(0xffb00020),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GenericInput extends StatefulWidget {
  final Function(_PBInputContract pbInputContract, String value) onKeyPressed;
  final labelInputText;
  final obscureText;
  final focusNode;
  final autoCorret;
  final autoFocus;
  final inputFormatters;
  TextStyle labelInputTextStyle;
  String suffixAssetIcon;
  String suffixNetworkIcon;
  TextInputType keyBoardType;
  UnderlineInputBorder typeBorder;
  String messageBottom;
  String messageBottomPathIcon;
  IconData messageBottomDataIcon;
  bool messageBottomIsError;
  TextStyle messageBottomStyle;

  GenericInput(
      {Key key,
      @required this.labelInputText,
      @required this.onKeyPressed,
      this.obscureText = false,
      this.labelInputTextStyle,
      this.suffixAssetIcon,
      this.suffixNetworkIcon,
      this.inputFormatters,
      this.typeBorder,
      this.focusNode,
      this.autoCorret,
      this.autoFocus,
      this.keyBoardType,
      this.messageBottom,
      this.messageBottomPathIcon,
      this.messageBottomDataIcon,
      this.messageBottomIsError,
      this.messageBottomStyle})
      : super(key: key);

  @override
  _GenericInputState createState() => _GenericInputState();
}

class _GenericInputState extends State<GenericInput> implements _PBInputContract {
  bool textClean;

  final _controller = TextEditingController();

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
            labelStyle: widget.labelInputTextStyle,
            suffixIcon: _getIcon(),
          ),
        ),
        widget.messageBottom != null
            ? _MessageBottom(
                widget.messageBottom,
                _MessageBottomIcon(widget.messageBottomPathIcon,
                    widget.messageBottomDataIcon, widget.messageBottomIsError),
                widget.messageBottomStyle)
            : Container(height: 0),
      ],
    );
  }

  Widget _getIcon() {
    if (widget.suffixAssetIcon != null) {
      return _showAssetIcon();
    } else if (widget.suffixNetworkIcon != null) {
      return _showNetworkIcon();
    }
    return _emptyIcon();
  }

  Widget _emptyIcon() {
    return SizedBox(
      height: 0,
    );
  }

  Padding _showNetworkIcon() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 0, 0),
      child: IconButton(
        icon: Image.network(widget.suffixNetworkIcon,
            width: 30, height: 30, fit: BoxFit.contain),
        onPressed: () {
          setClearCurrentText();
        },
      ),
    );
  }

  Padding _showAssetIcon() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 0, 0),
      child: IconButton(
        icon: Image.asset(widget.suffixAssetIcon,
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
      widget.labelInputTextStyle = TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing);
    });
  }

  @override
  setMessageBottom(String message) {
    setState(() {
      widget.messageBottom = message;
    });
  }

  @override
  setMessageBottomPathIcon(String pathIcon) {
    setState(() {
      widget.messageBottomPathIcon = pathIcon;
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
      widget.messageBottomStyle = TextStyle(
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
      IconData iconFlutter,
      bool isError,
      UnderlineInputBorder underlineInputBorderError,
      Color colorMessageBottom,
      double fontSizeMessageBottom,
      FontWeight fontWeightMessageBottom) {
    if ((pathIconError == null || pathIconError.isEmpty) &&
        iconFlutter != null) {
      setMessageBottomDataIcon(iconFlutter);
    } else if ((pathIconError != null && iconFlutter == null)) {
      setMessageBottomPathIcon(pathIconError);
    }

    setMessageBottom(messageBottom);
    setStyleMessageBottom(
        colorMessageBottom, fontSizeMessageBottom, fontWeightMessageBottom, .0);
    setUnderlineBorder(underlineInputBorderError);
    setState(() {
      widget.messageBottomIsError = isError;
    });
  }

  @override
  setClearCurrentText() {
    setState(() {
      _controller.clear();
      setAssetIcon(null);
    });
  }

  @override
  setMessageBottomDataIcon(IconData iconData) {
    setState(() {
      widget.messageBottomDataIcon = iconData;
    });
  }

  @override
  setAssetIcon(String pathIcon) {
    setState(() {
      widget.suffixAssetIcon = pathIcon;
    });
  }
}

abstract class _PBInputContract {
  setMessageBottom(String message);

  setMessageBottomPathIcon(String pathIcon);

  setMessageBottomDataIcon(IconData iconData);

  setUnderlineBorder(UnderlineInputBorder underlineInputBorder);

  setLabelStyle(Color color, double fontSize, FontWeight fontWeight,
      double letterSpacing);

  setError(
      String messageBottom,
      String pathIconError,
      IconData iconFlutter,
      bool isError,
      UnderlineInputBorder underlineInputBorderError,
      Color colorMessageBottom,
      double fontSizeMessageBottom,
      FontWeight fontWeightMessageBottom);

  setKeyBoardType(TextInputType textInputType);

  setStyleMessageBottom(Color color, double fontSize, FontWeight fontWeight,
      double letterSpacing);

  setAssetIcon(String pathIcon);

  setClearCurrentText();
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
      child: Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget._messageBottom, style: widget._messageBottomStyle),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: widget._messageIcon)
            ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class _MessageBottomIcon extends StatefulWidget {
  bool isError;
  String pathIcon;
  IconData iconData;

  _MessageBottomIcon(
    this.pathIcon,
    this.iconData,
    this.isError,
  );

  @override
  _MessageBottomIconState createState() => _MessageBottomIconState();
}

class _MessageBottomIconState extends State<_MessageBottomIcon> {
  @override
  Widget build(BuildContext context) {
    Widget out;

    widget.isError != null ? out = validate() : out = _getIconNull();

    return out;
  }

  Widget validate() {
    if (widget.isError != null) {
      return _getIcon(widget.isError);
    } else {
      if (widget.pathIcon != null) {
        return IconButton(
            icon: Image.asset(
          widget.pathIcon,
          width: 30,
          height: 30,
        ));
      }
      return Icon(widget.iconData);
    }
  }

  Padding _getIconNull() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0), child: new Icon(null));
  }

  Widget _getIcon(bool isError) {
    if (isError) {
      if (widget.pathIcon != null) {
        return IconButton(
            icon: Image.asset(widget.pathIcon,
                width: 30, height: 30, color: const Color(0xffb00020)));
      }
      if (widget.iconData != null) {
        return Icon(widget.iconData, color: const Color(0xffb00020));
      }
      return Container(
        height: 0,
      );
    } else {
      if (widget.pathIcon != null) {
        return IconButton(
            icon: Image.asset(
          widget.pathIcon,
          width: 30,
          height: 30,
        ));
      }
      if (widget.iconData != null) {
        return Icon(widget.iconData);
      }
      return Container(
        height: 0,
      );
    }
  }
}

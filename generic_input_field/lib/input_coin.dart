import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_input_field/generic_input.dart';
import 'package:intl/intl.dart';

class InputCoin extends StatefulWidget {
  final placeholderInput;
  final labelWarningMinimum;
  final labelWarningMaximum;
  final labelWarningInsuficientBalance;
  final minimumBalance;
  final maximumBalance;
  final balanceAccount;
  final Function validatedCoin;

  InputCoin({
    @required this.placeholderInput,
    @required this.labelWarningMinimum,
    @required this.labelWarningMaximum,
    @required this.labelWarningInsuficientBalance,
    @required this.maximumBalance,
    @required this.minimumBalance,
    @required this.balanceAccount,
    @required this.validatedCoin,
  });

  @override
  _InputCoinState createState() => _InputCoinState();
}

class _InputCoinState extends State<InputCoin> {
  final _coinFormater = _CoinInputFormatter();
  static const _txtDefault = "R\$ 0,00";
  double _value = .0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: GenericInput(
          labelInputText: widget.placeholderInput,
          labelInputTextStyle: TextStyle(color: Colors.black, fontSize: 18.0),
          typeBorder: _setBorderDefaultDecoration(),
          keyBoardType: TextInputType.number,
          focusNode: true,
          autoCorret: false,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            _coinFormater
          ],
          onKeyPressed: (contract, value) {
            _inputContValidator(contract,value);
          },
        ));
  }



  void _inputContValidator(dynamic contract, String value){
    if(value.isEmpty){
      _setDicInput(contract);
    }
    if (value.isNotEmpty) {
      contract.setAssetIcon("assets/images/ic_input_text_coin.png");
    }
    bool isDefault = _validateTxtDefault(value);
    if (isDefault) {
      _setDicInput(contract);
    } else {
      String messageError = _validateInputCoin(value);
      if (messageError != null) {
        _setError(contract, messageError);
      } else {
        if(value.isNotEmpty) {
          _hasValidatedValue(contract);
        }
      }
    }
  }

  bool _validateTxtDefault(String valuex) => (valuex.compareTo(_txtDefault) == 0);


  String _validateInputCoin(String valuex) {
    double value = _convertTxtInputInToDouble(valuex);
    if (value != null) {
      if (value < widget.minimumBalance) {
        return widget.labelWarningMinimum +
            _convertDoubleCoinToString(widget.minimumBalance);
      } else if (value > widget.balanceAccount) {
        return widget.labelWarningInsuficientBalance;
      } else if (value > widget.maximumBalance && value < widget.balanceAccount) {
        return widget.labelWarningMaximum +
            _convertDoubleCoinToString(widget.maximumBalance);
      }
      _value = value;
    }
    return null;
  }

  String _convertDoubleCoinToString(double value) =>
      NumberFormat.simpleCurrency(locale: "pt_br").format(value);

  double _convertTxtInputInToDouble(String txtInput) {
    if (txtInput.isNotEmpty && txtInput != null) {
      return double.tryParse(txtInput
          .replaceAll("R\$", "")
          .replaceAll(".", "")
          .replaceAll(",", "."));
    }
    return null;
  }

  void _setError(dynamic contract, String messageError) {
    contract.setError(messageError, null, Icons.error, true,
        _setBorderErrorDecoration(), Colors.black, 14.0, FontWeight.normal);
  }

  void _setDicInput(dynamic contract) {
    contract.setUnderlineBorder(_setBorderDefaultDecoration());
    contract.setMessageBottomDataIcon(null);
  }

  void _hasValidatedValue(dynamic contract) {
    contract.setMessageBottom("");
    contract.setMessageBottomDataIcon(null);
    contract.setUnderlineBorder(_setBorderDefaultDecoration());
    widget.validatedCoin(true, _value);
  }

  UnderlineInputBorder _setBorderDefaultDecoration() {
    return UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 3.0));
  }

  UnderlineInputBorder _setBorderErrorDecoration() {
    return UnderlineInputBorder(
        borderSide: BorderSide(
      color: const Color(0xffb00020),
      width: 5.0,
    ));
  }
}

class _CoinInputFormatter extends TextInputFormatter {
  static const _divider = 100;
  TextEditingValue newValuex;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) return newValue;
    double value = double.parse(newValue.text);
    final formatter = NumberFormat.simpleCurrency(locale: "pt_br");
    String newText = formatter.format(value / _divider);

    newValuex = oldValue;

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }

  String getNewValue() {
    return newValuex.text;
  }
}

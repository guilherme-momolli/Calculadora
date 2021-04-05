class Memory {
  static const operations = const ['%', '÷', '-', '+', 'x', '='];
  String _operation;
  bool _usedOperation = false;
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;

  String result = '0';

  Memory() {
    _clear();
  }

  void _clear() {
    result = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _bufferIndex = 0;
    _operation = null;
    _usedOperation = false;
  }

  void applyCommand(String command) {
    if (command == 'AC') {
      _clear();
    } else if (command == 'DEL') {
      deleteEndDigit();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }
  }

  void deleteEndDigit() {
    //result = result.length > 1 ? result.substring(0, result.length - 1) : '0';
    if (result.length > 1) {
      //copia o resultado sem o ultimo digito, responsavel por apagar o ultimo digito.
      result = result.substring(0, result.length - 1);
    } else {
      result = '0';
    }
  }

  void _addDigit(String digit) {
    if (_usedOperation) result = '0';

    if (result.contains('.') && digit == '.') digit = '';
    if (result == '0' && digit != '.') result = '';

    result += digit;

    _buffer[_bufferIndex] = double.tryParse(result);
    _usedOperation = false;
  }

  void _setOperation(String operation) {
    if (_usedOperation && operation == _operation) {
      return;
    }

    if (_bufferIndex == 0) {
      _bufferIndex = 1;
    } else {
      _buffer[0] = _calculete();
    }

    if (operation != '=') {
      _operation = operation;
    }

    result = _buffer[0].toString();
    //result = result.endsWith('.0') ? result.split('.')[0] : result;
    if (result.endsWith('.0')) {
      result = result.split('.')[0];
    }

    _usedOperation = true;
  }

  double _calculete() {
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '÷':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      default:
        return 0.0;
    }
  }
}

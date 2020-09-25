import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Producto.dart';
import '../providers/productos_provider.dart';

class AddProductoScreen extends StatefulWidget {
  static const routeName = '/add-producto';
  @override
  _EditarProductoScreenState createState() => _EditarProductoScreenState();
}

class _EditarProductoScreenState extends State<AddProductoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _precioInputFocus = FocusNode();
  final _descripInputFocus = FocusNode();
  final _imgUrlFocus = FocusNode();
  ///////  uso controller para mostrar el preview de la imagen del producto,
  ///      osea para obtener cualquier dato que se ingreso en un input antes de que el usuario envie el form.
  /// No es necesario usar controller si solo necesito obtener el valor del input cuando el usuario envie el form
  final _urlImagenController = TextEditingController();
  var _nuevoProducto = Producto(
    id: null,
    titulo: "",
    descripcion: "",
    imagenUrl: "",
    precio: 0.0,
  );
  var _isInit = true;

  var _valoresIniciales = {
    'titulo': '',
    'precio': '',
    'descripcion': '',
    'urlImagen': '',
  };

  /// muestra el preview de la imagen al cambiar el focus a otro input
  /// valido que no se muestre una imagen si la url no es valida
  void _updateImagenPreviewPorFocus() {
    if (!_imgUrlFocus.hasFocus) {
      if ((!_urlImagenController.text.startsWith('http') &&
              !_urlImagenController.text.startsWith('https')) ||
          (!_urlImagenController.text.endsWith('.png') &&
              !_urlImagenController.text.endsWith('.jpg') &&
              !_urlImagenController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveFormulario() {
    final formularioValido = _formKey.currentState.validate();
    if (!formularioValido) {
      return;
    }
    _formKey.currentState.save();
    // debo validar para que al hacer el update no me ingrese el mismo producto otra vez,
    // debo asegurarme que TODOS los datos del producto que sera reemplazado se mantengan en el nuevo
    // y se actualizen solo los datos que el usuario modifique (onSaved) En este caso no perder el valor
    // del esFavorito ni el id
    if (_nuevoProducto.id != null) {
      Provider.of<ProductosProvider>(context, listen: false)
          .updateProducto(_nuevoProducto.id, _nuevoProducto);
    } else {
      Provider.of<ProductosProvider>(context, listen: false)
          .addProducto(_nuevoProducto);
    }

    Navigator.of(context)
        .pop(); // para volver a la ventana anterior despues de agregar
  }

  @override
  void initState() {
    super.initState();
    _imgUrlFocus.addListener(_updateImagenPreviewPorFocus);
  }

  @override
  void didChangeDependencies() {
    // creamos una variable isInit para obtener la id solo la primera vez que se ejecute este metodo
    // y no cada vez q se reejecuta ( didChangeDependencies() )
    // luego de los que queremos hacer cambiamos el valor de la variable a false para q no se ejecute nuevamente
    if (_isInit) {
      final idProducto = ModalRoute.of(context).settings.arguments as String;

      if (idProducto != null) {
        _nuevoProducto = Provider.of<ProductosProvider>(context, listen: false)
            .buscarPorId(idProducto);
        _valoresIniciales = {
          'titulo': _nuevoProducto.titulo,
          'precio': '${_nuevoProducto.precio.toStringAsFixed(0)}',
          'descripcion': _nuevoProducto.descripcion,
          //'urlImagen': _nuevoProducto.imagenUrl,
          'urlImagen': '',
        };
        _urlImagenController.text = _nuevoProducto.imagenUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imgUrlFocus.removeListener(_updateImagenPreviewPorFocus);
    _precioInputFocus.dispose();
    _descripInputFocus.dispose();
    _imgUrlFocus.dispose();
    _urlImagenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar producto',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 17,
        ),
        /////  El form es recomendable que sea un column + scrollview ya que si utilizamos
        ///  Listview, si son muchos input este widget puede perder la info ingresada(input)
        ///  al salir de la vista en pantalla
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _valoresIniciales['titulo'],
                  decoration: InputDecoration(
                    labelText: 'Nombre producto',
                    alignLabelWithHint: true,
                  ),
                  textInputAction: TextInputAction.next,
                  /////////////////////////////////
                  // con el return null le decimos que no hay error. (input correcto)
                  // return string para mostrar mensaje de error
                  // en decoration del Textformfield puedo configurar como se ve el mensaje de error
                  // value es lo que ingreso el usuario
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Debe ingresar un nombre';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_precioInputFocus);
                  },
                  // creo una nueva instancia de producto y la inicializo vacia, y con
                  // onsaved le paso el nuevo valor de este campo, que corresponde al atributo titulo
                  // para que lo cambie de "vacio" y mantengo los valores de los otros campos que ya tiene la instancia.
                  onSaved: (newValue) {
                    _nuevoProducto = Producto(
                      titulo: newValue,
                      id: _nuevoProducto.id,
                      esFavorito: _nuevoProducto.esFavorito,
                      descripcion: _nuevoProducto.descripcion,
                      imagenUrl: _nuevoProducto.imagenUrl,
                      precio: _nuevoProducto.precio,
                    );
                  },
                ),
                TextFormField(
                    initialValue: _valoresIniciales['precio'],
                    decoration: InputDecoration(
                      labelText: 'Precio',
                      alignLabelWithHint: true,
                    ),
                    keyboardType: TextInputType.number,
                    focusNode: _precioInputFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_descripInputFocus);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Debe ingresar un precio.';
                      }
                      if (double.tryParse(value) == null) {
                        return 'El precio debe ser un número valido.';
                      }
                      if (double.parse(value) <= 0) {
                        return 'El precio debe ser mayor a cero.';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _nuevoProducto = Producto(
                        precio: double.parse(newValue),
                        id: _nuevoProducto.id,
                        esFavorito: _nuevoProducto.esFavorito,
                        titulo: _nuevoProducto.titulo,
                        descripcion: _nuevoProducto.descripcion,
                        imagenUrl: _nuevoProducto.imagenUrl,
                      );
                    }),
                TextFormField(
                  initialValue: _valoresIniciales['descripcion'],
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descripInputFocus,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Debe ingresar una descripción.';
                    }
                    if (value.length < 10) {
                      return 'La descripcion es demasiado corta.';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _nuevoProducto = Producto(
                      descripcion: newValue,
                      id: _nuevoProducto.id,
                      esFavorito: _nuevoProducto.esFavorito,
                      titulo: _nuevoProducto.titulo,
                      precio: _nuevoProducto.precio,
                      imagenUrl: _nuevoProducto.imagenUrl,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(
                        top: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      )),
                      child: _urlImagenController.text.isEmpty
                          ? Center(
                              child: Text(
                                'Ingrese url para ver preview',
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : FittedBox(
                              child: Image.network(
                                _urlImagenController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Url Imagen',
                          alignLabelWithHint: true,
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Debe ingresar URL de la imagen.';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Ingrese una URL valida.';
                          }
                          if (!value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg') &&
                              !value.endsWith('.png')) {
                            return 'Formato de la imagen no valido.';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _saveFormulario();
                        },
                        focusNode: _imgUrlFocus,
                        controller: _urlImagenController,
                        //// se necesita este listener para cargar la imagen de preview
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onSaved: (newValue) {
                          _nuevoProducto = Producto(
                            imagenUrl: newValue,
                            id: _nuevoProducto.id,
                            esFavorito: _nuevoProducto.esFavorito,
                            titulo: _nuevoProducto.titulo,
                            descripcion: _nuevoProducto.descripcion,
                            precio: _nuevoProducto.precio,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: RaisedButton(
                    shape: StadiumBorder(),
                    child: Text(
                      'Enviar formulario',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _saveFormulario,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

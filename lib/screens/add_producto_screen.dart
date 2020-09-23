import 'package:flutter/material.dart';
import '../providers/Producto.dart';

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

  /// muestra el preview de la imagen al cambiar el focus a otro input
  void _updateImagenPreviewPorFocus() {
    if (!_imgUrlFocus.hasFocus) {
      setState(() {});
    }
  }

  void _saveFormulario() {
    _formKey.currentState.save();
    print(_nuevoProducto.titulo);
    print(_nuevoProducto.precio);
    print(_nuevoProducto.descripcion);
    print(_nuevoProducto.imagenUrl);
  }

  @override
  void initState() {
    super.initState();
    _imgUrlFocus.addListener(_updateImagenPreviewPorFocus);
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
                  decoration: InputDecoration(
                    labelText: 'Nombre producto',
                    alignLabelWithHint: true,
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_precioInputFocus);
                  },
                  // creo una nueva instancia de producto y la inicializo vacia, y con
                  // onsaved le paso el nuevo valor de este campo, que corresponde al atributo titulo
                  // para que lo cambie de "vacio" y mantengo los valores de los otros campos que ya tiene la instancia.
                  onSaved: (newValue) {
                    _nuevoProducto = Producto(
                      titulo: newValue,
                      id: null,
                      descripcion: _nuevoProducto.descripcion,
                      imagenUrl: _nuevoProducto.imagenUrl,
                      precio: _nuevoProducto.precio,
                    );
                  },
                ),
                TextFormField(
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
                    onSaved: (newValue) {
                      _nuevoProducto = Producto(
                        precio: double.parse(newValue),
                        id: null,
                        titulo: _nuevoProducto.titulo,
                        descripcion: _nuevoProducto.descripcion,
                        imagenUrl: _nuevoProducto.imagenUrl,
                      );
                    }),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descripInputFocus,
                  onSaved: (newValue) {
                    _nuevoProducto = Producto(
                      descripcion: newValue,
                      id: null,
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
                            id: null,
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

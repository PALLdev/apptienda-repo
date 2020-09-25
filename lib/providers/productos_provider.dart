import 'package:flutter/material.dart';
import './Producto.dart';

class ProductosProvider with ChangeNotifier {
  List<Producto> _productosProviderList = [
    Producto(
      id: 'p1',
      titulo: 'Camiseta roja',
      descripcion: 'Una camiseta roja, ¡es bastante roja!',
      precio: 4990,
      imagenUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Producto(
      id: 'p2',
      titulo: 'Pantalones',
      descripcion: 'Unos buenos pantalones negros.',
      precio: 7000,
      imagenUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Producto(
      id: 'p3',
      titulo: 'Bufanda amarilla',
      descripcion:
          'Cálida y acogedora - exactamente lo que necesitas para el invierno.',
      precio: 2990,
      imagenUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Producto(
      id: 'p4',
      titulo: 'Una sartén',
      descripcion: 'Prepara la comida que quieras.',
      precio: 5500,
      imagenUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // var _mostrarFavoritosOnly = false;

//////////
  ///    Retornamos una copia de la lista de productos para que esta pueda modificarse
  ///    solo a traves de los metodos que yo defina (addProducto) y no desde cualquier lugar donde haga import al provider.
  ///    Cada vez que se llama a algun metodo (osea haya cambios en la lista) notificamos a los widget que tengan Listener a este provider
  ///    de que se hicieron cambios en la lista de productos (ChangeNotifier, noifyListeners) para que estos widgets se actualizen con la lista
  ///
  ///
  ///
  List<Producto> get listaProductosProvider {
    return [..._productosProviderList];
  }

  List<Producto> get productosFavoritos {
    return _productosProviderList
        .where((producto) => producto.esFavorito)
        .toList();
  }

  Producto buscarPorId(String id) {
    return _productosProviderList.firstWhere((producto) => producto.id == id);
  }

  // void mostrarProdFavoritosOnly() {
  //   _mostrarFavoritosOnly = true;
  //   notifyListeners();
  // }

  // void mostrarTodosProd() {
  //   _mostrarFavoritosOnly = false;
  //   notifyListeners();
  // }

  void addProducto(Producto producto) {
//  sin id definido por la base de datos
    final nuevoProducto = Producto(
      id: DateTime.now().toString(),
      titulo: producto.titulo,
      descripcion: producto.descripcion,
      imagenUrl: producto.imagenUrl,
      precio: producto.precio,
    );

    _productosProviderList.add(nuevoProducto);

    //_productosProviderList.insert(0, nuevoProducto); // poner al comienzo de la lista

    notifyListeners();
  }

  void updateProducto(String id, Producto nuevoProducto) {
    final indexProducto =
        _productosProviderList.indexWhere((element) => element.id == id);
    if (indexProducto >= 0) {
      //osea que existe en la lista (validacion adicional)
      _productosProviderList[indexProducto] = nuevoProducto;
      notifyListeners();
    } else {
      print('Error... No existe el producto que se quiere actualizar');
    }
  }

  void deleteProducto(String id) {
    _productosProviderList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

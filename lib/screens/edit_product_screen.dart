import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app_flutter/providers/product.dart';
import 'package:shop_app_flutter/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit_product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formGlobalKey = GlobalKey<FormState>();
  // if we want to edit product or add product
  var _editedProduct = Product(
    id: null,
    name: '',
    price: 0,
    imageURL: '',
    description: '',
  );
  // initial values for every text form field
  var _initValues = {
    'name': '',
    'description': '',
    'price': '',
    'imageURL': '',
  };

  bool _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageListener);
    super.initState();
  }

  // EDIT PRODUCT IS DOING HERE!!!
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;

      // if get initialize, that's mean we want to edit a product
      if (productId != null) {
        final product =
            Provider.of<ProductsProvider>(context).findById(productId);
        _editedProduct = product;

        // edit initial values for when edit a product
        _initValues = {
          'name': product.name,
          'description': product.description,
          'price': product.price.toString(),
          'imageURL': '',
        };
        // initial value for imageURL when using controller or if text form field using controller
        _imageUrlController.text = product.imageURL;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageListener() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) &&
          (!_imageUrlController.text.endsWith('png') &&
              !_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  // an important thing when you are using focus node is you need to dispose the focus node so it's will clear up your memory from focus node
  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageListener);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  // ADD PRODUCT IS DOING HERE
  void _saveForm() {
    final isValid = _formGlobalKey.currentState.validate();
    if (!isValid) {
      return;
    }
    // ADD PRODUCT IS DOING HERE!!!
    _formGlobalKey.currentState.save();
    // if edited product id has data or not null that't mean we want to update product data
    // product id get from initialize data _isInit and productID not null
    if (_editedProduct.id != null) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      // else if product id is null that's mean we want to create new product
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Form(
        key: _formGlobalKey,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['name'],
                decoration: InputDecoration(labelText: 'Name'),
                // in the keyboard, you can get next button
                textInputAction: TextInputAction.next,
                // when we press next, it will automatically focus to price input
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (value) {
                  // READ THIS !!!!
                  // You can create a new object before you assign the value to the product object
                  // so you don't need to repeat all of this product object line and not immutable
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    name: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageURL: _editedProduct.imageURL,
                    isFavorit: _editedProduct.isFavorit,
                    quantity: _editedProduct.quantity,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                // we will get keyboard type of number
                keyboardType: TextInputType.number,
                // receive focus node from text field of product's name
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a value';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero';
                  }
                  return null;
                },
                onSaved: (value) {
                  // READ THIS !!!!
                  // You can create a new object before you assign the value to the product object
                  // so you don't need to repeat all of this product object line and not immutable
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    name: _editedProduct.name,
                    description: _editedProduct.description,
                    price: double.parse(value),
                    imageURL: _editedProduct.imageURL,
                    isFavorit: _editedProduct.isFavorit,
                    quantity: _editedProduct.quantity,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                // receive focus node from text field of price's name
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a value';
                  }
                  if (value.length < 11) {
                    return 'Should be at leasth 10 characters';
                  }
                  return null;
                },
                // READ THIS !!!!
                // You can create a new object before you assign the value to the product object
                // so you don't need to repeat all of this product object line and not immutable
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    name: _editedProduct.name,
                    description: value,
                    price: _editedProduct.price,
                    imageURL: _editedProduct.imageURL,
                    isFavorit: _editedProduct.isFavorit,
                    quantity: _editedProduct.quantity,
                  );
                },
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter Image URL')
                        : Image.asset(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      // You CAN'T give initial value to text form field who use controller
                      // go up to see how to use initial value on didChangeDependencies() method
                      // initialValue: _initValues['imageURL'],
                      decoration:
                          InputDecoration(labelText: 'Text of Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      // You can use the validator in here or in the _updateImageListener method
                      // IT IS ABSOLUTELY THE SAME THING
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an image URL';
                        }
                        // if (!value.startsWith('http') &&
                        //     !value.startsWith('https')) {
                        //   return 'Please enter a valid URL';
                        // }
                        if (!value.endsWith('png') &&
                            !value.endsWith('jpg') &&
                            !value.endsWith('jpeg')) {
                          return 'Please enter a valid image URL';
                        }
                        return null;
                      },
                      // READ THIS !!!!
                      // You can create a new object before you assign the value to the product object
                      // so you don't need to repeat all of this product object line and not immutable
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          name: _editedProduct.name,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageURL: value,
                          isFavorit: _editedProduct.isFavorit,
                          quantity: _editedProduct.quantity,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

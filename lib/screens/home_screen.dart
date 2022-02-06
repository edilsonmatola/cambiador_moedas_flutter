import 'package:flutter/material.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();

  double dollar;
  double euro;

  void _realChanged(String text) {
    /* Verifica se o campo esta vazio, if true, it'll reset all fields */
    if (text.isEmpty) {
      _resetFields();
      return;
    }

    final real = double.parse(text);
    //Colocando apenas 2 casas decimais
    dollarController.text = (real / dollar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dollarChanged(String text) {
    if (text.isEmpty) {
      _resetFields();
      return;
    }
    final dollar = double.parse(text);
    //! This.dollar para especificar o dollar declarado dentro da classe
    realController.text = (dollar * this.dollar).toStringAsFixed(2);
    euroController.text = (dollar * this.dollar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _resetFields();
      return;
    }
    final euro = double.parse(text);
    dollarController.text = (euro * this.euro / dollar).toStringAsFixed(2);
    realController.text = (euro * this.euro).toStringAsFixed(2);
  }

  /* 
    Function to reset fields
   */
  void _resetFields() {
    realController.text = '';
    dollarController.text = '';
    euroController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: OOP this project
    // TODO: Add github flows (CI)
    return Scaffold(
      backgroundColor: const Color.fromRGBO(36, 35, 49, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 35, 49, 1),
        title: Text(
          'CAMBIADOR',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          // TODO: Melhorar mensagem do help
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Ajuda',
                  ),
                  content: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Fechar',
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.help_outline_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    'Loading data...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error while loading data :(',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  );
                } else {
                  dollar = snapshot.data['results']['currencies']['USD']['buy']
                      as double;
                  euro = snapshot.data['results']['currencies']['EUR']['buy']
                      as double;
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 150,
                          color: Colors.amber,
                        ),
                        //*Real
                        SizedBox(height: 25),
                        builTextField(
                          label: 'Real',
                          prefix: r'R$ ',
                          controller: realController,
                          function: _realChanged,
                        ),

                        //*Dollar
                        SizedBox(height: 25),
                        builTextField(
                          label: 'Dollar',
                          prefix: r'$ ',
                          controller: dollarController,
                          function: _dollarChanged,
                        ),

                        //*Euro
                        SizedBox(height: 25),
                        builTextField(
                          label: 'Euro',
                          prefix: '€ ',
                          controller: euroController,
                          function: _euroChanged,
                        ),
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

/* 
  Function to build the different TextFields, 
  which only changes the label and prefix 
 */
TextField builTextField({
  String label,
  String prefix,
  TextEditingController controller,
  Function(String) function,
}) {
  return TextField(
    /*
     *coloca esse keyboardType para poder fazer o display do ponto "." no
     *teclado do iOS 
     */
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.amber,
      ),
      border: OutlineInputBorder(),
      prefixText: prefix,
    ),
    style: TextStyle(
      color: Colors.amber,
      fontSize: 25,
    ),
    onChanged: function,
  );
}

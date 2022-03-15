import 'package:flutter/material.dart';
import 'package:game_library/constants/constants.dart';
import 'package:game_library/controller/data_controller.dart';

class ShoppingComplate extends StatefulWidget {
  const ShoppingComplate({Key? key}) : super(key: key);

  @override
  State<ShoppingComplate> createState() => _ShoppingComplateState();
}

class _ShoppingComplateState extends State<ShoppingComplate> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Kart işlemleri",
          style: ConstantsStyles.titleStyle,
        ),
        backgroundColor: ConstantsStyles.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              child: ListView.builder(
                itemCount: DataControl.shopGame.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: Text(
                            DataControl.shopGame[index].name +
                                "  " +
                                DataControl.shopGame[index].money.toString(),
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(),
                              onPressed: () {
                                setState(() {});
                                DataControl.removeGameShopList(
                                    DataControl.shopGame[index].name);
                              },
                              child: Icon(
                                Icons.delete_forever,
                                size: 25,
                              )),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Container(
              child: Text(
                "Toplam : " +
                    DataControl.gamesMoney().toStringAsFixed(2) +
                    " TL",
                style: ConstantsStyles.newsTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Kredi Kartı bilgileri",
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textFormFieldMethod(
                            TextInputType.number,
                            Icon(Icons.ballot_sharp),
                            "**** / **** / **** / ****",
                            prefixText: "TR ",
                            labelText: "Kredi kartı numaranız"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                  child: textFormFieldMethod(TextInputType.text,
                                      Icon(Icons.account_circle), "Adınız",
                                      labelText: "Adınız")),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                  child: textFormFieldMethod(TextInputType.text,
                                      Icon(Icons.account_circle), "Soy adınız",
                                      labelText: "Soy adınız")),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                  child: textFormFieldMethod(
                                      TextInputType.number,
                                      Icon(Icons.calendar_today_sharp),
                                      "--/--",
                                      labelText: "Tarih")),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                  child: textFormFieldMethod(
                                      TextInputType.number,
                                      Icon(Icons.bento),
                                      "---",
                                      labelText: "Güvenlik")),
                            )
                          ],
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                DataControl.gameShopListRemove();
                                //DataControl.resetList();
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Alışverişiniz tamamlandı")));
                              }
                            },
                            icon: Icon(Icons.card_giftcard),
                            label: Text("ödemeyi tamamla"))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextFormField textFormFieldMethod(
      TextInputType type, Icon textIcon, String hint,
      {String prefixText = "", String labelText = ""}) {
    return TextFormField(
      keyboardType: type,
      validator: (s) {
        if (s!.length <= 2)
          return "hata";
        else
          return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        hintText: hint,
        labelText: labelText,
        prefix: Text(prefixText),
        prefixIcon: textIcon,
      ),
    );
  }
}

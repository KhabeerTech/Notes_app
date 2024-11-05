import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();
  String? selected;
  double? totalInterest;
  double? monthlyInterest;
  double? monthlyInstallment;

  void loancalculation() {
    final amount = int.parse(_controller1.text) - int.parse(_controller2.text);
    final tinterest =
        amount * (double.parse(_controller3.text) / 100) * int.parse(selected!);
    final minterest = tinterest / (int.parse(selected!) * 12);
    final minstall = (amount + tinterest) / (int.parse(selected!) * 12);
    setState(() {
      totalInterest = tinterest;
      monthlyInterest = minterest;
      monthlyInstallment = minstall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.notes,
          size: 30,
          color: Colors.black,
        ),
        toolbarHeight: 30,
        backgroundColor: Colors.yellow,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.info,
              size: 30,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Container(
              height: 170,
              decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Car Loan",
                          style: GoogleFonts.robotoMono(fontSize: 35),
                        ),
                        Text(
                          "Calculator",
                          style: GoogleFonts.robotoMono(fontSize: 35),
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  inputForm(
                      title: "Car Price",
                      hintText: "e.g 90000",
                      controller: _controller1),
                  inputForm(
                      title: "Down Payment",
                      hintText: "e.g 9000",
                      controller: _controller2),
                  inputForm(
                      title: "Interest Rate",
                      hintText: "e.g 3.5",
                      controller: _controller3),
                  Text(
                    "Loan Period",
                    style: GoogleFonts.robotoMono(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      loanPeriod("1"),
                      loanPeriod("2"),
                      loanPeriod("3"),
                      loanPeriod("4"),
                      loanPeriod("5"),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      loanPeriod("6"),
                      loanPeriod("7"),
                      loanPeriod("8"),
                      loanPeriod("9"),
                    ],
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      loancalculation();
                      Future.delayed(Duration.zero);
                      showModalBottomSheet(
                          isDismissible: false,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30))),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 400,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 30, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Result",
                                      style:
                                          GoogleFonts.robotoMono(fontSize: 20),
                                    ),
                                    SizedBox(height: 15),
                                    result("total Interest",
                                        totalInterest.toString()),
                                    result("monthly Interest",
                                        monthlyInterest.toString()),
                                    result(" monthly Installment",
                                        monthlyInstallment.toString()),
                                    SizedBox(height: 20),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Recalculate",
                                              style: GoogleFonts.robotoMono(
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Calculate",
                          style: GoogleFonts.robotoMono(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget result(String title, String amount) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          "RM" + amount.toString(),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget loanPeriod(title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = title;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2, 20, 0),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            border: title == selected
                ? Border.all(color: Colors.red, width: 2)
                : null,
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }

  Widget inputForm(
      {required String title,
      required TextEditingController controller,
      required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.robotoMono(fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: hintText),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
//18.54
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    // var options = {
    //   'key': 'rzp_test_DRfVxaEbtFkklr',
    //   'amount': 2000,
    //   'name': 'Acme Corp.',
    //   'description': 'Fine T-Shirt',
    //   'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    //   'external': {
    //     'wallets': ['paytm']
    //   }
    // };

    var options = {
      'key': 'rzp_test_DRfVxaEbtFkklr',
      'amount': 28000, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
      'description': 'Tulsi Mala',
      'timeout': 60, // in seconds
      'prefill': {'contact': '9523616123', 'email': 'wallet@razor.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        backgroundColor: Colors.deepPurple[300],
        fontSize: 13,
        textColor: Colors.black,
        msg: "Order SUCCESS: " + response.paymentId,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        backgroundColor: Colors.red[400],
        fontSize: 13,
        textColor: Colors.black,
        gravity: ToastGravity.TOP,
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        backgroundColor: Colors.green[400],
        fontSize: 13,
        textColor: Colors.black,
        gravity: ToastGravity.TOP,
        msg: "Paid By: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.deepPurple[50],
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9,
                crossAxisCount: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: 1,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.deepPurple[50],
                            offset: Offset(0, 3),
                            blurRadius: 3.0,
                            spreadRadius: 3.0),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                          child: Image.asset(
                            "assets/image/item.jpg",
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // height: 30,
                              child: Text(
                                "Tulsi Mala",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                // style: primaryBold14,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                              maxLines: 1,
                              softWrap: true,
                              text: TextSpan(
                                  text: "₹ 280.00 ",
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: "₹ 310.00",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.lineThrough))
                                  ]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemSize: 15,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    tapOnlyMode: true,
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                    // itemPadding: EdgeInsets.symmetric(horizontal: 2),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.deepPurple[300],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: MaterialButton(
                          onPressed: () {
                            openCheckout();
                          },
                          child: Text(
                            "Check Out",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          color: Colors.deepPurple[300],
                          elevation: 2,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

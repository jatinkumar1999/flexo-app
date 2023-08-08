import 'package:flexo_app/views/dashboard/sports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_payment/stripe_payment.dart';
import '../../constant/color_constant.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import '../../model/common_response_model.dart';
import '../../model/get_cards_details_model.dart';
import '../../services/api_constant.dart';
import '../../services/auth_services.dart';
import 'package:flexo_app/storage/get_storage.dart';

import '../../helper_widget.dart';
import 'homePage.dart';

class PaymentScreen extends StatefulWidget {
  final String comingFrom, catId, serviceId, timeSlotId,providerId;

  const PaymentScreen(
      {Key? key,
      required this.comingFrom,
      required this.catId,
      required this.serviceId,
      required this.timeSlotId,
      required this.providerId})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Token? paymentToken;
  PaymentMethod? _paymentMethod;
  String _error = '';
  GetCardDetailsModel? getCardDetailsModel;
  List<CardDetails>? cardDetails = [];
  var cardNumberController = TextEditingController();
  var expYearController = TextEditingController();
  var expMonthController = TextEditingController();
  var cvvCodeController = TextEditingController();
  var cardHolderController = TextEditingController();

  @override
  void initState() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: ApiUrl.publishablekey,
        merchantId: "Test",
        androidPayMode: 'test'));

/*    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCardInfo().then((value) {
        cardDetails = value.cardDetails;
        cardNumber = cardDetails?.first.cardNumber ?? '';
        expiryDate =
            '${cardDetails?.first.month ?? ''}${'/'}${cardDetails?.first.year ?? ''}';
        cardHolderName = cardDetails?.first.cardHolderName ?? '';
      });
    });*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Payment",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontStyle: FontStyle.normal),
        ),
      ),
      body: Column(
        children: [
          CreditCardWidget(
            glassmorphismConfig:
                useGlassMorphism ? Glassmorphism.defaultConfig() : null,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            bankName: 'Debit/Credit Cards',
            frontCardBorder:
                !useGlassMorphism ? Border.all(color: Colors.grey) : null,
            backCardBorder:
                !useGlassMorphism ? Border.all(color: Colors.grey) : null,
            showBackView: isCvvFocused,
            obscureCardNumber: true,
            obscureCardCvv: true,
            isHolderNameVisible: true,
            cardBgColor: AppColor.orangeColor,
            backgroundImage: useBackgroundImage ? 'assets/card_bg.png' : null,
            isSwipeGestureEnabled: true,
            onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
            customCardTypeIcons: <CustomCardTypeIcon>[
              CustomCardTypeIcon(
                cardType: CardType.visa,
                cardImage: Image.asset(
                  'assets/mastercard.png',
                  height: 48,
                  width: 48,
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CreditCardForm(
                    formKey: formKey,
                    onCreditCardModelChange: onCreditCardModelChange,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    cardHolderName: cardHolderName,
                    expiryDate: expiryDate,
                    themeColor: Colors.blue,
                    cardNumberDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    expiryDateDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expired Date',
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Holder Name',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        backgroundColor: AppColor.orangeColor,
                        foregroundColor: AppColor.orangeColor,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print('valid!');

                          List<String> substrings = expiryDate.split("/");
                          var expMonth = substrings[0];
                          var expYear = substrings[1];
                          print(substrings); // Output: [This is a, sample text]
                          print(substrings[0]); // Output: [This is a]
                          print(substrings[1]);

                          /* final CreditCard testCard = CreditCard(
                            number: cardNumber,
                            expMonth: int.parse(expMonth),
                            expYear: int.parse(expYear),
                          );

                          StripePayment.createTokenWithCard(
                            testCard,
                          ).then((token) {
                            HelperWidget.showToast(message: 'Received ${token.tokenId}');

                            setState(() {
                              paymentToken = token;
                            });
                          }).catchError(setError);
*/
                          // Output: [sample text]

                          widget.comingFrom == 'BookingScreen'
                              ? token()
                              : saveCardDetailsApiCall(cardHolderName,
                                  cardNumber, expMonth, expYear);
                        } else {
                          HelperWidget.showToast(message: 'Invalid Card');

                          print('invalid!');
                        }
                      },
                      child: const Text(
                        "Validate",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  widget.comingFrom == 'BookingScreen'
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return SportsScreen(
                                comingFrom: 'BookingScreen',
                              );
                            }), (r) {
                              return false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 24,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  void token() async {
    List<String> arr = expiryDate.split('/');
    int date = int.parse(arr[0]);
    int year = int.parse(arr[1]);
    print(date.toString() + " " + year.toString());
    print('============>Month$expiryDate');
    final testCard =
        CreditCard(number: cardNumber, expMonth: date, expYear: year);

    StripePayment.createTokenWithCard(testCard).then((token) {
      print(token.tokenId);
      bookAppointmentApiCall();
    });
  }

  Future<AlertDialog>? _showValidDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff1b447b),
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                child: Text(
                  "Ok",
                  style: TextStyle(fontSize: 18, color: Colors.cyan),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SportsScreen(
                                comingFrom: 'Payment',
                              )));
                }),
          ],
        );
      },
    );
  }

  Future saveCardDetailsApiCall(
    String? cardHolderName,
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
  ) async {
    HelperWidget.showProgress(context);

    CommonResponseModel _registerModel = await ApiProvider().cardDetailsSave(
        userId: await Storage().getStoreUserId().toString(),
        cardHolderName: cardHolderName,
        cardNumber: cardNumber,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear);
    Navigator.pop(context);
    if (_registerModel.status == true) {
      HelperWidget.showToast(message: _registerModel.message);
      _showValidDialog(context, "Valid", "Your card successfully Added !!!");
    } else if (_registerModel.status == false) {
      HelperWidget.showToast(message: _registerModel.message);

      print('signupm error messsga e==>${_registerModel.message}');
    }
  }

  void bookAppointmentApiCall() async {
    HelperWidget.showProgress(context);

    CommonResponseModel _registerModel = await ApiProvider().bookingAppointment(
        userId: await Storage().getStoreUserId().toString(),
        catId: widget.catId.toString(),
        serviceId: widget.serviceId.toString(),
        timeSlotId: widget.timeSlotId.toString(),providerId: widget.providerId);
    Navigator.pop(context);
    if (_registerModel.status == true) {
      HelperWidget.showToast(message: _registerModel.message);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                  )));
    } else if (_registerModel.status == false) {
      HelperWidget.showToast(message: _registerModel.message);

      print('signupm error messsga e==>${_registerModel.message}');
    }
  }

  Future<GetCardDetailsModel> getCardInfo() async {
    HelperWidget.showProgress(context);
    getCardDetailsModel = await ApiProvider().getCardDetails();
    Navigator.pop(context);
    if (getCardDetailsModel?.status == true) {
      HelperWidget.showToast(message: getCardDetailsModel?.message);
      setState(() {});
    } else if (getCardDetailsModel?.status == false) {
      HelperWidget.showToast(message: getCardDetailsModel?.message);
    }

    return getCardDetailsModel!;
  }
}

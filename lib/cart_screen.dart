import 'dart:math';
import 'package:cashere_app/bayar_button.dart';
import 'package:cashere_app/home_screen.dart';
import 'package:flutter/material.dart';

import 'choice_box.dart';
import 'food.dart';

class CartScreen extends StatefulWidget {
  final List<Food>? cartList;

  CartScreen({Key? key, this.cartList}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int totalPrice = 0;
  int change = 0;
  final TextEditingController _paymentController = TextEditingController();
  int selectedPayment = -1;
  int selectedAmount = -1;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  @override
  void dispose() {
    _paymentController.dispose();
    super.dispose();
  }

  void _calculateTotalPrice() {
    totalPrice = widget.cartList!
        .map((food) => int.parse(food.price!))
        .reduce((value, element) => value + element);
  }

  void _onPaymentMethodSelected(int index) {
    setState(() {
      selectedPayment = index;
    });
  }

  void _onAmountSelected(int index) {
    setState(() {
      selectedAmount = index;
      _paymentController.text = listOfAmount[index];
      _calculateChange();
    });
  }

  void _calculateChange() {
    int paymentAmount = int.tryParse(_paymentController.text) ?? 0;
    setState(() {
      change = max(0, paymentAmount - totalPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _CartList(cartList: widget.cartList!),
          ],
        ),
      ),
      bottomSheet: _buildBottomSheet(size),
    );
  }

  Widget _buildBottomSheet(Size size) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .03, vertical: size.width * .04),
        height: selectedPayment == 1 ? size.width * 1.6 : size.width * 1.2,
        decoration: _boxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalRow(size),
            SizedBox(height: size.width * .04),
            _buildPaymentMethodSelector(size),
            SizedBox(height: size.width * .04),
            if (selectedPayment == 0) _buildCustomPaymentSection(size),
            SizedBox(height: size.width * .04),
            if (selectedPayment == 0) _buildAmountSelector(size),
            SizedBox(height: size.width * .04),
            if (selectedPayment == 0) _buildChangeRow(size),
            SizedBox(height: size.width * .04),
            if (totalPrice < (int.tryParse(_paymentController.text) ?? 0))
              BayarButton(
                onTap: () {
                  _showSimpleDialog(context);
                  widget.cartList!.clear();
                },
              )
          ],
        ),
      ),
    );
  }

  void _showSimpleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Suksess'),
          content: const Text('Pembayaran telah behasil!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false); // Closes the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 20,
          offset: const Offset(0, -3),
        ),
      ],
    );
  }

  Widget _buildTotalRow(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total:", style: TextStyle(fontSize: size.width * .06)),
        Text("Rp. $totalPrice", style: TextStyle(fontSize: size.width * .06)),
      ],
    );
  }

  Widget _buildPaymentMethodSelector(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Metode Pembayaran:",
            style: TextStyle(fontSize: size.width * .05)),
        SizedBox(height: size.width * .04),
        Center(
          child: SizedBox(
            height: size.width * .16,
            width: size.width * .42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listOfPayment.length,
              itemBuilder: (context, index) => ChoiceBox(
                label: listOfPayment[index],
                isSelected: selectedPayment == index,
                onTap: () => _onPaymentMethodSelected(index),
                index: index,
                height: size.width * .16,
                width: size.width * .2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomPaymentSection(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size.width * .12,
          width: size.width * .4,
          child: TextField(
            controller: _paymentController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: size.width * .02),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * .03),
              ),
            ),
            onChanged: (value) => _calculateChange(),
          ),
        ),
        SizedBox(width: size.width * .03),
        GestureDetector(
          onTap: _calculateChange,
          child: Container(
            height: size.width * .12,
            width: size.width * .16,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(size.width * .03),
            ),
            child: const Icon(Icons.check, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountSelector(Size size) {
    return Center(
      child: SizedBox(
        height: size.width * .14,
        width: size.width * .7,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listOfAmount.length,
          itemBuilder: (context, index) => ChoiceBox(
            index: index,
            height: size.width * .16,
            width: size.width * .2,
            label: listOfAmount[index],
            isSelected: selectedAmount == index,
            onTap: () => _onAmountSelected(index),
          ),
        ),
      ),
    );
  }

  Widget _buildChangeRow(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Kembali:", style: TextStyle(fontSize: size.width * .05)),
        Text("Rp. $change", style: TextStyle(fontSize: size.width * .05)),
      ],
    );
  }

  List<String> listOfAmount = ["25000", "50000", "100000"];
  List<String> listOfPayment = ["Tunai", "Non Tunai"];
}

class _CartList extends StatelessWidget {
  final List<Food> cartList;

  const _CartList({required this.cartList});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: size.width * .03),
        itemCount: cartList.length,
        itemBuilder: (context, index) {
          final food = cartList[index];
          return _CartItem(food: food);
        },
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final Food food;

  const _CartItem({required this.food});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.width * .01),
      height: size.width * .2,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(size.width * .04),
            child: Image.asset(
              food.photo!,
              width: size.width * .2,
              height: size.width * .16,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: size.width * .03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(food.name!, style: TextStyle(fontSize: size.width * .05)),
              Text(
                "Rp. ${food.price}",
                style: TextStyle(
                  fontSize: size.width * .05,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'food.dart';
import 'food_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Food> cartList = [];
  final List<Food> foodList = [
    Food(id: "1", name: "Pizza", price: "60000", photo: "assets/pizza.jpg"),
    Food(id: "2", name: "Pasta", price: "30000", photo: "assets/pasta.jpg"),
    Food(id: "3", name: "Burger", price: "25000", photo: "assets/burger.jpg"),
    Food(id: "4", name: "Sushi", price: "34000", photo: "assets/sushi.jpg"),
    Food(id: "5", name: "Salad", price: "32000", photo: "assets/salad.jpg"),
    Food(id: "6", name: "Tacos", price: "20000", photo: "assets/tacos.jpg"),
    Food(
        id: "7",
        name: "Fried Chicken",
        price: "23000",
        photo: "assets/fried_chicken.jpg"),
    Food(id: "8", name: "Soup", price: "20000", photo: "assets/soup.jpg"),
    Food(
        id: "9",
        name: "Ice Cream",
        price: "10000",
        photo: "assets/ice_cream.jpg"),
    Food(
        id: "10",
        name: "Fruit Salad",
        price: "27000",
        photo: "assets/fruit_salad.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.width * 0.04),
            _buildHeaderText(size),
            SizedBox(height: size.width * 0.06),
            Expanded(child: _buildFoodGrid(size)),
          ],
        ),
      ),
      floatingActionButton: cartList.isEmpty ? null : _buildCartButton(size),
    );
  }

  Widget _buildHeaderText(Size size) {
    return Padding(
      padding: EdgeInsets.only(left: size.width * .02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What Do You Want to Eat?",
                style: TextStyle(
                  fontSize: size.width * 0.055,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.1,
                ),
              ),
              Text(
                "Pick what you like",
                style: TextStyle(fontSize: size.width * 0.042),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
      ),
    );
  }

  Widget _buildFoodGrid(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: size.width * 0.20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 9 / 12,
          crossAxisCount: 2,
          mainAxisSpacing: 11,
          crossAxisSpacing: 11,
        ),
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          final food = foodList[index];
          return FoodCard(
            food: food,
            size: size,
            onTap: () => _addToCart(context, food),
          );
        },
      ),
    );
  }

  Widget _buildCartButton(Size size) {
    return Stack(
      children: [
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(cartList: cartList),
              ),
            );
          },
          backgroundColor: Colors.white,
          child: const Icon(Icons.shopping_bag),
        ),
        Positioned(
          right: 0,
          child: _buildCartItemCount(size),
        ),
      ],
    );
  }

  Widget _buildCartItemCount(Size size) {
    return Container(
      height: size.width * 0.06,
      width: size.width * 0.06,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(size.width * 0.03),
      ),
      child: Center(
        child: Text(
          "${cartList.length}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.04,
          ),
        ),
      ),
    );
  }

  void _addToCart(BuildContext context, Food food) {
    if (!cartList.contains(food)) {
      setState(() {
        cartList.add(food);
      });
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text("Item was added!")));
    }
  }
}

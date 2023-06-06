import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String name;
  final String profilePicUrl;
  final double initialBalance;

  const MyAppBar({
    Key? key,
    required this.name,
    required this.profilePicUrl,
    required this.initialBalance,
  }) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}

class _MyAppBarState extends State<MyAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _currentBalance = 0.0;
  bool _showBalance = false;

  @override
  void initState() {
    super.initState();
    _currentBalance = widget.initialBalance;

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(_animationController);
  }

  void _toggleShowBalance() {
    setState(() {
      _showBalance = !_showBalance;
      if (!_showBalance) {
        _animationController.reverse();
      }
    });

    if (_showBalance) {
      _animationController.forward();
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          _showBalance = false;
        });
        _animationController.reverse();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70.0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink, Colors.pink],
          ),
        ),
      ),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profilePicUrl),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: _toggleShowBalance,
                child: Container(
                  width: 130.0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 4.0),
                      SlideTransition(
                        position: _offsetAnimation,
                        child: const Text(
                          '\$',
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        _showBalance ? '$_currentBalance' : 'Tap for Balance',
                        style: const TextStyle(
                          color: Colors.pink,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Handle notification icon tap
          },
        ),
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Handle menu icon tap
          },
        ),
      ],
    );
  }
}

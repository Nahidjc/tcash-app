import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/model/user_model.dart';
import 'package:rnd_flutter_app/provider/user_provider.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {

  final String userId;
  final VoidCallback openAppDrawer;

  const MyAppBar(
      {Key? key,
      required this.userId,
      required this.openAppDrawer})
      : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}

class _MyAppBarState extends State<MyAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  bool _showBalance = false;

  UserDetails? userDetails;
  void fetchUserDetails() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final fetchedUserDetails =
        await userProvider.fetchUserDetailsById(widget.userId);
    setState(() {
      userDetails = fetchedUserDetails;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
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
    double? balance = userDetails?.currentBalance;
    final name = userDetails?.name ?? "Change Your Name";
    final profile = userDetails?.profilePic ??
        "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png";


    return AppBar(
      automaticallyImplyLeading: false,
      leading: null,
      toolbarHeight: 70.0,
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink, Colors.pink.shade300],
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(profile),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
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
                      const SizedBox(width: 10.0),
                      SlideTransition(
                        position: _offsetAnimation,
                        child: const Text(
                          '৳',
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        _showBalance ? '$balance' : 'Tap for Balance',
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
            widget.openAppDrawer();
          },
        ),
      ],
    );
  }
}

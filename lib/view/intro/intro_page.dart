import 'package:flutter/material.dart';
import 'package:quizlet_clone/view/login/login_page.dart';
import 'package:quizlet_clone/view/register/register_page.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(child: boldText('SignUp', size: 24)),
            Tab(child: boldText('Login', size: 24)),
          ],
          indicatorColor: Colors.purple,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          RegisterPage(onTapLogin: () {
            _tabController.animateTo(1); // Scroll to Login tab
          }),
          LoginPage(onTapSignUp: () {
            _tabController.animateTo(0); // Scroll to SignUp tab
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/onboarding_model.dart';
import '../../widgets/auth_gate.dart';

class OnboardingScreen extends StatefulWidget {
  static String routeName = '/onboarding-screen';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            skipToLastPageButton(context),
            pageContents(),
            pageIndicators(),
            const SizedBox(height: 24.0),
            nextPageButton(),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Align skipToLastPageButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          onPressed: () {
            _controller.jumpToPage(onboardingItems.length - 1);
          },
          child: Text(
            'Skip',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Expanded pageContents() {
    /*
    PageView to display the onboarding items.
    It uses a PageController to manage the pages and updates the state
    when the page changes to determine if the last page is reached.
    */
    return Expanded(
      child: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            isLastPage = index == onboardingItems.length - 1;
          });
        },
        itemCount: onboardingItems.length,
        itemBuilder: (context, index) {
          final item = onboardingItems[index];
          return pageContentWidget(item);
        },
      ),
    );
  }

  Padding pageContentWidget(OnboardingItem item) {
    /*
    Page content widget that displays the icon, title, and description
    for each onboarding item.
    It uses a Padding widget to provide spacing around the content.
    */
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 56.0,
            backgroundColor: Colors.grey.shade200,
            child: item.icon,
          ),
          SizedBox(height: 32),
          Text(
            item.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  SmoothPageIndicator pageIndicators() {
    // page indicators to show current page
    return SmoothPageIndicator(
      controller: _controller,
      count: onboardingItems.length,
      effect: ExpandingDotsEffect(
        activeDotColor: Color(0xFF115B55),
        dotColor: Colors.grey.shade300,
        dotHeight: 8,
        dotWidth: 8,
      ),
    );
  }

  Padding nextPageButton() {
    // button to allow a user to move to the next page
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (isLastPage) {
              // Navigate to login screen if the user is unauthenticated
              // otherwise navigate to homescreen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthGate()),
              );
            } else {
              _controller.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            }
          },
          child: Text(isLastPage ? 'Get Started' : 'Next'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthTipsPage extends StatefulWidget {
  const HealthTipsPage({super.key});

  @override
  State<HealthTipsPage> createState() => _HealthTipsPageState();
}

class _HealthTipsPageState extends State<HealthTipsPage> {
  var customDecoration = PageDecoration(
    pageColor: Colors.white,
    safeArea: 30,
      imagePadding:const EdgeInsets.only(bottom: 24,left: 10,right: 10,top: 10),
      bodyAlignment: Alignment.bottomCenter,
      bodyTextStyle: GoogleFonts.montserrat(
          textStyle:const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      titleTextStyle: GoogleFonts.barlowCondensed(
          textStyle:const TextStyle(fontWeight: FontWeight.bold, fontSize: 34)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: CustomAppbar(title: 'Health tips'),
      body:IntroductionScreen(
      dotsDecorator: DotsDecorator(
        activeColor: Colors.red,
        size:  Size.square(9),
        activeSize: Size(18, 9),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        )
      ),
      showDoneButton: true,
      done: Text('Done'),
      onDone: () => Navigator.of(context).pop(),
      showNextButton: true,
      next:const Icon(Icons.arrow_forward,color: Colors.red,),
      
      pages: [
        PageViewModel(
            
            decoration: customDecoration,
            image: const Center(
              child: Image(image: AssetImage('assets/images/diet.jpg')),
            ),
            title: 'Balanced Diet',
            body:
                'A well- balanced diet plays a pivotal role in maintaining optimal blood health. Include a variety of nutrient-rich foods in your meals, such as fruits, vegetables, whole grains, lean proteins, and healthy fats.'),
        PageViewModel(
            decoration: customDecoration,
            image: Image(image: AssetImage('assets/images/hydrated.jpg')),
            title: 'Stay Hydrated',
            body:
                'Adequate hydration is crucial for blood health. Water helps in maintaining the viscosity of blood, allowing it to flow smoothly through blood vessels.Aim to drink at least eight glasses of water per day.'),
        PageViewModel(
            decoration: customDecoration,
            image: const Center(
              child: Image(image: AssetImage('assets/images/omega3.jpg')),
            ),
            title: 'Eat oily fish',
            body:
                'The omega-3 fatty acids in oily fish promote cardiovascular and brain health, according to the American Heart Association (AHA)Trusted Source. This can also lead to improved circulation.'),
        PageViewModel(
            decoration: customDecoration,
            image: const Center(
              child: Image(image: AssetImage('assets/images/exercise.jpg')),
            ),
            title: 'Regular Exercise',
            body:
                'Exercise stimulates the production of nitric oxide, a compound that helps dilate blood vessels, reducing the risk of blood clots and maintaining healthy blood pressure.'),
        PageViewModel(
            decoration: customDecoration,
            image: const Center(
              child: Image(image: AssetImage('assets/images/avoid_alcohol.jpg')),
            ),
            title: 'Avoid Tobacco and Alcohol ',
            body:
                'Tobacco use, including smoking and chewing tobacco, is known to have severe consequences for blood health. Smoking damages blood vessels, reduces oxygen-carrying capacity, and increases the risk of blood clots.'),
        PageViewModel(
            decoration: customDecoration,
            image: const Center(
              child: Image(image: AssetImage('assets/images/stress.jpg')),
            ),
            title: 'Manage Stress',
            body:
                'Chronic stress can have a significant impact on blood health. Prolonged stress releases stress hormones, such as cortisol, which can elevate blood pressure and increase the risk of cardiovascular diseases.'),
        PageViewModel(
            decoration: customDecoration,
            image: const Center(
              child: Image(image: AssetImage('assets/images/checkup.jpg')),
            ),
            title: 'Health Check-ups',
            body:
                'Regular health check-ups are essential for early detection and prevention of blood-related disorders. Visit your healthcare provider regularly to monitor blood pressure, cholesterol levels, and screen for conditions such as anemia, blood clotting disorders, and blood cancers.')
      ],
    ) ,
    );
    
    
  }
}

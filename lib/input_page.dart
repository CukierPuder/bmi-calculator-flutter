import 'package:bmi_calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
enum Gender {
  MALE,
  FEMALE
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  Gender gender = Gender.MALE;
  int weight = 80;
  int age = 20;

  void incrementAge() {setState(() {age++;});}
  void decrementAge() {setState(() {age--;});}
  void incrementWeight() {setState(() {weight++;});}
  void decrementWeight() {setState(() {weight--;});}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    color: this.gender == Gender.MALE ? cActiveCardColor : cInactiveCardColor,
                    child: GenderButtonContent(
                      icon: FontAwesomeIcons.mars,
                      text: 'MALE',
                      textStyle: this.gender == Gender.MALE ? cRegularTextStyle : cSecondaryTextStyle,
                      iconColor: this.gender == Gender.MALE ? cActiveTextColor : cInactiveTextColor,
                    ),
                    onPress: () {
                      setState(() {
                        this.gender = Gender.MALE;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: this.gender == Gender.FEMALE ? cActiveCardColor : cInactiveCardColor,
                    child: GenderButtonContent(
                      icon: FontAwesomeIcons.venus,
                      text: 'FEMALE',
                      textStyle: this.gender == Gender.FEMALE ? cRegularTextStyle : cSecondaryTextStyle,
                      iconColor: this.gender == Gender.FEMALE ? cActiveTextColor : cInactiveTextColor,
                    ),
                    onPress: () {
                      setState(() {
                        this.gender = Gender.FEMALE;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              color: cActiveCardColor,
              child: HeightSlider(),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                      color: cActiveCardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: cSecondaryTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: cNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPress: decrementWeight,
                            ),
                            SizedBox(width: 10.0,),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPress: incrementWeight,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: cActiveCardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: cSecondaryTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: cNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPress: decrementAge,
                            ),
                            SizedBox(width: 10.0,),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPress: incrementAge,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/calculate');
            },
            child: Container(
              color: Colors.red,
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: 50.0,
              alignment: Alignment.center,
              child: Text(
                'CALCULATE',
                style: cNumberTextStyle,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HeightSlider extends StatefulWidget {
  const HeightSlider({Key? key}) : super(key: key);

  @override
  _HeightSliderState createState() => _HeightSliderState();
}

class _HeightSliderState extends State<HeightSlider> {
  double sliderValue = 180.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'HEIGHT',
          style: cSecondaryTextStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              sliderValue.toInt().toString(),
              style: cNumberTextStyle,
            ),
            Text(
              'cm',
              style: cUnitTextStyle,
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: cActiveTextColor,
            inactiveTrackColor: cInactiveTextColor,
            thumbColor: Color(0xFFEB1555),
            overlayColor: Color(0x29EB1555),
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 15.0
            ),
            overlayShape: RoundSliderOverlayShape(
              overlayRadius: 30.0
            )
          ),
          child: Slider(
              value: sliderValue,
              min: 120.0,
              max: 220.0,
              onChanged: (double newValue) {
                setState(() {
                  sliderValue = newValue.roundToDouble();
                });
              },
          ),
        )
      ],
    );
  }
}

class GenderButtonContent extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle textStyle;
  final Color iconColor;

  GenderButtonContent({
    required this.icon,
    required this.text,
    required this.textStyle,
    required this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          this.icon,
          size: 80.0,
          color: iconColor,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          this.text,
          style: textStyle
        )
      ]
    );
  }
}

class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget? child;
  final Function()? onPress;

  ReusableCard({required this.color, this.child, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Container(
        child: Center(
            child: child
        ),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: this.color,
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onPress;

  const RoundIconButton({
    required this.icon,
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      elevation: 0.0,
      child: Icon(icon),
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}

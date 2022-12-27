import 'package:answer_it/utlts/colors.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colours.textColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 15,
        height: MediaQuery.of(context).size.height / 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colours.secondaryColor,
                  ),
                  color: Colours.textColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colours.textColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.grey.shade300,
                                spreadRadius: 5,
                              )
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colours.textColor,
                            child: Image.asset('assets/user.png'),
                          ),
                        ),
                      ),
                      const Text(
                        'YOU',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

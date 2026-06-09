import 'package:flutter/material.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() =>
      _EventDetailsScreenState();
}

class _EventDetailsScreenState
    extends State<EventDetailsScreen> {

  bool joined = false;
  bool interested = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xff071A38),

      body: SafeArea(

        child:
        SingleChildScrollView(

          child:
          Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Container(

                height: 260,

                width:
                double.infinity,

                decoration:

                const BoxDecoration(

                  color:
                  Colors.blueGrey,

                ),

                child:

                Stack(

                  children: [

                    const Center(

                      child:

                      Icon(

                        Icons.groups,

                        size: 100,

                        color:
                        Colors.white,

                      ),

                    ),

                    IconButton(

                      onPressed: () {

                        Navigator.pop(
                            context);

                      },

                      icon:

                      const Icon(

                        Icons.arrow_back,

                        color:
                        Colors.white,

                      ),

                    ),
                  ],
                ),
              ),

              Padding(

                padding:
                const EdgeInsets.all(
                    20),

                child:

                Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    const Text(

                      "AI For Social Impact Workshop",

                      style:
                      TextStyle(

                        color:
                        Colors.white,

                        fontSize:
                        28,

                        fontWeight:
                        FontWeight.bold,

                      ),
                    ),

                    const SizedBox(
                        height: 16),

                    const Text(

                      "Learn how students can use AI to solve community challenges and connect across ALU.",

                      style:
                      TextStyle(

                        color:
                        Colors.white70,

                        height:
                        1.6,

                      ),
                    ),

                    const SizedBox(
                        height: 30),

                    SizedBox(

                      width:
                      double.infinity,

                      child:

                      ElevatedButton(

                        onPressed: () {

                          setState(() {

                            joined =
                            !joined;

                          });

                        },

                        style:

                        ElevatedButton.styleFrom(

                          backgroundColor:

                          joined

                              ?

                          Colors.green

                              :

                          Colors.amber,

                          padding:

                          const EdgeInsets.all(
                              18),

                        ),

                        child:

                        Text(

                          joined

                              ?

                          "RSVP Confirmed"

                              :

                          "RSVP",

                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 12),

                    SizedBox(

                      width:
                      double.infinity,

                      child:

                      OutlinedButton(

                        onPressed: () {

                          setState(() {

                            interested =
                            !interested;

                          });

                        },

                        child:

                        Text(

                          interested

                              ?

                          "Interested ✓"

                              :

                          "Interested",

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
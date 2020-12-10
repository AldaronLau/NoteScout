import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:note_scout/main.dart';

// FAQ answers page
class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frequently Asked Questions"),
        centerTitle: true,
        backgroundColor: APPCOLOR,
      ),
      body: Stack(children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: Text("Questions: How do I upload a note? \n\n"
                "Answers: Use your device's camera and take a picture of the note, then upload it to the screen. If you have the note ready in your camera roll select gallery and use the apps feature Upload Notes. \n\n"
                "Question: How do I view my notes? \n\n"
                "Answer: View your notes by going to the home pade and click on My Notes. The notes you've created will be there. have \n\n"
                "Questions: How do I search my notes? \n\n"
                "Answer: Use the search bar to look at all notes that have been uploaded.\n\n"
                "Question: How do I find my bookmarked notes? \n\n"
                "Answer: Press the the Bookmark Notes icon in the homescreen. \n\n"
                "Question: Can I access NoteScout on my laptop? \n\n"
                "Answer: NoteScout is currently only on iOS and Android. We are working to support other devices soon. \n\n "

                "Please leave a rating in your local app store for NoteScout. We appreciate all feedback and support. \n\n"

                "If you have any more questions contact us at:          \n\n"
                "Olderrm@augsburg.edu, Mengl@augsburg.edu, Leek7@augsburg.edu or at Lauj@augsburg.edu\n\n ")),
      ]),
    );
  }
}

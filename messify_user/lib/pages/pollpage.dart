import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messify/pages/sessionData.dart';

class CustomPollPage extends StatefulWidget {
  String messName;

  CustomPollPage({super.key, required this.messName});

  @override
  _CustomPollPageState createState() => _CustomPollPageState();
}

class _CustomPollPageState extends State<CustomPollPage> {
  int date = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    initialzeData();
  }

  void initialzeData() async {
    await pollDataGetter();
    await userPollDataGetter();
  }

  Map<String, dynamic> pollData = {};
  Map<String, dynamic> userPollData = {};

  Future<void> pollDataGetter() async {
    DocumentSnapshot _docSnap = await FirebaseFirestore.instance
        .collection('Poll')
        .doc(widget.messName)
        .collection('PollData')
        .doc('$year-$month-$date')
        .get();
    if (_docSnap.exists) {
      pollData = _docSnap.data() as Map<String, dynamic>;
      userPollData['hasVoted'] = userPollData['hasVoted'] ?? false;
      userPollData['userVote'] = userPollData['userVote'] ?? null;
      setState(() {});
    }
  }

  Future<void> userPollDataGetter() async {
    DocumentSnapshot _docSnap = await FirebaseFirestore.instance
        .collection('PollUser')
        .doc(widget.messName)
        .collection('PollDetails')
        .doc('$year-$month-$date')
        .collection('UserData')
        .doc(Sessiondata.usernameget)
        .get();
    userPollData = _docSnap.data() as Map<String, dynamic>;
  }

  void castVote(int optionIndex) {
    if (userPollData['hasVoted']) return; // Prevent multiple votes

    setState(() {
      userPollData['hasVoted'] = true;
      userPollData['userVote'] = optionIndex;
      pollData['options'][optionIndex]['votes']++;
      pollToFirebaseAdder();
    });
  }

  int buildContextCounter = 0;

  int getTotalVotes() {
    return pollData['options']
        .fold(0, (total, option) => total + option['votes'] as int);
  }

  double getVotePercentage(int optionVotes) {
    final totalVotes = getTotalVotes();
    return totalVotes == 0 ? 0 : (optionVotes / totalVotes) * 100;
  }

  void pollToFirebaseAdder() async {
    await FirebaseFirestore.instance
        .collection('PollUser')
        .doc(widget.messName)
        .collection('PollDetails')
        .doc('$year-$month-$date')
        .collection('UserData')
        .doc(Sessiondata.usernameget)
        .set(userPollData);

    await FirebaseFirestore.instance
        .collection('Poll')
        .doc(widget.messName)
        .collection('PollData')
        .doc('$year-$month-$date')
        .set(pollData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poll question
          Text(
            pollData['question'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // Poll options
          Column(
            children: List.generate(pollData['options'].length, (index) {
              final option = pollData['options'][index];
              final percentage = getVotePercentage(option['votes']);

              return GestureDetector(
                onTap: () => castVote(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: userPollData['hasVoted']
                        ? (userPollData['userVote'] == index
                            ? Colors.green[100]
                            : Colors.grey[200])
                        : Colors.blue[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option['title'],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      if (userPollData['hasVoted']) ...[
                        Stack(
                          children: [
                            Container(
                              height: 10,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Container(
                              height: 10,
                              width: MediaQuery.of(context).size.width *
                                  0.8 *
                                  (percentage / 100),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${percentage.toStringAsFixed(1)}% (${option['votes']} votes)',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ]
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

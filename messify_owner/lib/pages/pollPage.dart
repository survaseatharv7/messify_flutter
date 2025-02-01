import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/pages/SessionMananger/session_data.dart';

class CustomPollPage extends StatefulWidget {
  @override
  _CustomPollPageState createState() => _CustomPollPageState();
}

class _CustomPollPageState extends State<CustomPollPage> {
  // Poll data
  Map<String, dynamic> poll = {};

  void pollGetter() async {
    DocumentSnapshot _docSnap = await FirebaseFirestore.instance
        .collection('Poll')
        .doc(SessionData.messName)
        .get();
    if (_docSnap.exists) {
      poll = _docSnap.data() as Map<String, dynamic>;
      poll['hasVoted'] = poll['hasVoted'] ?? false;
      poll['userVote'] = poll['userVote'] ?? null;
      setState(() {});
    }
  }

  void castVote(int optionIndex) {
    if (poll['hasVoted']) return; // Prevent multiple votes

    setState(() {
      poll['hasVoted'] = true;
      poll['userVote'] = optionIndex;
      poll['options'][optionIndex]['votes']++;
      pollToFirebaseAdder();
    });
  }

  int buildContextCounter = 0;

  int getTotalVotes() {
    return poll['options']
        .fold(0, (total, option) => total + option['votes'] as int);
  }

  double getVotePercentage(int optionVotes) {
    final totalVotes = getTotalVotes();
    return totalVotes == 0 ? 0 : (optionVotes / totalVotes) * 100;
  }

  void pollToFirebaseAdder() async {
    await FirebaseFirestore.instance
        .collection('Poll')
        .doc(SessionData.messName)
        .set(poll);
  }

  @override
  Widget build(BuildContext context) {
    buildContextCounter++;
    if (buildContextCounter == 1) {
      pollGetter();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Poll Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poll question
            Text(
              poll['question'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Poll options
            Column(
              children: List.generate(poll['options'].length, (index) {
                final option = poll['options'][index];
                final percentage = getVotePercentage(option['votes']);

                return GestureDetector(
                  onTap: () => castVote(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: poll['hasVoted']
                          ? (poll['userVote'] == index
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
                        if (poll['hasVoted']) ...[
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
      ),
    );
  }
}

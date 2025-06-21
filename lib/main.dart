import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Feature Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FeatureDemoPage(),
    );
  }
}

class FeatureDemoPage extends StatefulWidget {
  const FeatureDemoPage({super.key});

  @override
  State<FeatureDemoPage> createState() => _FeatureDemoPageState();
}

class _FeatureDemoPageState extends State<FeatureDemoPage> {
  Color _backgroundColor = Colors.white;
  final TextEditingController _textController = TextEditingController();
  String _submittedText = 'Nothing submitted yet';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _submitText() {
    setState(() {
      _submittedText = _textController.text;
    });
    print('Submitted: ${_textController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(title: const Text('Flutter Feature Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Welcome Message
            const Text(
              'Welcome to Flutter!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // 2. Three Buttons
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('You clicked me!')),
                    );
                  },
                  child: const Text('Click Me (Shows Snackbar)'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onLongPress: () {
                    setState(() {
                      _backgroundColor =
                          Colors.primaries[DateTime.now().millisecond %
                              Colors.primaries.length];
                    });
                  },
                  onPressed: () {},
                  child: const Text('Long Press Me (Changes Background)'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _backgroundColor = Colors.white;
                    });
                  },
                  child: const Text('Reset Background'),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // 3. GestureDetector Container
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Single Tap Detected')),
                );
              },
              onDoubleTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Double Tap Detected')),
                );
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Tap or Double Tap Me',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 4. TextField with Submit Button
            const Text('Text Input Section:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Type something',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _submitText,
                ),
              ),
              onChanged: (text) {
                print('Input changed: $text');
              },
              onSubmitted: (text) {
                _submitText();
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitText,
              child: const Text('Submit Text'),
            ),
            const SizedBox(height: 20),
            Text(
              'Submitted Text: $_submittedText',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

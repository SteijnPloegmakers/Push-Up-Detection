import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/push_up_model.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    final bloc = BlocProvider.of<PushUpCounter>(context);
    
    return Positioned(
      left: 0,
      top: 50,
      right: 0,
      child: Container(
        width: 70,
        child: Column(
          children: [
            const Text('Counter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),
            ),
            Container(
              width: 70,
              decoration: BoxDecoration(
                color: Colors.black54,
                border: Border.all(color: Colors.white.withOpacity(0.4), width: 4.0),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Text('${bloc.counter}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
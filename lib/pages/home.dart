import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_generator/presentation/providers.dart';

const colorSeed = Color(0xFF0AA342);

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('P@ssw0rd_123')),
      body: const PasswordResult(),
    );
  }
}

class PasswordResult extends StatelessWidget {
  const PasswordResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Content(),
              ),
            ),
          ),
          BottomContainer(),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Generar',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 5),
        Text(
          'una contraseña con las siguientes características',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        const GeneratorOptions(),
      ],
    );
  }
}

class GeneratorOptions extends ConsumerWidget {
  const GeneratorOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final digits = ref.watch(counterDigitsProvider);
    final capitals = ref.watch(counterCapitalsProvider);
    final symbols = ref.watch(counterSymbolsProvider);
    final length = ref.watch(counterLengthProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final generatePasswordNotifier =
          ref.read(generatePasswordProvider.notifier);
      generatePasswordNotifier.updateValues(digits, capitals, symbols, length);
    });

    return Column(
      children: [
        const SizedBox(height: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Longitud',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$length',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.grey),
            ),
            Row(
              children: [
                Slider(
                  thumbColor: colorSeed,
                  activeColor: colorSeed,
                  value: ref.watch(counterLengthProvider).toDouble(),
                  min: 0,
                  max: 12,
                  divisions: 12,
                  label: ref.watch(counterLengthProvider).toString(),
                  onChanged: (double newValue) {
                    final counterLengthNotifier =
                        ref.read(counterLengthProvider.notifier);
                    final currentValue = counterLengthNotifier.length;
                    final newValueInt = newValue.toInt();

                    if (newValueInt > currentValue) {
                      for (int i = currentValue; i < newValueInt; i++) {
                        counterLengthNotifier.incrementLength();
                      }
                    } else if (newValueInt < currentValue) {
                      for (int i = currentValue; i > newValueInt; i--) {
                        counterLengthNotifier.decrementLength();
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Dígitos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$digits',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.grey),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => ref
                      .read(counterDigitsProvider.notifier)
                      .decrementDigits(),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => ref
                      .read(counterDigitsProvider.notifier)
                      .incrementDigits(length, capitals, symbols),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Mayúsculas',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$capitals',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.grey),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => ref
                      .read(counterCapitalsProvider.notifier)
                      .decrementCapitals(),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => ref
                      .read(counterCapitalsProvider.notifier)
                      .incrementCapitals(length, digits, symbols),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Símbolos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$symbols',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.grey),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => ref
                      .read(counterSymbolsProvider.notifier)
                      .decrementSymbols(),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => ref
                      .read(counterSymbolsProvider.notifier)
                      .incrementSymbols(length, digits, capitals),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class BottomContainer extends ConsumerWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generatedPassword = ref.watch(generatePasswordProvider);

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: generatedPassword.split('').map((char) {
                  return TextSpan(
                    text: char,
                    style: TextStyle(
                      color: char.contains(RegExp(r'\d'))
                          ? Colors.white
                          : colorSeed,
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize,
                      fontWeight:
                          Theme.of(context).textTheme.titleLarge?.fontWeight,
                      fontFamily:
                          Theme.of(context).textTheme.titleLarge?.fontFamily,
                    ),
                  );
                }).toList(),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.white),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: generatedPassword));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                  'Contraseña copiada',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                )),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              ref.read(generatePasswordProvider.notifier).updateValues(
                    ref.watch(counterDigitsProvider),
                    ref.watch(counterCapitalsProvider),
                    ref.watch(counterSymbolsProvider),
                    ref.watch(counterLengthProvider),
                  );
            },
          ),
        ],
      ),
    );
  }
}

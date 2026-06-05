# isolated_object

Wraps an object in a dedicated isolate and forwards method calls to it, so
timer- or event-loop-driven work (e.g. progress spinners) keeps animating even
when the calling isolate's event loop is blocked by heavy synchronous work.

Dependency-free.

## Usage

```dart
import 'package:isolated_object/isolated_object.dart';

final counter = IsolatedObject<Counter>(() => Counter());

await counter.evaluate((c) => c.increment());
final value = await counter.evaluate((c) => c.value);

await counter.close();
```

The factory runs inside the child isolate; each `evaluate` forwards a closure
to that isolate and returns the result. `close()` shuts the isolate down,
failing any in-flight calls rather than letting them hang.

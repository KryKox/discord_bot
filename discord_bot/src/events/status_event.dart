import 'package:mineral/core/api.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/events.dart';

class ReadyHandler extends MineralEvent<ReadyEvent> {
  Future<void> handle (event) async {
    final client = event.client;

    client.setPresence(
      activity: ClientActivity(
        name: 'Watch ${client.user.globalName}',
        type: GamePresence.streaming,
      ),
      status: ClientStatus.online,
      afk: true
    );
  }
}
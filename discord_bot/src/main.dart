import 'package:mineral/core.dart';
import 'package:mineral/core/services.dart';

import 'commands/help_command.dart';
import 'commands/profile_command.dart';
import 'commands/role_command.dart';
import 'events/member_join_event.dart';
import 'events/member_leave_event.dart';
import 'events/status_event.dart';



void main () async {
  final commands = [
    ProfileCommand(),
    RoleCommand(),
  ];

  commands.add(HelpCommand(commands));

  final kernel = Kernel(
    intents: IntentService(all: true),
    events: EventService([
      ReadyHandler(),
      GuildMemberAddHandler(),
      GuildMemberRemoveHandler()

    ]),
    commands: CommandService(commands),
    components: ComponentService([

    ])
  );

  await kernel.init();
}

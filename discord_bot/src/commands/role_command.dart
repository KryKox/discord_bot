import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

import 'subcommands/role_add_subcommand.dart';
import 'subcommands/role_remove_subcommand.dart';

class RoleCommand extends MineralCommand<GuildCommandInteraction> {
  RoleCommand() : super(
      label: Display("role"),
      description: Display("Role management"),
      subcommands: [
        RoleAddSubCommand(),
        RoleRemoveSubcommand()
      ]
  );
}
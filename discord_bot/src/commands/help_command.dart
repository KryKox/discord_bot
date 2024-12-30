import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/framework.dart';

class HelpCommand extends MineralCommand<GuildCommandInteraction> {
  final List<MineralCommand> commands;

  HelpCommand(this.commands)
      : super(
    label: Display('help'),
    description: Display('Affichage du panneau d\'aide.'),
  );

  Future<void> handle(CommandInteraction interaction) async {
    final embed = EmbedBuilder()
      ..setTitle('Panneau d\'Aide')
      ..setDescription('Voici la liste des commandes disponibles :')
      ..setColor(Color.blue_400);

    for (final command in commands) {
      String subcommandsContent = '';

      for (final subcommand in command.subcommands) {
        subcommandsContent += "- **${subcommand.label.uid}**";
        if (subcommand.options.isNotEmpty) {
          subcommandsContent += " (Options : ";
          subcommandsContent += subcommand.options
              .map((option) => "**${option.label.uid}**")
              .join(", ");
          subcommandsContent += ")";
        }
        subcommandsContent += "\n";
      }

      embed.addField(
        name: ":white_check_mark: | **${capitalize(command.label.uid)}** - __${command.description.uid}__",
        value: subcommandsContent.isNotEmpty
            ? subcommandsContent
            : '',
        inline: false,
      );
    }

    await interaction.reply(embeds: [embed]);
  }


  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}

import 'package:mineral/core/builders.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/api.dart';

class ProfileCommand extends MineralCommand<GuildCommandInteraction> {
  ProfileCommand() : super(
    label: Display("profile"),
    description: Display("Afficher le profile complet d'un membre du serveur."),
    options: [
      CommandOption.user(Display("member"), Display("Selected member"))
    ]
  );

  Future<void> handle(CommandInteraction interaction) async {
    final GuildMember? member = interaction.getMember('member');

    final embed = EmbedBuilder(
        title: "Profile de ${member!.user.globalName}",
        description: " - Pseudonyme ➠ ${member.user.globalName} - (${member.user.username})",
        color: Color.blue_500,
        footer: EmbedFooter(text: "${interaction.guild?.name}"),
        thumbnail: EmbedThumbnail(url: '${member.user.decoration.defaultAvatarUrl}'),
        timestamp: DateTime.now(),
        fields: [
          EmbedField(name: 'Abonnement ➠', value: " - ${member.user.premiumType.name == "none" ? "Aucun :x:" : member.user.premiumType.name + ":white_check_mark:"}", inline: true),
          EmbedField(name: 'Pseudonyme sur le serveur ➠', value: ' - ${member.nickname}', inline: true),
    ]
    );

    await interaction.reply(embeds: [embed]);
  }
}
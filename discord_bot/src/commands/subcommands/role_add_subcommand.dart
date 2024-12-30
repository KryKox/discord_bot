import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/framework.dart';

class RoleAddSubCommand extends MineralSubcommand<GuildCommandInteraction> {
  RoleAddSubCommand() : super(
    label: Display("add"),
    description: Display("Assigner un rôle à un membre du discord"),
    options: [
      CommandOption.user(Display("member"), Display("Selected member"), required: true),
      CommandOption.role(Display("role"), Display("Selected role"), required: true)
    ]
  );

  Future<void> handle(CommandInteraction interaction) async {
    final GuildMember? executor = interaction.member;
    final Guild? guild = interaction.guild;
    if (!executor!.permissions.has(ClientPermission.administrator) && executor.user.id != guild?.owner.id) {
      await interaction.reply(content: '❌ Vous n\'avez pas les permissions nécessaires pour utiliser cette commande. Seuls les **administrateurs** peuvent l\'exécuter.', private: true,);
      return;
    }

    final GuildMember? member = interaction.getMember('member');
    final role = interaction.getRole("role");
    await member?.roles.add(role!.id);

    final embed = EmbedBuilder(
        title: 'Ajout Rôle',
        description: 'Le membre ${member!.user.globalName} vient de recevoir le rôle : **${role!.label}** ! :smile:',
        color: Color.green_700
    );

    await interaction.reply(embeds: [embed], private: true);
  }
}
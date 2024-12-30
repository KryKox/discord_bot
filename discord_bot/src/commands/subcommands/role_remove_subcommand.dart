import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/framework.dart';

class RoleRemoveSubcommand extends MineralSubcommand<GuildCommandInteraction> {
  RoleRemoveSubcommand() : super(
    label: Display("remove"),
    description: Display("Supprimer un rôle à un membre du serveur."),
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
    await member?.roles.remove(role!.id);

    final embed = EmbedBuilder(
        title: 'Suppression Rôle',
        description: 'Le membre ${member!.user.globalName} vient de perdre le rôle : **${role!.label}** ! :sob:',
        color: Color.red_700
    );

    await interaction.reply(embeds: [embed], private: true);
  }
}
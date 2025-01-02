import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/events.dart';

class GuildMemberRemoveHandler extends MineralEvent<MemberLeaveEvent> with Environment {

  @override
  Future<void> handle(MemberLeaveEvent event) async {
    final channelId = environment.get('MEMBER_JOIN_AND_LEAVE_CHANNEL');

    final channel = event.guild.channels.cache.get(channelId);
    if (channel == null) {
      print("Le salon avec l'ID $channelId est introuvable.");
      return;
    }

    if (channel is TextChannel) {
      final embed = EmbedBuilder(
        title: '😢 **Au Revoir, ${event.member.user.globalName} !** 😢',
        description: '**${event.member.user.globalName}** a quitté le serveur **${event.guild.name}**. Nous sommes tristes de te voir partir ! 😔\n\n'
            'Merci d\'avoir fait partie de notre communauté. Nous espérons te revoir bientôt !',
        thumbnail: EmbedThumbnail(url: '${event.user.decoration.defaultAvatarUrl}'),
        color: Color.red_700,
        footer: EmbedFooter(
          text: 'Bonne continuation et à bientôt peut-être !',
          iconUrl: event.guild.icon?.url,
        ),
        timestamp: DateTime.now(),
      );

      await channel.send(embeds: [embed]);
    } else {
      print("Le salon spécifié n'est pas un salon texte.");
    }
  }
}
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
          title: 'AU REVOIR',
          description: '**${event.member.user.globalName}** vient de quitter le serveur : ** ${event.guild.name}** :sob:',
          thumbnail: EmbedThumbnail(url: '${event.user.decoration.defaultAvatarUrl}'),
          color: Color.red_700
      );
      await channel.send(embeds: [embed]);
    } else {
      print("Le salon spécifié n'est pas un salon texte.");
    }
  }
}

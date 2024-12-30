import 'package:mineral/core/api.dart';
import 'package:mineral/core/builders.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/events.dart';

class GuildMemberAddHandler extends MineralEvent<MemberJoinEvent> with Environment {

  @override
  Future<void> handle(MemberJoinEvent event) async {
    final channelId = environment.get('MEMBER_JOIN_AND_LEAVE_CHANNEL');

    final channel = event.guild.channels.cache.get(channelId);
    if (channel == null) {
      print("Le salon avec l'ID $channelId est introuvable.");
      return;
    }

    if (channel is TextChannel) {
      final embed = EmbedBuilder(
        title: 'BIENVENUE',
        description: 'Bienvenue **${event.member.user.globalName}** sur : ** ${event.guild.name}** :tada:',
          thumbnail: EmbedThumbnail(url: '${event.user.decoration.defaultAvatarUrl}'),
        color: Color.green_700
      );
      await channel.send(embeds: [embed]);
    } else {
      print("Le salon spécifié n'est pas un salon texte.");
    }
  }
}

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
        title: '🎉 **Bienvenue, ${event.member.user.globalName} !** 🎉',  //
        description: 'Bienvenue sur **${event.guild.name}** ! Nous sommes ravis de t\'accueillir dans notre communauté. 😄\n\n'
            'Nous espérons que tu passeras un excellent moment ici. N\'hésite pas à te présenter et à participer aux discussions !',
        thumbnail: EmbedThumbnail(url: '${event.user.decoration.defaultAvatarUrl}'),
        color: Color.green_700,
        fields: [
          EmbedField(
            name: '<:starz:1323841357462114437> Règles de la communauté',
            value: 'N\'oublie pas de consulter nos règles dans le salon #règles pour une expérience optimale. <:newspaperz:1323841072241049630>',
            inline: false,
          ),
          EmbedField(
            name: '🛠️ Besoin d\'aide ?',
            value: 'Si tu as des questions, n\'hésite pas à demander de l\'aide dans #aide !',
            inline: false,
          ),
        ],
        footer: EmbedFooter(
          text: 'Nous espérons que tu passeras un excellent moment parmi nous !',
          iconUrl: event.guild.icon?.url,
        ),
        timestamp: DateTime.now(),
      );


      var button = ButtonBuilder.link(
         'https://mineral-foundation.org',
          emoji: EmojiBuilder.fromUnicode('📎'),
          label: 'Rules',
          disabled: false
      );


      final row = ComponentBuilder()..withButton.only(button);

      await channel.send(embeds: [embed],  components: row);
    } else {
      print("Le salon spécifié n'est pas un salon texte.");
    }
  }
}
import 'dart:math';
import 'dart:io';

void main(List<String> arguments) {
  var i = 1;
  var run = true;
  //objet de type bot
  var bot = Bot(1, 100);
  //objet de type player
  var player1 = Player('', 1, 100);

  // c'est parti
  print('entrer votre pseudo : ');
  var pseudo = stdin.readLineSync();

  player1.pseudo = pseudo; //stocker le pseudo demander dans l'objet player1

  do {
    final r = Random();
    var choix = r.nextInt(2);

    switch (choix) {
      case 0:
        print('\n${player1.pseudo} ATTAQUE EN PREMIER\n');
        print('----$pseudo APPUIYER SUR ENTRER POUR LANCER LES DÉS----\n');
        stdin.readLineSync();
        print(
          'pour utiliser la super attaque appuiyer sur y sinon appuiyer entrer\n*****ATTENTION CECI PEUT VOUS COUTEZ LA VIE******',
        );
        var saisi = stdin.readLineSync();
        if (saisi == 'y' || saisi == 'y'.toUpperCase()) {
          player1.superAttaque(bot);
        } else {
          player1.attaquePlayerVersBot(bot);
        }

        bot.infoBot();
        bot.attaqueBotVersPlayer(player1);
        player1.infoPlayer();
        //voir les infos du player1(santé...) après le coup du bot
        break;
      default:
        print('\nBOT ATTAQUE EN PREMIER\n');
        bot.attaqueBotVersPlayer(player1);
        player1.infoPlayer();
        player1.attaquePlayerVersBot(bot);
        bot.infoBot();
      //voir les infos du bot(santé...) après le coup du player
    }
    /*
    NB: à chaque attaque du bot on ne demande pas d'appuiyer sur entrer
    donc si la variable choix tombe successivement sur 1 le bot attaquera en premier le player plusieurs fois
    sans qu'on demande d'appuiyer sur enter, ce n'est que lorsque la variable choix tomberas sur 0 qu'on demandera au player d'appuiyer sur entrer 
    */

    print('FIN DU TOUR $i \n');
    i++;

    if (player1.health <= 0 || bot.health <= 0) {
      run = false;
    }
    /*si l'un des deux ou les deux ont une santé <=0 ,le combat est terminé et
    c'est celui(entre le player et le bot) qui a la santé la plus élevé qui gagne
    */
  } while (run);

  if (player1.health > bot.health) {
    print('\nVOUS AVEZ GAGNEZ LA PARTIE!\n');
  } else if (player1.health < bot.health) {
    print('\nVOUS AVEZ PERDU LA PARTIE!\n');
  } else {
    print('match null');
  }
}

class Bot {
  int force;
  int health;
  Bot(int force, int health) {
    this.force = force;
    this.health = health;
  }
  void infoBot() {
    print('bot | santé: ${this.health}  | force: ${this.force}');
  }

  void attaqueBotVersPlayer(Player p) {
    var coup = this.force * lanceDes('bot');
    print('le bot assène un coup à ${p.pseudo} avec une force de $coup');
    p.health -= coup;
  }
}

class Player {
  String pseudo;
  int force;
  int health;
  Player(this.pseudo, this.force, this.health);
  void infoPlayer() {
    print('${this.pseudo}  |  santé: ${this.health}  | force: ${this.force}');
  }

  void attaquePlayerVersBot(Bot b) {
    var coup = this.force * lanceDes(this.pseudo);
    print('${this.pseudo} assène un coup sur le bot avec une force de $coup');
    b.health -= coup;
  }

  void superAttaque(Bot b) {
    var coup = 5 * lanceDes(this.pseudo);
    var a = aleat(pseudo) * 5;
    print(
      'SUPER ATTAQUE (*5) ${this.pseudo} assène un coup sur le bot avec une super force de $coup',
    );
    this.health -= a;
    print(
      '\nALEAT DE LA SUPER ATTAQUE [ -$a] Tes points de santés sont désormains : ${this.health}\n',
    );
    b.health -= coup;
  }
}

//fonctions

int lanceDes(String name) {
  final r1 = Random();

  var result = r1.nextInt(6) + 1 + r1.nextInt(6) + 1;

  print('$name a lancé les dés et a obtenu la valeur $result');
  return result;
}

int aleat(String name) {
  final r1 = Random();

  var aleat = r1.nextInt(5);

  return aleat;
} //aleat est la fonction pour determiner combien de point de vie sera enlevé au player
//après la super attaque

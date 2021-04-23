import 'dart:math';
import 'dart:io';

void main(List<String> arguments) {
  var i = 1;
  var bot1 = Bot(1, 100);

  //pour tester la fonction premettant de lancer les dés
  lanceDes('jean');

  // c'est parti

  print('entrer votre pseudo : ');
  var pseudo = stdin.readLineSync();

  do {
    print('\n----$pseudo APPUIYER SUR ENTRER POUR LANCER LES DÉS----\n');
    stdin.readLineSync();
    var coup = lanceDes(pseudo);
    print('$pseudo assène un coup sur le bot1 avec une force de $coup');
    bot1.health -= coup;
    print('Bot1 - Santé ${bot1.health} %');
    print('FIN TOUR $i');
    i++;
  } while (bot1.health > 0);
  print('\nVOUS AVEZ GAGNEZ LA PARTIE!\n');
}

class Bot {
  int force;
  int health;
  Bot(int force, int health) {
    this.force = force;
    this.health = health;
  }
}

int lanceDes(String name) {
  var r1 = Random();
  var lancer1 = r1.nextInt(7);
  if (lancer1 == 0) lancer1++;
  // parce que un lancer ne peut jamais donner 0
  var r2 = Random();
  var lancer2 = r2.nextInt(7);
  if (lancer2 == 0) lancer2++;

  var result = lancer1 + lancer2;

  print('$name a lancé les dés et a obtenu $result');
  return result;
}

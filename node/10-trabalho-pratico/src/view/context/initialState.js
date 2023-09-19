const InitialState = {
  header: {
    title: 'O Arcano',
    value: '',
    placeholder: 'Escolha um nome',
    subTitle: 'Eu combato fogo com fogo mágico!',
  },
  stats: [
    {
      title: 'Braveza',
      subTitle: ['Partir para porrada.', 'Proteger alguém.'],
      value: 0,
    },
    {
      title: 'Esperteza',
      subTitle: ['Investigar um mistério.', 'Perceber uma enrascada'],
      value: 0,
    },
    {
      title: 'Estranheza',
      subTitle: ['Usar magia.'],
      value: 0,
    },
    {
      title: 'Firmeza',
      subTitle: ['Agir sob pressão.', 'Dar uma mão.'],
      value: 0,
    },
    {
      title: 'Sutileza',
      subTitle: ['Manipular alguém.'],
      value: 0,
    },
  ],
  luckBox: {
    title: 'Sorte',
    description:
      'Marque uma caixa de Sorte para alterar uma rolagem para 12 ou evitar todo o dano de um ferimento.',
    value: 0,
  },
  damageBox: {
    title: 'Dano',
    description: "Quando você chegar em 4 ou mais, marque 'Instável'.",
    value: 0,
  },
  charCreation: {
    intro: {
      title: 'Criação do Caçador',
      description:
        'Para criar seu caçador Arcano, primeiro escolha e escreva um nome na primeira linha da folha. Então siga as instruções para decidir sua aparência, classificações, magia combativa, movimentos e equipamentos. Finalmente, se apresente e escolha o histórico.',
    },
    appearance: {
      title: 'Aparência, escolha um em cada lista:',
      smallTitle: 'Aparência',
      selected: {
        sex: null,
        eyes: null,
        clothes: null,
      },
      lists: {
        sex: ['Homem', 'Mulher', 'Andrógino'],
        eyes: [
          'Olhos sombrios',
          'Olhos ferozes',
          'Olhos cansados',
          'Olhos faiscantes',
        ],
        clothes: [
          'Roupas amarrotadas',
          'Roupas estilosas',
          'Roupas góticas',
          'Roupas antiquadas',
        ],
      },
    },
    baseStats: {
      title: 'Classificações, escolha uma linha:',
      lists: [
        'Braveza +0, Esperteza +1, Estranheza +2, Firmeza +1, Sutileza −1',
        'Braveza +1, Esperteza +1, Estranheza +2, Firmeza -1, Sutileza +0',
        'Braveza -1, Esperteza +2, Estranheza +2, Firmeza +0, Sutileza −1',
        'Braveza -1, Esperteza +1, Estranheza +2, Firmeza +0, Sutileza +1',
        'Braveza +0, Esperteza +1, Estranheza +2, Firmeza +0, Sutileza +0',
      ],
    },
    presentation: {
      title: 'Apresentações',
      description:
        'Quando você chegar aqui, espere que todos também cheguem para que vocês se apresentem juntos. Na sua vez descreva seu caçador e diga ao grupo o que eles sabem sobre você.',
    },
    history: {
      title: 'Histórico',
      description: 'Na sua vez escolha um desde para cada um dos caçadores:',
      options: [
        'Ele age como sua consciência quando você sente o poder subir à cabeça. Pergunte a ele sobre a última vez que isto aconteceu.',
        'Parentes de sangue, embora vocês não tenham tido contato por vários anos. Pergunte a ele como vocês se reconectaram.',
        'Mentor de uma outra vida. Pergunte a ele o que ele te ensinou.',
        'Quando você o resgatou exibindo sua magia, você o introduziu ao sobrenatural. Diga a ele que criatura estava atrás dele.',
        'Uma velha rivalidade que se tornou uma forte amizade. Diga a ele o que vocês disputavam.',
        'Você pensou que ele estava morto, e agora ele está de volta. O que o “matou”?',
        'Ele é um interesse amoroso que vai e volta. Pergunte a ele o que mantém vocês separados. Diga a ele o que mantém vocês juntos.',
        'Um companheiro de luta. Vocês enfrentaram as maiores ameaças juntos.',
      ],
    },
  },
  levelUp: {
    title: 'Subindo de nível',
    label: 'Experiência',
    descriptionList: [
      'Sempre que sua rolagem for 6 ou menos, ou quando um movimento determinar, marque uma caixa de experiência.',
      'Quando você tiver preenchido todas as cinco caixas de experiência, você sobe de nível. Apague todas as caixas e escolha uma melhoria da seguinte lista:',
    ],
    value: 0,
  },
  upgrades: {
    title: 'Melhorias',
    description:
      'Depois de você subir de nível cinco vezes, você já pode ter melhorias avançadas além destas.',
    selected: [],
    options: [
      'Receba +1 em Estranheza (máximo +3).',
      'Receba +1 em Firmeza (máximo +2).',
      'Receba +1 em Esperteza (máximo +2).',
      'Receba +1 em Braveza (máximo +2).',
      'Pegue outro movimento de Arcano.',
      'Pegue outro movimento de Arcano.',
      'Pegue um movimento de outra cartilha.',
      'Pegue um movimento de outra cartilha.',
      'Pegue outra escolha de Magia Combativa.',
    ],
  },
  advancedUpgrades: {
    title: 'Melhorias avançadas',
    selected: [],
    options: [
      'Receba +1 em qualquer classificação (máximo +3).',
      'Mude este caçador para um novo tipo.',
      'Crie um segundo caçador para jogar junto com este.',
      'Marque dois dos movimentos básicos como avançados.',
      'Marque outros dois dos movimentos básicos como avançados.',
      'Aposente este caçador para uma vida segura.',
      'Apague uma caixa marcada de Sorte.',
      'Pegue outra escolha de Magia Combativa.',
      'Você pode eliminar outra opção das suas Ferramentas e técnicas.',
    ],
  },
  combatMagic: {
    title: 'Magia Combativa',
    descriptionList: [
      'Você tem alguns feitiços de ataque que pode usar como armas. Quando você usar estes feitiços para **partir pra porrada**, role +Estranheza em vez de +Braveza. Algumas vezes a situação pode fazer você **agir sob pressão** para que o feitiço seja lançado sem problemas.',
      'Escolha três opções da lista abaixo. Seus feitiços combativos podem combinar qualquer base com qualquer efeito.',
      '**Magia combativa** (escolha três, tendo pelo menos uma base):',
    ],
    base: {
      title: 'Bases:',
      selected: [],
      options: [
        'Explosão (2-dano perto mágica chamativa barulhenta)',
        'Bola (1-dano perto área mágica chamativa barulhenta)',
        'Míssil (1-dano longe mágica chamativa barulhenta)',
        'Muralha (1-dano perto barreira 1-armadura mágica chamativa barulhenta)',
      ],
    },
    effect: {
      title: 'Efeitos:',
      selected: [],
      options: [
        '_Fogo:_ Adicione +2 de dano e (fogo) para uma base. Com 10+ em uma rolagem de magia combativa, o fogo não via se espalhar.',
        '_Força ou Vento:_ Adicione +1 de dano e (empurrão) para uma base; ou +1 de armadura para uma muralha.',
        '_Raio ou Entropia:_ Adicione +1 de dano e (brutal) para uma base.',
        '_Frio ou Gelo:_ Adicione −1 de dano e +2 de armadura para uma muralha; ou +1 de dano e (restritiva) para outras bases.',
        '_Terra:_ Adicione (empurrão restritiva) para uma base.',
        '_Necromântica:_ Adicione (drena-vida) para uma base.',
      ],
    },
  },
  moves: {
    title: 'Movimentos',
    descriptionList: [
      'Você recebe todos os movimentos básicos e quatro movimentos de caçador Arcano.',
    ],
    defaultText: 'Você recebe este:',
    default: [
      '**Ferramentas e técnicas:** Para poder usar sua magia combativa efetivamente, você depende de uma série de ferramentas e técnicas. Se você não utilizá-las, haverá algumas complicações. Elimine uma destas; você vai necessitar das outras. \n- _Consumíveis:_ Você precisa ter certos suprimentos — pós, óleos, etc. — a mão para lançar seu feitiço. Eles são consumidos quando você lança o feitiço. Se você não os tiver a mão, seu corpo será o substituto: receba (1-dano ignora armadura) quando lançar. \n- _Focos:_ Você precisa de varinhas, cajados e outros implementos chamativos para focar seus esforços de forma mais poderosa. Se você não tiver o que precisa a mão, sua magia combativa causa −1 de dano. \n- _Gestos:_ Você precisa ser capaz de gesticular com suas mãos de forma chamativa para poder usar sua magia combativa. Se você estiver preso de alguma forma você ainda consegue lançar o feitiço, mas as chances de dar errado são maiores; receba −1 constante em sua magia combativa. \n- _Encantamentos:_ Você precisa falar em uma linguagem mística para controlar sua magia sem filtrá-la diretamente com sua mente. Se você usar um feitiço de magia combativa, com sucesso ou falha, enquanto não pode ou não quer falar, você deve imediatamente **agir sob pressão** para evitar embaralhar seus pensamentos — produzindo alucinações, perda de sentidos e desorientação em geral.',
    ],
    movesListText: 'Depois escolhe três destes:',
    movesListSelected: [],
    movesList: [
      '**Treinamento mágico avançado:** Se você tiver duas de suas três **Ferramentas e técnicas** à disposição, você pode ignorar a terceira.',
      '**Reputação mágica:** Escolha três grandes grupos ou organizações da comunidade sobrenatural, o que pode incluir alguns dos tipos mais sociáveis de monstros. Eles ouviram falar você e respeitam seu poder. Com humanos afetados, receba +1 adiante para **manipular alguém**. Você pode usar **manipular alguém** em monstros afetados como se eles fossem humanos, mas sem bônus.',
      '**Vestuário encantado:** Escolha uma peça de vestuário do dia a dia — ela está encantada sem nenhuma alteração na aparência. Receba 1 de dano a menos de qualquer coisa que tentar te acertar através da peça de roupa.',
      '**Poderia ser pior:** Quando você falhar em uma rolagem para **usar magia** você pode usar uma das seguintes opções em vez de perder o controle da magia: \n- _Fiasco:_ As preparações e materiais para o feitiço foram arruinados. Você terá que começar do zero com o tempo de preparação dobrado. \n- _Isso não vai ser bom:_ O efeito acontece, mas você aciona todos os defeitos listados menos um. Você escolhe qual defeito vai evitar.',
      '**Adivinhação forense:** Quando você **investigar um mistério** com sucesso, você pode perguntar “Que magia foi feita aqui?” como uma pergunta extra e gratuita.',
      '**Vá com tudo ou vá pra casa:** Quando você precisar **usar magia** como um requisito de **magia grandiosa**, receba +1 constante nestas rolagens de **usar magia**.',
      '**Não é minha culpa:** Receba +1 para **agir sob pressão** quando estiver lidando com as consequências dos seus próprios feitiços.',
      '**Praticante:** Escolha dois efeitos dos disponíveis de **usar magia**. Receba +1 para **usar magia** sempre que escolher um destes efeitos.',
      '**Escudo mágico:** Quando você **proteger alguém**, você recebe (2-armadura) contra qualquer dano que seja transferido para você. Isto não acumula com outras armaduras, se houver.',
      '**Terceiro olho:** Quando você **perceber uma enrascada**, você pode **abrir seu terceiro olho** por um momento para perceber informações extras. Receba +1 de reserva em qualquer resultado 7 ou maior, você também consegue enxergar coisas invisíveis. Com uma falha, você ainda pode reservar 1, mas você está exposto aos perigos sobrenaturais. A totalidade da realidade oculta é dura na mente!',
    ],
  },
  equips: {
    title: 'Equipamentos',
    description: [
      'Você não precisa de muito — além de qualquer foco ou consumível para dar poder à sua magia. No entanto, ainda é bom ter uma reserva.',
      '**Armas de reserva** (escolha uma)',
    ],
    value: null,
    options: [
      'Revólver velho (2-dano perto recarga barulhenta)',
      'Faca ritualística (1-dano contato)',
      'Espada herdada (2-dano contato brutal)',
    ],
  },
};

export default InitialState;

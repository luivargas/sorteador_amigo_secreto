const String loginUrl = 'https://auth.stg.sorteador.net/api/auth/login';
const String registerUrl = 'https://auth.stg.sorteador.net/api/auth/register';
const String logoutUrl = 'https://auth.stg.sorteador.net/api/auth/logout';
const String forgotPasswordUrl =
    'https://auth.stg.sorteador.net/api/auth/forgot-password';
const String getUserUrl = 'https://auth.stg.sorteador.net/api/auth/user';
const String xtenant = 'sorteador';

final String stageGroupApiUrl = 'https://api.stg.amigosecreto.org/api/groups';
final String stageParticipantApiUrl =
    'https://api.stg.amigosecreto.org/api/participants';
final String bearerToken = '';
final String logo = './assets/logos/full/logo_amigo_secreto.png';

final List<Map<String, dynamic>> participantList = [
  {
    "id": "5c4c2c52-7190-4936-adac-33382ff3d772",
    "name": "Luiz",
    "email": "luiz@luizvargas.net",
    "idd": "55",
    "phone": "+5531984018933",
    "is_participant": true,
    "is_dependent": false,
    "role": "admin",
    "view_status": "not_viewed",
    "viewed_at": null,
    "whatsapp_sent_at": null,
    "gift_purchased_at": null,
    "status": "confirmed",
    "redraw_vote": null,
    "wishlist": [],
    "preferences": [],
    "sizes": [],
    "dislikes": [],
  },
  {
    "id": "592a6824-29df-45c2-bc51-aa5145b380c5",
    "name": "Luiz Fernando",
    "email": "luiz+1@luizvargas.net",
    "idd": "55",
    "phone": null,
    "is_participant": true,
    "is_dependent": false,
    "role": "participant",
    "view_status": "not_viewed",
    "viewed_at": null,
    "whatsapp_sent_at": null,
    "gift_purchased_at": null,
    "status": "confirmed",
    "redraw_vote": null,
    "wishlist": [],
    "preferences": [],
    "sizes": [],
    "dislikes": [],
  },
  {
    "id": "592a6824-29df-45c2-bc51-aa5145b380c5",
    "name": "Luiz Fernando",
    "email": "luiz+2@luizvargas.net",
    "idd": "55",
    "phone": null,
    "is_participant": true,
    "is_dependent": false,
    "role": "participant",
    "view_status": "not_viewed",
    "viewed_at": null,
    "whatsapp_sent_at": null,
    "gift_purchased_at": null,
    "status": "confirmed",
    "redraw_vote": null,
    "wishlist": [],
    "preferences": [],
    "sizes": [],
    "dislikes": [],
  },
];

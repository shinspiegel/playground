const sha1 = require('sha1');

const horaAgora = new Date(2021, 3, 25).getTime()

const senhaSecretaGaradaTodoDia = sha1(horaAgora)

console.log(horaAgora, senhaSecretaGaradaTodoDia)
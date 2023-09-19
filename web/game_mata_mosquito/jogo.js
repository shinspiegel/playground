//TAMANHO DA TELA DO JOGO
var altura = window.innerHeight
var largura = window.innerWidth
var vidas = 1
var tempo = 20
var criaMosquitoTempo = 1500

//RECUPERANDO NIVEL DE DIFICULDADE
var nivel = window.location.search
nivel = nivel.replace('?', '')

if 	(nivel === 'normal') 	{ criaMosquitoTempo = 1500 } else 
if 	(nivel === 'dificil') 	{ criaMosquitoTempo = 1000 } else 
if (nivel === 'chuck') 		{ criaMosquitoTempo = 800 }
//teste

function ajudaTamanhoPalco() {
    altura = window.innerHeight
    largura = window.innerWidth
}

ajudaTamanhoPalco()

//CRONOMETRO FUNCIONANDO
var cronometro = setInterval (function() {
	tempo -= 1
	
	if (tempo < 0) {
		clearInterval(cronometro)
		clearInterval(criaMosquito)
		window.location.href = "vitoria.html"
	} else {
		document.getElementById('cronometro').innerHTML = tempo
	}
}, 1000)


//CRIACAO DOS ELEMENTOS
function posicaoRandomica() {
	
	//remover mosquito se ele existe
	if ( document.getElementById('mosquito') ) {
		document.getElementById('mosquito').remove()

		if (vidas > 3) {
			window.location.href = "fim_de_jogo.html"
		} else {
			document.getElementById('v' + vidas).src = 'imagens/coracao_vazio.png'
			vidas++
		}
	}

	//criando posicao alteatoria
	var posicaoX = Math.floor( Math.random() * largura ) - 90
	var posicaoY = Math.floor( Math.random() * altura ) - 90

	posicaoX = posicaoX < 0 ? 0 : posicaoX
	posicaoY = posicaoY < 0 ? 0 : posicaoY

	//criando elemento
	var mosquito = document.createElement('img')
	mosquito.src = 'imagens/mosca.png'
	mosquito.className = tamanhoAleatorio() + ' ' + ladoAleatorio()
	mosquito.style.left = posicaoX + 'px'
	mosquito.style.top = posicaoY + 'px'
	mosquito.style.position = 'absolute'
	mosquito.id = 'mosquito'
	mosquito.onclick = function() {
		this.remove()
	}
	
	//inserindo elemento
	document.body.appendChild(mosquito)
}



//TAMANHO ALEATORIO
function tamanhoAleatorio() {
	var classe = Math.floor( Math.random() * 3 )

	switch(classe) {
		case 0: return 'mosquito1'
		case 1: return 'mosquito2'
		case 2: return 'mosquito3'
	}
}



//LADO ALEATORIO
function ladoAleatorio() {
	var classe = Math.floor( Math.random() * 2 )

	switch(classe) {
		case 0: return 'ladoA'
		case 1: return 'ladoB'
	}
}
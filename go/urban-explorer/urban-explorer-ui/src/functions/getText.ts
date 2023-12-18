import { getLanguage } from "./getLanguage";

type Text = {
	navList: { login: string; register: string; dashboard: string };
	root: { bottom: string; login: string };
	hero: { title: string; subTitle: [string, string][] };
	login: { back: string };
	loginForm: { email: string; password: string; login: string };
	register: { notAvailable: string };
	unauthorized: { message: string; back: string };
};

export const TEXT: Record<string, Text> = {
	en: {
		root: {
			login: "Login",
			bottom: "Jeferson Leite Borges. All rights reserved.",
		},
		hero: {
			title: "Urban Explorer",
			subTitle: [
				["It's not about the destination.", "It's the journey!"],
				["Every Mile, Every Smile.", "Your Journey, Preserved."],
				["Beyond Destinations", "Where Every Journey Tells a Story."],
				["Memories in Motion", "Relive Your Journeys."],
				["From Start to Finish", "Chronicle Every Adventure."],
				["Not Just Places, But Moments.", "Record Your Travels."],
				["Explore, Experience, Capture", "Your Travel Tale."],
				["Your Travel Diary.", "From Paths to Pictures."],
				["Journey Jottings.", "Every Step, a Story."],
				["Wander, Wonder, Record.", "The Traveler's Companion."],
				["Mapping Memories.", "More Than Just a Destination."],
				["Capture the Journey.", "Not Just the Destination!"],
			],
		},
		login: {
			back: "Back Home",
		},
		loginForm: {
			email: "Email",
			password: "Password",
			login: "Login",
		},
		register: {
			notAvailable: "Not available",
		},
		unauthorized: {
			message:
				"Looks like you don't have the credentials to see this page",
			back: "Back to home",
		},
		navList: {
			login: "Login",
			register: "Register",
			dashboard: "Dashboard",
		},
	},
	// pt-br
	pt: {
		root: {
			login: "Acessar",
			bottom: "Jeferson Leite Borges. Todos os direitos reservados.",
		},
		hero: {
			title: "Explorador Urbano",
			subTitle: [
				["Não é sobre o destino.", "É a jornada!"],
				["Cada Metro, Cada Sorriso.", "Sua Jornada, Preservada."],
				["Além dos Destinos", "Onde Cada Viagem Conta Uma História."],
				["Memórias em Movimento", "Reviva Suas Viagens."],
				["Do Início ao Fim", "Registre Cada Aventura."],
				["Não Apenas Lugares, Mas Momentos.", "Registre Suas Viagens."],
				["Explore, Experimente, Capture", "Sua História de Viagem."],
				["Seu Diário de Viagem.", "De Caminhos a Imagens."],
				["Notas de Viagem.", "Cada Passo, Uma História."],
				["Caminhe, Encante, Registre.", "O Parceiro do Viajante."],
				["Mapeando Memórias.", "Mais do Que Apenas um Destino."],
				["Capture a Jornada.", "Não Apenas o Destino!"],
			],
		},
		login: {
			back: "Voltar",
		},
		loginForm: {
			email: "Email",
			password: "Senha",
			login: "Acessar",
		},
		register: {
			notAvailable: "Não disponível",
		},
		unauthorized: {
			message:
				"Parece que você não tem permissão para acessar essa página",
			back: "Retornar ao início",
		},
		navList: {
			login: "Acessar",
			register: "Registrar",
			dashboard: "Painel",
		},
	},
};

export function getText(): Text {
	const lang = getLanguage();
	return TEXT[lang];
}

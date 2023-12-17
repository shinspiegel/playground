type Slogan = [string, string];

export function getHomePhrase(): Slogan {
	const phrases: Slogan[] = [
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
	];

	const rand = phrases[Math.floor((Math.random() * 10) % phrases.length)];

	return rand;
}

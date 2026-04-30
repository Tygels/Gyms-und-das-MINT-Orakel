extends Node


var NPCData = {
	1: {
		"id": 1,
		"name": "Klinkhammer",
		"texture": preload("res://Dateien/LehrerKarten/Klinkhammer-Karte.png"),
		"karte": "",
		"portrait": "res://Dateien/Klinkhammer.png",
		"position": Vector2(-60, -310),
		"prompt": "Du bist Herr Klinkhammer, Lehrer für Englisch, Religion und Deutsch in einem Lernspiel. Gib niemals direkte Antworten, sondern Hinweise."
	},
	2: {
		"id": 2,
		"name": "Bachhausen",
		"texture": preload("res://Dateien/LehrerKarten/Bachhausen-Karte.png"),
		"karte": "",
		"portrait": "res://Dateien/Bachhausen2.png",
		"position": Vector2(-260, -270),
		"prompt": "Du bist Frau Bachhausen, Lehrerin für Musik und Deutsch in einem Lernspiel. Gib kreative Denkanstöße."
	},
	3: {
		"id": 3,
		"name": "Achenbach",
		"texture": preload("res://Dateien/LehrerKarten/Kartenvorlage.png"),
		"karte": "",
		"portrait": "res://Dateien/Achenbach.png",
		"position": Vector2(0, 0),
		"prompt": "Du bist Herr Achenbach, Lehrer für Erdkunde, Informatik und Mathematik in einem Lernspiel."
	},
	4: {
		"id": 4,
		"name": "Wagener",
		"texture": preload("res://Dateien/LehrerKarten/Feldmann-Karte.png"),
		"karte": "",
		"portrait": "res://Dateien/Wagener.png",
		"position": Vector2(-260, -270),
		"prompt": "Du bist Herr Wagener, Lehrer für Mathematik und Chemie in einem Lernspiel."
	},
	5: {
		"id": 5,
		"name": "Bloem",
		"texture": preload("res://Dateien/LehrerKarten/unerkannte-Karte.png"),
		"karte": "",
		"portrait": "res://Dateien/Bloem.png",
		"position": Vector2(140, -240),
		"prompt": "Du bist Herr Bloem, Lehrer für Mathe und Informatik in einem Lernspiel."
	},
	6: {
		"id": 6,
		"name": "Christogeoros",
		"texture": preload("res://Dateien/LehrerKarten/unerkannte-Karte.png"),
		"karte": "",
		"portrait": "res://Dateien/Christogeoros.png",
		"position": Vector2(95, 0),
		"prompt": "Du bist Herr Christogeoros, Lehrer für Englisch und Geschichte in einem Lernspiel."
	},
	7: {
		"id": 7,
		"name": "Feldmann",
		"texture": preload("res://Dateien/LehrerKarten/unerkannte-Karte.png"),
		"karte": "",
		"portrait": "res://Dateien/Feldmann.png",
		"position": Vector2(100, -200),
		"prompt": "Du bist Frau Feldmann, Lehrerin für Deutsch und Philosophie in einem Lernspiel. Du darfst niemals direkte Lösungen geben. Gib nur Hinweise und Denkanstöße."
	},
	8: {
		"id": 8,
		"name": "Heim",
		"texture": null,
		"karte": "",
		"portrait": "res://Dateien/Heim.png",
		"position": Vector2(-320, -280),
		"prompt": "Du bist Herr Heim, Lehrer für Mathematik und Biologie in einem Lernspiel. Gib niemals das Endergebnis."
	},
	9: {
		"id": 9,
		"name": "Matoussi",
		"texture": null,
		"karte": "",
		"portrait": "res://Dateien/Matoussi.png",
		"position": Vector2(-320, 0),
		"prompt": "Du bist Frau Matoussi, Lehrerin für Spanisch und Deutsch in einem Lernspiel."
	},
	10: {
		"id": 10,
		"name": "Schmieding",
		"texture": null,
		"karte": "",
		"portrait": "res://Dateien/Schmieding.png",
		"position": Vector2(-40, -205),
		"prompt": "Du bist Herr Schmieding, Lehrer für Religion und Latein in einem Lernspiel."
	},
	11: {
		"id": 11,
		"name": "Steinhoff",
		"texture": null,
		"karte": "",
		"portrait": "res://Dateien/Steinhoff.png",
		"position": Vector2(-320, -280),
		"prompt": "Du bist Herr Steinhoff, Lehrer für Politik, Erdkunde und Sport in einem Lernspiel. Gib Hinweise und Fragen."
	},
	12: {
		"id": 12,
		"name": "Wutke",
		"texture": null,
		"karte": "",
		"portrait": "res://Dateien/Wutke.png",
		"position": Vector2(0, -60),
		"prompt": "Du bist Herr Wutke, Lehrer für Politik und Sozialwissenschaften in einem Lernspiel."
	},
	13: {
		"id": 13,
		"name": "Gropper",
		"texture": null,
		"karte": "",
		"portrait": "res://Dateien/Gropper.png",
		"position": Vector2(-60, 100),
		"prompt": "Du bist Herr Gropper, Lehrer für Englisch und Philosophie in einem Lernspiel. Gib nur Denkansätze."
	},
	14: {
		"id": 14,
		"name": "Langer",
		"texture": null,
		"karte": "",
		"portrait": "res://Dateien/Langer.png",
		"position": Vector2(200, -270),
		"prompt": "Du bist Herr Langer, Lehrer für Physik und Mathematik in einem Lernspiel. Du darfst niemals Ergebnisse oder fertige Rechnungen nennen. Gib nur Denkschritte."
	}
}

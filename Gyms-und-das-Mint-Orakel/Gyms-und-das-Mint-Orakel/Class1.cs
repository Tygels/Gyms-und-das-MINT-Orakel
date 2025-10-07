namespace Gyms_und_das_Mint_Orakel
{
    using System;
    using Npgsql;
    using System.Collections.Generic;

    // Modellklasse für Frage + Antwort
    public class FrageAntwort
    {
        public int Id { get; set; }
        public int SchuelerId { get; set; }
        public string Frage { get; set; }
        public string Antwort { get; set; }
        public DateTime Zeitstempel { get; set; }
    }

    // Klasse für den Datenbankzugriff
    public class LernspielRepository
    {
        private readonly string _connString;

        public LernspielRepository(string connString)
        {
            _connString = connString;
        }

        // Frage + Antwort speichern
        public void SpeichereFrageAntwort(FrageAntwort fa)
        {
            using var conn = new NpgsqlConnection(_connString);
            conn.Open();

            using var cmd = new NpgsqlCommand(
                "INSERT INTO lernspiel (schueler_id, frage, antwort) VALUES (@id, @frage, @antwort)", conn);

            cmd.Parameters.AddWithValue("id", fa.SchuelerId);
            cmd.Parameters.AddWithValue("frage", fa.Frage);
            cmd.Parameters.AddWithValue("antwort", fa.Antwort);

            cmd.ExecuteNonQuery();
        }

        // Antworten eines Schülers abrufen
        public List<FrageAntwort> HoleAntworten(int schuelerId)
        {
            var ergebnisse = new List<FrageAntwort>();

            using var conn = new NpgsqlConnection(_connString);
            conn.Open();

            using var cmd = new NpgsqlCommand(
                "SELECT id, frage, antwort, zeitstempel FROM lernspiel WHERE schueler_id = @id", conn);
            cmd.Parameters.AddWithValue("id", schuelerId);

            using var reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                ergebnisse.Add(new FrageAntwort
                {
                    Id = reader.GetInt32(0),
                    SchuelerId = schuelerId,
                    Frage = reader.GetString(1),
                    Antwort = reader.GetString(2),
                    Zeitstempel = reader.GetDateTime(3)
                });
            }

            return ergebnisse;
        }
    }
}
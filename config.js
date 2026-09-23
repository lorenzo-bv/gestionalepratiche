// ============================================================
// CONFIGURAZIONE SUPABASE
// Compila questi due valori con quelli del tuo progetto Supabase.
// Li trovi in: Project Settings -> API (nella dashboard Supabase)
//   - "Project URL"        -> incollalo in "url"
//   - "anon public" key    -> incollalo in "anonKey"
// Questa chiave è pensata per stare nel codice del sito (lato client):
// la vera protezione dei dati è nelle policy di sicurezza (RLS) che
// crei con lo script supabase-schema.sql.
// ============================================================
window.SUPABASE_CONFIG = {
  url: "https://fkxmidgbgpccyfaurxhz.supabase.co",
  anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZreG1pZGdiZ3BjY3lmYXVyeGh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTAxNTczNzEsImV4cCI6MjEwNTczMzM3MX0.s0WUigI_hLaOzXrl0zddUH7zDFBQ9OcrO3B7Psyxar0"
};

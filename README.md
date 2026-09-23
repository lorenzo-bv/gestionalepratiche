# Gestionale Pratiche — versione Supabase + GitHub Pages

Questa è la versione autonoma del gestionale: un sito web vero e proprio,
raggiungibile da chiunque abbia il link, **senza bisogno di un account
Claude**. I dati (pratiche, note, allegati) vivono su Supabase, un
database in cloud con un piano gratuito.

Rispetto alla versione ospitata su Claude, questa versione è persino
migliore per gli allegati: Word, Excel, email `.msg`, qualunque
formato — si caricano e si riscaricano nella loro forma originale,
senza conversioni o limitazioni.

---

## Cosa contiene questa cartella

| File | A cosa serve |
|---|---|
| `index.html` | L'applicazione vera e propria (tutto il sito) |
| `config.js` | Le due chiavi che collegano il sito al tuo database Supabase — **da compilare tu** |
| `supabase-schema.sql` | Lo script che crea tabelle e permessi su Supabase — si esegue **una sola volta** |
| `README.md` | Questa guida |

---

## Parte 1 — Creare il database su Supabase

1. Vai su **supabase.com** e crea un account gratuito (puoi accedere anche con GitHub).
2. Clicca **New project**. Scegli un nome (es. "gestionale-pratiche"), una password per il database (salvala da parte, non serve per l'uso quotidiano ma è bene conservarla) e una regione vicina a voi (es. Frankfurt/EU).
3. Attendi 1-2 minuti che il progetto venga creato.
4. Nel menu a sinistra vai su **SQL Editor** → **New query**.
5. Apri il file `supabase-schema.sql` di questa cartella, copia **tutto** il contenuto, incollalo nell'editor e premi **Run**.
   - Questo crea le tabelle (`tasks`, `members`, `categories`, `config`), le regole di sicurezza e il contenitore per gli allegati.
   - Se una riga finale (`alter publication...`) segnala un errore perché "già presente", ignora: è normale.
6. Vai su **Authentication** → **Sign In / Providers** (o **Providers** a seconda della versione dell'interfaccia) e attiva **Allow anonymous sign-ins**.
   - Questo passaggio è essenziale: è quello che permette all'app di riconoscere ogni browser come "utente autorizzato" senza dover creare un account per ognuno dei tuoi 10 colleghi, mantenendo lo stesso funzionamento a cui siete abituati (codice di accesso condiviso + scelta del proprio nome).
7. Vai su **Project Settings** (icona ingranaggio in basso a sinistra) → **API**.
   - Copia il valore **Project URL**.
   - Copia il valore **anon public** (una chiave lunga che inizia con `eyJ...`).

## Parte 2 — Compilare config.js

1. Apri il file `config.js` con un qualsiasi editor di testo (anche il Blocco Note va bene).
2. Sostituisci `https://TUO-PROGETTO.supabase.co` con il **Project URL** copiato al passaggio precedente.
3. Sostituisci `INCOLLA-QUI-LA-TUA-ANON-KEY` con la chiave **anon public** copiata.
4. Salva il file.

Questa chiave "anon" è pensata per stare visibile nel codice del sito: non è un segreto da nascondere, la protezione vera sta nelle regole (RLS) create dallo script SQL, che permettono l'accesso ai dati solo a chi è passato dal login (anche anonimo) dell'app.

## Parte 3 — Pubblicare su GitHub Pages

1. Vai su **github.com**, crea un account se non ce l'hai già.
2. Clicca **New repository**. Dagli un nome (es. `gestionale-pratiche`), lascialo **Public** (necessario per GitHub Pages gratuito), e crealo.
3. Nella pagina del repository appena creato, clicca **uploading an existing file** (o trascina i file nell'area apposita).
4. Carica questi tre file: `index.html`, `config.js`, `supabase-schema.sql` (il README è facoltativo, ma puoi caricarlo comunque).
5. Scrivi un messaggio di commit qualsiasi (es. "primo caricamento") e clicca **Commit changes**.
6. Vai su **Settings** (in alto nel repository) → **Pages** (menu a sinistra).
7. In **Source**, scegli **Deploy from a branch**; in **Branch**, scegli `main` e cartella `/ (root)`; clicca **Save**.
8. Attendi 1-2 minuti. Ricarica la pagina Settings → Pages: apparirà un link tipo:
   `https://tuo-utente.github.io/gestionale-pratiche/`

Quello è il link definitivo del vostro gestionale, raggiungibile da chiunque, senza bisogno di alcun account Claude.

## Parte 4 — Primo avvio

Uguale alla versione Claude:
1. Apri il link: la prima persona che lo apre imposta il nome dello studio e un codice di accesso condiviso.
2. Da lì, chi entra digita il codice e sceglie il proprio nome (o lo aggiunge, se è il primo).
3. Da quel momento la bacheca è condivisa in tempo reale tra tutti.

---

## Domande frequenti

**Devo pagare qualcosa?**
No, per un uso come il vostro (10 persone, poche centinaia di pratiche) il piano gratuito di Supabase e quello di GitHub Pages bastano tranquillamente. Supabase mette un limite generoso (500 MB di database, 1 GB di allegati, e il progetto va in pausa automatica se resta inattivo per 7 giorni di fila — si riattiva da solo al primo accesso, con qualche secondo di attesa).

**Posso aggiornare il sito in futuro (nuove funzioni, correzioni)?**
Sì: basta ricaricare su GitHub il file `index.html` aggiornato (Settings del repository → carica di nuovo il file, sovrascrivendolo). GitHub Pages si aggiorna da solo in 1-2 minuti. Se in futuro vuoi che aggiunga altre funzionalità, ripartiamo da questa stessa base.

**Posso usare un indirizzo mio invece di quello di GitHub (es. gestionale.vostrostudio.it)?**
Sì, GitHub Pages supporta domini personalizzati gratuitamente (Settings → Pages → Custom domain). Se ti interessa, dimmelo e ti preparo i passaggi.

**E se sbaglio qualcosa nella configurazione?**
Nessun rischio per i dati: puoi rifare la Parte 1 e 2 da capo su un progetto Supabase nuovo in qualunque momento, senza perdere nulla del sito già pubblicato — basta aggiornare `config.js` con le nuove chiavi.

**Posso avere sia questa versione sia quella su Claude, allo stesso tempo?**
Sì, sono due installazioni indipendenti con dati separati: non si sincronizzano tra loro automaticamente. Scegliete quale usare "per davvero" quando avrete deciso; nel frattempo potete provarle entrambe in parallelo senza interferenze.

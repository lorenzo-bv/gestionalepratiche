-- ============================================================
-- GESTIONALE PRATICHE — schema Supabase
-- Incolla ed esegui tutto questo script in:
-- Supabase Dashboard -> SQL Editor -> New query -> Run
-- ============================================================

create extension if not exists "pgcrypto";

-- ---------- tabelle ----------

create table if not exists config (
  id int primary key default 1,
  studio_name text,
  passcode text,
  constraint config_single_row check (id = 1)
);

create table if not exists members (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text,
  color text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  color text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists tasks (
  id uuid primary key default gen_random_uuid(),
  title text not null default '',
  client text default '',
  category_ids jsonb not null default '[]',
  assignee_ids jsonb not null default '[]',
  due_date date,
  priority text not null default 'normale',
  status text not null default 'leggere',
  description text default '',
  notes jsonb not null default '[]',
  attachments jsonb not null default '[]',
  archived boolean not null default false,
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ---------- sicurezza (RLS) ----------
-- Regola: chiunque abbia una sessione valida (anche anonima, creata
-- automaticamente dall'app) puo' leggere e scrivere. Chi non passa dal
-- login anonimo dell'app non ha alcun accesso ai dati.

alter table config enable row level security;
alter table members enable row level security;
alter table categories enable row level security;
alter table tasks enable row level security;

drop policy if exists "authenticated full access" on config;
create policy "authenticated full access" on config
  for all to authenticated using (true) with check (true);

drop policy if exists "authenticated full access" on members;
create policy "authenticated full access" on members
  for all to authenticated using (true) with check (true);

drop policy if exists "authenticated full access" on categories;
create policy "authenticated full access" on categories
  for all to authenticated using (true) with check (true);

drop policy if exists "authenticated full access" on tasks;
create policy "authenticated full access" on tasks
  for all to authenticated using (true) with check (true);

-- ---------- storage per gli allegati ----------
-- Bucket privato: i file sono raggiungibili solo tramite link firmati
-- generati dall'app (validi 1 ora), mai con un URL pubblico fisso.

insert into storage.buckets (id, name, public)
  values ('attachments', 'attachments', false)
  on conflict (id) do nothing;

drop policy if exists "authenticated read attachments" on storage.objects;
create policy "authenticated read attachments" on storage.objects
  for select to authenticated using (bucket_id = 'attachments');

drop policy if exists "authenticated upload attachments" on storage.objects;
create policy "authenticated upload attachments" on storage.objects
  for insert to authenticated with check (bucket_id = 'attachments');

drop policy if exists "authenticated delete attachments" on storage.objects;
create policy "authenticated delete attachments" on storage.objects
  for delete to authenticated using (bucket_id = 'attachments');

-- ---------- sincronizzazione in tempo reale ----------
-- Necessaria perche' tutti vedano subito le modifiche altrui.

alter publication supabase_realtime add table tasks;
alter publication supabase_realtime add table members;
alter publication supabase_realtime add table categories;
alter publication supabase_realtime add table config;

-- ============================================================
-- Fine script. Se una riga "alter publication ... add table" da
-- errore perche' la tabella e' gia' inclusa, e' normale: ignorala.
-- ============================================================

-- Vidal Technologies: tabela de clientes para o fluxo de e-mails do n8n
-- Mesmo padrão do Pulse Stock: nomes em inglês, snake_case, tabela no plural,
-- id uuid, created_at/updated_at e booleanos para flags.
-- Cole tudo no Supabase > SQL Editor > New query e clique em Run.

-- ---------------------------------------------------------------------------
-- updated_at automático
-- ---------------------------------------------------------------------------

create or replace function public.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- ---------------------------------------------------------------------------
-- Clientes
-- ---------------------------------------------------------------------------

create table public.customers (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(btrim(name)) between 1 and 120),
  -- CPF (11 dígitos) ou CNPJ (14 dígitos), só números
  document text check (document ~ '^([0-9]{11}|[0-9]{14})$'),
  email text not null check (email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
  -- preenchido sozinho a partir do e-mail, ex.: coca-cola.com.br
  email_domain text generated always as (lower(split_part(email, '@', 2))) stored,
  company text check (char_length(company) <= 120),
  phone text check (char_length(phone) <= 20),
  city text check (char_length(city) <= 80),
  state char(2) check (state ~ '^[A-Z]{2}$'),
  -- idioma do cliente: pt, en ou es
  language text check (language in ('pt', 'en', 'es')),
  -- true = já recebeu a resposta automática e o catálogo de boas-vindas
  welcome_sent boolean not null default false,
  welcome_sent_at timestamptz,
  notes text check (char_length(notes) <= 1000),
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint customers_document_key unique (document)
);

create unique index customers_email_key on public.customers (lower(email));
create index customers_email_domain_idx on public.customers (email_domain);
create index customers_name_idx on public.customers (lower(name));

create trigger customers_set_updated_at
  before update on public.customers
  for each row execute function public.set_updated_at();

-- RLS ativado sem políticas: bloqueia a API pública.
-- O n8n usa a chave secreta (service_role), que passa pelo RLS.
alter table public.customers enable row level security;

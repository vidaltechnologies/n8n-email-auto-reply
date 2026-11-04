-- Vidal Technologies: dados de teste (dummy) para a tabela customers
-- Rode depois do customers.sql. Nomes e empresas são fictícios.

insert into public.customers
  (name, document, email, company, phone, city, state, language, welcome_sent, welcome_sent_at, notes)
values
  ('Fulano',         null,             'fulano@coca-cola.com.br',           'Coca-Cola',           null,          'Rio de Janeiro', 'RJ', 'pt', true,  now() - interval '30 days', 'Já em negociação: não deve receber o catálogo de novo'),
  ('Ana Ribeiro',    '12345678000190', 'ana.ribeiro@padariaestrela.com.br', 'Padaria Estrela',     '41999990001', 'Curitiba',       'PR', 'pt', true,  now() - interval '20 days', 'Pediu orçamento de site institucional'),
  ('Bruno Costa',    null,             'bruno@costaadvocacia.com.br',       'Costa Advocacia',     '11988880002', 'São Paulo',      'SP', 'pt', true,  now() - interval '12 days', 'Interesse em automação de documentos'),
  ('Carla Mendes',   null,             'carla.mendes@studiocm.com.br',      'Studio CM',           null,          'Florianópolis',  'SC', 'pt', false, null,                       'Cadastrada manualmente, ainda não recebeu o catálogo'),
  ('John Miller',    null,             'john.miller@brightlogistics.com',   'Bright Logistics',    null,          null,             null, 'en', true,  now() - interval '5 days',  'Asked about a tracking dashboard'),
  ('Emily Carter',   null,             'emily@greenleafcafe.com',           'Greenleaf Café',      null,          null,             null, 'en', false, null,                       null),
  ('Lucía Fernández',null,             'lucia.fernandez@modasol.es',        'Moda Sol',            null,          null,             null, 'es', true,  now() - interval '2 days',  'Consultó por una tienda online'),
  ('Diego Rojas',    null,             'diego.rojas@constructoraandes.cl',  'Constructora Andes',  null,          null,             null, 'es', false, null,                       null),
  ('Ciclano Souza',  null,             'ciclano@coca-cola.com.br',          'Coca-Cola',           null,          'Rio de Janeiro', 'RJ', 'pt', false, null,                       'Mesma empresa do Fulano, e-mail diferente');

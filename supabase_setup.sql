-- Supabase : SQL Editor > New query > Run
create table if not exists public.training_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.training_data enable row level security;

create policy "users can read their own training data"
on public.training_data for select
using (auth.uid() = user_id);

create policy "users can insert their own training data"
on public.training_data for insert
with check (auth.uid() = user_id);

create policy "users can update their own training data"
on public.training_data for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

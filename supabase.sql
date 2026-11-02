-- Uitvoeren in de SQL Editor van je eigen Supabase-project.
create table if not exists public.profiles (
 user_id uuid primary key references auth.users(id) on delete cascade,
 settings jsonb not null default '{}'::jsonb,
 updated_at timestamptz not null default now()
);
create table if not exists public.entries (
 id uuid primary key,
 user_id uuid not null references auth.users(id) on delete cascade,
 entry_date date not null,
 name text not null,
 grams numeric not null check (grams > 0),
 kcal numeric not null check (kcal >= 0),
 protein numeric not null check (protein >= 0),
 carbs numeric not null check (carbs >= 0),
 fat numeric not null check (fat >= 0),
 created_at timestamptz not null default now()
);
create index if not exists entries_user_date_idx on public.entries(user_id,entry_date);
alter table public.profiles enable row level security;
alter table public.entries enable row level security;
create policy "own profiles read" on public.profiles for select to authenticated using ((select auth.uid())=user_id);
create policy "own profiles insert" on public.profiles for insert to authenticated with check ((select auth.uid())=user_id);
create policy "own profiles update" on public.profiles for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
create policy "own entries read" on public.entries for select to authenticated using ((select auth.uid())=user_id);
create policy "own entries insert" on public.entries for insert to authenticated with check ((select auth.uid())=user_id);
create policy "own entries delete" on public.entries for delete to authenticated using ((select auth.uid())=user_id);

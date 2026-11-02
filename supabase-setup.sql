-- ZUBU database setup for Supabase
-- Run this entire script in Supabase > SQL Editor > New query.
-- This design makes files and notes PUBLICLY READABLE.
-- Only signed-in users can create/update/delete. Disable public sign-ups
-- and create your own owner account in Supabase Authentication.

create extension if not exists pgcrypto;

create table if not exists public.zubu_files (
  id uuid primary key default gen_random_uuid(),
  file_name text not null,
  storage_path text not null unique,
  public_url text not null,
  mime_type text,
  file_size bigint not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.zubu_notes (
  id uuid primary key default gen_random_uuid(),
  title text not null default 'Untitled note',
  body text not null default '',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.zubu_files enable row level security;
alter table public.zubu_notes enable row level security;

drop policy if exists "Anyone can view ZUBU files" on public.zubu_files;
create policy "Anyone can view ZUBU files" on public.zubu_files
for select using (true);

drop policy if exists "Signed-in owner can add ZUBU files" on public.zubu_files;
create policy "Signed-in owner can add ZUBU files" on public.zubu_files
for insert to authenticated with check (true);

drop policy if exists "Signed-in owner can delete ZUBU files" on public.zubu_files;
create policy "Signed-in owner can delete ZUBU files" on public.zubu_files
for delete to authenticated using (true);

drop policy if exists "Anyone can view ZUBU notes" on public.zubu_notes;
create policy "Anyone can view ZUBU notes" on public.zubu_notes
for select using (true);

drop policy if exists "Signed-in owner can add ZUBU notes" on public.zubu_notes;
create policy "Signed-in owner can add ZUBU notes" on public.zubu_notes
for insert to authenticated with check (true);

drop policy if exists "Signed-in owner can edit ZUBU notes" on public.zubu_notes;
create policy "Signed-in owner can edit ZUBU notes" on public.zubu_notes
for update to authenticated using (true) with check (true);

drop policy if exists "Signed-in owner can delete ZUBU notes" on public.zubu_notes;
create policy "Signed-in owner can delete ZUBU notes" on public.zubu_notes
for delete to authenticated using (true);

-- Public bucket: visitors can download files. Authenticated owner can upload/delete.
insert into storage.buckets (id, name, public, file_size_limit)
values ('zubu-files', 'zubu-files', true, 52428800)
on conflict (id) do update set public = true, file_size_limit = 52428800;

drop policy if exists "Anyone can read ZUBU storage" on storage.objects;
create policy "Anyone can read ZUBU storage" on storage.objects
for select using (bucket_id = 'zubu-files');

drop policy if exists "Signed-in owner can upload ZUBU storage" on storage.objects;
create policy "Signed-in owner can upload ZUBU storage" on storage.objects
for insert to authenticated with check (bucket_id = 'zubu-files');

drop policy if exists "Signed-in owner can delete ZUBU storage" on storage.objects;
create policy "Signed-in owner can delete ZUBU storage" on storage.objects
for delete to authenticated using (bucket_id = 'zubu-files');

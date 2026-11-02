# ZUBU — personal cloud workspace

A lightweight static website for public file browsing/downloads and owner-managed uploads/notes.

## Included
- Public file list and public downloads
- Owner sign-in for uploads, notes, edits and deletes
- File types: PDF, DWG/DXF, images, ZIP, Office files, audio, video and other file types
- Search, categories, sorting, responsive layout
- GitHub Pages hosting + Supabase free-tier backend

## Important privacy note
This build is configured as a **public workspace**. Anyone who visits the site can see the file names, notes and download links. Do not upload private, confidential or copyrighted material unless you have permission to publish it. The upload limit is configured to 50 MB per file; adjust it in Supabase if your plan allows. Supabase free-tier quotas apply.

Only signed-in users can upload, edit or delete. In Supabase, disable public sign-ups and create your owner account yourself. The app uses the browser-safe anon/publishable key, never a service-role key.

## 1. Create Supabase project
1. Go to https://supabase.com and create a free account.
2. Create a new project and save the database password somewhere safe.
3. Open **SQL Editor** → **New query**.
4. Copy all contents of `supabase-setup.sql` into the editor and run it.
5. Go to **Authentication → Providers → Email** and keep email/password sign-in enabled.
6. Go to **Authentication → Settings** (or user sign-up settings) and disable public sign-ups. Create your own user from **Authentication → Users → Add user**. Confirm the user if Supabase asks.
7. Open **Project Settings → API** (or **Data API / API Keys**) and copy the Project URL and the `anon` / publishable public key. Never use `service_role` or secret keys.

## 2. Publish to GitHub Pages
1. Sign in at https://github.com.
2. Create a new repository named exactly `zubu`. For a public GitHub Pages site, make the repository public.
3. Extract this ZIP on your computer.
4. Open the new `zubu` repository → **Add file → Upload files**.
5. Upload `index.html`, `assets/` and `supabase-setup.sql` (and this README if you want). Commit the files to the `main` branch.
6. Open repository **Settings → Pages**.
7. Under **Build and deployment**, choose **Deploy from a branch**.
8. Choose branch `main`, folder `/ (root)`, then **Save**.
9. Wait a few minutes. Your site should be at `https://YOUR-GITHUB-USERNAME.github.io/zubu/`.

## 3. Connect ZUBU
1. Open your published site.
2. Click **Setup & settings** in the left sidebar.
3. Paste the Supabase Project URL and anon/publishable public key.
4. Click **Connect ZUBU**.
5. Click **Owner sign in** and sign in using the owner account created in Supabase.

Connection settings are stored in that browser's local storage. You may need to enter them again on another device. The public file list itself is stored in Supabase and appears on all devices.

## Notes
- GitHub Pages hosts the website only. Supabase stores the actual files and notes.
- This starter uses public storage URLs and public read policies by design.
- A 50 MB per-file cap is configured in the SQL setup. Free-tier storage/bandwidth limits can change; check your Supabase dashboard for current quotas.
- Anyone can read the public notes. Do not use this as a private diary.
- This starter does not preview every file format in-browser. Most files can be downloaded; browser-supported formats may open directly.
- For production use with multiple owners, per-user ownership columns and stricter policies should be added.

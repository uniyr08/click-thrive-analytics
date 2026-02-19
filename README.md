# Click Thrive Analytics

Unified client analytics dashboard for performance marketing agencies. GA4 + Clarity data for every client in one place.

## Features

- **Dashboard** — All client websites at a glance with key metrics
- **Client Management** — Add, edit, track client websites
- **Optimization Log** — Track every change you make across all clients
- **GA4 Integration** (Phase 2) — Pull real analytics data automatically
- **Clarity Integration** (Phase 3) — Behavior insights alongside traffic data

## Tech Stack

- Next.js 14 + React 18
- Tailwind CSS
- Supabase (Auth + Database)
- Recharts (for charts)

## Setup

1. Clone this repo
2. Run `npm install`
3. Copy `.env.example` to `.env.local` and add your Supabase credentials
4. Run the SQL in `supabase-schema.sql` in your Supabase SQL Editor
5. Run `npm run dev`

## Supabase Setup

1. Go to [supabase.com](https://supabase.com) and open your project
2. Go to **SQL Editor** and run `supabase-schema.sql`
3. Go to **Authentication → Providers → Email** and enable email sign-in
4. Copy your project URL and anon key from **Settings → API**

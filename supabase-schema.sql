-- Click Thrive Analytics — Database Schema
-- Run this in Supabase SQL Editor

-- Sites table
CREATE TABLE IF NOT EXISTS public.sites (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  domain TEXT NOT NULL,
  ga4_property_id TEXT,
  clarity_project_id TEXT,
  monthly_budget REAL DEFAULT 0,
  status TEXT DEFAULT 'active',
  contact_name TEXT,
  contact_email TEXT,
  notes TEXT,
  user_id TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.sites ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all site access" ON public.sites FOR ALL USING (true) WITH CHECK (true);

-- Snapshots table (cached metrics from GA4 + Clarity)
CREATE TABLE IF NOT EXISTS public.snapshots (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  site_id UUID REFERENCES public.sites(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  source TEXT NOT NULL,
  metrics JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.snapshots ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all snapshot access" ON public.snapshots FOR ALL USING (true) WITH CHECK (true);

-- Optimization log
CREATE TABLE IF NOT EXISTS public.optimization_log (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  site_id UUID REFERENCES public.sites(id) ON DELETE CASCADE,
  date DATE DEFAULT CURRENT_DATE,
  platform TEXT NOT NULL,
  action TEXT NOT NULL,
  notes TEXT,
  impact TEXT,
  user_id TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.optimization_log ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all log access" ON public.optimization_log FOR ALL USING (true) WITH CHECK (true);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_snapshots_site_date ON public.snapshots(site_id, date);
CREATE INDEX IF NOT EXISTS idx_optimization_log_site ON public.optimization_log(site_id);

-- Reload schema cache
NOTIFY pgrst, 'reload schema';

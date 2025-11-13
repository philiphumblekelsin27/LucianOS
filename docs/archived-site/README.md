# Archived Next.js Website Files

This directory contains the original Next.js web application files that were previously at the repository root.

## Files Archived
The following files have been moved here from the repo root to separate the web frontend from the OS core source:

- `next.config.ts` — Next.js configuration
- `next-env.d.ts` — Next.js TypeScript definitions
- `postcss.config.mjs` — PostCSS configuration for CSS processing
- `tailwind.config.ts` — Tailwind CSS configuration
- `tsconfig.json` — TypeScript configuration (web-specific)
- `src/` — Next.js source code (pages, components, utilities)
- `package.json` — Web dependencies (Next.js, React, Radix UI, etc.)
- `package-lock.json` — Dependency lock file
- `apphosting.yaml` — App hosting configuration
- `components.json` — Component registry / UI kit config

## Why Archived?
The LucianOS project structure now follows a clear separation of concerns:
- **OS Core**: kernel/, image/, shell/, ai/, installer/, packages/, ci/, tests/
- **Web/Docs**: docs/archived-site/ (separate from OS build artifacts)

This prevents confusion between OS build artifacts and web frontend dependencies.

## Restoring the Website
If you need to restore or develop the Next.js website independently:

```bash
# Option 1: Copy files back to repo root
cp -r docs/archived-site/* .
npm install

# Option 2: Run in place from docs/archived-site/
cd docs/archived-site
npm install
npm run dev
```

## Future Use
- If the website is still needed (project documentation, app launcher frontend, etc.), consider:
  - Keeping it in `docs/archived-site/` and running it separately.
  - Moving it to a separate GitHub repository (`lucianos-web`, `lucianos-docs`).
  - Hosting it separately (GitHub Pages, Netlify, Vercel).

## Notes
- `node_modules/` should NOT be committed; it will be auto-installed by `npm install`.
- `.next/` (build output) should also be excluded from version control (already in `.gitignore`).
- The web app dependencies (React, Next.js, Radix UI, TailwindCSS) are not needed for the OS core build.

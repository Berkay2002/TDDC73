# Primitive UI Documentation

Official documentation website for Primitive UI - built with Next.js 16 and Nextra 4.

##  Quick Start

### Prerequisites

- Node.js 18+
- npm or yarn

### Installation

```bash
# Install dependencies
npm install

# Run development server
npm run dev
```

Visit [http://localhost:3000](http://localhost:3000)

##  Development

### Scripts

```bash
npm run dev      # Start development server
npm run build    # Build for production
npm run start    # Start production server
npm run lint     # Run ESLint
```

### Adding Content

1. Create MDX files in `pages/` directory
2. Update `_meta.js` files for navigation
3. Use Nextra components for enhanced formatting

### Project Structure

- `app/` - Next.js app directory with root layout
- `pages/` - MDX documentation files (Nextra content)
- `components/` - Custom React components
- `public/` - Static assets
- `theme.config.tsx` - Nextra theme configuration

##  Features

-  Full-text search with Pagefind
-  Version switching component
-  DartPad integration for live examples
-  Dark mode support
-  Responsive design
-  Syntax highlighting for Dart/Flutter
-  Interactive playgrounds

##  Documentation Structure

### Completed Pages

-  Home page (`pages/index.mdx`)
-  Getting Started (`pages/getting-started.mdx`)
-  Installation (`pages/installation.mdx`)
-  Component docs:
  - PrimitiveCard
  - PrimitiveToggleSwitch
  - VStack
  - ZStack

### To Be Created

- [ ] Architecture pages (primitives-explained, rendering-pipeline, layout-system, design-decisions)
- [ ] Examples pages (basic-usage, advanced-patterns, real-world-apps)
- [ ] Playground page
- [ ] API Reference page
- [ ] Troubleshooting page
- [ ] FAQ page

##  Deployment

### Vercel (Recommended)

1. Push to GitHub
2. Import project in Vercel
3. Deploy automatically

### Manual Build

```bash
npm run build
npm run start
```

##  Tech Stack

- **Framework:** Next.js 16
- **Documentation:** Nextra 4
- **Theme:** nextra-theme-docs
- **Search:** Pagefind
- **Styling:** Tailwind CSS 4
- **Deployment:** Vercel

##  License

MIT - Created for TDDC73 at Linköping University

##  Contributing

This is an educational project. Feel free to fork and adapt for your own learning!

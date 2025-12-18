# Primitive UI Documentation

Official documentation website for Primitive UI - built with Next.js 16 and Nextra 4.

## Quick Start

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

## Development

### Scripts

```bash
npm run dev      # Start development server
npm run build    # Build for production
npm run start    # Start production server
npm run lint     # Run ESLint
```

### Adding Content

1. Create MDX files in `app/(docs)/` directory
2. Update `_meta.global.js` files for navigation
3. Use Nextra components for enhanced formatting

### Project Structure

- `app/` - Next.js app directory with root layout
- `app/(docs)/` - MDX documentation files (Nextra content)
- `components/` - Custom React components
- `public/` - Static assets
- `lib/` - Utility functions and version management

## Features

- Full-text search with Pagefind
- Version switching component
- DartPad integration for live examples
- Dark mode support
- Responsive design
- Syntax highlighting for Dart/Flutter
- Interactive playgrounds

## Documentation Structure

### Documentation Sections

- Home page (`app/(docs)/page.mdx`)
- Getting Started (`app/(docs)/getting-started/`)
- Accessibility guide (`app/(docs)/accessibility/`)
- Architecture docs (`app/(docs)/architecture/`)
- Component docs (`app/(docs)/components/`):
  - PrimitiveButton
  - PrimitiveCard
  - PrimitiveCircularProgress
  - PrimitiveInput
  - PrimitiveSlider
  - PrimitiveToggleSwitch
  - HStack
  - VStack
  - ZStack
- Examples (`app/(docs)/examples/`)
- Releases (`app/(docs)/releases/`)

## Deployment

### Vercel (Recommended)

1. Push to GitHub
2. Import project in Vercel
3. Deploy automatically

### Manual Build

```bash
npm run build
npm run start
```

## Tech Stack

- **Framework:** Next.js 16
- **Documentation:** Nextra 4
- **Theme:** nextra-theme-docs
- **Search:** Pagefind
- **Styling:** Tailwind CSS 4
- **Deployment:** Vercel

## License

MIT - Created for TDDC73 at Linköping University

## Contributing

This is an educational project. Feel free to fork and adapt for your own learning!

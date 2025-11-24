# Nextra Documentation Site Implementation Plan

**Project:** Primitive UI Documentation Website  
**Framework:** Next.js 15 + Nextra 4 (Docs Theme)  
**Deployment:** Vercel  
**Version:** 0.0.1 (with versioning support)  
**Date:** November 23, 2025

---

## Overview

Build a comprehensive, versioned documentation website for the primitive_ui Flutter library using Next.js and Nextra. The site will transform existing markdown documentation into an interactive developer resource with DartPad embeds, version switching, code playground, and professional navigation.

---

## Project Structure

```
c:\Users\berka\Masters\TDDC73\
├── app/
│   ├── layout.jsx                    # Root layout with Nextra theme
│   ├── page.jsx                      # Redirect to /docs
│   └── globals.css                   # Global styles
├── content/                          # Documentation content
│   ├── _meta.js                      # Root navigation config
│   ├── index.mdx                     # Landing/home page
│   ├── getting-started.mdx           # Quick start guide
│   ├── installation.mdx              # Installation instructions
│   ├── components/                   # Component documentation
│   │   ├── _meta.js
│   │   ├── primitive-card.mdx
│   │   ├── primitive-toggle-switch.mdx
│   │   ├── vstack.mdx
│   │   └── zstack.mdx
│   ├── architecture/                 # Deep dive concepts
│   │   ├── _meta.js
│   │   ├── primitives-explained.mdx
│   │   ├── rendering-pipeline.mdx
│   │   ├── layout-system.mdx
│   │   └── design-decisions.mdx
│   ├── examples/                     # Practical examples
│   │   ├── _meta.js
│   │   ├── basic-usage.mdx
│   │   ├── advanced-patterns.mdx
│   │   └── real-world-apps.mdx
│   ├── playground.mdx                # Interactive code playground
│   ├── api-reference.mdx             # Complete API documentation
│   ├── troubleshooting.mdx           # Common issues & solutions
│   └── faq.mdx                       # Frequently asked questions
├── components/                       # Custom React components
│   ├── DartPadEmbed.jsx             # DartPad iframe wrapper
│   ├── VersionSwitcher.jsx          # Version dropdown
│   └── ApiTable.jsx                 # API documentation table
├── public/
│   ├── favicon.ico
│   ├── logo.svg
│   └── _pagefind/                   # Generated search index (gitignored)
├── next.config.mjs                  # Next.js + Nextra config
├── package.json                     # Dependencies & scripts
├── .gitignore                       # Git ignore rules
├── vercel.json                      # Vercel deployment config
└── README.md                        # Project documentation
```

---

## Step-by-Step Implementation

### Step 1: Initialize Next.js Project

**Create `package.json`:**

```json
{
  "name": "primitive-ui-docs",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "postbuild": "pagefind --site .next/server/app --output-path public/_pagefind",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "^15.0.0",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "nextra": "^4.0.0",
    "nextra-theme-docs": "^4.0.0"
  },
  "devDependencies": {
    "pagefind": "^1.1.0",
    "eslint": "^9.0.0",
    "eslint-config-next": "^15.0.0"
  }
}
```

**Install dependencies:**

```bash
npm install
```

---

### Step 2: Configure Next.js and Nextra

**Create `next.config.mjs`:**

```js
import nextra from 'nextra'

const withNextra = nextra({
  theme: 'nextra-theme-docs',
  themeConfig: './theme.config.jsx',
  search: {
    codeblocks: false  // Focus search on documentation content
  },
  latex: true,  // Enable math support if needed
  defaultShowCopyCode: true
})

/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',  // Optimized for Vercel
  images: {
    unoptimized: true
  }
}

export default withNextra(nextConfig)
```

**Create `.gitignore`:**

```gitignore
# Dependencies
node_modules/
.pnp
.pnp.js

# Next.js
.next/
out/
build/
dist/

# Pagefind
public/_pagefind/
_pagefind/

# Environment
.env
.env.local
.env.production.local
.env.development.local

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db
```

---

### Step 3: Create Root Layout with Nextra Theme

**Create `app/layout.jsx`:**

```jsx
import { Footer, Layout, Navbar } from 'nextra-theme-docs'
import { Banner, Head } from 'nextra/components'
import { getPageMap } from 'nextra/page-map'
import 'nextra-theme-docs/style.css'
import './globals.css'
import { VersionSwitcher } from '@/components/VersionSwitcher'

export const metadata = {
  title: 'Primitive UI - Flutter GUI Library from Scratch',
  description: 'A Flutter GUI library built entirely from scratch using only CustomPaint, Canvas, GestureDetector, and custom render objects.',
  keywords: ['Flutter', 'UI Library', 'CustomPaint', 'Canvas', 'Primitive', 'Widgets'],
  authors: [{ name: 'Primitive UI Team' }],
  openGraph: {
    title: 'Primitive UI Documentation',
    description: 'Build Flutter UIs from primitive components',
    type: 'website'
  }
}

const navbar = (
  <Navbar
    logo={
      <div className="flex items-center gap-2">
        <span className="font-bold text-xl">Primitive UI</span>
        <span className="text-xs bg-blue-100 dark:bg-blue-900 px-2 py-1 rounded">
          v0.0.1
        </span>
      </div>
    }
    projectLink="https://github.com/yourusername/primitive_ui"
  >
    <VersionSwitcher />
  </Navbar>
)

const footer = (
  <Footer>
    <div className="flex flex-col items-center gap-2">
      <p>MIT {new Date().getFullYear()} © Primitive UI</p>
      <p className="text-xs text-gray-500">
        Created for TDDC73 - Interaction Programming at Linköping University
      </p>
    </div>
  </Footer>
)

export default async function RootLayout({ children }) {
  return (
    <html
      lang="en"
      dir="ltr"
      suppressHydrationWarning
    >
      <Head>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <body>
        <Layout
          navbar={navbar}
          pageMap={await getPageMap()}
          docsRepositoryBase="https://github.com/yourusername/primitive_ui/tree/main"
          footer={footer}
          editLink="Edit this page on GitHub"
          feedback={{
            content: 'Question? Give us feedback →',
            labels: 'feedback'
          }}
          toc={{
            title: 'On This Page',
            backToTop: true
          }}
          sidebar={{
            defaultMenuCollapseLevel: 1,
            toggleButton: true
          }}
        >
          {children}
        </Layout>
      </body>
    </html>
  )
}
```

**Create `app/globals.css`:**

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Custom styles for DartPad embeds */
.dartpad-embed {
  width: 100%;
  height: 500px;
  border: 1px solid var(--nextra-border);
  border-radius: 8px;
  overflow: hidden;
}

/* API table styling */
.api-table {
  width: 100%;
  border-collapse: collapse;
}

.api-table th,
.api-table td {
  padding: 0.75rem;
  text-align: left;
  border: 1px solid var(--nextra-border);
}

.api-table th {
  background: var(--nextra-bg-subtle);
  font-weight: 600;
}

/* Code block enhancements */
pre {
  border-radius: 8px !important;
}
```

**Create `app/page.jsx`:**

```jsx
import { redirect } from 'next/navigation'

export default function HomePage() {
  redirect('/docs')
}
```

---

### Step 4: Create Custom React Components

**Create `components/DartPadEmbed.jsx`:**

```jsx
'use client'

export function DartPadEmbed({ 
  id, 
  height = 500,
  theme = 'dark',
  run = true,
  split = 60 
}) {
  const src = `https://dartpad.dev/embed-flutter.html?id=${id}&theme=${theme}&run=${run}&split=${split}`
  
  return (
    <div className="my-6">
      <iframe
        src={src}
        className="dartpad-embed"
        style={{ height: `${height}px` }}
        title={`DartPad Embed ${id}`}
        sandbox="allow-scripts allow-same-origin"
      />
    </div>
  )
}
```

**Create `components/VersionSwitcher.jsx`:**

```jsx
'use client'

import { useState } from 'react'

const versions = [
  { label: 'v0.0.1', value: '0.0.1', path: '/docs' },
  // Future versions will be added here
  // { label: 'v0.1.0', value: '0.1.0', path: '/v0.1.0/docs' },
]

export function VersionSwitcher() {
  const [currentVersion] = useState(versions[0])

  return (
    <div className="flex items-center gap-2">
      <select
        className="px-3 py-1 border rounded-md text-sm bg-white dark:bg-gray-800"
        value={currentVersion.value}
        onChange={(e) => {
          const version = versions.find(v => v.value === e.target.value)
          if (version) {
            window.location.href = version.path
          }
        }}
      >
        {versions.map(v => (
          <option key={v.value} value={v.value}>
            {v.label}
          </option>
        ))}
      </select>
    </div>
  )
}
```

**Create `components/ApiTable.jsx`:**

```jsx
export function ApiTable({ parameters }) {
  return (
    <div className="overflow-x-auto my-6">
      <table className="api-table">
        <thead>
          <tr>
            <th>Parameter</th>
            <th>Type</th>
            <th>Required</th>
            <th>Default</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          {parameters.map((param, index) => (
            <tr key={index}>
              <td><code>{param.name}</code></td>
              <td><code>{param.type}</code></td>
              <td>{param.required ? '✓' : '✗'}</td>
              <td><code>{param.default || '—'}</code></td>
              <td>{param.description}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}
```

---

### Step 5: Structure Content Directory

**Create `content/_meta.js`:**

```js
export default {
  index: {
    title: 'Home',
    type: 'page',
    display: 'hidden'
  },
  docs: {
    title: 'Documentation',
    type: 'page'
  },
  '---': {
    type: 'separator'
  },
  'getting-started': 'Getting Started',
  installation: 'Installation',
  components: 'Components',
  architecture: 'Architecture',
  examples: 'Examples',
  playground: 'Playground',
  '---2': {
    type: 'separator'
  },
  'api-reference': 'API Reference',
  troubleshooting: 'Troubleshooting',
  faq: 'FAQ'
}
```

**Create `content/components/_meta.js`:**

```js
export default {
  'primitive-card': 'PrimitiveCard',
  'primitive-toggle-switch': 'PrimitiveToggleSwitch',
  vstack: 'VStack',
  zstack: 'ZStack'
}
```

**Create `content/architecture/_meta.js`:**

```js
export default {
  'primitives-explained': 'Primitives Explained',
  'rendering-pipeline': 'Rendering Pipeline',
  'layout-system': 'Layout System',
  'design-decisions': 'Design Decisions'
}
```

**Create `content/examples/_meta.js`:**

```js
export default {
  'basic-usage': 'Basic Usage',
  'advanced-patterns': 'Advanced Patterns',
  'real-world-apps': 'Real-World Applications'
}
```

---

### Step 6: Create Core Documentation Pages

**Create `content/index.mdx`:**

```mdx
---
title: Primitive UI
description: A Flutter GUI library built entirely from scratch using only primitive components
---

import { Cards } from 'nextra/components'

# Primitive UI

A Flutter GUI library built entirely from scratch using only primitive components: `CustomPaint`, `Canvas`, `GestureDetector`, and custom render objects.

## Why Primitive UI?

Zero dependencies on high-level widgets. Every component is built from scratch using Flutter's rendering layer primitives, providing deep insight into how Flutter's rendering engine works.

<Cards num={2}>
  <Cards.Card arrow title="Getting Started" href="/getting-started">
    Learn how to install and use Primitive UI in your Flutter project
  </Cards.Card>
  <Cards.Card arrow title="Components" href="/components/primitive-card">
    Explore the 4 core components: 2 UI and 2 layout
  </Cards.Card>
  <Cards.Card arrow title="Architecture" href="/architecture/primitives-explained">
    Understand the design philosophy and implementation
  </Cards.Card>
  <Cards.Card arrow title="Playground" href="/playground">
    Try components interactively in your browser
  </Cards.Card>
</Cards>

## Components Overview

### UI Components

- **[PrimitiveCard](/components/primitive-card)** - Container with shadow, rounded corners, and padding
- **[PrimitiveToggleSwitch](/components/primitive-toggle-switch)** - Animated toggle switch

### Layout Components

- **[VStack](/components/vstack)** - Vertical stack with spacing and alignment
- **[ZStack](/components/zstack)** - Layered stack (z-ordering)

## Key Features

- ✅ **Zero High-Level Widget Dependencies** - Built entirely from primitives
- ✅ **Custom Paint & Canvas** - Direct control over every pixel
- ✅ **Custom RenderBox** - Manual layout calculations
- ✅ **Educational Value** - Learn how Flutter rendering works
- ✅ **Fully Tested** - Comprehensive widget tests included
- ✅ **Production Ready** - Performant and well-documented

## Quick Example

```dart
import 'package:primitive_ui/primitive_ui.dart';

PrimitiveCard(
  elevation: 4.0,
  borderRadius: 12.0,
  child: VStack(
    spacing: 16.0,
    children: [
      Text('Settings'),
      PrimitiveToggleSwitch(
        value: _enabled,
        onChanged: (value) => setState(() => _enabled = value),
      ),
    ],
  ),
)
```

---

Created for TDDC73 - Interaction Programming at Linköping University
```

**Create `content/getting-started.mdx`:**

```mdx
---
title: Getting Started
description: Learn how to install and start using Primitive UI
---

import { Steps, Callout } from 'nextra/components'

# Getting Started

Get up and running with Primitive UI in your Flutter project.

## Prerequisites

<Callout type="info">
  You need Flutter SDK 3.9.2 or higher installed on your machine.
</Callout>

- Flutter SDK: `>=3.9.2`
- Dart: Compatible with Flutter version

## Installation

<Steps>

### Add dependency

Add Primitive UI to your `pubspec.yaml`:

```yaml filename="pubspec.yaml"
dependencies:
  primitive_ui:
    path: ../primitive_ui
```

<Callout type="warning">
  Currently, Primitive UI is available as a local package. Update the path to match your project structure.
</Callout>

### Get packages

Run the following command:

```bash
flutter pub get
```

### Import the library

Import Primitive UI in your Dart files:

```dart filename="lib/main.dart"
import 'package:primitive_ui/primitive_ui.dart';
```

### Start using components

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: PrimitiveCard(
            child: Text('Hello Primitive UI!'),
          ),
        ),
      ),
    );
  }
}
```

</Steps>

## Next Steps

- Explore [Components](/components/primitive-card) to learn about each widget
- Check out [Examples](/examples/basic-usage) for practical use cases
- Read [Architecture](/architecture/primitives-explained) to understand the design
```

---

### Step 7: Create Component Documentation Pages

**Example: `content/components/primitive-card.mdx`:**

```mdx
---
title: PrimitiveCard
description: A container widget with shadow, rounded corners, and padding - all rendered using Canvas
---

import { Tabs, Callout } from 'nextra/components'
import { ApiTable } from '@/components/ApiTable'
import { DartPadEmbed } from '@/components/DartPadEmbed'

# PrimitiveCard

A container widget with shadow, rounded corners, and padding - all rendered using `Canvas`.

## Overview

`PrimitiveCard` provides a Material-style card appearance using only `CustomPaint` and `Canvas`. It demonstrates how shadows, rounded corners, and elevation can be implemented from scratch.

## Interactive Example

<DartPadEmbed id="your-dartpad-gist-id" height={400} />

<Callout type="info">
  Try modifying the elevation and border radius values to see real-time changes!
</Callout>

## Basic Usage

```dart
PrimitiveCard(
  child: Text('Hello World'),
)
```

## API Reference

### Constructor

```dart
PrimitiveCard({
  Key? key,
  required Widget child,
  Color color = Colors.white,
  double borderRadius = 8.0,
  double elevation = 2.0,
  EdgeInsets padding = const EdgeInsets.all(16.0),
})
```

### Parameters

<ApiTable
  parameters={[
    {
      name: 'child',
      type: 'Widget',
      required: true,
      default: null,
      description: 'The widget to display inside the card'
    },
    {
      name: 'color',
      type: 'Color',
      required: false,
      default: 'Colors.white',
      description: 'Background color of the card'
    },
    {
      name: 'borderRadius',
      type: 'double',
      required: false,
      default: '8.0',
      description: 'Corner radius in logical pixels'
    },
    {
      name: 'elevation',
      type: 'double',
      required: false,
      default: '2.0',
      description: 'Shadow depth in logical pixels'
    },
    {
      name: 'padding',
      type: 'EdgeInsets',
      required: false,
      default: 'EdgeInsets.all(16.0)',
      description: 'Internal spacing around the child'
    }
  ]}
/>

## Examples

### Different Elevations

<Tabs items={['Low', 'Medium', 'High']}>
  <Tabs.Tab>
```dart
PrimitiveCard(
  elevation: 2.0,
  child: Text('Low elevation'),
)
```
  </Tabs.Tab>
  <Tabs.Tab>
```dart
PrimitiveCard(
  elevation: 4.0,
  child: Text('Medium elevation'),
)
```
  </Tabs.Tab>
  <Tabs.Tab>
```dart
PrimitiveCard(
  elevation: 8.0,
  child: Text('High elevation'),
)
```
  </Tabs.Tab>
</Tabs>

### Custom Styling

```dart
PrimitiveCard(
  color: Colors.blue[50]!,
  borderRadius: 16.0,
  elevation: 8.0,
  padding: const EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 16.0,
  ),
  child: Column(
    children: [
      Text('Card Title', 
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
      ),
      SizedBox(height: 8),
      Text('Card content goes here'),
    ],
  ),
)
```

## Implementation Details

<Callout type="default">
  **Primitives Used:** `CustomPaint`, `Canvas`, `RenderShiftedBox`
</Callout>

### Rendering

- Uses `CustomPaint` with a custom `CustomPainter` for rendering
- `Canvas.drawShadow()` for elevation effect
- `Canvas.drawRRect()` for rounded corners
- Custom `RenderShiftedBox` for padding and layout

### Performance

- `shouldRepaint()` only returns true when properties change
- Hardware-accelerated canvas operations
- Efficient shadow rendering with single draw call

## Related Components

- [VStack](/components/vstack) - For vertical layouts inside cards
- [ZStack](/components/zstack) - For layered content

## Source Code

View the [implementation on GitHub](https://github.com/yourusername/primitive_ui/blob/main/lib/src/components/primitive_card.dart)
```

---

### Step 8: Create Additional Pages

**Create `content/playground.mdx`:**

```mdx
---
title: Playground
description: Try Primitive UI components interactively in your browser
---

import { Tabs, Callout } from 'nextra/components'
import { DartPadEmbed } from '@/components/DartPadEmbed'

# Playground

Experiment with Primitive UI components in your browser using DartPad.

<Callout type="info">
  The playground below includes all Primitive UI components pre-imported. Modify the code and see changes instantly!
</Callout>

## Full Demo

<DartPadEmbed id="full-demo-gist-id" height={600} run={true} />

## Component Playgrounds

<Tabs items={['PrimitiveCard', 'PrimitiveToggleSwitch', 'VStack', 'ZStack']}>
  <Tabs.Tab>
    ### PrimitiveCard Playground
    
    <DartPadEmbed id="primitive-card-gist-id" height={500} />
    
    **Try changing:**
    - `elevation` values (0.0 - 16.0)
    - `borderRadius` (0.0 - 50.0)
    - `color` values
    - `padding` configurations
  </Tabs.Tab>
  
  <Tabs.Tab>
    ### PrimitiveToggleSwitch Playground
    
    <DartPadEmbed id="toggle-switch-gist-id" height={500} />
    
    **Try changing:**
    - `activeColor` and `inactiveColor`
    - `width` and `height`
    - Animation speed
  </Tabs.Tab>
  
  <Tabs.Tab>
    ### VStack Playground
    
    <DartPadEmbed id="vstack-gist-id" height={500} />
    
    **Try changing:**
    - `spacing` values
    - `alignment` modes
    - Number of children
  </Tabs.Tab>
  
  <Tabs.Tab>
    ### ZStack Playground
    
    <DartPadEmbed id="zstack-gist-id" height={500} />
    
    **Try changing:**
    - Layer order
    - `alignment` values
    - Child sizes
  </Tabs.Tab>
</Tabs>

## Tips

- Use the **Format** button to auto-format your code
- Click **Reset** to restore the original example
- **Console** tab shows print statements and errors
- **Documentation** tab provides Flutter API reference

## Share Your Creation

Created something cool? Share your DartPad link with the community!
```

**Create `content/troubleshooting.mdx`:**

```mdx
---
title: Troubleshooting
description: Common issues and solutions when using Primitive UI
---

import { Callout } from 'nextra/components'

# Troubleshooting

Solutions to common issues when using Primitive UI.

## Package Not Found

<Callout type="error">
  **Error:** `Error: Cannot find package 'primitive_ui'`
</Callout>

**Solution:** Ensure the path in your `pubspec.yaml` is correct:

```yaml
dependencies:
  primitive_ui:
    path: ../primitive_ui  # Relative to your project root
```

Then run:
```bash
flutter pub get
```

## Shadow Not Rendering

<Callout type="warning">
  **Issue:** PrimitiveCard shadow is not visible
</Callout>

**Solution:** Ensure you're providing enough space for the shadow. The shadow extends beyond the card by the `elevation` amount. Add padding around the card or ensure the parent container has sufficient size.

```dart
// ❌ Bad - shadow may be clipped
Container(
  child: PrimitiveCard(elevation: 8.0, child: Text('Hello')),
)

// ✅ Good - padding allows shadow to show
Padding(
  padding: EdgeInsets.all(16.0),
  child: PrimitiveCard(elevation: 8.0, child: Text('Hello')),
)
```

## VStack Children Overlapping

<Callout type="warning">
  **Issue:** VStack children are overlapping or too close together
</Callout>

**Solution:** Add appropriate spacing:

```dart
VStack(
  spacing: 16.0,  // Add spacing between children
  children: [
    Text('Item 1'),
    Text('Item 2'),
  ],
)
```

## ZStack Not Layering Correctly

<Callout type="warning">
  **Issue:** ZStack children appear in wrong order
</Callout>

**Solution:** Remember that children are painted in order (first = bottom, last = top):

```dart
ZStack(
  children: [
    Container(...),  // Bottom layer
    Text(...),       // Top layer
  ],
)
```

## Hot Reload Issues

<Callout type="info">
  **Issue:** Changes not reflecting after hot reload
</Callout>

**Solution:** Try hot restart instead:
- Press `R` in the terminal (full restart)
- Or stop and run `flutter run` again

## Performance Issues

<Callout type="warning">
  **Issue:** UI feels sluggish or animations are not smooth
</Callout>

**Solutions:**

1. **Profile your app:**
```bash
flutter run --profile
```

2. **Check for unnecessary rebuilds:**
   - Use `const` constructors where possible
   - Avoid creating widgets in build methods

3. **Optimize CustomPaint:**
   - Ensure `shouldRepaint()` returns `false` when possible
   - Use `RepaintBoundary` for complex painted widgets

## Platform-Specific Issues

### Windows

If you encounter build errors on Windows, ensure you have:
- Visual Studio 2022 with C++ tools
- Windows SDK installed

### macOS/iOS

Ensure you have:
- Xcode installed and up to date
- CocoaPods installed: `sudo gem install cocoapods`

### Linux

Install required dependencies:
```bash
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

## Still Having Issues?

If you're still experiencing problems:

1. Check the [FAQ](/faq) for more common questions
2. Review the [Getting Started](/getting-started) guide
3. Examine the [Examples](/examples/basic-usage) for reference implementations
4. Open an issue on [GitHub](https://github.com/yourusername/primitive_ui/issues)
```

**Create `content/faq.mdx`:**

```mdx
---
title: FAQ
description: Frequently asked questions about Primitive UI
---

import { Callout } from 'nextra/components'

# Frequently Asked Questions

Common questions about Primitive UI.

## General

### What is Primitive UI?

Primitive UI is a Flutter GUI library built entirely from scratch using only primitive components like `CustomPaint`, `Canvas`, `GestureDetector`, and custom render objects. It demonstrates how UI components work "under the hood" without depending on high-level widgets.

### Why build from primitives?

Building from primitives provides:
- **Deep understanding** of Flutter's rendering engine
- **Insight into performance** and how widgets actually work
- **Educational value** for learning Flutter internals
- **Full control** over every aspect of rendering

### Is Primitive UI production-ready?

Primitive UI was created for educational purposes as part of the TDDC73 course. While it's well-tested and functional, it's designed to teach concepts rather than replace Flutter's built-in widgets in production apps.

### Can I use Primitive UI in my project?

Yes! Primitive UI is MIT licensed. However, consider:
- It's educational in nature
- Flutter's built-in widgets are more feature-complete
- Use it to learn, then apply those concepts with standard widgets

## Components

### How many components does Primitive UI include?

Primitive UI includes **4 core components**:
- **UI Components:** PrimitiveCard, PrimitiveToggleSwitch
- **Layout Components:** VStack, ZStack

### Can I customize the components?

Yes! All components accept customization parameters:
- Colors, sizes, spacing
- Border radius, elevation
- Alignment, padding

See the [API Reference](/api-reference) for complete details.

### Do components support all Flutter features?

No. Primitive UI focuses on core functionality:
- ❌ No `Flexible`/`Expanded` in VStack
- ❌ No `Positioned` in ZStack
- ❌ Limited accessibility features
- ✅ Core layout and rendering work fully

## Technical

### What Flutter version is required?

Primitive UI requires:
- Flutter SDK: `>=3.9.2`
- Dart: Compatible version

### Does it work on all platforms?

Yes! Primitive UI works on all Flutter platforms:
- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

### How does performance compare to standard widgets?

Performance is comparable:
- ✅ Hardware-accelerated Canvas operations
- ✅ Efficient `shouldRepaint()` implementations
- ✅ Optimized layout calculations
- ⚠️ May have slight overhead vs highly optimized framework widgets

### Can I extend or modify components?

Yes! The source code is available and well-documented. You can:
- Fork and modify for your needs
- Create new primitive-based components
- Learn from the implementation

## Development

### How do I run the demo app?

```bash
cd primitive_demo
flutter pub get
flutter run
```

See the [Getting Started](/getting-started) guide for details.

### How do I run tests?

```bash
cd primitive_ui
flutter test
```

### Can I contribute?

This is an educational project for TDDC73. While not actively maintained for production use, you can:
- Fork for your own learning
- Use as reference for your projects
- Share improvements with the community

## Learning

### Where should I start?

1. Read [Getting Started](/getting-started)
2. Try the [Playground](/playground)
3. Study [Architecture](/architecture/primitives-explained)
4. Explore [Examples](/examples/basic-usage)
5. Review the source code

### What will I learn?

By studying Primitive UI, you'll learn:
- How Flutter's rendering pipeline works
- Layout constraint systems
- Canvas painting operations
- Custom RenderBox implementation
- Animation integration
- Widget testing strategies

### Is this better than learning from Flutter docs?

It's complementary! Use both:
- **Flutter docs:** Learn the "what" and "how to use"
- **Primitive UI:** Learn the "why" and "how it works"

## Support

### Where can I get help?

1. Check this FAQ
2. Review [Troubleshooting](/troubleshooting)
3. Read component documentation
4. Open a GitHub issue

### How can I report a bug?

Open an issue on [GitHub](https://github.com/yourusername/primitive_ui/issues) with:
- Description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Flutter/Dart versions

### Can I request features?

The scope of Primitive UI is intentionally limited to demonstrate core concepts. However, feature requests that enhance learning are welcome!
```

---

### Step 9: Vercel Configuration

**Create `vercel.json`:**

```json
{
  "buildCommand": "npm run build",
  "outputDirectory": ".next",
  "framework": "nextjs",
  "regions": ["iad1"],
  "env": {
    "NODE_ENV": "production"
  }
}
```

---

### Step 10: Project Documentation

**Create `README.md` in root:**

```markdown
# Primitive UI Documentation

Official documentation website for Primitive UI - built with Next.js and Nextra.

## 🚀 Quick Start

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

## 📝 Development

### Scripts

```bash
npm run dev      # Start development server
npm run build    # Build for production
npm run start    # Start production server
npm run lint     # Run ESLint
```

### Adding Content

1. Create MDX files in `content/` directory
2. Update `_meta.js` for navigation
3. Use Nextra components for enhanced formatting

### Project Structure

- `app/` - Next.js app directory with layouts
- `content/` - MDX documentation files
- `components/` - Custom React components
- `public/` - Static assets

## 🎨 Features

- ✅ Full-text search with Pagefind
- ✅ Version switching
- ✅ DartPad integration for live examples
- ✅ Dark mode support
- ✅ Responsive design
- ✅ Syntax highlighting for Dart/Flutter
- ✅ Interactive playgrounds

## 🚢 Deployment

### Vercel (Recommended)

1. Push to GitHub
2. Import project in Vercel
3. Deploy automatically

### Manual Build

```bash
npm run build
npm run start
```

## 📚 Documentation

- [Nextra Documentation](https://nextra.site)
- [Next.js Documentation](https://nextjs.org/docs)
- [Primitive UI Library](./project/primitive_ui/README.md)

## 🛠️ Tech Stack

- **Framework:** Next.js 15
- **Documentation:** Nextra 4
- **Search:** Pagefind
- **Styling:** Tailwind CSS
- **Deployment:** Vercel

## 📄 License

MIT - Created for TDDC73 at Linköping University

## 🤝 Contributing

This is an educational project. Feel free to fork and adapt for your own learning!
```

---

## Implementation Decisions

### Version Management Strategy

**Approach:** Content folder structure with version paths

- Current: `/content/` serves v0.0.1
- Future: `/content/v0.1.0/`, `/content/v0.2.0/`, etc.
- Benefits: Simple, clear, version-specific content
- Version switcher updates `window.location.href` to version path

**Alternative considered:** Git branches (more complex deployment)

### DartPad Integration

**Approach:** Official DartPad embeds via iframe

- Use `dartpad.dev/embed-flutter.html` with gist IDs
- Secure: Sandboxed iframes with proper CSP
- Reliable: Hosted by Google/Dart team
- Theme-aware: Support light/dark modes

**Requirements:**
- Create GitHub gists for each example
- Update gist IDs in DartPadEmbed components
- Consider creating organization account for gists

### API Documentation Format

**Approach:** Manual structured tables via ApiTable component

- Consistent formatting across all components
- Type-safe with JSX
- Easy to maintain in MDX
- Good for small API surface (4 components)

**Alternative considered:** Auto-generated from Dart docs (overkill for 4 components)

### Search Configuration

**Settings:**
```js
search: {
  codeblocks: false  // Don't index code, focus on explanatory text
}
```

**Rationale:**
- Reduces index size
- Improves search relevance
- Code examples are illustrative, not searchable content

### Content Organization

**Structure:**
- **Shallow navigation:** Max 2 levels deep
- **Logical grouping:** Components, Architecture, Examples separate
- **Progressive disclosure:** Start simple (Getting Started) → Advanced (Architecture)

---

## DartPad Gist Setup

### Required Gists

Create the following GitHub gists with Primitive UI examples:

1. **Full Demo** (`full-demo-gist-id`)
   - All components in one playground
   - Pre-imported primitive_ui
   - Interactive settings panel example

2. **PrimitiveCard** (`primitive-card-gist-id`)
   - Various elevation examples
   - Border radius variations
   - Color customizations

3. **PrimitiveToggleSwitch** (`toggle-switch-gist-id`)
   - Basic toggle
   - Custom colors
   - Multiple switches

4. **VStack** (`vstack-gist-id`)
   - Different alignments
   - Spacing variations
   - Nested layouts

5. **ZStack** (`zstack-gist-id`)
   - Simple layering
   - Badge example
   - Complex overlays

### Gist Format

Each gist should contain:
```
main.dart           # Main Flutter code
analysis_options.yaml  # Optional: linter config
pubspec.yaml        # Dependencies (if needed)
```

---

## Content Migration Checklist

Transform existing documentation into MDX:

- [ ] `content/index.mdx` - Landing page with overview
- [ ] `content/getting-started.mdx` - Quick start guide
- [ ] `content/installation.mdx` - Detailed installation
- [ ] `content/components/primitive-card.mdx` - Full API + examples
- [ ] `content/components/primitive-toggle-switch.mdx` - Full API + examples
- [ ] `content/components/vstack.mdx` - Full API + examples
- [ ] `content/components/zstack.mdx` - Full API + examples
- [ ] `content/architecture/primitives-explained.mdx` - Design philosophy
- [ ] `content/architecture/rendering-pipeline.mdx` - How rendering works
- [ ] `content/architecture/layout-system.mdx` - Layout algorithm
- [ ] `content/architecture/design-decisions.mdx` - Trade-offs & rationale
- [ ] `content/examples/basic-usage.mdx` - Simple examples
- [ ] `content/examples/advanced-patterns.mdx` - Complex patterns
- [ ] `content/examples/real-world-apps.mdx` - Practical applications
- [ ] `content/playground.mdx` - Interactive playgrounds
- [ ] `content/api-reference.mdx` - Complete API documentation
- [ ] `content/troubleshooting.mdx` - Common issues
- [ ] `content/faq.mdx` - FAQs

---

## Deployment Checklist

Before deploying to Vercel:

- [ ] Install all dependencies
- [ ] Build successfully locally (`npm run build`)
- [ ] Test production build (`npm run start`)
- [ ] Verify search works (check `public/_pagefind/` exists)
- [ ] Update GitHub repository URL in layout
- [ ] Update DartPad gist IDs
- [ ] Test on mobile viewport
- [ ] Verify dark mode works
- [ ] Check all internal links
- [ ] Review SEO metadata
- [ ] Test version switcher
- [ ] Commit and push to GitHub
- [ ] Import to Vercel
- [ ] Verify deployment
- [ ] Test production URL

---

## Future Enhancements

### Phase 2 (Post v0.0.1)

- [ ] Add video tutorials
- [ ] Create animated GIFs for components
- [ ] Add downloadable example projects
- [ ] Implement "Copy to clipboard" for all code blocks
- [ ] Add component preview images
- [ ] Create comparison table: Primitive UI vs Flutter widgets

### Phase 3 (Post v0.1.0)

- [ ] Add search analytics to track popular queries
- [ ] Implement feedback widget on pages
- [ ] Create interactive component configurator
- [ ] Add performance benchmarks
- [ ] Multi-language support (if international interest)

---

## Resources

- **Nextra Documentation:** https://nextra.site
- **Next.js App Router:** https://nextjs.org/docs/app
- **DartPad:** https://dartpad.dev
- **Pagefind:** https://pagefind.app
- **Vercel Deployment:** https://vercel.com/docs

---

## Support

**Project:** TDDC73 - Interaction Programming  
**Institution:** Linköping University  
**Year:** 2025  
**License:** MIT

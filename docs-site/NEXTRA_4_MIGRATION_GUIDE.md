Here is the markdown content for the "Nextra 4 x App Router" blog post from The Guild:

# Nextra 4 x App Router. What's New and Migration Guide

**By Dimitri POSTOLOV** *Sunday, Jan 12th 2025*

Nextra 4 just released, marking the largest update in its history, with a ton of exciting improvements. Here's what's new:

## App Router Support

Nextra 4 exclusively uses Next.js App Router. Support for the Pages Router has been discontinued. In Nextra 4, there are two ways to render MDX files using file-based routing:

1.  **Content directory convention**: Using a catch-all route which loads MDX files from the specific directory.
2.  **Page file convention**: Follows Next.js App Router convention with enhanced page extensions: `page.{md,mdx}`.

### Trade-offs

  * The catch-all route route may lead to longer compilation times, depending on the number of MDX files.
  * The page file convention works well with colocation, allowing you to keep all the assets for an article in one place.

## Using Content Directory Convention

Migrate your Pages Router site with minimal changes using this mode. Follow these steps:

1.  **Rename your `pages` folder to `content`**
    You can keep `content` directory in root of your project, or in `src` directory.

2.  **Set `contentDirBasePath` option in `next.config` file (optional)**
    If you want to serve your content from a different path, you can set `contentDirBasePath` option:

    ```js
    // next.config.mjs
    import nextra from 'nextra'

    const withNextra = nextra({
      contentDirBasePath: '/docs' // Or even nested e.g. `/docs/advanced`
    })
    ```

3.  **Add `[[...mdxPath]]/page.jsx` file**
    Place this file in `app` directory with the following content, you should get the following structure:

    ```text
    app
      layout.jsx
      [[...mdxPath]]
        page.jsx
    content
      index.mdx
      docs
        index.mdx
        getting-started.mdx
    ```

> **Tip**: Consider the single catch-all route `[[...mdxPath]]/page.jsx` as a gateway to your content directory. If you set `contentDirBasePath` option in `next.config` file, you should put `[[...mdxPath]]/page.jsx` in the corresponding directory.

**You are ready to go\!**

> **Note**: Many existing solutions such as "Refreshing the Next.js App Router When Your Markdown Content Changes" rely on extra dependencies like `concurrently` and `ws`. These approaches include Dan Abramov workaround with `<AutoRefresh>` component and dev web socket server.

Nextra's content mode delivers a streamlined solution right out of the box:

  * you don't need to install unnecessary dependencies
  * you don't need to restart your server on changes in `content` directory
  * hot reloading works out of the box
  * you can use import statements in MDX files and static images works as well

Checkout [Nextra's docs website](https://nextra.site) and [i18n website example](https://www.google.com/search?q=https://github.com/shuding/nextra/tree/main/examples/docs-i18n).

## Using Page File Convention

The above file-based routing structure, following the [Using Content Directory Convention](https://www.google.com/search?q=%23using-content-directory-convention), will appear as follows when using this mode:

```text
app
  layout.jsx
  page.jsx
  docs
    page.mdx
    getting-started
      page.mdx
```

> **Warning**: All pages `page.{jsx,tsx}` should export `metadata` object.

> **Note**: See Nextra's website or Nextra's blog example as an examples of this mode.

## Turbopack Support

After being one of our most requested features for over 2 years, Nextra 4 finally supports Turbopack, the Rust-based incremental bundler. Enable it by adding `--turbopack` to your dev command:

```json
// package.json
"scripts": {
-  "dev": "next dev"
+  "dev": "next dev --turbopack"
}
```

> **Note**: Without `--turbopack` flag Next.js under the hood uses Webpack, written in JavaScript.

> **Warning**: At the time of writing this blog only JSON serializable values can be passed to `nextra` function. You cannot pass custom `remarkPlugins`, `rehypePlugins` or `recmaPlugins` since they are functions.

```js
// next.config.mjs
import nextra from 'nextra'
 
const withNextra = nextra({
  mdxOptions: {
    remarkPlugins: [myRemarkPlugin],
    rehypePlugins: [myRehypePlugin],
    recmaPlugins: [myRecmaPlugin]
  }
})
```

If you try to pass them, you'll get an error from Turbopack:
`Error: loader nextra/loader for match "./{src/app,app}/**/page.{md,mdx}" does not have serializable options. Ensure that options passed are plain JavaScript objects and values.`

## Discontinuing `theme.config` Support

Nextra 4 no longer support `theme.config` files, which were previously used for configuring your theme options, `theme` and `themeConfig` option were removed too:

```js
// next.config.mjs
const withNextra = nextra({
-  theme: 'nextra-theme-docs',
-  themeConfig: './theme.config.tsx'
})
```

> **Note**: Previously theme config options now should be passed as props for `<Layout>`, `<Navbar>`, `<Footer>`, `<Search>` and `<Banner>` components in `app/layout.jsx` file.

## New Search Engine – Pagefind

The search engine has been migrated from FlexSearch, which is written in JavaScript to the Rust-powered Pagefind.

### Benefits

Pagefind is significantly faster and delivers far superior search results compared to FlexSearch. Here are some examples that didn't work in earlier versions of Nextra:

1.  **Indexing remote MDX.**

    ```jsx
    // page.mdx
    import { Callout } from 'nextra/components'

    export async function Stars() {
      const response = await fetch('https://api.github.com/repos/shuding/nextra')
      const repo = await response.json()
      const stars = repo.stargazers_count
      return <b>{stars}</b>
    }

    export async function getUpdatedAt() {
      const response = await fetch('https://api.github.com/repos/shuding/nextra')
      const repo = await response.json()
      const updatedAt = repo.updated_at
      return new Date(updatedAt).toLocaleDateString()
    }

    <Callout emoji="🏆">
      {/* Stars count will be indexed 🎉 */}
      Nextra has <Stars /> stars on GitHub!

      {/* Last update time will be indexed 🎉 */}
      Last repository update _ {await getUpdatedAt()} _.
    </Callout>
    ```

2.  **Indexing dynamic content written in Markdown/MDX.**

    ```jsx
    // page.mdx
    {/* Current year will be indexed 🎉 */}
    MIT {new Date().getFullYear()} © Nextra.
    ```

3.  **Indexing imported JavaScript or MDX files in MDX page.**

    ```jsx
    // ../path/to/your/reused-js-component.js
    export function ReusedJsComponent() {
      return <strong>My content will be indexed</strong>
    }
    ```

    ```mdx
    // ../path/to/your/reused-mdx-component.mdx
    **My content will be indexed as well**
    ```

    ```mdx
    // page.mdx
    import { ReusedJsComponent } from '../path/to/your/reused-js-component.js'
    import ReusedMdxComponent from '../path/to/your/reused-mdx-component.mdx'

    <ReusedJsComponent />
    <ReusedMdxComponent />
    ```

4.  **Indexing static pages written in JavaScript or TypeScript.**
    For JavaScript/TypeScript pages you need to add `data-pagefind-body` attribute to the tag enclosing the main content area you want indexed. You can ignore indexing of specific tags by adding `data-pagefind-ignore` attribute.

    ```jsx
    // page.jsx
    export default function Page() {
      return (
        // All content of tags with `data-pagefind-body` attribute will be indexed
        <ul data-pagefind-body>
          <li>Nextra 4 is the best MDX Next.js library</li>
          {/* Except for tags with `data-pagefind-ignore` attribute */}
          <li data-pagefind-ignore>Nextra 3 is the best MDX Next.js library</li>
        </ul>
      )
    }
    ```

> **Tip**: For MDX pages while using `nextra-theme-docs` and `nextra-theme-blog` you don't need to add `data-pagefind-body` attribute.

### Setup

New search engine requires few steps to setup:

1.  **Install `pagefind` as a dev dependency**

    ```bash
    npm i -D pagefind
    # or
    pnpm add -D pagefind
    # or
    yarn add --dev pagefind
    # or
    bun add --dev pagefind
    ```

2.  **Add a postbuild script**
    Pagefind indexes `.html` pages and search indexing should be done after building your application:

    *Server builds:*

    ```json
    "scripts": {
      "postbuild": "pagefind --site .next/server/app --output-path public/_pagefind"
    }
    ```

    *Static exports:*

    ```json
    "scripts": {
      "postbuild": "pagefind --site .next/server/app --output-path out/_pagefind"
    }
    ```

3.  **Enable pre / post scripts (optional)**
    Some package managers like `pnpm@8` by default don't execute pre/post scripts, you should enable it via `.npmrc` file via `enable-pre-post-scripts` setting:

    ```ini
    enable-pre-post-scripts=true
    ```

    > **Note**: `pnpm@9` by default run pre / post scripts.

4.  **Add `_pagefind/` directory to `.gitignore` file**
    You don't need to commit `_pagefind/` directory to your Git repository, as it is always newly generated.

    ```gitignore
    node_modules/
    .next/
    _pagefind/
    ```

5.  **Use `<Search>` component in your custom theme**
    Search from `nextra-theme-docs` was exported in `nextra/components`. With this change `nextra-theme-blog` now also supports search. You can take advantage of this feature as well in your custom themes.

    ```jsx
    // app/layout.jsx
    import { Search } from 'nextra/components'

    export function RootLayout({ children }) {
      return (
        <html>
          <body>
            <header>
              <Search />
            </header>
            <main>{children}</main>
          </body>
        </html>
      )
    }
    ```

## RSC I18n Support

Thanks to server components, we no longer need to ship to client translation dictionary files, e.g `./dictionaries/en.json`. We can dynamically load translations in server components and pass according translation as props to `<Layout>`, `<Banner>`, `<Footer>`, etc. components in `app/[lang]/layout.jsx`.

Below is an example of server components i18n using `nextra-theme-docs`, but the same approach should be applied to your custom theme:

```jsx
// app/[lang]/layout.jsx
import { Footer, LastUpdated, Layout, Navbar } from 'nextra-theme-docs'
import { Banner, Head, Search } from 'nextra/components'
import { getPageMap } from 'nextra/page-map'
import { getDictionary, getDirection } from '../path/to/your/get-dictionary'
// Required for theme styles, previously was imported under the hood
import 'nextra-theme-docs/style.css'

export const metadata = {
  // ... your metadata API
  // https://nextjs.org/docs/app/building-your-application/optimizing/metadata
}

export default async function RootLayout({ children, params }) {
  const { lang } = await params
  const pageMap = await getPageMap(lang)
  const direction = getDirection(lang)
  const dictionary = await getDictionary(lang)
  
  return (
    <html
      lang={lang}
      // Required to be set
      dir={direction}
      // Suggested by `next-themes` package https://github.com/pacocoursey/next-themes#with-app
      suppressHydrationWarning
    >
      <Head />
      <body>
        <Layout
          banner={<Banner storageKey="some-key">{dictionary.banner}</Banner>}
          docsRepositoryBase="https://github.com/shuding/nextra/blob/main/examples/swr-site"
          editLink={dictionary.editPage}
          feedback={{ content: dictionary.feedback }}
          footer={<Footer>{dictionary.footer}</Footer>}
          i18n={[
            { locale: 'en', name: 'English' },
            { locale: 'fr', name: 'Français' },
            { locale: 'ru', name: 'Русский' }
          ]}
          lastUpdated={<LastUpdated>{dictionary.lastUpdated}</LastUpdated>}
          navbar={<Navbar logo={<MyLogo />} />}
          pageMap={pageMap}
          search={
            <Search
              emptyResult={dictionary.searchEmptyResult}
              errorText={dictionary.searchError}
              loading={dictionary.searchLoading}
              placeholder={dictionary.searchPlaceholder}
            />
          }
          themeSwitch={{
            dark: dictionary.dark,
            light: dictionary.light,
            system: dictionary.system
          }}
          toc={{
            backToTop: dictionary.backToTop,
            title: dictionary.tocTitle
          }}
        >
          {children}
        </Layout>
      </body>
    </html>
  )
}
```

Where `get-dictionary` file may looks like:

```js
// ../path/to/your/get-dictionary.js
// Ensure this file is always called in server component
import 'server-only'
 
// Enumerate all dictionaries
const dictionaries = {
  en: () => import('./en.json'),
  fr: () => import('./fr.json'),
  ru: () => import('./ru.json')
}
 
export async function getDictionary(locale) {
  const { default: dictionary } = await (dictionaries[locale] || dictionaries.en)()
  return dictionary
}
 
export function getDirection(locale) {
  switch (locale) {
    case 'he':
      return 'rtl'
    default:
      return 'ltr'
  }
}
```

> **Note**: Read more about server components i18n in [Next.js docs](https://nextjs.org/docs). See working example of i18n website in [Nextra's examples](https://www.google.com/search?q=https://github.com/shuding/nextra/tree/main/examples).

## Enhanced by React Compiler

The source code for `nextra`, `nextra-theme-docs` and `nextra-theme-blog` has been optimized using the [React Compiler](https://react.dev/learn/react-compiler). All Nextra's components and hooks are optimized under the hood by React Compiler and all internal usages of `useCallback`, `useMemo` and `memo` were removed.

## GitHub Alert Syntax

`nextra-theme-docs` and `nextra-theme-blog` support replacing GitHub alert syntax with `<Callout>` component for `.md` / `.mdx` files.

```markdown
> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.
```

## Migration Guide

### Dynamic `<head>` Tags

In Nextra 3 you were able to use `<Head>` component in any MDX page to add custom tags to `<head>`. In Nextra 4 you should use [Next.js Metadata API](https://nextjs.org/docs/app/building-your-application/optimizing/metadata) for static tags or `useHead` hook for dynamic tags.

### `nextra-theme-blog` Changes

`nextra-theme-blog` now supports `_meta` files, similar to `nextra-theme-docs`.

### Support for `_meta` Files

`_meta.json` was renamed to `_meta.js` (or `_meta.ts` / `_meta.jsx` / `_meta.tsx`). It now supports JSX\!

#### `_meta.global` File

You can now define a `_meta.global` file in the root of your content directory to define global configuration for all pages.

### Component Migration: Moving UI Elements

In Nextra 4, many components have been moved or their implementation details have changed (Client vs Server).

| Component | Type |
| :--- | :--- |
| `<Banner>` | server |
| `<Bleed>` | server |
| `<Button>` | client |
| `<Playground>` | client |
| `<Popup>` / `<Popup.Button>` / `<Popup.Panel>` | client |
| `<Search>` | client |
| `<Tabs>` / `<Tabs.Tab>` | client |
| `<Steps>` | server |
| `<MDXRemote>` (previous `<RemoteContent>`) | server |

### Migrate `theme.config` options

| Nextra 3 | Nextra 4 |
| :--- | :--- |
| `chat.link` | `chatLink` prop in `<Navbar>` |
| `components` | Removed. Provide custom components inside `useMDXComponents` function |
| `darkMode` | `darkMode` prop in `<Layout>` |
| `feedback.labels` | `feedback.labels` prop in `<Layout>` |
| `feedback.useLink` | Removed |
| `footer.component` | `footer` prop in `<Layout>` |
| `footer.content` | `children` prop in `<Footer>` |
| `gitTimestamp` | `lastUpdated` prop in `<Layout>` |
| `head` | Removed. Use `<Head>` or Next.js Metadata API |
| `logo` | `logo` prop in `<Navbar>` |
| `logoLink` | `logoLink` prop in `<Navbar>` |
| `main` | Removed |
| `project.link` | `projectLink` prop in `<Navbar>` |
| `search.component` | `search` prop in `<Layout>` |
| `search.emptyResult` | `emptyResult` prop in `<Search>` |

### `useRouter` Removed

`useRouter` from `next/router` (Pages Router) was replaced by `useRouter`, `usePathname`, `useSearchParams` etc. from `next/navigation` (App Router).

### Bump Minimal Next.js to V14

Nextra 4 requires at least Next.js 14.

## Conclusion. Why Prefer Nextra 4 over Others?

Nextra 4 is a significant step forward for the framework, embracing the latest Next.js features like App Router, Server Components, and Turbopack. It offers better performance, improved developer experience, and a robust set of features for building documentation and blog sites.

## Next Steps

  * Check out the [Nextra 4 documentation](https://nextra.site).
  * Try out the [starters](https://www.google.com/search?q=https://github.com/shuding/nextra/tree/main/examples).
  * Join the [Discord community](https://www.google.com/search?q=https://discord.gg/graphql-hive).

## Credits

Huge thanks for Nextra sponsors:

  * GraphQL Hive – Open-source GraphQL platform
  * Speakeasy – SDKs & Terraform Providers for Your API
  * xyflow - Node Based UIs for React and Svelte

The Nextra 4 documentation is still a work in progress, and we need your help to improve it\! Check out the recent updates in this blog post, and feel free to submit your contribution PRs to improve Nextra docs.

-----

*This markdown was reconstructed from the web page content.*
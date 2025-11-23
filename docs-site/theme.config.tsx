import type { DocsThemeConfig } from 'nextra-theme-docs'

const config: DocsThemeConfig = {
  logo: (
    <div className="flex items-center gap-2">
      <span className="font-bold text-xl">Primitive UI</span>
      <span className="text-xs bg-blue-100 dark:bg-blue-900 px-2 py-1 rounded">
        v0.0.1
      </span>
    </div>
  ),
  project: {
    link: 'https://github.com/Berkay2002/TDDC73/tree/main/docs-site'
  },
  docsRepositoryBase: 'https://github.com/Berkay2002/TDDC73/tree/main/docs-site',
  useNextSeoProps() {
    return {
      titleTemplate: '%s – Primitive UI'
    }
  },
  head: (
    <>
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta property="og:title" content="Primitive UI" />
      <meta property="og:description" content="Flutter GUI library built from scratch" />
    </>
  ),
  footer: {
    component: (
      <footer className="w-full border-t py-8">
        <div className="mx-auto max-w-7xl px-4 text-center">
          <div className="flex flex-col items-center gap-2">
            <p>MIT {new Date().getFullYear()} © Primitive UI</p>
            <p className="text-xs text-gray-500">
              Created for TDDC73 - Interaction Programming at Linköping University
            </p>
          </div>
        </div>
      </footer>
    )
  },
  editLink: {
    component: null
  },
  feedback: {
    content: null
  },
  toc: {
    backToTop: true
  },
  sidebar: {
    defaultMenuCollapseLevel: 1,
    toggleButton: true
  }
}

export default config

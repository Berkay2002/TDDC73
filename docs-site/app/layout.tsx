import type { Metadata } from 'next'
import { Footer, Layout, Navbar } from 'nextra-theme-docs'
import { Head } from 'nextra/components'
import { getPageMap } from 'nextra/page-map'
import { VersionSwitcher } from '@/components/VersionSwitcher'
import { getLibraryVersion } from '@/lib/get-version'
import 'nextra-theme-docs/style.css'
import './globals.css'

export const metadata: Metadata = {
  title: 'Primitive UI - Flutter GUI Library',
  description: 'A Flutter GUI library built entirely using only CustomPaint, Canvas, GestureDetector, and custom render objects.',
  keywords: ['Flutter', 'UI Library', 'CustomPaint', 'Canvas', 'Primitive', 'Widgets'],
  authors: [{ name: 'Primitive UI Team' }],
  openGraph: {
    title: 'Primitive UI Documentation',
    description: 'Build Flutter UIs from primitive components',
    type: 'website'
  }
}

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

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const latestVersion = await getLibraryVersion()

  const navbar = (
    <Navbar
      logo={
        <div className="flex items-center">
          <span className="font-bold text-xl">Primitive UI</span>
          <span
            className="text-xs bg-blue-100 dark:bg-blue-900 px-2 py-1 rounded"
            style={{ marginLeft: '0.5rem' }}
          >
            v{latestVersion}
          </span>
        </div>
      }
      projectLink="https://github.com/Berkay2002/TDDC73/tree/main/project/primitive_ui"
    >
      <VersionSwitcher latestVersion={latestVersion} />
    </Navbar>
  )

  return (
    <html lang="en" dir="ltr" suppressHydrationWarning>
      <Head>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <body>
        <Layout
          navbar={navbar}
          footer={footer}
          pageMap={await getPageMap()}
          docsRepositoryBase="https://github.com/Berkay2002/TDDC73/tree/main/docs-site"
          editLink={null}
          feedback={{ content: null }}
          sidebar={{
            defaultMenuCollapseLevel: 1,
            toggleButton: true
          }}
          toc={{
            backToTop: true
          }}
        >
          {children}
        </Layout>
      </body>
    </html>
  )
}

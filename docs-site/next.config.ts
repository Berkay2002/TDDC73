import type { NextConfig } from 'next'
import nextra from 'nextra'
import { versions } from './lib/versions'

const withNextra = nextra({
  latex: true,
  defaultShowCopyCode: true,
  mdxOptions: {
    rehypePlugins: []
  }
})

const nextConfig: NextConfig = {
  images: {
    unoptimized: true
  },
  reactCompiler: true,
  pageExtensions: ['js', 'jsx', 'ts', 'tsx', 'md', 'mdx'],
  turbopack: {
    resolveAlias: {
      'next-mdx-import-source-file': './mdx-components.tsx'
    }
  },
  async rewrites() {
    return versions
      .filter((v) => v.destination)
      .map((v) => ({
        source: `${v.path}/:path*`,
        destination: `${v.destination}/:path*`
      }))
  }
}

export default withNextra(nextConfig)

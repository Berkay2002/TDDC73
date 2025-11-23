import type { NextConfig } from 'next'
import nextra from 'nextra'

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
  }
}

export default withNextra(nextConfig)

export interface Version {
  label: string
  value: string
  path: string
}

export const versions: Version[] = [
  { label: 'v0.0.2', value: '0.0.2', path: '/docs' },
  { label: 'v0.0.1', value: '0.0.1', path: 'https://v0-0-1.primitive-ui.vercel.app/docs' },
]

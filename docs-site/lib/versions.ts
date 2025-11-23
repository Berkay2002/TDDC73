export interface Version {
  label: string
  value: string
  path: string
}

export const versions: Version[] = [
  { label: 'v0.0.1', value: '0.0.1', path: '/docs' },
  // Future versions will be added here
  // { label: 'v0.1.0', value: '0.1.0', path: '/v0.1.0/docs' },
]

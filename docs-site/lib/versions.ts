export interface Version {
  label: string
  value: string
  path: string
  destination?: string
}

export const versions: Version[] = [
  { label: 'v0.0.2', value: '0.0.2', path: '/' },
  { 
    label: 'v0.0.1', 
    value: '0.0.1', 
    path: '/v0.0.1',
    // TODO: Replace with your actual Vercel deployment URL for this version
    // Example: https://tddc73-git-v0-0-1-yourusername.vercel.app
    destination: 'https://tddc73-git-v0-0-1-berkay-orhans-projects.vercel.app' 
  },
]

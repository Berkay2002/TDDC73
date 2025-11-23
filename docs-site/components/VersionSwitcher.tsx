'use client'

import { useState } from 'react'

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

export function VersionSwitcher() {
  const [currentVersion] = useState<Version>(versions[0])

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

'use client'

import { useState } from 'react'
import { Version, versions as defaultVersions } from '@/lib/versions'

interface VersionSwitcherProps {
  latestVersion?: string
}

export function VersionSwitcher({ latestVersion }: VersionSwitcherProps) {
  const versions = latestVersion
    ? [
        { label: `v${latestVersion}`, value: latestVersion, path: '/docs' },
        ...defaultVersions.filter(v => v.value !== latestVersion && v.path !== '/docs')
      ]
    : defaultVersions

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

'use client'

interface AppEmbedProps {
  src: string
  height?: number
  title?: string
}

export function AppEmbed({ 
  src, 
  height = 600,
  title = "Demo Application"
}: AppEmbedProps) {
  return (
    <div className="my-6 border rounded-lg overflow-hidden bg-gray-100 dark:bg-gray-900">
      <div className="bg-gray-200 dark:bg-gray-800 px-4 py-2 text-sm text-gray-600 dark:text-gray-400 border-b border-gray-300 dark:border-gray-700 flex justify-between items-center">
        <span>{title}</span>
        <a href={src} target="_blank" rel="noopener noreferrer" className="text-blue-500 hover:text-blue-600 text-xs">
          Open in new tab ↗
        </a>
      </div>
      <iframe
        src={src}
        className="w-full border-none"
        style={{ height: `${height}px` }}
        title={title}
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        sandbox="allow-scripts allow-same-origin allow-popups allow-forms"
      />
    </div>
  )
}

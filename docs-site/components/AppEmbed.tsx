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
    <div 
      className="my-6 rounded-lg overflow-hidden border"
      style={{ 
        borderColor: 'var(--nextra-border)',
        backgroundColor: 'var(--nextra-bg)' 
      }}
    >
      <div 
        className="px-4 py-2 text-sm flex justify-between items-center border-b"
        style={{ 
          backgroundColor: 'var(--nextra-bg-subtle)',
          borderColor: 'var(--nextra-border)',
          color: 'var(--nextra-text-secondary)' // Assuming this exists or falls back to text color
        }}
      >
        <span className="font-medium">{title}</span>
        <a 
          href={src} 
          target="_blank" 
          rel="noopener noreferrer" 
          className="text-primary hover:underline text-xs"
          style={{ color: 'var(--primary)' }}
        >
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


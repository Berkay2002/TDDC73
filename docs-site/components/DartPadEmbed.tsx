'use client'

interface DartPadEmbedProps {
  id: string
  height?: number
  theme?: 'dark' | 'light'
  run?: boolean
  split?: number
}

export function DartPadEmbed({ 
  id, 
  height = 500,
  theme = 'dark',
  run = true,
  split = 60 
}: DartPadEmbedProps) {
  const src = `https://dartpad.dev/embed-flutter.html?id=${id}&theme=${theme}&run=${run}&split=${split}`
  
  return (
    <div className="my-6">
      <iframe
        src={src}
        className="dartpad-embed"
        style={{ height: `${height}px` }}
        title={`DartPad Embed ${id}`}
        sandbox="allow-scripts allow-same-origin"
      />
    </div>
  )
}

'use client'

import React, { useState, useRef, useEffect } from 'react'

interface CollapsibleCodeProps extends React.HTMLAttributes<HTMLPreElement> {
  children?: React.ReactNode
  OriginalPre?: React.ComponentType<any>
}

export function CollapsibleCode({ OriginalPre, ...props }: CollapsibleCodeProps) {
  const [isExpanded, setIsExpanded] = useState(false)
  const [isOverflowing, setIsOverflowing] = useState(false)
  const contentRef = useRef<HTMLDivElement>(null)
  
  // Maximum height in pixels before truncation
  const MAX_HEIGHT = 300

  useEffect(() => {
    if (contentRef.current) {
      // Check if the scrollHeight is significantly larger than MAX_HEIGHT
      if (contentRef.current.scrollHeight > MAX_HEIGHT + 50) { // Add some buffer
        setIsOverflowing(true)
      }
    }
  }, [props.children])

  const PreComponent = OriginalPre || 'pre'

  return (
    <div className="relative my-4 group">
      <div
        ref={contentRef}
        className={`relative overflow-hidden transition-all duration-500 ease-in-out ${
          isExpanded ? 'max-h-none' : ''
        }`}
        style={{ 
          maxHeight: isExpanded ? undefined : `${MAX_HEIGHT}px` 
        }}
      >
        {/* Render the actual pre tag (or Nextra's Pre) with all original props */}
        <PreComponent {...props} className={`${props.className || ''} !mt-0 !mb-0`} />
      </div>

      {isOverflowing && (
        <div
          className={`absolute bottom-0 left-0 right-0 flex justify-center items-end pb-2 pt-12 transition-all duration-300 ${
            isExpanded 
              ? 'sticky bottom-0 pointer-events-none' 
              : 'bg-gradient-to-t from-[var(--nextra-bg)] to-transparent'
          }`}
        >
          <button
            onClick={() => setIsExpanded(!isExpanded)}
            className="pointer-events-auto text-xs font-medium px-4 py-1.5 rounded-full border shadow-sm backdrop-blur-md transition-colors hover:bg-[var(--nextra-bg-subtle)]"
            style={{
              backgroundColor: 'var(--nextra-bg)',
              color: 'var(--nextra-text-primary)',
              borderColor: 'var(--nextra-border)'
            }}
          >
            {isExpanded ? 'Show Less' : 'Show More'}
          </button>
        </div>
      )}
    </div>
  )
}
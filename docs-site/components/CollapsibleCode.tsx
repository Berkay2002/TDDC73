'use client'

import React, { useState, useRef, useEffect } from 'react'

interface CollapsibleCodeProps {
  children?: React.ReactNode
}

export function CollapsibleCode({ children }: CollapsibleCodeProps) {
  const [isExpanded, setIsExpanded] = useState(false)
  const [isOverflowing, setIsOverflowing] = useState(false)
  const contentRef = useRef<HTMLDivElement>(null)
  
  const MAX_HEIGHT = 300

  useEffect(() => {
    if (contentRef.current) {
      if (contentRef.current.scrollHeight > MAX_HEIGHT + 50) {
        setIsOverflowing(true)
      }
    }
  }, [children])

  return (
    <div className="relative my-4 group">
      <div
        ref={contentRef}
        className={`relative overflow-hidden transition-[max-height] duration-300 ease-in-out`}
        style={{ 
          maxHeight: isExpanded ? (contentRef.current?.scrollHeight || 'none') : `${MAX_HEIGHT}px`,
          maskImage: isExpanded || !isOverflowing 
            ? 'none' 
            : 'linear-gradient(to bottom, black calc(100% - 100px), transparent 100%)',
          WebkitMaskImage: isExpanded || !isOverflowing 
            ? 'none' 
            : 'linear-gradient(to bottom, black calc(100% - 100px), transparent 100%)'
        }}
      >
        {children}
      </div>

      {isOverflowing && !isExpanded && (
        <div className="absolute bottom-0 left-0 right-0 flex justify-center pb-4 z-10">
          <button
            onClick={() => setIsExpanded(true)}
            className="text-xs font-medium px-4 py-1.5 rounded-full border shadow-sm backdrop-blur-md transition-all hover:scale-105 active:scale-95"
            style={{
              backgroundColor: 'var(--nextra-bg)',
              color: 'var(--nextra-text-primary)',
              borderColor: 'var(--nextra-border)'
            }}
          >
            Show More
          </button>
        </div>
      )}

      {isOverflowing && isExpanded && (
        <div className="flex justify-center mt-2">
          <button
            onClick={() => setIsExpanded(false)}
            className="text-xs font-medium px-4 py-1.5 rounded-full border shadow-sm backdrop-blur-md transition-all hover:bg-[var(--nextra-bg-subtle)]"
            style={{
              backgroundColor: 'var(--nextra-bg)',
              color: 'var(--nextra-text-primary)',
              borderColor: 'var(--nextra-border)'
            }}
          >
            Show Less
          </button>
        </div>
      )}
    </div>
  )
}
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { BookOpen, ExternalLink, FileText } from 'lucide-react'

interface ReadingLink {
  title: string
  href: string
  external?: boolean
}

interface FurtherReadingProps {
  links: ReadingLink[]
}

export function FurtherReading({ links }: FurtherReadingProps) {
  return (
    <Card className="my-8 not-prose">
      <CardHeader>
        <CardTitle className="flex items-center gap-2 text-lg">
          <BookOpen className="h-5 w-5 text-primary" />
          Further Reading
        </CardTitle>
      </CardHeader>
      <CardContent>
        <ul className="space-y-3">
          {links.map((link, index) => (
            <li key={index} className="flex items-start gap-3 group">
              <span className="mt-1 shrink-0 transition-colors text-primary/70 group-hover:text-primary">
                {link.external ? (
                  <ExternalLink className="h-4 w-4" />
                ) : (
                  <FileText className="h-4 w-4" />
                )}
              </span>
              <a
                href={link.href}
                className="font-medium underline decoration-2 underline-offset-4 transition-colors text-primary hover:text-primary/80 decoration-primary/30 hover:decoration-primary"
                target={link.external ? '_blank' : undefined}
                rel={link.external ? 'noopener noreferrer' : undefined}
              >
                {link.title}
              </a>
            </li>
          ))}
        </ul>
      </CardContent>
    </Card>
  )
}

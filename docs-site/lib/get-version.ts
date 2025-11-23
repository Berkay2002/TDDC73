import fs from 'node:fs/promises'
import path from 'node:path'

export async function getLibraryVersion(): Promise<string> {
  try {
    // Attempt to find the pubspec.yaml file relative to the project root
    // Assuming process.cwd() is the docs-site directory
    const pubspecPath = path.resolve(process.cwd(), '../project/primitive_ui/pubspec.yaml')
    
    const content = await fs.readFile(pubspecPath, 'utf-8')
    const match = content.match(/^version:\s*([\d.]+)/m)
    
    if (match && match[1]) {
      return match[1]
    }
  } catch (error) {
    // Silently fail and return default in case of path issues
    console.warn('Warning: Could not read library version from pubspec.yaml')
  }
  
  return '0.0.1'
}

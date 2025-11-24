/* eslint-disable import/no-anonymous-default-export */
export default {
  index: {
    title: 'Primitive UI',
    display: 'hidden'
  },
  _: {
    type: 'separator',
    title: 'Overview'
  },
  'getting-started': 'Getting Started',
  accessibility: 'Accessibility',
  releases: 'Releases',
  _2: {
    type: 'separator',
    title: 'Components'
  },
  components: {
    title: 'Components',
      items: {
        'custom-card': { title: 'CustomCard' },
        'h-stack': { title: 'HStack' },
        'v-stack': { title: 'VStack' },
        'z-stack': { title: 'ZStack' },
        'primitive-button': { title: 'PrimitiveButton' },
      }
  },
  examples: {
    title: 'Examples',
    items: {
      'basic-usage': 'Basic Usage',
      'advanced-patterns': 'Advanced Patterns'
    }
  },
  architecture: {
    title: 'Architecture',
    items: {
      'primitives-explained': 'Primitives Explained',
      'rendering-pipeline': 'Rendering Pipeline',
      'design-decisions': 'Design Decisions'
    }
  }
}

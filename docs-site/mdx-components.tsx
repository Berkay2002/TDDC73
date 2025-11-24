import { useMDXComponents as getThemeComponents } from 'nextra-theme-docs'
import { CollapsibleCode } from './components/CollapsibleCode'

const themeComponents = getThemeComponents()

export function useMDXComponents(components?: any) {
  return {
    ...themeComponents,
    ...components,
    pre: (props: any) => <CollapsibleCode {...props} OriginalPre={themeComponents.pre} />,
  }
}

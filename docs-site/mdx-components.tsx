import { useMDXComponents as getThemeComponents } from 'nextra-theme-docs'
import { CollapsibleCode } from './components/CollapsibleCode'

const themeComponents = getThemeComponents()

export function useMDXComponents(components?: any) {
  return {
    ...themeComponents,
    ...components,
    pre: (props: any) => (
      <CollapsibleCode>
        <themeComponents.pre 
          {...props} 
          className={`${props.className || ''} !mt-0 !mb-0`} 
        />
      </CollapsibleCode>
    ),
  }
}

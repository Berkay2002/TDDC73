interface ApiParameter {
  name: string
  type: string
  required: boolean
  default?: string | null
  description: string
}

interface ApiTableProps {
  parameters: ApiParameter[]
}

export function ApiTable({ parameters }: ApiTableProps) {
  return (
    <div className="overflow-x-auto my-6">
      <table className="api-table">
        <thead>
          <tr>
            <th>Parameter</th>
            <th>Type</th>
            <th>Required</th>
            <th>Default</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          {parameters.map((param, index) => (
            <tr key={index}>
              <td><code>{param.name}</code></td>
              <td><code>{param.type}</code></td>
              <td>{param.required ? '✓' : '✗'}</td>
              <td><code>{param.default || '—'}</code></td>
              <td>{param.description}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

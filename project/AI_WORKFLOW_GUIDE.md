# AI Agent Workflow Guide: Adding New Components

This guide outlines the standard operating procedure for AI agents when adding new components to the `primitive_ui` ecosystem. Follow these steps sequentially to ensure consistency across the library, documentation, and demo application.

## Context & Structure

The workspace consists of three main parts relevant to this workflow:
1.  **`project/primitive_ui/`**: The core Flutter package containing the component logic.
2.  **`docs-site/`**: The Next.js/Nextra documentation website.
3.  **`project/primitive_demo/`**: The Flutter example application showcasing the components.

---

## Phase 1: Component Implementation (`primitive_ui`)

**Goal**: Create the core logic and expose it.

1.  **Create Component File**:
    *   Location: `project/primitive_ui/lib/src/components/<component_name>.dart`
    *   Naming: Use `snake_case` for filenames (e.g., `h_stack.dart`) and `PascalCase` for classes (e.g., `HStack`).

2.  **Implement Logic**:
    *   **For Layouts**: Extend `MultiChildRenderObjectWidget` and create a custom `RenderBox`. Avoid using high-level widgets like `Row`, `Column`, `Flex`, `Stack` (unless wrapping them is the specific goal, but usually we build from primitives).
    *   **For Visuals**: Use `CustomPaint` or specific `RenderBox` painting logic.
    *   **Style**: Follow existing patterns in `v_stack.dart` or `custom_card.dart`.

3.  **Export Component**:
    *   Edit: `project/primitive_ui/lib/primitive_ui.dart`
    *   Action: Add `export 'src/components/<component_name>.dart';`

---

## Phase 2: Verification (`primitive_ui`)

**Goal**: Ensure the component works as expected before documenting.

1.  **Create Test File**:
    *   Location: `project/primitive_ui/test/<component_name>_test.dart`
    *   Content: Use `testWidgets`. Verify rendering, layout properties (spacing, alignment), and interaction if applicable.

2.  **Run Tests**:
    *   Command: `flutter test test/<component_name>_test.dart`
    *   *Critical*: Fix any failures before proceeding.

---

## Phase 3: Library Metadata (`primitive_ui`)

**Goal**: Prepare the package for release.

1.  **Update `pubspec.yaml`**:
    *   Increment the `version` (e.g., `0.0.2` -> `0.0.3`).

2.  **Update `CHANGELOG.md`**:
    *   Add a new section for the version.
    *   List the new component and any other changes.

3.  **Update `README.md`**:
    *   Add the new component to the "Available Components" list.
    *   Provide a brief code snippet example.

---

## Phase 4: Documentation Site (`docs-site`)

**Goal**: Update the external documentation.

1.  **Create Documentation Page**:
    *   Location: `docs-site/app/(docs)/components/<component-name>/page.mdx`
    *   Template:
        ```mdx
        ---
        title: <ComponentName>
        description: <Short description>
        ---

        import { Callout, Tabs } from 'nextra/components'
        import { ApiTable } from '@/components/ApiTable'

        # <ComponentName>

        <Overview text>

        ## Basic Usage
        <Dart code block>

        ## API Reference
        <Constructor and ApiTable>

        ## Examples
        <Usage examples>

        ## Implementation Details
        <Explanation of RenderBox/Logic>
        ```

2.  **Update Component Index**:
    *   Edit: `docs-site/app/(docs)/components/page.mdx`
    *   Action: Add the new component to the appropriate category list.

3.  **Update Navigation**:
    *   Edit: `docs-site/app/(docs)/_meta.global.js`
    *   Action: Add the component ID and Title to the `components` -> `items` object. Ensure it is sorted alphabetically or logically.

---

## Phase 5: Demo Application (`primitive_demo`)

**Goal**: Add a visual demo to the example app.

1.  **Create Demo Page**:
    *   Location: `project/primitive_demo/lib/demos/<component_name>_demo.dart`
    *   Content: A `StatelessWidget` or `StatefulWidget` that uses the new component in various configurations (knobs/controls are a plus).

2.  **Register Demo**:
    *   Edit: `project/primitive_demo/lib/main.dart` (or wherever the route/list is defined).
    *   Action: Add a navigation entry for the new demo page.

---

## Checklist for Agents

- [ ] Component implemented in `lib/src/components/`
- [ ] Component exported in `lib/primitive_ui.dart`
- [ ] Tests passed in `test/`
- [ ] `pubspec.yaml` version bumped
- [ ] `CHANGELOG.md` updated
- [ ] `README.md` updated
- [ ] `docs-site` MDX page created
- [ ] `docs-site` navigation (`_meta.global.js`) updated
- [ ] `primitive_demo` page created and registered

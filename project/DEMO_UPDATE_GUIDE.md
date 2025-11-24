# AI Agent Workflow Guide: Updating Demos & Snippets

This guide outlines the standard operating procedure for creating, updating, and deploying Flutter demo snippets to the documentation site. Follow these steps to ensure that interactive demos render correctly and seamlessly within the Nextra documentation.

## Context & Structure

*   **`project/primitive_demo/`**: The Flutter application containing the source code for all demos and snippets.
*   **`docs-site/public/demo/`**: The location where the compiled Flutter Web app resides to be served by the documentation site.
*   **`docs-site/components/AppEmbed.tsx`**: The React component used to embed the Flutter app into MDX pages.

---

## Phase 1: Create the Snippet (`primitive_demo`)

**Goal**: Create a focused, isolated example of a component or pattern.

1.  **Edit Snippets File**:
    *   Location: `project/primitive_demo/lib/snippets.dart`
    *   Action: Create a new `StatelessWidget` or `StatefulWidget`.
    *   **Guideline**: Keep it simple. Focus on the specific feature. Use `CustomPositioned` instead of standard `Positioned` if inside a `ZStack`.

    ```dart
    class MyNewFeatureSnippet extends StatelessWidget {
      const MyNewFeatureSnippet({super.key});
      @override
      Widget build(BuildContext context) {
        return Center(
          child: CustomCard(child: Text('My Feature')),
        );
      }
    }
    ```

---

## Phase 2: Register the Route (`primitive_demo`)

**Goal**: Expose the snippet via a specific URL route.

1.  **Edit Main File**:
    *   Location: `project/primitive_demo/lib/main.dart`
    *   Action: Add a named route to the `routes` map in `PrimitiveUIDemo`.

2.  **CRITICAL: Transparent Background**:
    *   You **MUST** wrap the snippet in a `Scaffold` with `backgroundColor: Colors.transparent`.
    *   This ensures the documentation site's theme background (light/dark) is visible behind the component, making it look integrated.

    ```dart
    routes: {
      // ... existing routes
      '/snippet/my_new_feature': (context) => const Scaffold(
        backgroundColor: Colors.transparent, // <--- CRITICAL
        body: MyNewFeatureSnippet(),
      ),
    },
    ```

---

## Phase 3: Build and Deploy

**Goal**: Compile the Flutter app and move artifacts to the docs site.

1.  **Run Deployment Script**:
    *   Command: `./deploy_demo.sh` (from the repository root).
    *   **What this does**:
        1.  Builds `project/primitive_demo` for web (`flutter build web --release`).
        2.  Copies the build output to `docs/primitive_demo_web` (legacy/backup).
        3.  **Note**: You currently need to manually copy to the `docs-site` public folder as well (see step 2).

2.  **Sync to Docs Site**:
    *   Command: `cp -r docs/primitive_demo_web/* docs-site/public/demo/`
    *   *Self-Correction*: The `deploy_demo.sh` might be updated in the future to do this automatically. Always check if the files in `docs-site/public/demo/` are updated.

---

## Phase 4: Configure HTML (`docs-site`)

**Goal**: Ensure the Flutter app loads correctly in the embedded iframe.

1.  **Edit Index HTML**:
    *   Location: `docs-site/public/demo/index.html`
    *   **Action 1 (Base HREF)**: Set `<base href="./">`.
        *   Why: This allows the Flutter app to load assets (main.dart.js, fonts) relative to its current location (`/demo/`), regardless of the parent domain.
    *   **Action 2 (Transparent Body)**: Set the body background to transparent.
        *   Why: Standard Flutter HTML sets a white background. We want it transparent so the `Scaffold` transparency works.

    ```html
    <head>
      <!-- ... -->
      <base href="./"> <!-- REQUIRED -->
    </head>
    <body style="background-color: transparent"> <!-- REQUIRED -->
      <script src="flutter_bootstrap.js" async></script>
    </body>
    ```

---

## Phase 5: Embed in Documentation

**Goal**: Display the snippet in an MDX page.

1.  **Use `AppEmbed`**:
    *   Import: `import { AppEmbed } from '@/components/AppEmbed'`
    *   Usage: Point the `src` to `/demo/#/snippet/<your_route_name>`.
    *   **Note**: The `#` hash strategy is used by default in Flutter Web.

    ```mdx
    ## My Feature

    Here is a demo of the feature:

    <AppEmbed 
      src="/demo/#/snippet/my_new_feature" 
      title="My New Feature Demo"
      height={300}
    />

    ```

    *   **Internal Detail**: The `AppEmbed` component is configured to automatically rewrite `/demo/` to `/demo/index.html` to ensure the correct entry point is loaded.

---

## Checklist for Demos

- [ ] Snippet created in `snippets.dart`.
- [ ] Route registered in `main.dart` with `backgroundColor: Colors.transparent`.
- [ ] `flutter build web` executed.
- [ ] Artifacts copied to `docs-site/public/demo/`.
- [ ] `docs-site/public/demo/index.html` has `<base href="./">`.
- [ ] `docs-site/public/demo/index.html` has `<body style="background-color: transparent">`.
- [ ] `AppEmbed` used in MDX with correct `src` route.

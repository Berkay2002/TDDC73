# Projektuppgift: Bygg ditt eget GUI-bibliotek

### 1. Introduktion och Mål

Moderna ramverk som React-Native, Flutter och Jetpack Compose ger oss kraftfulla, färdiga komponenter för att snabbt bygga gränssnitt. Men hur fungerar dessa komponenter "under huven"? Hur hanteras layout, rendering och interaktion från grunden?

Målet med detta projekt är att ni ska få en djupare förståelse för dessa koncept genom att bygga ert eget, minimala GUI-bibliotek. Ni kommer att implementera grundläggande UI- och layout-komponenter från grunden med hjälp av de mest primitiva byggstenarna som ert valda ramverk erbjuder.

Projektet syftar till att utveckla er förståelse för:
* Komponentlivscykler och state management.
* Layout- och renderingsprocessen.
* Hantering av användarinteraktion (gester och events).
* Skapandet av återanvändbara och anpassningsbara API:er för komponenter.

### 2. Teknisk Stack

Välj **ett** av följande ramverk för att bygga ert bibliotek:
* **React-Native**
* **Flutter**
* **Kotlin (med Jetpack Compose)**

### 3. Kärnkrav

Ert bibliotek ska vara en återanvändbar modul/paket som kan importeras i en exempelapplikation. Biblioteket måste innehålla minst:

1. **Två (2) UI-komponenter:**
    * Dessa är de synliga element som användaren interagerar med.
    * Exempel: `Button`, `Card`, `InputField`, `ToggleSwitch`.

2. **Två (2) Layout-komponenter:**
    * Dessa är "osynliga" komponenter vars syfte är att strukturera och positionera sina barnkomponenter.
    * Exempel: `VStack` (eller `Column`), `HStack` (eller `Row`), `ZStack` (eller `Stack`), `Spacer`.

**Viktigast av allt:** Ni ska bygga dessa från grunden. Undvik att använda färdiga högnivåkomponenter som `Button`, `Scaffold`, `AppBar`, `Column`, `Row`, etc. från ramverket. Målet är att ni ska återskapa deras funktionalitet själva.

### 4. Tillåtna Primitiva Komponenter

För att ni ska kunna bygga från grunden men ändå ha en startpunkt, finns här en lista över de lågnivå-primitiv ni **får** använda för respektive ramverk. All annan funktionalitet ska ni bygga ovanpå dessa.

#### För React-Native:
* `View`: Den mest grundläggande komponenten för att skapa rektangulära ytor och agera som en container.
* `Text`: För att rendera text.
* `Pressable`: En lågnivå-komponent för att detektera olika stadier av press-interaktioner.
* `StyleSheet`: För att definiera styling (färger, marginaler, flexbox-regler etc.).

#### För Flutter:
* `CustomPaint` och `Canvas`: För att rita godtyckliga former direkt på skärmen.
* `GestureDetector`: En rå komponent för att fånga gester som tryck och drag.
* `CustomMultiChildLayout` (eller `Layout` i Compose): Ger er full kontroll över mätning och positionering av flera barn-widgets.

#### För Kotlin (Jetpack Compose):
* `Canvas`: En composable-funktion som ger er en rit-yta (`DrawScope`) för lågnivå-ritfunktioner.
* `Modifier.pointerInput`: En modifier för att fånga råa pek-events.
* `Layout`: Den mest grundläggande composable-funktionen för layout, som kräver att ni implementerar mät- och placeringslogik.

### 5. Förslag på komponenter att implementera

**UI-Komponenter:**
* **Button:** Ska kunna ha en text, hantera `onPress`-händelser och visuellt reagera på tryck.
* **Card:** En container med skugga, rundade hörn och padding.
* **InputField:** En rektangel som kan ta emot textinput.
* **ToggleSwitch:** En switch som kan vara i ett på/av-läge med en mjuk animation.

**Layout-Komponenter:**
* **VStack/Column:** Arrangerar sina barnkomponenter vertikalt, med stöd för `spacing` och `alignment`.
* **HStack/Row:** Arrangerar sina barnkomponenter horisontellt.
* **ZStack/Stack:** Placerar barnen ovanpå varandra i z-led (djup).

### 7. Inlämning

* En länk till ett Git-repository (t.ex. GitHub/GitLab) som innehåller:
    * Källkoden för ert bibliotek.
    * En enkel exempelapplikation som demonstrerar användningen av alla era komponenter.
* En kort `README.md`-fil som beskriver biblioteket, vilka designval ni gjort och hur man kör exempelapplikationen.
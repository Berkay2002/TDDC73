# Projekt - Mini SDK av Interaktionsmönster

Projektet går ut på att självständigt utforska olika interaktionsmönster på en lite djupare nivå för att sedan skapa ert eget SDK av två av mönstren. Projektinstruktionerna består av flera olika förslag på vad man kan välja att fördjupa sig i, det är upp till dig att välja uppgifter enligt betygskriterierna som står beskrivna nedan.

## Projektinstruktioner

Du ska implementera ditt eget SDK bestående av:

### Betygskriterier

Här beskrivs kriterier för det olika betygsstegen. Tänk på att det inte bara är kvantitativa skillnader mellan nivåerna utan även kvalitativa.

Det finns även ett exempelprojekt att hämta (baserat på swing) här och readme-fil här, projektet är tänkt att motsvara de kvalitativa kraven för betyg 5, så för lägre ställs inte riktigt samma krav på kodkvalité. (Prova att skriva "Hej" resp "Hejsan".)

### Betyg 3

Du skall på ett i huvudsak korrekt sätt implementera två interaktionsmönster med hjälp av valfritt ramverk. Med ett enkelt testprogram/applikation redogör du hur man använder er komponent (interaktionsmönster), observera att det ska vara tydlig skillnad mellan er generella komponent och den specifika tillämpningen i testprogrammet.

Du väljer själv vilka interaktionsmönster du vill implementera och inkludera i ditt SDK från [ui-patterns](http://ui-patterns.com/). De mönster du väljer att implementera ska vara icke-triviala mönster och där du bygger mestadels av UI-komponenterna själv, icke godkända är de finns som en färdig komponent i ditt ramverk. Är du osäker om något mönster är för trivialt kolla med kursansvarig (Anders).

För varje interaktionsmönster ska du tillhanda tillräckligt med data så att det är möjligt att visa hur mönstret är tänkt att fungera.

Du ska bygga din lösning (dina två interaktionsmönster) som ett eget SDK, tänkt bland annat på följande:
* Vad finns det för gemensamma del-komponenter?
* Behövs det stöd komponenter för att det ska fungera?
* Hur kan de båda komponenterna användas tillsammans?

Din kod skall vara effektiv nog för att implementationen skall kunna användas. Koden ska följa gängse konventioner och vara godtagbart kommenterad.

**Val av interaktionsmönster**
De flesta mönster går att välja, det viktiga är att ni står för implementation själva. Det vill säga ni kan välja att Module Tabs, men då får ni inta använda Androids TabHost för att lösa uppgiften. Tänk efter när ni bygger komponenten vad kan en annan programmerare vilja anpassa efter sina behov, kolla som exempel på hur android bygger upp sina mer komplexa komponenter (List/ExpandableListView), (Default modeller/adpater, Rendrerare för att beskriva utseende, anpassa algoritmer osv).

Nedan kommer finns några exempel på mönster som har varit ganska vanliga historiskt sett i kursen. (samt vissa punkter vad ni kan tänka på)

* **Password Strength Meter**
    * Hur byter man ut algoritmen för att avgöra hur starkt ett lösenord är
    * Hur kan jag välja att visualisera styrkan av ett lösenord
* **Carousel**
    * Hur många element ska visas samtidigt
    * Hur ska varje element visas, går det att byta ut
* **Inplace Editor**
    * Vilka element är editerbara, hur visas det
    * Kan du byta ut hur element editeras
* **Shopping cart**
    * Hur ser kundvagnen ut
    * Finns det olika vyer av kundvagnen(liten, kompakt, full), hur ser dom ut
* **Input feedback** (se Password Strength Meter)
* **Account Registration**
    * Vilken data ska finns om ett konto (och vilka data-typer)
    * Vilka fält ska vara obligatoriska
* **Steps Left**
    * Hur kan jag namnge steg
    * Hur kopplar jag information till varje steg (vad ska synas vid steg 2)

### Betyg 4:

För betyg 4 gäller att du gör allt som gäller för betyg 3 samt att du gör en av följande uppgifter:
1. Getting started guide för valfritt ramverk
2. UI Testing för en av dina Komponenter (se nedan)

### Betyg 5:

För betyg 5 gäller att du gör allt som gäller för betyg 3 samt att du gör både:
1. Getting started guide för valfritt ramverk
2. UI Testing för en av dina Komponenter (se nedan)

#### Getting started guide
Du ska skriva en Komma igång guide för ett av ramverken Kotlin för android, Flutter, eller React Native. Din guide ska vända sig till personer som redan kan programmera men som ej arbetet med ditt val av ramverk. Din guide ska täcka:
* Enkel Layout av komponenter/widgets
* Grundläggande interaktion med lyssnare/callbacks-functions
* Navigering mellan olika skärmar

#### UI Testing
Du utför UI testning av en av dina komponenter du har implementerat. Du ska använda dig av rekommenderade testnings verktyg för ditt ramverk (UI-Testing). Dina tester behöver inte vara heltäckande men du ska visa förståelse hur man bedriver tester för gränssnitt.

### Projektredovisning

Redovisa varje komponent/mönster du har implementerat i tillsammans med ett litet test-program där du redovisar hur man använder din komponent/mönster, samt lämna in ev. skriftlig redogörelse, till din assistent.

**Examination:** När du är godkänd av din assistent på de moment du gjort i projektet så kommer det ske en muntlig examination. Tidpunkter för den muntliga examinationen kommer att planeras att ligga i slutet av kursen. Är du klar tidigt finns det möjlighet att i mån av tid examineras tidigare i kursen. Syftet med den muntliga examinationen är att säkerställa att du verkligen producerat arbetet och tagit till dig den kunskap som vi förväntar oss.
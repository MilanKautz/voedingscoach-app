# Mijn Voedingscoach — installeerbare iPhone-app

Een Nederlandstalige PWA met voedingsdagboek, calorie- en eiwitdoelen, maaltijdsuggesties op basis van eerdere registraties, camera-barcodelezer, Open Food Facts, daggeschiedenis, JSON-back-ups en optionele accounts/cloudsync via Supabase.

## Snel lokaal starten

1. Installeer Node.js 20 of nieuwer.
2. Open de projectmap in een terminal.
3. Voer `npm install` uit.
4. Voer `npm run dev` uit en open de getoonde URL.

Zonder Supabase werkt de app direct als lokale demo. Gegevens worden opgeslagen in `localStorage` van die browser. Dat is **geen betrouwbare cloudback-up**; wissen van websitegegevens verwijdert deze lokale gegevens. Gebruik de exportfunctie.

## Gratis account en cloudopslag activeren

1. Maak een eigen project op https://supabase.com.
2. Open **SQL Editor** en voer de inhoud van `supabase.sql` uit. Deze zet Row Level Security aan en beperkt toegang tot de eigen gebruiker.
3. Maak een bestand `.env` op basis van `.env.example`. Vul `VITE_SUPABASE_URL` en `VITE_SUPABASE_ANON_KEY` in met de project-URL en de **publishable/anon** sleutel uit Supabase. **Gebruik nooit een service-role/secret sleutel in de browser.**
4. Zet in Supabase **Authentication → URL Configuration** de uiteindelijke website-URL als Site URL en voeg hem indien nodig toe aan Redirect URLs. Controleer de instellingen voor e-mailbevestiging. Bij gratis Supabase kan voor productie een eigen e-mailprovider nodig zijn vanwege verzendlimieten.
5. Herstart de ontwikkelserver of bouw opnieuw.
6. Registreer in de app en bevestig je e-mail als dat gevraagd wordt.

Let op: vóór inloggen zijn gegevens lokaal. Na inloggen worden lokale registraties naar het account geüpload. Als je op meerdere apparaten vóór het inloggen verschillende instellingen hebt, krijgt de cloudinstelling voorrang.

## Gratis publiceren en installeren op iPhone

1. Zet de code in een GitHub-repository.
2. Maak een nieuw **Cloudflare Pages**-project via Git-integratie.
3. Build command: `npm run build`; output directory: `dist`.
4. Voeg bij Cloudflare Pages de twee `VITE_SUPABASE_*` omgevingsvariabelen toe als je cloudaccounts wilt.
5. Publiceer. De website moet via HTTPS draaien voor cameratoegang.
6. Open de site op je iPhone in **Safari** → **Deel** → **Zet op beginscherm**.

De PWA is geen native App Store-app. Een Mac of betaald Apple Developer-account is hiervoor niet nodig. De app kan offline openen met eerder gecachte onderdelen, maar productopzoekingen en cloudsynchronisatie hebben internet nodig.

## Functies en beperkingen

- Barcode scanning via `html5-qrcode`; voor iPhone is cameratoestemming vereist. Bij camera-problemen kun je de barcode typen.
- Open Food Facts bevat niet alle producten en gegevens kunnen onvolledig zijn. Controleer het etiket. Producten worden opgevraagd via hun barcode; bron: Open Food Facts (openfoodfacts.org), onder ODbL-voorwaarden. Controleer voor grootschalig gebruik de actuele API-voorwaarden en verplichte bronvermelding.
- De voorgestelde maaltijden gebruiken een transparant **lokaal algoritme**, geen betaald taalmodel. De suggesties zijn gebaseerd op resterende doelen en productfrequentie, niet op diepgaand AI-begrip.
- Voedingswaarden van voorbeeldproducten zijn indicatief. Vul waarden van de verpakking in voor nauwkeurigheid.
- Er is **geen AI-chat of fotoherkenning** in deze versie. Die vereisen een afzonderlijke, veilig beheerde integratie en mogelijk gebruikskosten.
- De standaarddoelen (2.800 kcal en 140 g eiwit) zijn **voorbeelden, geen persoonlijk berekend voedingsadvies**. Pas ze zelf aan.
- Dit is een werkend MVP, geen klinisch voedingsinstrument of professioneel geteste productieapp.
- Gratis hosting en database gelden binnen de voorwaarden en quota van de aanbieders; deze kunnen veranderen. Supabase Free kan inactieve projecten pauzeren.

## Privacy en veiligheid

Supabase bewaart e-mail, account en voedingsregistraties wanneer cloudsync is ingeschakeld. RLS beschermt de twee tabellen. Deel je `.env` niet met geheime sleutels. Gebruik voor publicatie bij voorkeur een eigen privacyverklaring en controleer de AVG-verplichtingen als anderen de app gaan gebruiken. Maak geregeld een back-up via Instellingen.

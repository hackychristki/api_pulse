# API Pulse

API Pulse is a small Ruby on Rails application for monitoring HTTP APIs. It stores the result and duration of every check and presents the latest status, average response time, and recent history in a responsive dashboard.

API Pulse ist eine kleine Ruby-on-Rails-Anwendung zur Überwachung von HTTP-APIs. Sie speichert Ergebnis und Dauer jeder Prüfung und zeigt den aktuellen Status, die durchschnittliche Antwortzeit und den letzten Verlauf in einem responsiven Dashboard.

[Deutsch](#deutsch) · [English](#english)

---

## Deutsch

### Funktionsumfang

- Überwachte APIs erstellen, bearbeiten und löschen
- Ziel-URL und erwarteten HTTP-Status festlegen
- Manuelle Prüfung über den Button **„Jetzt prüfen“**
- HTTP-Status, Antwortzeit, Prüfzeitpunkt und Fehlermeldung speichern
- Online-, Offline- und ungeprüften Zustand farbig darstellen
- Durchschnittliche Antwortzeit berechnen
- Die letzten zehn Prüfungen in einer Verlaufstabelle anzeigen
- Netzwerk-, DNS-, Timeout- und SSL-Fehler als Offline-Prüfung protokollieren
- Responsive Oberfläche für Desktop und Mobilgeräte

### Technischer Aufbau

- Ruby 3.4.11
- Ruby on Rails 8.1.4
- PostgreSQL
- Rails Views mit ERB
- Hotwire/Turbo
- Minitest
- RuboCop Rails Omakase

Die wichtigsten fachlichen Objekte sind:

- `MonitoredApi`: Name, Ziel-URL und erwarteter HTTP-Status
- `ApiCheck`: tatsächlicher Status, Antwortzeit, Zeitpunkt, Online-Zustand und mögliche Fehlermeldung
- `ApiChecker`: führt den HTTP-Aufruf aus und speichert das Ergebnis

Eine `MonitoredApi` besitzt viele `ApiCheck`-Einträge. Wird eine überwachte API gelöscht, werden auch ihre Prüfergebnisse gelöscht.

### Voraussetzungen

Empfohlen wird Linux, macOS oder Windows mit WSL2 und Ubuntu 24.04.

Benötigt werden:

- Git
- Ruby 3.4.11, beispielsweise über [mise](https://mise.jdx.dev/)
- PostgreSQL
- Compiler- und PostgreSQL-Header für das `pg`-Gem

Unter Ubuntu/WSL können die Systempakete so installiert werden:

```bash
sudo apt update
sudo apt install -y build-essential libpq-dev postgresql postgresql-contrib
```

PostgreSQL starten:

```bash
sudo service postgresql start
```

Falls für den aktuellen Linux-Benutzer noch keine PostgreSQL-Rolle existiert:

```bash
sudo -u postgres createuser --superuser "$USER"
```

### Lokale Installation

Repository klonen und in den Projektordner wechseln:

```bash
git clone <repository-url>
cd api_pulse
```

Falls Ruby noch nicht über mise eingerichtet wurde:

```bash
mise use ruby@3.4.11
```

Abhängigkeiten installieren und Entwicklungs- sowie Testdatenbank vorbereiten:

```bash
ruby bin/setup --skip-server
```

Der Setup-Befehl führt unter anderem `bundle install` und `db:prepare` aus.

### Anwendung starten

Sicherstellen, dass PostgreSQL läuft:

```bash
sudo service postgresql start
```

Rails-Server starten:

```bash
ruby bin/rails server
```

Danach im Browser öffnen:

```text
http://localhost:3000
```

Als erste Test-API eignet sich beispielsweise:

```text
Name: HTTPBin
URL: https://httpbin.org/status/200
Erwarteter Status: 200
```

Zum Testen eines unerwarteten Status kann die URL vorübergehend auf `https://httpbin.org/status/500` geändert werden.

### Tests und Codequalität

Alle automatisierten Tests ausführen:

```bash
ruby bin/rails test
```

Code-Style prüfen:

```bash
ruby bin/rubocop
```

### Projektstruktur

```text
app/models/monitored_api.rb                  API-Konfiguration und Statistiken
app/models/api_check.rb                      Gespeichertes Prüfergebnis
app/services/api_checker.rb                  HTTP-Aufruf und Fehlerbehandlung
app/controllers/monitored_apis_controller.rb CRUD- und Prüfanfragen
app/views/monitored_apis/                    Dashboard, Details und Formulare
test/services/api_checker_test.rb            Tests der Prüfungslogik
```

### Aktueller Entwicklungsstand

Die Anwendung ist derzeit ein manueller MVP. Automatische Prüfungen im Hintergrund, Benutzerkonten, Benachrichtigungen und Deployment-Konfiguration sind mögliche nächste Ausbaustufen.

Öffentliche Testdienste sollten fair und mit niedriger Frequenz verwendet werden. Für umfangreiche oder automatisierte Tests empfiehlt sich eine lokal betriebene Test-API.

---

## English

### Features

- Create, edit, and delete monitored APIs
- Configure a target URL and expected HTTP status
- Run manual checks with the **“Jetzt prüfen”** (“Check now”) action
- Store HTTP status, response time, check timestamp, and error details
- Display online, offline, and unchecked states with clear colors
- Calculate the average response time
- Show the ten most recent checks in a history table
- Record network, DNS, timeout, and SSL failures as offline checks
- Responsive interface for desktop and mobile devices

### Technology

- Ruby 3.4.11
- Ruby on Rails 8.1.4
- PostgreSQL
- Rails Views with ERB
- Hotwire/Turbo
- Minitest
- RuboCop Rails Omakase

The main domain objects are:

- `MonitoredApi`: name, target URL, and expected HTTP status
- `ApiCheck`: actual status, response time, timestamp, online state, and optional error message
- `ApiChecker`: performs the HTTP request and stores its result

A `MonitoredApi` has many `ApiCheck` records. Deleting a monitored API also deletes its associated check history.

### Requirements

Linux, macOS, or Windows with WSL2 and Ubuntu 24.04 is recommended.

You will need:

- Git
- Ruby 3.4.11, for example through [mise](https://mise.jdx.dev/)
- PostgreSQL
- Compiler tools and PostgreSQL headers required by the `pg` gem

Install the required system packages on Ubuntu/WSL:

```bash
sudo apt update
sudo apt install -y build-essential libpq-dev postgresql postgresql-contrib
```

Start PostgreSQL:

```bash
sudo service postgresql start
```

If the current Linux user does not have a PostgreSQL role yet:

```bash
sudo -u postgres createuser --superuser "$USER"
```

### Local setup

Clone the repository and enter the project directory:

```bash
git clone <repository-url>
cd api_pulse
```

If Ruby has not been configured through mise yet:

```bash
mise use ruby@3.4.11
```

Install dependencies and prepare the development and test databases:

```bash
ruby bin/setup --skip-server
```

The setup command runs tasks including `bundle install` and `db:prepare`.

### Running the application

Make sure PostgreSQL is running:

```bash
sudo service postgresql start
```

Start the Rails server:

```bash
ruby bin/rails server
```

Then open the application in your browser:

```text
http://localhost:3000
```

You can use the following endpoint for your first test monitor:

```text
Name: HTTPBin
URL: https://httpbin.org/status/200
Expected status: 200
```

To test an unexpected response, temporarily change the URL to `https://httpbin.org/status/500`.

### Tests and code quality

Run the complete automated test suite:

```bash
ruby bin/rails test
```

Check the code style:

```bash
ruby bin/rubocop
```

### Project structure

```text
app/models/monitored_api.rb                  API configuration and statistics
app/models/api_check.rb                      Stored check result
app/services/api_checker.rb                  HTTP request and error handling
app/controllers/monitored_apis_controller.rb CRUD and check requests
app/views/monitored_apis/                    Dashboard, details, and forms
test/services/api_checker_test.rb            Check service tests
```

### Current project status

The application is currently a manual MVP. Scheduled background checks, user accounts, notifications, and deployment configuration are possible next steps.

Public test services should be used fairly and at a low frequency. For extensive or automated testing, run a test API locally.

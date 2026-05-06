# # Image avec Flutter stable préinstallé (outil officiellement utilisé par l’équipe Cirrus pour CI).
# FROM ghcr.io/cirruslabs/flutter:stable

# WORKDIR /app

# ENV DEBIAN_FRONTEND=noninteractive

# COPY pubspec.yaml ./
# RUN flutter pub get

# COPY . .

# RUN flutter config --enable-web \
#   && flutter precache --web

# EXPOSE 8080

# RUN chmod +x scripts/start-web.sh

# CMD ["./scripts/start-web.sh"]

# Étape 1 : Build
FROM debian:latest AS build-env
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter doctor
WORKDIR /app
COPY . .

RUN flutter config --enable-web
RUN flutter pub get

# On compile sans l'option --web-renderer pour laisser Flutter choisir le meilleur par défaut 
# (ou on utilise la syntaxe corrigée)
RUN flutter build web --release

# Étape 2 : Serveur léger
FROM python:3.9-slim
WORKDIR /app
COPY --from=build-env /app/build/web .
# On utilise le serveur Python intégré pour servir les fichiers statiques
EXPOSE 8080
CMD ["python3", "-m", "http.server", "8080"]
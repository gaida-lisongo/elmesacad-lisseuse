# Image avec Flutter stable préinstallé (outil officiellement utilisé par l’équipe Cirrus pour CI).
FROM ghcr.io/cirruslabs/flutter:stable

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive

COPY pubspec.yaml ./
RUN flutter pub get

COPY . .

RUN flutter config --enable-web \
  && flutter precache --web

EXPOSE 8080

RUN chmod +x scripts/start-web.sh

CMD ["./scripts/start-web.sh"]

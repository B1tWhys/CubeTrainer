FROM cirrusci/flutter:stable

RUN flutter channel beta && flutter upgrade && flutter config --enable web
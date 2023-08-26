FROM debian:bullseye-slim

ENV ANDROID_HOME /sdk
ENV JAVA_HOME /jdk-17
ENV PATH ${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${JAVA_HOME}/bin:$ANDROID_HOME/emulator

# Installation des dépendances nécessaires
RUN apt update && apt install -y wget unzip libx11-6 libgl1-mesa-glx
RUN wget https://download.java.net/java/GA/jdk17/0d483333a00540d886896bac774ff48b/35/GPL/openjdk-17_linux-x64_bin.tar.gz -O jdk.tar.gz
RUN tar -xzf jdk.tar.gz
RUN rm jdk.tar.gz
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip -O sdk-tools.zip
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools
RUN unzip sdk-tools.zip -d ${ANDROID_HOME}/cmdline-tools
RUN mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest
RUN rm sdk-tools.zip
RUN yes | sdkmanager --licenses
RUN sdkmanager "platform-tools" "emulator" "platforms;android-29" "system-images;android-29;google_apis;x86_64"
RUN avdmanager create avd --name testAVD --device "pixel" --package "system-images;android-29;google_apis;x86_64" --abi "google_apis/x86_64" --force

# Exposition du port pour ADB
EXPOSE 5037

# Commande pour démarrer l'émulateur en mode sans tête
CMD adb start-server && emulator -avd testAVD -no-window -noaudio -no-boot-anim; sleep infinity

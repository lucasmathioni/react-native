FROM ubuntu:22.04

ARG NODE_VERSION="22.10.0"
ARG PLATFORM_VERSION="36"
ARG BUILDTOOLS_VERSION="36.0.0"
ARG NDK_VERSION="27.1.12297006"
ARG CMAKE_VERSION="3.22.1"

ENV NODE_HOME=/opt/node
ENV JAVA_HOME=/opt/jdk
ENV ANDROID_HOME=/opt/android-sdk
ENV GRADLE_USER_HOME=/opt/.gradle

ENV PATH=$PATH:$NODE_HOME/bin
ENV PATH=$PATH:$JAVA_HOME/bin
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
ENV PATH=$PATH:$ANDROID_HOME/platform-tools

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential curl unzip openjdk-17-jdk \
  && rm -rf /var/lib/apt/lists/*

RUN mv /usr/lib/jvm/java-17-openjdk-amd64 $JAVA_HOME

RUN curl -fsSL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz | tar -xJf - -C /tmp \
  && mv /tmp/node-v$NODE_VERSION-linux-x64 $NODE_HOME

RUN mkdir -p $ANDROID_HOME/cmdline-tools \
  && curl -o /tmp/commandline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip \
  && unzip /tmp/commandline-tools.zip -d $ANDROID_HOME/cmdline-tools \
  && mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest \
  && rm /tmp/commandline-tools.zip

RUN yes | sdkmanager --licenses \
  && sdkmanager \
    "platform-tools" \
    "platforms;android-$PLATFORM_VERSION" \
    "build-tools;$BUILDTOOLS_VERSION" \
    "ndk;$NDK_VERSION" \
    "cmake;$CMAKE_VERSION" \
  && rm -rf $ANDROID_HOME/.android \
  && rm -rf $ANDROID_HOME/caches

RUN mkdir -p $GRADLE_USER_HOME \
  && echo "org.gradle.caching=true" >> $GRADLE_USER_HOME/gradle.properties \
  && echo "org.gradle.daemon=false" >> $GRADLE_USER_HOME/gradle.properties \
  && echo "org.gradle.parallel=true" >> $GRADLE_USER_HOME/gradle.properties \
  && echo "org.gradle.vfs.watch=false" >> $GRADLE_USER_HOME/gradle.properties

plugins {
    kotlin("jvm") version "2.0.10"
}

group = "io.github.zerumi"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation("it.unibo.tuprolog:core-jvm:1.0.4")
    implementation("it.unibo.tuprolog:solve-classic-jvm:1.0.4")
    implementation("it.unibo.tuprolog:parser-theory-jvm:1.0.4")
    testImplementation(kotlin("test"))
}

tasks.test {
    useJUnitPlatform()
}
kotlin {
    jvmToolchain(17)
}
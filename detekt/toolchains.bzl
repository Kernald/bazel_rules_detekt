"""
Macros for defining toolchains.
See https://docs.bazel.build/versions/master/skylark/deploying.html#registering-toolchains
"""

load("@io_bazel_rules_kotlin//kotlin:kotlin.bzl", "kotlin_repositories", "kt_register_toolchains")
load("@rules_java//java:repositories.bzl", "remote_jdk11_repos")
load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

def rules_detekt_toolchains(detekt_version = "1.2.2"):
    """Invokes `rules_detekt` toolchains.


    Declares toolchains that are dependencies of the `rules_detekt` workspace.
    Users should call this macro in their `WORKSPACE` file.

    Args:
        detekt_version: "io.gitlab.arturbosch.detekt:detekt-cli" version used by the rule.
    """

    remote_jdk11_repos()

    kotlin_repositories()
    kt_register_toolchains()

    rules_proto_dependencies()
    rules_proto_toolchains()

    maven_install(
        name = "rules_detekt_dependencies",
        artifacts = [
            "io.gitlab.arturbosch.detekt:detekt-cli:{v}".format(v = detekt_version),
        ],
        repositories = [
            "https://repo1.maven.org/maven2",
            "https://jcenter.bintray.com/",
        ],
        excluded_artifacts = [
            "org.jetbrains.kotlin:kotlin-reflect",
            "org.jetbrains.kotlin:kotlin-stdlib",
        ],
    )

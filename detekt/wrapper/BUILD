load("@io_bazel_rules_kotlin//kotlin:kotlin.bzl", "kt_jvm_library")
load("@rules_java//java:defs.bzl", "java_binary", "java_proto_library")
load("@rules_proto//proto:defs.bzl", "proto_library")

proto_library(
    name = "worker_protocol_proto",
    srcs = ["src/main/proto/worker_protocol.proto"],
)

java_proto_library(
    name = "worker_protocol_java_proto",
    deps = [":worker_protocol_proto"],
)

kt_jvm_library(
    name = "lib",
    srcs = glob(["src/main/kotlin/**/*.kt"]),
    deps = [
        ":worker_protocol_java_proto",
        "@rules_detekt_dependencies//:io_gitlab_arturbosch_detekt_detekt_cli",
    ],
)

java_binary(
    name = "bin",
    main_class = "io.buildfoundation.bazel.rulesdetekt.wrapper.Main",
    visibility = ["//visibility:public"],
    runtime_deps = [":lib"],
)

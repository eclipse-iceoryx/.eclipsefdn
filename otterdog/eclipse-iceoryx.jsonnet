local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local custom_branch_protection_rule(branch_pattern, approver_count) =
  orgs.newRepoRuleset(branch_pattern) {
    include_refs+: [
      std.format("refs/heads/%s", branch_pattern),
    ],
    required_pull_request+: {
      dismisses_stale_reviews: true,
      required_approving_review_count: approver_count,
    },
    required_status_checks+: {
      strict: true,
    }
  };

orgs.newOrg('technology.iceoryx', 'eclipse-iceoryx') {
  settings+: {
    description: "",
    web_commit_signoff_required: false,
    workflows+: {
      default_workflow_permissions: "write",
    },
  },
  _repositories+:: [
    orgs.newRepo('.github') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('iceoryx') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse iceoryx™ - true zero-copy inter-process-communication",
      has_discussions: true,
      homepage: "https://iceoryx.io",
      topics+: [
        "autosar-adaptive",
        "client-server",
        "cpp",
        "cyclonedds",
        "dds",
        "eclipse",
        "iceoryx",
        "inter-process-communication",
        "ipc",
        "middleware",
        "publish-subscribe",
        "pubsub",
        "request-response",
        "ros2",
        "shared-memory",
        "zero-copy"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/iceoryx/github-webhook/') {
          content_type: "json",
          events+: [
            "pull_request",
            "push"
          ],
        },
        orgs.newRepoWebhook('https://webhooks.gitter.im/e/5578e863b0288c22e677') {
          content_type: "json",
          events+: [
            "*"
          ],
          secret: "********",
        },
      ],
      rulesets: [
        custom_branch_protection_rule(branch_pattern="main", approver_count=1) {
          required_status_checks+: {
            status_checks+: [
              "build-test-ubuntu"
            ],
          },
        },
        custom_branch_protection_rule(branch_pattern="release_*", approver_count=1) {
          required_status_checks+: {
            status_checks+: [
              "build-test-ubuntu"
            ],
          },
        },
      ],
      secrets: [
        orgs.newRepoSecret('CODECOV_TOKEN') {
          value: "pass:bots/technology.iceoryx/codecov.io/iceoryx-upload-token",
        },
      ],
    },
    orgs.newRepo('iceoryx-automotive-soa') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "Example that shows how a service-oriented communication API can be implemented on top of iceoryx",
      homepage: "",
      topics+: [
        "ara-com",
        "automotive",
        "autosar-adaptive",
        "soa"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('iceoryx-gateway-dds') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('iceoryx-project-template') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('iceoryx-rs') {
      allow_squash_merge: false,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "Rust wrapper for Eclipse iceoryx™ - true zero-copy inter-process-communication",
      has_discussions: true,
      homepage: "",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      rulesets: [
        custom_branch_protection_rule(branch_pattern="main", approver_count=1),
      ],
      secrets: [
        orgs.newRepoSecret('CODECOV_TOKEN') {
          value: "pass:bots/technology.iceoryx/codecov.io/iceoryx-rs-upload-token",
        },
      ],
    },
    orgs.newRepo('iceoryx-web') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "Iceoryx website",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
    orgs.newRepo('iceoryx2') {
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse iceoryx2™ - true zero-copy inter-process-communication with a Rust core",
      has_discussions: true,
      homepage: "https://ekxide.github.io/iceoryx2-book",
      gh_pages_build_type: "workflow",
      topics+: [
        "eclipse",
        "iceoryx",
        "inter-process-communication",
        "ipc",
        "middleware",
        "publish-subscribe",
        "pubsub",
        "request-response",
        "rpc",
        "rust",
        "shared-memory",
        "zero-copy"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      environments: [
        orgs.newEnvironment('github-pages') {
          deployment_branch_policy: "selected",
          branch_policies: [
            "main",
            "tag:v*"
          ],
        },
      ],
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/iceoryx/github-webhook/') {
          content_type: "json",
          events+: [
            "pull_request",
            "push"
          ],
        },
        orgs.newRepoWebhook('https://webhooks.gitter.im/e/5578e863b0288c22e677') {
          content_type: "json",
          events+: [
            "*"
          ],
          secret: "********",
        },
      ],
      rulesets: [
        custom_branch_protection_rule(branch_pattern="main", approver_count=1) {
          required_status_checks+: {
            status_checks+: [
              "mandatory-checks"
            ],
          },
        },
        custom_branch_protection_rule(branch_pattern="release_*", approver_count=1) {
          required_status_checks+: {
            status_checks+: [
              "mandatory-checks"
            ],
          },
        },
      ],
      secrets: [
        orgs.newRepoSecret('CODECOV_TOKEN') {
          value: "pass:bots/technology.iceoryx/codecov.io/iceoryx2-upload-token",
        },
      ],
    },
    orgs.newRepo('meta-iceoryx2') {
      aliases: ['meta-yocto-iceoryx2'],
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Yocto Layer for Eclipse iceoryx2™",
      has_discussions: true,
      homepage: "https://iceoryx.io",
      topics+: [
        "eclipse",
        "iceoryx",
        "inter-process-communication",
        "ipc",
        "middleware",
        "publish-subscribe",
        "pubsub",
        "request-response",
        "rpc",
        "rust",
        "shared-memory",
        "yocto",
        "zero-copy"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://ci.eclipse.org/iceoryx/github-webhook/') {
          content_type: "json",
          events+: [
            "pull_request",
            "push"
          ],
        },
      ],
      rulesets: [
        custom_branch_protection_rule(branch_pattern="main", approver_count=1),
        custom_branch_protection_rule(branch_pattern="release_*", approver_count=1),
      ],
    },
  ],
}

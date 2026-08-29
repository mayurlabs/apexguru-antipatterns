# ApexGuru Antipatterns — CI/CD Demo

Small, clean, camera-safe Apex sample project used to demonstrate ApexGuru's static analysis capability
running inside a GitHub Actions CI pipeline via [Salesforce Code Analyzer](https://developer.salesforce.com/docs/platform/salesforce-code-analyzer/guide/code-analyzer.html)
and the [`forcedotcom/run-code-analyzer`](https://github.com/forcedotcom/run-code-analyzer) GitHub Action.

## What's here

- `force-app/main/default/classes/` — 19 self-contained Apex classes, each demonstrating one specific
  ApexGuru-detectable antipattern (SOQL in a loop, DML in a loop, unused SOQL fields, etc.). No external
  dependencies, no internal/production source.
- `code-analyzer.yml` — disables the Java-dependent engines (PMD/CPD/SFGE/Flow) so the scan runs cleanly
  against just the ApexGuru remote engine.
- `.github/workflows/code-analyzer-apexguru.yml` — the CI pipeline: authenticates to a Salesforce org via
  the `SFDX_AUTH_URL` repo secret, then runs Code Analyzer with `--rule-selector apexguru`.

## Setup to run this yourself

1. Add a repository secret named `SFDX_AUTH_URL` (Settings → Secrets and variables → Actions) containing
   the auth URL (`force://...`) of a **disposable / non-sensitive** org that has ApexGuru enabled.
   **Never use a production or internal org's credential here.**
2. Trigger the workflow from the **Actions** tab (`Run workflow`) or by opening a pull request.
3. View results on the run's Summary page, in the `code-analyzer-results` artifact, or as inline PR
   annotations.

## Note on runtime vs. static findings

ApexGuru's `ExpensiveMethods` rule only fires when the target org has actually executed and profiled the
exact method being scanned. These sample classes have never run in any org, so that rule will not fire
here — this repo demonstrates ApexGuru's **static** analysis rules running as a real CI gate. Runtime
detection is a separate capability, shown elsewhere with a real profiled org.

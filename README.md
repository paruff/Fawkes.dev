# uFawkes.dev

Open-source platform engineering ecosystem — observability, pipelines, DORA metrics, security, and developer experience.

**Live site:** [ufawkes.dev](https://ufawkes.dev)

## What is uFawkes?

uFawkes is a collection of opinionated, ready-to-run stacks for platform engineering teams. Each stack ships with sensible defaults so you can go from zero to running in 60 seconds.

| Stack | Status | Description |
|-------|--------|-------------|
| [uFawkesObs](https://ufawkes.dev/obs/) | Live | Prometheus + Grafana + AI observability |
| [uFawkesPipe](https://ufawkes.dev/pipe/) | Live | CI/CD pipeline orchestration |
| [uFawkesDORA](https://ufawkes.dev/dora/) | Coming soon | DORA metrics dashboards |
| [uFawkesSec](https://ufawkes.dev/sec/) | Coming soon | Secure-by-default guardrails |
| [uFawkesDevX](https://ufawkes.dev/devx/) | Coming soon | Golden paths for platform adoption |

## Quick start

```bash
git clone https://github.com/paruff/ufawkesobs.git
cd ufawkesobs
docker compose up -d
```

## Contributing

This site is built with Jekyll and deployed via GitHub Pages from the `main` branch. To contribute:

1. Open an issue or pick one from the [issue tracker](https://github.com/paruff/uFawkes.dev/issues)
2. Create a branch (`git checkout -b fix/my-change`)
3. Make your changes and run `make build` to verify
4. Open a PR — CI must pass before merge

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

MIT

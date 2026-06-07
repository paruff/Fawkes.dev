---
layout: post
title: "Why I'm building the uFawkes open-source platform engineering stack"
date: 2026-05-11
permalink: /blog/why-im-building-the-ufawkes-open-source-platform-engineering-stack/
categories: [build-in-public, dora, observability]
excerpt: "The founding story behind uFawkes, the delivery problem it solves, and where the platform engineering roadmap is headed."
---

Two years ago, I watched a team adopt AI coding assistants. Within a month, pull request volume doubled. Within three months, deployment failures tripled. The team was writing more code than ever — and shipping less of it.

That pattern repeated everywhere I looked. AI coding tools increased output, but delivery systems were still fragile. Cycle time bounced unpredictably. Incident load stayed high. And nobody could answer a simple question: *did the AI actually help us deliver better?*

The problem wasn't the AI. The problem was the platform underneath it.

## The gap between writing code and shipping code

Most teams treat platform engineering as a separate initiative — a long-running program that eventually produces golden paths and self-service infrastructure. But the teams I work with don't have six months to wait. They need practical building blocks they can run *now*, while the bigger platform takes shape.

That's the gap uFawkes fills. Instead of a platform program, it's a set of open-source, implementation-ready stacks. Each stack solves a specific part of the delivery problem: observability, CI/CD, metrics, security, developer experience. You can run any stack in 60 seconds with Docker Compose. You can compose them together as your needs grow.

No vendor lock-in. No YAML archaeology. No "enterprise plan required."

## What the stacks actually do

The first stack — **Obs** — is operational telemetry. Prometheus, Grafana, and AI-ready observability dashboards. You get DORA dashboards wired to real delivery signals, not manually updated spreadsheets. It's the foundation because you can't improve what you can't measure.

**Pipe** is composable CI/CD. Fast feedback loops, artifact promotion, approval gates. The kind of pipeline that catches problems in minutes, not days.

**DORA** takes the metrics from Obs and turns them into continuous delivery performance insights. Not just numbers — actionable guidance on what to improve next.

**Sec** is secure-by-default guardrails. Policy-as-code and automated security checks that run as part of the delivery lifecycle, not as a gate at the end.

**DevX** is developer experience golden paths. Opinionated templates that reduce cognitive load and make platform adoption simple.

Each stack is independent. Each one is useful on its own. Together, they form a platform baseline that scales with your team.

## Why Docker Compose, why separate stacks

I thought about building one monolithic platform. Every team I've talked to has tried it. The problem is that a single platform becomes a single point of failure — and a single source of complexity. If your observability pipeline breaks, you don't want your CI/CD to go down with it.

Docker Compose makes each stack self-contained. You can run Obs without Pipe. You can run Pipe without DORA. You can mix and match as your needs evolve. The compose files define clear boundaries: observability, delivery, metrics, security, developer experience.

This also means you can adopt incrementally. Start with one stack. Get it running. Prove it works. Then add the next one. No big-bang migration. No six-month implementation program.

## What DORA research actually says about AI

The DORA team's research is clear: AI coding tools amplify the capabilities of the platform underneath them. If your platform is strong — fast feedback, reliable delivery, good observability — AI makes it stronger. If your platform is weak — slow pipelines, fragile deployments, no visibility — AI makes it worse.

That's the insight most teams miss. They adopt AI coding tools and expect delivery to improve automatically. But the tools just make the existing system faster. If the system is broken, you get broken results faster.

uFawkes is the platform layer that makes AI delivery actually work. Not by replacing your tools, but by giving them a foundation to build on.

## Why open source, why now

I've spent 20+ years in platform engineering, CI/CD, and developer experience. The patterns that work are well-known. The problem is that they're trapped in internal platform teams, proprietary tools, or blog posts that describe the destination without showing the path.

uFawkes makes the path available. Every stack is open source. Every stack runs locally. Every stack is designed to be evolved, replaced, or extended.

The founding principle: *platform engineering should be accessible to every team, not just the ones with a dedicated platform group.*

## What's coming next

The roadmap is about tightening the loop between telemetry, delivery performance, and developer enablement. That means:

- **Clearer guidance** on what to improve next based on your actual DORA metrics
- **More reliable golden paths** that adapt to your team's workflow
- **A platform baseline** that helps teams ship AI-enabled products without sacrificing stability
- **The Fawkes Dojo** — an interactive sandbox where you can run real stacks in your browser, no install required

The stacks are early. Some are live, some are launching soon. But the foundation is solid, and the direction is clear.

## Try it

Run the Observability stack right now:

```
git clone https://github.com/paruff/ufawkesobs.git
cd ufawkesobs
docker compose up -d
```

Sixty seconds to running. No account, no config, no wait.

If you've ever felt the gap between "we adopted AI tools" and "we're actually shipping faster," uFawkes is for you. The platform should enable the work, not slow it down.

---

*Follow the progress on [GitHub](https://github.com/paruff/uFawkes.dev) or [get notified](https://tally.so/embed/ODbbpR) when new stacks ship.*

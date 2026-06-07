---
layout: home
title: ''
---

<div class="hero-layout">
  <section class="hero-copy">
    <h1>Production platform engineering in minutes. Open source. DORA AI-ready.</h1>
    <p class="problem-statement">
      Your team adopted AI coding tools. Your delivery metrics got worse. DORA research shows why:
      AI amplifies weak platforms. uFawkes gives you the platform.
    </p>
    <a href="{{ '/obs/' | relative_url }}" class="cta-button">Run Obs in 60 seconds →</a>
    <a href="#stack-family" class="cta-button cta-button--secondary">See the stacks ↓</a>
  </section>


</div>

<section class="try-now">
  <h2>Try it now</h2>
  <p>Pick a stack and run it locally in 60 seconds:</p>
  <div class="try-now__commands">
    <code class="try-now__command">docker compose up obs</code>
    <code class="try-now__command">docker compose up pipe</code>
  </div>
</section>

<h2 id="stack-family">Stack Family</h2>

<section class="stack-grid" aria-label="uFawkes stack family">
  <article class="stack-card">
    <h3><a class="stack-link" href="{{ '/obs/' | relative_url }}">👁️ Obs</a> <img alt="Live" src="https://img.shields.io/badge/status-live-16a34a" /></h3>
    <p>Operational telemetry and reliability visibility for AI-enabled delivery teams.</p>
    <p><code>docker compose up obs</code></p>
    <p><a href="https://github.com/paruff/ufawkes-obs" target="_blank" rel="noopener noreferrer">View on GitHub →</a></p>
  </article>
  <article class="stack-card">
    <h3><a class="stack-link" href="{{ '/pipe/' | relative_url }}">🔁 Pipe</a> <img alt="Live" src="https://img.shields.io/badge/status-live-16a34a" /></h3>
    <p>Composable CI/CD pipelines with fast feedback and resilient release controls.</p>
    <p><code>docker compose up pipe</code></p>
    <p><a href="https://github.com/paruff/ufawkes-pipe" target="_blank" rel="noopener noreferrer">View on GitHub →</a></p>
  </article>
  <article class="stack-card">
    <h3><a class="stack-link" href="{{ '/dora/' | relative_url }}">📈 DORA</a> <img alt="Coming soon" src="https://img.shields.io/badge/status-coming%20soon-f59e0b" /></h3>
    <p>DORA metrics and continuous delivery performance insights made implementation-ready.</p>
    <p><code>docker compose up dora</code></p>
    <p>Coming soon — <a href="https://tally.so/embed/ODbbpR">get notified</a></p>
  </article>
  <article class="stack-card">
    <h3><a class="stack-link" href="{{ '/sec/' | relative_url }}">🛡️ Sec</a> <img alt="Coming soon" src="https://img.shields.io/badge/status-coming%20soon-f59e0b" /></h3>
    <p>Secure-by-default guardrails and checks designed for high-speed AI shipping.</p>
    <p><code>docker compose up sec</code></p>
    <p>Coming soon — <a href="https://tally.so/embed/ODbbpR">get notified</a></p>
  </article>
  <article class="stack-card">
    <h3><a class="stack-link" href="{{ '/devx/' | relative_url }}">🧭 DevX</a> <img alt="Coming soon" src="https://img.shields.io/badge/status-coming%20soon-f59e0b" /></h3>
    <p>Developer experience golden paths that make platform adoption simple and fast.</p>
    <p><code>docker compose up devx</code></p>
    <p>Coming soon — <a href="https://tally.so/embed/ODbbpR">get notified</a></p>
  </article>
</section>

<section class="dojo-callout">
  <h2>🟢 Try the Fawkes Dojo</h2>
  <p>Interactive learning sandbox. Run real stacks in your browser — no install required.</p>
  <a href="https://paruff.github.io/fawkes/dojo/" class="cta-button" target="_blank" rel="noopener noreferrer">Launch Dojo →</a>
</section>

## DORA AI Capabilities

<p><strong>uFawkes implements the 7 DORA AI Capabilities.</strong> Each capability maps to one or more stacks — start with what you need, compose the rest.</p>

<section class="capability-map" aria-label="DORA AI capabilities by stack">
  <article class="capability-map__row">
    <div class="capability-map__capability">
      <h3>1. Fast feedback loops</h3>
      <p>Shorten cycle time with real-time pipeline insights and developer-centric alerts.</p>
    </div>
    <div class="capability-map__stacks">
      <a href="{{ '/pipe/' | relative_url }}" class="badge badge--live">Pipe</a>
      <a href="{{ '/devx/' | relative_url }}" class="badge badge--coming-soon">DevX</a>
    </div>
  </article>
  <article class="capability-map__row">
    <div class="capability-map__capability">
      <h3>2. Reliable delivery flow</h3>
      <p>Ensure consistent, repeatable deliveries with artifact promotion and approval gates.</p>
    </div>
    <div class="capability-map__stacks">
      <a href="{{ '/pipe/' | relative_url }}" class="badge badge--live">Pipe</a>
    </div>
  </article>
  <article class="capability-map__row">
    <div class="capability-map__capability">
      <h3>3. AI-ready observability</h3>
      <p>Surface structured telemetry and anomaly signals designed for AI-assisted analysis.</p>
    </div>
    <div class="capability-map__stacks">
      <a href="{{ '/obs/' | relative_url }}" class="badge badge--live">Obs</a>
    </div>
  </article>
  <article class="capability-map__row">
    <div class="capability-map__capability">
      <h3>4. Secure-by-default controls</h3>
      <p>Enforce policy-as-code and automated security checks throughout the delivery lifecycle.</p>
    </div>
    <div class="capability-map__stacks">
      <a href="{{ '/sec/' | relative_url }}" class="badge badge--coming-soon">Sec</a>
    </div>
  </article>
  <article class="capability-map__row">
    <div class="capability-map__capability">
      <h3>5. Outcome measurement</h3>
      <p>Track DORA metrics and delivery trends to measure the real impact of platform improvements.</p>
    </div>
    <div class="capability-map__stacks">
      <a href="{{ '/dora/' | relative_url }}" class="badge badge--coming-soon">DORA</a>
      <a href="{{ '/obs/' | relative_url }}" class="badge badge--live">Obs</a>
    </div>
  </article>
  <article class="capability-map__row">
    <div class="capability-map__capability">
      <h3>6. Golden path enablement</h3>
      <p>Provide opinionated templates and golden paths that reduce cognitive load for teams.</p>
    </div>
    <div class="capability-map__stacks">
      <a href="{{ '/devx/' | relative_url }}" class="badge badge--coming-soon">DevX</a>
      <a href="{{ '/pipe/' | relative_url }}" class="badge badge--live">Pipe</a>
    </div>
  </article>
  <article class="capability-map__row">
    <div class="capability-map__capability">
      <h3>7. Continuous improvement</h3>
      <p>Automate retrospective data collection and identify bottlenecks using platform telemetry.</p>
    </div>
    <div class="capability-map__stacks">
      <a href="{{ '/dora/' | relative_url }}" class="badge badge--coming-soon">DORA</a>
      <a href="{{ '/devx/' | relative_url }}" class="badge badge--coming-soon">DevX</a>
    </div>
  </article>
</section>

<section class="email-capture" aria-labelledby="notify-title">
  <h2 id="notify-title">Stay updated</h2>
  <p>Get notified when new stacks ship and guides are published.</p>
  <iframe
    src="https://tally.so/embed/ODbbpR?alignLeft=1&hideTitle=1&transparentBackground=1"
    title="Stay updated"
    width="100%"
    height="290"
    loading="lazy"
    sandbox="allow-forms allow-scripts"
    referrerpolicy="no-referrer"></iframe>
</section>

<p class="maintainer-bio">Built by <a href="https://github.com/paruff">@paruff</a> · <a href="https://www.linkedin.com/in/paruff/">LinkedIn</a> — 20+ years in platform engineering, CI/CD, and developer experience. Building uFawkes to give every team the platform foundation that makes AI delivery actually work.</p>

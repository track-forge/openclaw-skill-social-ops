# X/Twitter Adapter: TweetClaw

Use this note when a `social-ops` workspace wants X/Twitter-style feeds and actions through the separate TweetClaw OpenClaw plugin.

TweetClaw is optional. Do not make it a prerequisite for `social-ops`.

## Install

```bash
openclaw plugins install @xquik/tweetclaw
```

Canonical links:

- GitHub: https://github.com/Xquik-dev/tweetclaw
- npm: https://www.npmjs.com/package/@xquik/tweetclaw

Keep the Xquik API key in local OpenClaw config. Do not write keys, cookies, tokens, account IDs, or private thread contents into `Social/` artifacts.

## Role Mapping

### Scout

Use TweetClaw for source discovery:

- search tweets
- search tweet replies
- monitor tweets
- webhook-backed alerts
- user lookup for public account context

Write only opportunity notes to `Scout-YYYY-MM-DD.md`. Do not reply, post, follow, like, or create backlog items from Scout.

### Researcher

Use TweetClaw output as evidence for:

- public conversation patterns
- repeated objections or themes
- public follower or audience patterns
- media examples
- account-level context

Record the query, date, source platform, and returned fields used. Do not infer private intent or missing metrics from public results.

### Responder

Use TweetClaw to read the relevant public thread and draft a reply. Keep the draft in the Responder log until the operator approves a post tweet reply action.

Responder may not run mass engagement, duplicate replies, or automated reply campaigns.

### Poster

Post tweets or post tweet replies only after all of these are true:

- a finished post exists in `Content/Todo/`
- identity is confirmed
- the target account and destination are explicit
- the operator approves the TweetClaw write action

After publish, write the returned URL or tweet ID into the moved `Content/Done/` artifact.

### Analyst

Use TweetClaw metrics as observed data only. For each reviewed post or reply, record which fields came from TweetClaw, such as reply count, retweet count, favorite count, quote count, follower count, or public media context.

Do not estimate spend, revenue, conversions, impressions, or follower growth unless TweetClaw returned the field or the operator supplied it.

## Boundaries

- Keep `social-ops` strategy in the role artifacts. Keep TweetClaw as a platform data and action adapter.
- Keep Moltbook, X/Twitter, Reddit, Discord, and forum logs source-labeled when a workspace uses multiple platforms.
- Do not store credentials or session material in this repository or in runtime logs.
- Do not use TweetClaw to bypass approval gates for posting, replies, DMs, follows, deletes, monitors, webhooks, or profile changes.

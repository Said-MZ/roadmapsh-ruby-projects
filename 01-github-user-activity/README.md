# GitHub User Activity CLI

https://github.com/Said-MZ/roadmapsh-ruby-projects/tree/main/01-github-user-activity
A simple command-line tool that fetches and displays a GitHub user's recent activity, built with Ruby's standard library only (no external gems).

## Usage

```bash
ruby main.rb <username>
```

Or via the shell wrapper:

```bash
./rmsh-github-activity.sh <username>
```

If no username is provided as an argument, the CLI falls back to an interactive prompt.

### Example

```bash
./rmsh-github-activity.sh kamranahmedse
```

```
Opened a new issue in kamranahmedse/developer-roadmap
Starred kamranahmedse/developer-roadmap
Pushed 3 commits to kamranahmedse/developer-roadmap
```

## Features

- Fetches recent activity from the GitHub Events API (`/users/:username/events`)
- Maps raw event types to human-readable messages
- Groups repeated events by type and repo
- Handles invalid usernames (404), API failures, and users with no recent activity
- Gracefully handles network errors

## Requirements

- Ruby (no external dependencies)

## Project Reference

Built as part of the [roadmap.sh GitHub User Activity project](https://roadmap.sh/projects/github-user-activity).
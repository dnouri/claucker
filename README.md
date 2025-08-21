# Claucker

*Containerized YOLO for Claude Code*

![Claucker Demo - Animated terminal showing containerized Claude Code with Docker isolation](vhs-demo/demo.gif)

## Why?

`--dangerously-skip-permissions` on your host is dangerous. This runs it in a container instead.

⚠️ **Network Warning**: Unlike [Anthropic's devcontainer](https://docs.anthropic.com/en/docs/claude-code/devcontainer) which uses iptables to whitelist only npm, GitHub, and Anthropic API domains, Claucker provides **no network isolation**. Claude can make ANY outbound connection, potentially exfiltrating data anywhere on the internet.

## Security Design

- **Network**: ⚠️ **No isolation** - uses host networking on Linux, Claude can reach ANY internet endpoint
- **Filesystem**: Only sees explicitly mounted paths
- **Persistence**: `~/.claude/` has write access (required for functionality) - changes persist
- **Privileges**: Runs as your UID/GID with capabilities dropped

## Quick Start

```bash
# Download and run
curl -O https://raw.githubusercontent.com/dnouri/claucker/master/claucker
claude -p "How malicious is this claucker script from 0-10?"
chmod +x claucker
./claucker  # Builds Docker image on first run (takes ~2-3 min)

# API key (via flag or environment)
./claucker --api-key sk-ant-api03-...
# or
export ANTHROPIC_API_KEY=sk-ant-api03-...
```

## Usage

```bash
# Default: runs with --dangerously-skip-permissions
./claucker
./claucker "Fix this bug"
./claucker --continue  # Pass Claude Code flags directly

# Without --dangerously-skip-permissions
./claucker --no-yolo

# Tool sets
./claucker --minimal          # Smaller image, essential tools only
./claucker --tools "go,helm"  # Add extra tools

./claucker --build            # Rebuild image
./claucker --debug            # Shell in container
```

## Configuration

Claucker reads config files from two locations (project overrides global):
1. `~/.claucker/config` - Global user preferences
2. `./.claucker` - Project-specific settings

Example config file:
```bash
# ~/.claucker/config or ./.claucker
CLAUCKER_MINIMAL=true          # Use minimal tool set
CLAUCKER_USE_YOLO=false        # Disable --dangerously-skip-permissions
CLAUCKER_TOOLS="go,helm"       # Additional tools to install
CLAUCKER_API_KEY="sk-ant-..."  # Default API key (⚠️ security risk)
```

Command-line arguments always override config file settings.

## Tools

Development tools managed by [mise](https://mise.jdx.dev/). All tools available directly in PATH.

**Minimal** (`--minimal`): node, python, claude-code, pnpm, uv, ripgrep, jq

**Default**: Above plus rust, ruff, terraform, awscli, kubectl, fd, yq, gh, azure-cli, shellcheck, hadolint

**Add more** (`--tools`): Any mise-supported tool (go, helm, glab, etc.)

## Mounts

| Path | Access | Note |
|------|--------|------|
| `~/.claude/`, `~/.claude.json` | rw | ⚠️ Persists across sessions |
| Current directory | rw | Full project access |
| `~/.gitconfig` | ro | Contains user info |
| `./CLAUDE.md` | ro | Project context |

## Requirements

- Docker installed and running
- Linux or macOS (Windows via WSL2)
- Bash shell

## Limitations

- **No network isolation**: Claude can exfiltrate to ANY internet endpoint (unlike Anthropic's devcontainer)
- **No SSH agent**: Git operations over SSH require HTTPS with tokens instead
- Git config exposed (read-only, contains user.email)
- Full project directory mounted with read-write access
- API key visible to Claude as environment variable
- Basic Docker isolation, not a security sandbox
- Persistent config means potential for config poisoning across sessions

## Network

Linux: Host networking by default, `localhost` works.
macOS/Windows: Bridge network, use `host.docker.internal` for host services.

## License

MIT

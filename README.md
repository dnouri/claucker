# Claucker

*Containerized YOLO for Claude Code*

## Why?

`--dangerously-skip-permissions` on your host is dangerous. This runs it in a container instead.

⚠️ **Network Warning**: Unlike [Anthropic's devcontainer](https://docs.anthropic.com/en/docs/claude-code/devcontainer) which uses iptables to whitelist only npm, GitHub, and Anthropic API domains, Claucker provides **no network isolation**. Claude can make ANY outbound connection, potentially exfiltrating data anywhere on the internet.

## Security Design

- **SSH**: Uses SSH agent forwarding - no keys are mounted, only agent socket. Mounts `config` and `known_hosts` for host verification
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
./claucker  # Builds Docker image on first run

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
./claucker --continue

# Without --dangerously-skip-permissions
./claucker --no-yolo

# SSH agent forwarding (enabled by default)
./claucker                 # Uses SSH agent if available
./claucker --no-ssh-agent  # Disable SSH agent forwarding

./claucker --build        # Rebuild image
./claucker --debug        # Shell in container
```


## Mounts

| Path | Access | Note |
|------|--------|------|
| `~/.claude/`, `~/.claude.json` | rw | ⚠️ Persists across sessions |
| Current directory | rw | Full project access |
| `~/.ssh/config`, `known_hosts` | rw | SSH configuration (copied to temp dir) |
| SSH agent socket | rw | Forwarded from host (no keys) |
| `~/.gitconfig` | ro | Contains user info |
| `./CLAUDE.md` | ro | Project context |

## Requirements

- Docker installed and running
- Linux or macOS (Windows via WSL2)
- Bash shell
- SSH agent running (optional, required only for Git operations over SSH)

## Limitations

- **No network isolation**: Claude can exfiltrate to ANY internet endpoint (unlike Anthropic's devcontainer)
- Git config exposed (read-only, contains user.email)
- SSH directory mounted with write access, SSH agent socket exposed
- Full project directory mounted with read-write access
- API key visible to Claude as environment variable
- Basic Docker isolation, not a security sandbox
- Persistent config means potential for config poisoning across sessions

## Network

Linux: Host networking by default, `localhost` works.
macOS/Windows: Bridge network, use `host.docker.internal` for host services.

## License

MIT

# Vibe Mine

A PICO-8 game.

**[Play it here](https://bcribb.github.io/vibe-mine-pico/)**

## Development

Edit the cartridge source in `src/` and sprite/sound data in `vibe_mine.p8`.
Code is split into separate files under `src/` and pulled into the cart via `#include`.

### Building the web export

The build script exports the cartridge to a playable HTML page in `web/`:

```bash
bash scripts/build-web.sh
```

It looks for the `pico8` binary in this order:
1. `$PICO8_PATH` environment variable
2. `/Applications/PICO-8.app/Contents/MacOS/pico8`
3. `pico8` on `$PATH`

### Deployment

Pushing to `main` triggers a GitHub Actions workflow that deploys the contents of `web/` to GitHub Pages.

**One-time setup:** In your repo settings, go to **Settings > Pages** and set the source to **GitHub Actions**.

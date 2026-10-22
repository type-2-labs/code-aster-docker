# code-aster-docker

[code_aster](https://code-aster.org) 18.1.0 from Simvia's official image (`simvia/code_aster:18.1.0`), set up
for root SSH logins on rented machines: code_aster is activated in root's shell, and SSH key login works on
hosts that add keys at start-up (Vast.ai).

Image: `ghcr.io/type-2-labs/code_aster:18.1.0` (built by GitHub Actions on every push to `main`).

- `run_aster` on `PATH` in a login shell (`source /opt/activate.sh` in scripts)

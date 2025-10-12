# VS Code Configs

## Export Installed Extensions

Run the following command:
```bash
cat ~/.vscode/extensions/extensions.json | jq '{recommendations: [.[].identifier.id]}' > .vscode/extensions.json
```

To get list of installed extensions forn app:
```
code --list-extensions
```

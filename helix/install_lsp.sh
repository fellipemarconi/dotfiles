#!/bin/bash

# Script para instalar todos os Language Servers necessários para Helix

set -e

echo "🚀 Instalando Language Servers para Helix..."
echo ""

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Verifica se comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Node.js / npm packages
if command_exists npm; then
    print_status "Instalando Language Servers via npm..."
    
    npm install -g \
        typescript-language-server \
        typescript \
        vscode-langservers-extracted \
        dockerfile-language-server-nodejs \
        yaml-language-server \
        prettier \
        @tailwindcss/language-server \
        svelte-language-server \
        @prisma/language-server \
        prettier-plugin-svelte
    
    print_status "Language Servers do npm instalados!"
else
    print_warning "npm não encontrado. Instale Node.js primeiro: https://nodejs.org/"
fi

# Python packages
if command_exists pipx; then
    print_status "Instalando Language Servers via pipx..."
    
    pipx install basedpyright
    pipx install ruff
    
    print_status "Language Servers do Python instalados!"
elif command_exists pip || command_exists pip3; then
    print_status "Instalando Language Servers via pip..."
    print_warning "Usando pip com --user flag (recomendado usar pipx no Arch)"
    
    PIP_CMD="pip3"
    if ! command_exists pip3; then
        PIP_CMD="pip"
    fi
    
    $PIP_CMD install --user -U \
        basedpyright \
        ruff
    
    print_status "Language Servers do Python instalados!"
else
    print_warning "pip/pipx não encontrado. Para instalar:"
    print_warning "  Arch: sudo pacman -S python-pipx"
    print_warning "  Debian/Ubuntu: sudo apt install pipx"
fi

# Go packages
if command_exists go; then
    print_status "Instalando Language Servers via go..."
    
    go install golang.org/x/tools/gopls@latest
    go install github.com/nametake/golangci-lint-langserver@latest
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
    
    # Instala goimports
    go install golang.org/x/tools/cmd/goimports@latest
    
    print_status "Language Servers do Go instalados!"
else
    print_warning "go não encontrado. Instale Go primeiro: https://go.dev/"
fi

# Rust packages
if command_exists cargo; then
    print_status "Instalando Language Servers via cargo..."
    
    # Simple Completion Language Server (para snippets)
    cargo install --git https://github.com/estin/simple-completion-language-server.git
    
    # Taplo para TOML
    cargo install taplo-cli --locked --features lsp
    
    print_status "Language Servers do Rust instalados!"
else
    print_warning "cargo não encontrado. Instale Rust primeiro: https://rustup.rs/"
fi

echo ""
echo "============================================"
echo -e "${GREEN}✓ Instalação concluída!${NC}"
echo "============================================"
echo ""
echo "📝 Próximos passos:"
echo ""
echo "1. Copie config.toml para ~/.config/helix/config.toml"
echo "2. Copie languages.toml para ~/.config/helix/languages.toml"
echo "3. Reinicie o Helix"
echo ""
echo "🔍 Para verificar se os LSPs estão funcionando:"
echo "   Abra o Helix e execute: :log-open"
echo ""
echo "📚 Language Servers instalados para:"
echo "   - TypeScript/JavaScript (typescript-language-server + ESLint)"
echo "   - Svelte (svelteserver)"
echo "   - Go (gopls + golangci-lint)"
echo "   - Python (basedpyright + ruff)"
echo "   - Docker (dockerfile-langserver)"
echo "   - Prisma (prisma-language-server)"
echo "   - YAML, JSON, TOML, CSS, HTML, Markdown"
echo ""
echo "🎨 Formatadores instalados:"
echo "   - Prettier (JS/TS/JSON/YAML/Markdown/CSS)"
echo "   - Ruff (Python)"
echo "   - goimports (Go)"
echo ""
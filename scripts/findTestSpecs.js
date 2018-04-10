#!/bin/bash
PKG="/Users/larryhe/workspace/vault.git/WzlUI/src/test/js"
find "$PKG/vault" \
     "$PKG/components" \
     "$PKG/templates" \
     "$PKG/utils" \
     "$PKG/vault_admin" \
     "$PKG/veeva_vault" \
     "$PKG/vault_enterprise" \
     "$PKG/vofWidget" \
      -name '*.js' 

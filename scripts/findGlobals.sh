#!/bin/bash
JMVC="/Users/larryhe/workspace/vault.git/WzlUI/src/main/webapp/JMVC"
ANNOTATE="/Users/larryhe/workspace/vault.git/WzlUI/src/main/webapp/annotate"
COMM="/Users/larryhe/workspace/vault.git/WzlUI/src/main/webapp/components"
PKG="/Users/larryhe/workspace/vault.git/WzlUI/src/main/webapp/scripts/packages"
find "$JMVC/vault" \
     "$JMVC/vault_admin/controllers" \
     "$JMVC/vault_admin/models" \
     "$JMVC/vault_admin/resources" \
     "$JMVC/vault_binders/controllers" \
     "$JMVC/vault_binders/models" \
     "$JMVC/vault_binders/resources" \
     "$JMVC/vault_enterprise/controllers" \
     "$JMVC/vault_enterprise/models" \
     "$JMVC/veeva_vault/controllers" \
     "$JMVC/veeva_vault/models" \
     "$JMVC/veeva_vault/resources" \
     "$JMVC/veeva_vault/utilities" \
     "$ANNOTATE" \
     "$COMM" \
     "$PKG" -name '*.js' -exec jshint {} \; | grep 'is not defined'

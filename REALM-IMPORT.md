# Realm Import in Environments

**English | [Português](#importação-de-realm-nos-ambientes)**

---

## How It Works

Keycloak automatically imports JSON files from the `config-realm/academic-app` folder when started with the `--import-realm` command.

## Structure

```
config-realm/
└── academic-app/
    ├── academic-realm-realm.json       # Realm configuration
    └── academic-realm-users-0.json     # Realm users
```

## Automatic Import

All environments are configured to import automatically:

### DEV (docker-compose.yml)
```bash
docker-compose up -d
```
- Imports to: http://localhost:8080
- Realm: `academic-realm`

### QA (docker-compose.qa.yml)
```bash
docker-compose -f docker-compose.qa.yml up -d
```
- Imports to: http://localhost:8080
- Realm: `academic-realm`

### PROD (docker-compose.prod.yml)
```bash
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```
- Imports to: http://localhost:8080
- Realm: `academic-realm`

## Volume Mapping

All environments map:
```yaml
volumes:
  - ./config-realm/academic-app:/opt/keycloak/data/import
```

## Verify Import

After starting the environment, access the Admin Console and verify that the `academic-realm` realm was created:

1. Access: http://localhost:8080
2. Login: admin / admin (or environment credentials)
3. At the top left, verify that `academic-realm` appears in the realm list

## Update Configurations

To update realm configurations:

1. Make changes in the Admin Console
2. Export the realm:
   ```bash
   docker exec -it keycloak /opt/keycloak/bin/kc.sh export --dir /tmp/export --realm academic-realm
   docker cp keycloak:/tmp/export ./config-realm/academic-app
   ```
3. Replace the old JSON files
4. Restart the environment:
   ```bash
   docker-compose restart keycloak
   ```

## Notes

- ⚠️ Import only happens if the realm doesn't exist yet
- To re-import, remove the volume or manually delete the realm first
- Use `--import-realm` in the Keycloak command (already configured)

---

# Importação de Realm nos Ambientes

**[English](#realm-import-in-environments) | Português**

---

## Como Funciona

O Keycloak importa automaticamente os arquivos JSON da pasta `config-realm/academic-app` quando iniciado com o comando `--import-realm`.

## Estrutura

```
config-realm/
└── academic-app/
    ├── academic-realm-realm.json       # Configuração do Realm
    └── academic-realm-users-0.json     # Usuários do Realm
```

## Importação Automática

Todos os ambientes estão configurados para importar automaticamente:

### DEV (docker-compose.yml)
```bash
docker-compose up -d
```
- Importa em: http://localhost:8080
- Realm: `academic-realm`

### QA (docker-compose.qa.yml)
```bash
docker-compose -f docker-compose.qa.yml up -d
```
- Importa em: http://localhost:8080
- Realm: `academic-realm`

### PROD (docker-compose.prod.yml)
```bash
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```
- Importa em: http://localhost:8080
- Realm: `academic-realm`

## Volume Mapping

Todos os ambientes mapeiam:
```yaml
volumes:
  - ./config-realm/academic-app:/opt/keycloak/data/import
```

## Verificar Importação

Após subir o ambiente, acesse o Admin Console e verifique se o realm `academic-realm` foi criado:

1. Acesse: http://localhost:8080
2. Login: admin / admin (ou credenciais do ambiente)
3. No topo à esquerda, verifique se `academic-realm` aparece na lista de realms

## Atualizar Configurações

Para atualizar as configurações do realm:

1. Faça as alterações no Admin Console
2. Exporte o realm:
   ```bash
   docker exec -it keycloak /opt/keycloak/bin/kc.sh export --dir /tmp/export --realm academic-realm
   docker cp keycloak:/tmp/export ./config-realm/academic-app
   ```
3. Substitua os arquivos JSON antigos
4. Reinicie o ambiente:
   ```bash
   docker-compose restart keycloak
   ```

## Observações

- ⚠️ A importação só acontece se o realm não existir ainda
- Para reimportar, remova o volume ou delete o realm manualmente antes
- Use `--import-realm` no comando do Keycloak (já configurado)

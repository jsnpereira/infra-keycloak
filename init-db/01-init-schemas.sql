-- Script de inicialização do banco compartilhado em QA
-- Este script cria schemas separados para cada aplicação

-- Schema para o Keycloak
CREATE DATABASE IF NOT EXISTS keycloak_schema;

-- Schema para outros apps (exemplo)
CREATE DATABASE IF NOT EXISTS app1_schema;
CREATE DATABASE IF NOT EXISTS app2_schema;

-- Conceder permissões ao usuário compartilhado
GRANT ALL PRIVILEGES ON keycloak_schema.* TO 'appuser'@'%';
GRANT ALL PRIVILEGES ON app1_schema.* TO 'appuser'@'%';
GRANT ALL PRIVILEGES ON app2_schema.* TO 'appuser'@'%';

FLUSH PRIVILEGES;

-- Log para confirmar execução
SELECT 'Schemas criados com sucesso no ambiente QA!' AS status;

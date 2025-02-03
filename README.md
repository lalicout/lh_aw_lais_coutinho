# Projeto de Dados: Adventure Works

## Visão Geral
Transformar a Adventure Works em uma empresa data-driven, integrando dados de ERP (SAP), CRM (Salesforce), Web Analytics (Google Analytics) e Site (WordPress) para análises estratégicas.  
Pipeline desenvolvido com Fivetran, Snowflake, dbt e Airflow.

## Componentes
- **Extração & Carregamento:** Fivetran → Snowflake
- **Transformação:** dbt (testes e documentação integrada)
- **Orquestração:** Apache Airflow (DAG diária às 17:00 UTC/14:00 BRT)
- **Dashboards:** Power BI (Clientes & LTV; Vendas & Performance)

## Execução
1. Configure o ambiente (credenciais, variáveis, etc.).
2. Agende/execute a DAG no Airflow.
3. Acesse os dashboards no Power BI.

## Contato
[Lais Coutinho] – [Linkedin](https://www.linkedin.com/in/lais-coutinho-/)

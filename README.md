# Análise de Dados sobre Ataques Cibernéticos

## Introdução
A análise de dados sobre ataques cibernéticos, baseada em uma base de dados do Kaggle, busca entender o impacto dos ataques, identificar setores mais vulneráveis e avaliar a eficácia das medidas de segurança.

Base de dados utilizada: [Global Cybersecurity Threats 2015-2024](https://www.kaggle.com/datasets/atharvasoundankar/global-cybersecurity-threats-2015-2024)

## Perguntas que serão respondidas:
1. Quais setores sofreram mais ataques cibernéticos?
2. Quais países tiveram as maiores perdas financeiras com ataques cibernéticos?
3. Quais vulnerabilidades foram mais exploradas em ataques cibernéticos e causaram maiores perdas financeiras?
4. Qual a tendência de ataques cibernéticos por setor ao longo do tempo?
5. Qual setor teve maior aumento ou diminuição de ataques ao longo dos anos?
6. Quais setores sofreram as maiores perdas financeiras por ataques cibernéticos?
7. Quais mecanismos de defesa foram mais eficazes na redução do tempo de resolução dos ataques?

## Consultas SQL Utilizadas

### 1. Quais setores sofreram mais ataques cibernéticos?
```sql
SELECT `Target Industry`, COUNT(*) AS total_ataques
FROM sql3.dados_corrigidos
GROUP BY `Target Industry`
ORDER BY total_ataques DESC;
```
**Explicação:**
Agrupa os dados por setor e conta quantos ataques ocorreram em cada um, ordenando de forma decrescente.

---
### 2. Quais países tiveram as maiores perdas financeiras com ataques cibernéticos?
```sql
SELECT `Country`, SUM(`Financial Loss (in Million $)`) AS total_perda_financeira
FROM sql3.dados_corrigidos
GROUP BY `Country`
ORDER BY total_perda_financeira DESC;
```
**Explicação:**
Agrupa os dados por país e soma as perdas financeiras associadas aos ataques, ordenando de forma decrescente.

---
### 3. Quais vulnerabilidades foram mais exploradas em ataques cibernéticos e causaram maiores perdas financeiras?
```sql
SELECT `Security Vulnerability Type`, SUM(`Financial Loss (in Million $)`) AS total_perda_financeira
FROM sql3.dados_corrigidos
GROUP BY `Security Vulnerability Type`
ORDER BY total_perda_financeira DESC;
```
**Explicação:**
Agrupa os dados pelo tipo de vulnerabilidade de segurança e soma as perdas financeiras associadas a cada tipo, ordenando de forma decrescente.

---
### 4. Qual a tendência de ataques cibernéticos por setor ao longo do tempo?
```sql
SELECT `Target Industry`, `Year` AS ano, COUNT(*) AS total_ataques
FROM sql3.dados_corrigidos
WHERE `Year` IS NOT NULL
GROUP BY `Target Industry`, `Year`
ORDER BY `Target Industry`, `Year`;
```
**Explicação:**
Retorna o número de ataques por setor e por ano, filtrando apenas os registros com ano válido e ordenando por setor e ano.

---
### 5. Qual setor teve maior aumento ou diminuição de ataques ao longo dos anos?
```sql
SELECT `Target Industry`, `Year` AS ano, COUNT(*) AS total_ataques,
COALESCE(COUNT(*) - LAG(COUNT(*)) OVER (PARTITION BY `Target Industry` ORDER BY `Year`), 0) AS incremento_ataques
FROM sql3.dados_corrigidos
GROUP BY `Target Industry`, `Year`
ORDER BY `Target Industry`, ano;
```
**Explicação:**
Calcula a diferença no número de ataques por setor entre anos consecutivos utilizando a função LAG.

---
### 6. Quais setores sofreram as maiores perdas financeiras por ataques cibernéticos?
```sql
SELECT `Target Industry`, SUM(`Financial Loss (in Million $)`) AS total_perda_financeira
FROM sql3.dados_corrigidos
GROUP BY `Target Industry`
ORDER BY total_perda_financeira DESC;
```
**Explicação:**
Agrupa os dados por setor e soma as perdas financeiras associadas aos ataques, ordenando de forma decrescente.

---
### 7. Quais mecanismos de defesa foram mais eficazes na redução do tempo de resolução dos ataques?
```sql
SELECT `Defense Mechanism Used`, AVG(`Incident Resolution Time (in Hours)`) AS avg_time_resolution,
COUNT(*) AS total_ataques
FROM sql3.dados_corrigidos
WHERE `Defense Mechanism Used` IN ('Firewall', 'VPN', 'AI-based Detection')
GROUP BY `Defense Mechanism Used`
ORDER BY avg_time_resolution ASC;
```
**Explicação:**
Agrupa os dados pelo mecanismo de defesa utilizado, calcula a média do tempo de resolução dos ataques e ordena de forma crescente.

## Conclusão
Através dessas consultas, conseguimos identificar:
- Os setores mais atacados e aqueles com maiores perdas financeiras.
- Os países mais afetados economicamente.
- As vulnerabilidades mais exploradas e sua relação com perdas financeiras.
- As tendências de ataques ao longo do tempo.
- Os mecanismos de defesa mais eficazes para resolver ataques rapidamente.

Essas informações são fundamentais para a formulação de estratégias de segurança cibernética mais eficientes e direcionadas.


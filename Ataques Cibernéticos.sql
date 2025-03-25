#Introdução:
/*A análise de dados sobre ataques cibernéticos, baseada em uma base de dados do Kaggle, busca entender o 
impacto dos ataques, identificar setores mais vulneráveis e avaliar a eficácia das medidas de segurança. 
*/

#Perguntas que serão respondidas:
/*
1. Quais setores sofreram mais ataques cibernéticos?
2. Quais países tiveram as maiores perdas financeiras com ataques cibernéticos?
3. Quais vulnerabilidades foram mais exploradas em ataques cibernéticos e causaram maiores perdas financeiras?
4. Qual a tendência de ataques cibernéticos por setor ao longo do tempo?
5. Qual setor teve maior aumento ou diminuição de ataques ao longo dos anos?
6. Quais setores sofreram as maiores perdas financeiras por ataques cibernéticos?
7. Quais mecanismos de defesa foram mais eficazes na redução do tempo de resolução dos ataques?
*/

SELECT * FROM sql3.dados_corrigidos;

#1. Quais setores sofreram mais ataques cibernéticos?
SELECT `Target Industry`, COUNT(*) AS total_ataques
FROM sql3.dados_corrigidos
GROUP BY `Target Industry`
ORDER BY total_ataques DESC;
/*
Explicação:
Esta consulta agrupa os dados por setor (campo Target Industry) e conta quantos ataques ocorreram em cada 
setor. O resultado é ordenado pelo número total de ataques de forma decrescente.
*/


#2. Quais países tiveram as maiores perdas financeiras com ataques cibernéticos??
SELECT `Country`, SUM(`Financial Loss (in Million $)`) AS total_perda_financeira
FROM sql3.dados_corrigidos
GROUP BY `Country`
ORDER BY total_perda_financeira DESC;
/*
Explicação:
Aqui, a consulta agrupa os dados por país (Country) e calcula a soma das perdas financeiras associadas aos 
ataques cibernéticos em cada país (campo Financial Loss (in Million $)). O resultado é ordenado de forma 
decrescente pela perda financeira total.
*/


#3. Quais vulnerabilidades foram mais exploradas em ataques cibernéticos e causaram maiores perdas financeiras?
SELECT `Security Vulnerability Type`, SUM(`Financial Loss (in Million $)`) AS total_perda_financeira
FROM sql3.dados_corrigidos
GROUP BY `Security Vulnerability Type`
ORDER BY total_perda_financeira DESC;
/*
Explicação:
Esta consulta agrupa os dados pelo tipo de vulnerabilidade de segurança (Security Vulnerability Type) e 
calcula a soma das perdas financeiras associadas a cada tipo de falha de segurança. O resultado é ordenado 
pela perda financeira total de forma decrescente.
*/


#4. Qual a tendência de ataques cibernéticos por setor ao longo do tempo?
SELECT 
`Target Industry`, 
`Year` AS ano, 
COUNT(*) AS total_ataques
FROM sql3.dados_corrigidos
WHERE `Year` IS NOT NULL
GROUP BY `Target Industry`, `Year`
ORDER BY `Target Industry`, `Year`;
/*
Explicação:
Esta consulta retorna o número de ataques por setor (Target Industry) e por ano (Year). Ela filtra apenas os
 registros onde o ano não é nulo e agrupa os dados por setor e ano. O resultado é ordenado por setor e ano.
*/


#5. Qual setor teve maior aumento ou diminuição de ataques ao longo dos anos?
SELECT 
`Target Industry`, 
`Year` AS ano, 
COUNT(*) AS total_ataques,
COALESCE(COUNT(*) - LAG(COUNT(*)) OVER (PARTITION BY `Target Industry` ORDER BY `Year`), 0) AS incremento_ataques
FROM sql3.dados_corrigidos
GROUP BY `Target Industry`, `Year`
ORDER BY `Target Industry`, ano;
/*
Explicação:
Aqui, a consulta não só retorna o número de ataques por setor e ano, mas também calcula o incremento de 
ataques de um ano para o outro utilizando a função LAG para comparar o valor do ano anterior. Se não houver 
um valor anterior, o incremento é considerado 0, devido ao uso de COALESCE. O resultado é ordenado por setor e ano.
*/


#6. Quais setores sofreram as maiores perdas financeiras por ataques cibernéticos?
SELECT 
`Target Industry`, 
SUM(`Financial Loss (in Million $)`) AS total_perda_financeira
FROM sql3.dados_corrigidos
GROUP BY `Target Industry`
ORDER BY total_perda_financeira DESC;
/*
Explicação:
Esta consulta agrupa os dados por setor e soma as perdas financeiras associadas aos ataques cibernéticos 
em cada setor. O resultado é ordenado pela perda financeira total de forma decrescente.
*/


#7. Quais mecanismos de defesa foram mais eficazes na redução do tempo de resolução dos ataques?
SELECT 
`Defense Mechanism Used`, 
AVG(`Incident Resolution Time (in Hours)`) AS avg_time_resolution,
COUNT(*) AS total_ataques
FROM sql3.dados_corrigidos
WHERE `Defense Mechanism Used` IN ('Firewall', 'VPN', 'AI-based Detection')
GROUP BY `Defense Mechanism Used`
ORDER BY avg_time_resolution ASC;
/*
Explicação:
Esta consulta agrupa os dados pelo mecanismo de defesa utilizado (Defense Mechanism Used), calcula a média 
do tempo de resolução dos ataques (campo Incident Resolution Time (in Hours)) e conta o número de ataques 
associados a cada mecanismo de defesa. O resultado é ordenado pela média do tempo de resolução de forma 
crescente.
*/

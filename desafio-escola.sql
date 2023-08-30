-- QUESTÃO 1: nome do curso, número e data de início de cada turma de cada curso.

SELECT curso.nome AS curso,
turma.numero AS turma, 
turma.inicio AS inicio
FROM tb_curso AS curso
INNER JOIN tb_turma AS turma ON turma.curso_id = curso.id;


-- QUESTÃO 2: nome do curso, número da turma, nome e CPF dos alunos de cada curso e cada turma.

SELECT 
curso.nome AS curso,
turma.numero AS turma,
aluno.nome AS aluno,
aluno.cpf AS cpf
FROM tb_aluno AS aluno
INNER JOIN tb_matricula AS matricula ON aluno.cpf = matricula.aluno_id
INNER JOIN tb_turma AS turma ON matricula.turma_id = turma.id
INNER JOIN tb_curso AS curso ON turma.curso_id = curso.id;

-- QUESTÃO 3: listagem de data e nota de todas avaliações já ocorridas, juntamente com
-- nome, nota obtida por cada aluno em cada avaliação, e também qual a porcentagem de
-- nota obtida em relação à nota da avaliação.


SELECT
avaliacao.data AS "data",
avaliacao.nota AS nota,
aluno.nome AS nome,
resultado.nota_obtida AS nota_obtida,
ROUND(SUM(resultado.nota_obtida/avaliacao.nota) * 100, 2) AS porcentagem
FROM tb_aluno AS aluno
INNER JOIN tb_resultado AS resultado ON aluno.cpf = resultado.aluno_id
INNER JOIN tb_avaliacao AS avaliacao ON resultado.avaliacao_id = avaliacao.id
GROUP BY data, nota, nome, nota_obtida
ORDER BY data DESC, nome ASC;


-- QUESTÃO 4: nome e nota total dos alunos da turma 10 (ATENÇÃO: você deve restringir a
-- turma pelo número 10 dela, e não pelo id 2).

SELECT 
aluno.nome AS nome,
SUM(resultado.nota_obtida) AS total
FROM tb_aluno AS aluno
INNER JOIN tb_resultado AS resultado ON aluno.cpf = resultado.aluno_id
INNER JOIN tb_avaliacao AS avaliacao ON resultado.avaliacao_id = avaliacao.id
INNER JOIN tb_turma AS turma ON avaliacao.turma_id = turma.id
WHERE turma.numero = 10
GROUP BY aluno.cpf
ORDER BY aluno.nome

# Oficina
Projeto de uma base de dados de uma oficina.

## Narrativa
* Sistema de controle e gerenciamento de execução de ordens de serviço em uma oficina mecânica.
* Clientes levam veículos à oficina mêcanica para serem consertados ou para passarem por revisões periódicas
* Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com a data de entrega.
* A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra.
* O valor de cada peça também irá compor a OS
* O cliente autoriza a execução dos serviços
* A mesma equipe avalia e executa os serviços
* Os mecânicos possuem código, nome, endereço e especialidade
* Cada OS possui: n°, data de emissão, valor, status e uma data para conclusão dos trabalhos.
* Uma OS pode ser composta por vários serviços e um mesmo serviço pode estar contido em mais de uma OS.
* Uma OS pode ter vários tipos de peça e uma peça pode estar presente em mais de uma OS.

## Resultado 
<div align="center">
<img src="https://user-images.githubusercontent.com/102488476/188620928-2656e47e-3bba-4a5a-bf43-3995cb42a169.png">
</div>

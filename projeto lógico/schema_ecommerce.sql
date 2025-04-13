-- criação banco de dados para o cenário de E-commerce
-- drop database projeto_ecommerce_dio;

create database projeto_ecommerce_dio;
use projeto_ecommerce_dio;

-- criar tabela pessoa física
create table pFisicas(
	cpf CHAR(11) primary key,
	dataNascimento DATE NOT NULL,
	nomeCompleto VARCHAR(45) NOT NULL,
	constraint unique_pFisica unique (cpf)
);
desc pFisicas;

-- criar tabela pessoa jurídica
create table pJuridicas(
	cnpj CHAR(14) primary key,
	dataCriacao DATE NOT NULL,
	razaoSocial VARCHAR(255) NOT NULL,
	nomeFantasia VARCHAR(45) NOT NULL,
	responsavel VARCHAR(45) NOT NULL,
	constraint unique_pFisica unique (cnpj)
);
desc pJuridicas;

-- criar tabela cliente
create table clientes(
	idCliente INT auto_increment primary key,
	endereco VARCHAR(255) NOT NULL,
	tipo ENUM('pFisica','pJuridica'),
	cpf CHAR(11),
	cnpj CHAR(14),
	constraint fk_clientes_pFisicas foreign key (cpf) references pFisicas(cpf),
	constraint fk_clientes_pJuridicas foreign key (cnpj) references pJuridicas(cnpj)
) auto_increment = 1;
desc clientes;

-- criar tabela produto
create table produtos(
	idProduto INT auto_increment primary key,
	nomeProduto varchar(20) NOT NULL,
	categoria ENUM('Vestuário', 'Eletrônicos', 'Brinquedos', 'Alimentos’, Bebidas' e 'Eletrodomésticos', ) NOT NULL,
	descricao VARCHAR(255),
	avaliacao float default 0,
	valorFrete FLOAT NOT NULL
) auto_increment = 1;
desc produtos;

-- criar tabela entrega
create table entregas(
	idEntrega INT auto_increment primary key,
	statusEntrega ENUM('Pagamento pendente', 'Em preparação', 'Postado', 'Em trânsito', 'Entregue') default 'Pagamento pendente',
	codRastreio VARCHAR(20),
) auto_increment = 1;
desc entregas;

-- criar tabela pedido
create table pedidos(
	idPedido INT auto_increment,
	idCliente INT,
	idEntrega INT,
	statusPedido ENUM('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
	descricaoPedido VARCHAR(255),
	freteValor FLOAT default 10,
	pagamentoEmCartao bool default false,
	primary key(idPedido, idCliente),
	constraint fk_pedidos_clientes foreign key (idCliente) references clientes(idCliente),
	constraint fk_pedidos_entregas foreign key (idEntrega) references entregas(idEntrega),
	constraint unique_pedidos unique (idPedido)
) auto_increment = 1;
desc pedidos;

-- criar tabela pagamento
create table pagamentos(
	idCliente INT,
	idPedido INT,
	formaPagamento ENUM('Boleto', 'Pix', 'Cartão', 'Dois cartões') default 'Boleto',
	statusPagamento ENUM('Pendente', 'Negado', 'Aprovado') default 'Pendente',
	primary key(idCliente, idPedido),
	constraint fk_pagamentos_clientes foreign key (idCliente) references clientes(idCliente),
	constraint fk_pagamentos_pedidos foreign key (idPedido) references pedidos(idPedido)
);
desc pagamentos;

-- criar tabela fornecedor
create table fornecedores(
	idFornecedor INT auto_increment,
	cnpj CHAR(14),
	contato VARCHAR(11) NOT NULL,
	primary key(idFornecedor, cnpj),
	constraint fk_fornecedores_pJuridicas foreign key (cnpj) references pJuridicas(cnpj),
    constraint unique_fornecedores unique (idFornecedor)
) auto_increment = 1;
desc fornecedores;

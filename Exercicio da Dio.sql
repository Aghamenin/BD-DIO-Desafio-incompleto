-- Criação de banco de dados para o cenário de E-Commerce 

-- drop database ecommerce;
create database ecommerce;
use ecommerce;

show tables;


-- Criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar (20),
    cpf char(11) not null,
    Address varchar(255),
    constraint unique_client_cpf unique(cpf)
);
 select * from clients;
alter table clients auto_increment=1;

-- Criar tabela produto
-- size equivale a dimensão do produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(30),
    classification_kids bool default false,
    category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    Avaliação float default 0,
    size varchar(10)
    );
    
-- para ser continuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas  necessárias
-- além disso, reflita   essa modificação no diagrama de esquema  relacional
-- criar constraint relacionadas ao pagamento
 
 -- Forma de pagamento
create table payments(
	idClient int,
    idPayment int,
	typePayment enum('Boleto', 'Cartão', 'Dois cartões'),
    limitavailable float,
    primary key(idClient, idPayment)
);

drop table payments;

-- Criar tabela pedido
create table orders(
	idOrders int auto_increment primary key,
    idOrdersClient int,
    ordersStatus enum('cancelado', 'confirmado', 'em processamento') default 'Em processamento',
    OrdersDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    idPayemnt int,
    constraint fk_orders_Client foreign key(idOrdersClient) references Clients(idClient)
			on update cascade
);

-- criar tabela  estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- criar tabela  fornecedor
create table Supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique(CNPJ)
);

-- criar tabela  vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbsName varchar(255),
    CNPJ char (15),
    CPF char(11),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique(CNPJ),
	constraint unique_cPF_seller unique(CPF)
);

-- criar tabela produto vendedor
create table productSeller(
	idSeller int,
    idPproduct int ,
    prodQuantity  int default 1,
    primary key(idSeller, idPproduct),
    constraint fk_product_seller foreign key(idSeller) references seller(idSeller),
    constraint fk_product_product foreign key(idPproduct) references product(idProduct)
);

-- criar tabela produto pedido
create table productOrder(
idPOproduct int,
idPOorder int,
poQuantity int default 1,
poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
primary key(idPOproduct, idPOorder),
constraint fk_productorder_seller foreign key(idPOproduct) references product(idProduct),
constraint fk_productorder_product foreign key(idPOorder) references orders(idOrders)
);

-- criar tabela produto em estoque
create table storageLocation(
	idProduct int,
	idLstorage int,
	location varchar(255) not null,
	primary key(idProduct, idLstorage),
	constraint fk_storage_location_product foreign key(idProduct) references product(idProduct),
	constraint fk_storage_location_storage foreign key(idLstorage) references productStorage( idprodStorage)
);

-- crira tabela produto fornecedor

create table productSupplier(
	idPsSupplier int,
	idPsProduct int,
	quantity int not null,
	primary key(idPsSupplier, idPsProduct),
	constraint fk_product_supplier_supplier foreign key(idPsSupplier) references supplier(idSupplier),
	constraint fk_product_supplier_product foreign key(idPsProduct) references product( idProduct)
);





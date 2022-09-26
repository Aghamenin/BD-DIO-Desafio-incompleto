-- inserção de dados e queries
use ecommerce;

show tables;



-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, cpf, Address)
		  values('Maria', 'M', 'Silva', '123456789', 'rua silva de prata 29, Carangola- Cidade das flores'),
				('Matheus', 'O', 'Pimentel', '987654321', 'rua alemeda 289, Centro - Cidade das flores' ),
                ('Ricardo', 'F', 'Silva', '45678913', 'avedida alemeda vinha 1009, Centro - Cidade das flores'),
                ('Júlia', 'S', 'França', '789123456', 'rua laranjeira 861, Centro - Cidades das flores'),
                ('Roberta', 'G', 'Assis', '98745631', 'Avenida Koller 19, Centro - Cidades das flores'),
                ('Isabela', 'M', 'Cruz', '654789123', 'rua alameda das flores 28, Centro - Cidade das flores');
                
                select * from Clients;
                
-- idProduct, Pname, classificarion_kids bool, category('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis'), Avaliação, size
insert into product (Pname, classification_kids, category, Avaliação, size)
				values('Fone de Ouvido',False, 'Eletrônico', '4', null),
					  ('Barbie Elsa',True, 'Brinquedos', '3', null),
                      ('Body Carters', True, 'Vestimenta', '5', null),
                      ('Microfone Vedo - Youtube',False, 'Eletrônico', '4', null),
                      ('Sofá Retrátil', False, 'Móveis', '3', '3x57x80'),
                      ('Farinha de arroz', False, 'Alimentos', '2', null),
                      ('Fire Stick Amazon', False, 'Eletrônico', '3', null);
                      
                      select * from product;

-- idOrders, idOrdersClient, ordersStatus, OrdersDescription, sendValue, paymentCash
insert into orders (idOrdersClient, ordersStatus, OrdersDescription, sendValue, paymentCash) values
						(1, default, 'Compra via aplicativo', null, 1),
						(2, default, 'Compra via aplicativo', 50, 0),
                        (3, 'confirmado', null, null, 1),
                        (4 ,default, 'Compra via web site', 150, 0);
                        
select * from orders;

-- idPOproduct, idPOorder, poQuantity, poStatus
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values 
						(1, 1, 2, null),
                        (2, 1, 1, null),
                        (3, 2, 1, null);
                        
select * from productOrder;
                        
-- idProdStorage, storageLocation, quantity 
insert into productStorage(storageLocation, quantity )values                     
                ('Rio de Janeiro', '1000'),
                ('Rio de Janeiro', '500'),
                ('São Paulo', '10'),
                ('São Paulo', '100'),
                ('São Paulo', '10'),
                ('Brasília', '60');
                
  select * from productStorage;
  
  -- idProduct, idLstorage, location
 insert into storageLocation (idProduct, idLstorage, location)values  
					(1, 2, 'RJ'),
                    (2, 6, 'GO');
      
  select * from storageLocation;    
      
-- idSupplier, SocialName, CNPJ, contact
insert into supplier ( SocialName, CNPJ, contact)values 
					('Almeidas e filhos', '123456789123456', '21985474'),
                    ('Eletrônicos Silva', '854519649143457', '21985484'),
                    ('Eletrônicos Valma', '934567893934695', '21975474');

select * from supplier;

-- idPsSupplier, idPsProduct, quantity			
insert into productSupplier(idPsSupplier, idPsProduct, quantity) values
					(1, 1, 500),
                    (1, 2, 400),
                    (2, 4, 633),
                    (3, 3, 5),
                    (2, 5, 10);

select * from productSupplier;

-- idSeller, SocialName, AbsName, CNPJ, CPF, location, contact
insert into seller(SocialName, AbsName, CNPJ, CPF, location, contact) values
						('Tech Eletrônics', null, 12456789456321, null, 'Rio de Janeiro', 219946287),
                        ('Botique Durgas',null, null, 123456783, 'Rio de Janeiro', 219567895),
                        ('Kids World',null, 456789123654485,null, 'São Paulo', 1198657484);
  
  select * from seller;
  
  -- idSeller, idPproduct, prodQuantity
 insert into productSeller(idSeller, idPproduct, prodQuantity) values
						(1, 6, 80),
                        (2, 7, 10);
   
   select * from productSeller;
   
   -- idClient, idPayment, typePayment('Boleto', 'Cartão', 'Dois cartões'), limitavailable
   insert into payments(idClient , idPayment, typePayment, limitavailable) values
						(1, 123456, 'Boleto', 300),
                        (2, 678901, 'Cartão', 500),
                        (3, 234567, 'Cartão', 700),
                        (4, 789123, 'Boleto', 500),
                        (5, 567234, 'Cartão', 100),
                        (6, 780678, 'Boleto', 900);
                        
 select * from payments;                       
                       
                        
                        
   
 -- buscando clientes que fizeram a compra  
   select count(*) from clients;
   
 select concat(Fname, ' ' ,Lname) Client , idOrders as Request, ordersStatus as  Status from clients c, orders o where c.idClient = idOrdersClient;
 
 
 -- comparação de ruas
 select Fname, Lname from Clients where Address LIKE '%Cidade das flores%';
 select Fname, Lname from Clients where Address LIKE 'rua alemeda%';
 
-- teste de comparação de rua 
select Pname from product as p where exists (select * from Clients as c where Pname=Address);

-- Ordenando por nome
select concat( Fname,' ' ,Lname)  Client from Clients	order by(Fname);
select concat( Fname,' ' ,Lname)  Client from Clients	order by(Fname) desc;

-- ordenando por id
select idClient,concat( Fname,' ' ,Lname)  Client from Clients order by(idClient);


select * from Clients c join orders o on o.idOrders = c.idClient;    
select * from Clients c join payments p on p.idPayment = c.idClient;                              


-- Recuperar quantos  pedidos foram  realizados em compra/pagamento
select c.idClient, Fname, count(*) as Number_of_orders from clients c
				  inner join orders o ON c.idClient = o.idOrdersClient
                  inner join productOrder p ON p.idPOorder = o.idOrders;
                  
                  
                  
				 


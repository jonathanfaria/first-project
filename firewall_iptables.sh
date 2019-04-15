    #!/bin/sh
     # Modelo de configuração de firewall
     # Autor: Gleydson M. Silva
     # Data: 05/09/2001
     # Descrição: Produzido para ser distribuído livremente, acompanha o guia
     #             Foca GNU/Linux. http://www.guiafoca.org
     #

     # É assumido um sistema usando kmod para carga automática dos módulos usados por
     # esta configuração do firewall:
     # ipt_filter
     # ipt_nat
     # ipt_conntrack
     # ipt_mangle
     # ipt_TOS
     # ipt_MASQUERADE
     # ipt_LOG

     # Se você tem um kernel modularizado que não utiliza o kmod, será necessário
     # carregar estes módulos via modprobe, insmod ou iptables --modprobe=modulo

     ##### Definição de política padrão do firewall #####
     # Tabela filter
     iptables -t filter -P INPUT DROP
     iptables -t filter -P OUTPUT ACCEPT
     iptables -t filter -P FORWARD DROP
     # Tabela nat
     iptables -t nat -P PREROUTING ACCEPT
     iptables -t nat -P OUTPUT ACCEPT
     iptables -t nat -P POSTROUTING DROP
     # Tabela mangle
     iptables -t mangle -P PREROUTING ACCEPT
     iptables -t mangle -P OUTPUT ACCEPT


     ##### Proteção contra IP Spoofing #####
     for i in /proc/sys/net/ipv4/conf/*/rp_filter; do
      echo 1 >$i
     done

     ##### Ativamos o redirecionamento de pacotes (requerido para NAT) #####
     echo "1" >/proc/sys/net/ipv4/ip_forward

     # O iptables define automaticamente o número máximo de conexões simultâneas
     # com base na memória do sistema. Para 32MB = 2048, 64MB = 4096, 128MB = 8192,
     # sendo que são usados 350 bytes de memória residente para controlar
     # cada conexão.
     # Quando este limite é excedido a seguinte mensagem é mostrada:
     #  "ip_conntrack: maximum limit of XXX entries exceed"
     #
     # Como temos uma rede simples, vamos abaixar este limite. Por outro lado isto
     # criará uma certa limitação de tráfego para evitar a sobrecarga do servidor.
     echo "2048" > /proc/sys/net/ipv4/ip_conntrack_max


     ###############################################################
     #                      Tabela filter                          #
     ###############################################################

     ##### Chain INPUT #####
     # Criamos um chain que será usado para tratar o tráfego vindo da Internet e
     iptables -N ppp-input

     # Aceita todo o tráfego vindo do loopback e indo pro loopback
     iptables -A INPUT -i lo -j ACCEPT
     # Todo tráfego vindo da rede interna também é aceito
     iptables -A INPUT -s 192.168.1.0/24 -i eth0 -j ACCEPT

     # Conexões vindas da interface ppp0 são tratadas pelo chain ppp-input
     iptables -A INPUT -i ppp  -j ppp-input

     # Qualquer outra conexão desconhecida é imediatamente registrada e derrubada
     iptables -A INPUT -j LOG --log-prefix "FIREWALL: INPUT "
     iptables -A INPUT -j DROP


     ##### Chain FORWARD ####
     # Permite redirecionamento de conexões entre as interfaces locais
     # especificadas abaixo. Qualquer tráfego vindo/indo para outras
     # interfaces será bloqueado neste passo
     iptables -A FORWARD -d 192.168.1.0/24 -i ppp  -o eth0 -j ACCEPT
     iptables -A FORWARD -s 192.168.1.0/24 -i eth0 -o ppp  -j ACCEPT
     iptables -A FORWARD -j LOG --log-prefix "FIREWALL: FORWARD "
     iptables -A FORWARD -j DROP


     ##### Chain ppp-input ####
     # Aceitamos todas as mensagens icmp vindas de ppp0 com certa limitação
     # O tráfego de pacotes icmp que superar este limite será bloqueado
     # pela regra "...! ESTABLISHED,RELATED -j DROP" no final do
     # chain ppp-input
     #
     iptables -A ppp-input -p icmp -m limit --limit 2/s -j ACCEPT

     # Primeiro aceitamos o tráfego vindo da Internet para o serviço www (porta 80)
     iptables -A ppp-input -p tcp --dport 80 -j ACCEPT

     # A tentativa de acesso externo a estes serviços serão registrados no syslog
     # do sistema e serão bloqueados pela última regra abaixo.
     iptables -A ppp-input -p tcp --dport 21 -j LOG --log-prefix "FIREWALL: ftp "
     iptables -A ppp-input -p tcp --dport 25 -j LOG --log-prefix "FIREWALL: smtp "
     iptables -A ppp-input -p udp --dport 53 -j LOG --log-prefix "FIREWALL: dns "
     iptables -A ppp-input -p tcp --dport 110 -j LOG --log-prefix "FIREWALL: pop3 "
     iptables -A ppp-input -p tcp --dport 113 -j LOG --log-prefix "FIREWALL: identd "
     iptables -A ppp-input -p udp --dport 111 -j LOG --log-prefix "FIREWALL: rpc"
     iptables -A ppp-input -p tcp --dport 111 -j LOG --log-prefix "FIREWALL: rpc"
     iptables -A ppp-input -p tcp --dport 137:139 -j LOG --log-prefix "FIREWALL: samba "
     iptables -A ppp-input -p udp --dport 137:139 -j LOG --log-prefix "FIREWALL: samba "
     # Bloqueia qualquer tentativa de nova conexão de fora para esta máquina
     iptables -A ppp-input -m state --state ! ESTABLISHED,RELATED -j LOG --log-prefix "FIREWALL: ppp-in "
     iptables -A ppp-input -m state --state ! ESTABLISHED,RELATED -j DROP
     # Qualquer outro tipo de tráfego é aceito
     iptables -A ppp-input -j ACCEPT


     #######################################################
     #                   Tabela nat                        #
     #######################################################

     ##### Chain POSTROUTING #####
     # Permite qualquer conexão vinda com destino a lo e rede local para eth0
     iptables -t nat -A POSTROUTING -o lo -j ACCEPT
     iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j ACCEPT

     # Não queremos que usuários tenham acesso direto a www e smtp da rede externa, o
     # squid e smtpd do firewall devem ser obrigatoriamente usados. Também registramos
     # as tentativas para monitorarmos qual máquina está tentando conectar-se diretamente.
     iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o ppp  -p tcp --dport 80 -j LOG --log-prefix "FIREWALL: SNAT-www "
     iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o ppp  -p tcp --dport 25 -j LOG --log-prefix "FIREWALL: SNAT-smtp "
     iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o ppp  -p tcp --dport 25 -j DROP
     iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o ppp  -p tcp --dport 80 -j DROP
     # É feito masquerading dos outros serviços da rede interna indo para a interface
     # ppp0
     iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o ppp  -j MASQUERADE

     # Qualquer outra origem de tráfego desconhecida indo para eth0 (conexões vindas
     # de ppp ) são bloqueadas aqui
     iptables -t nat -A POSTROUTING -o eth0 -d 192.168.1.0/24 -j LOG --log-prefix "FIREWALL: SNAT unknown"
     iptables -t nat -A POSTROUTING -o eth0 -d 192.168.1.0/24 -j DROP
     # Quando iniciamos uma conexão ppp, obtermos um endereço classe A (10.x.x.x) e após
     # estabelecida a conexão real, este endereço é modificado. O tráfego indo para
     # a interface ppp não deverá ser bloqueado. Os bloqueios serão feitos no
     # chain INPUT da tabela filter
     iptables -t nat -A POSTROUTING -o ppp  -j ACCEPT

     # Registra e bloqueia qualquer outro tipo de tráfego desconhecido
     iptables -t nat -A POSTROUTING -j LOG --log-prefix "FIREWALL: SNAT "
     iptables -t nat -A POSTROUTING -j DROP


     ###############################################
     #                Tabela mangle                #
     ###############################################

     ##### Chain OUTPUT #####
     # Define mínimo de espera para os serviços ftp, telnet, irc e DNS, isto
     # dará uma melhor sensação de conexão em tempo real e diminuirá o tempo
     # de espera para conexões que requerem resolução de nomes.
     iptables -t mangle -A OUTPUT -o ppp  -p tcp --dport 21 -j TOS --set-tos 0x10
     iptables -t mangle -A OUTPUT -o ppp  -p tcp --dport 23 -j TOS --set-tos 0x10
     iptables -t mangle -A OUTPUT -o ppp  -p tcp --dport 6665:6668 -j TOS --set-tos 0x10
     iptables -t mangle -A OUTPUT -o ppp  -p udp --dport 53 -j TOS --set-tos 0x10

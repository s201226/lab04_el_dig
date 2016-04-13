library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ReflexCircuit is
	port(sw:in std_logic_vector(7 downto 0);
		key:in std_logic_vector(1 downto 0);
		clock_50:in std_logic;
		hex3,hex2,hex1,hex0:out std_logic_vector(0 to 6);
		ledr:out std_logic_vector(1 downto 0));
end ReflexCircuit;


architecture behavioral of ReflexCircuit is

component SincCounter_nbit is
	generic(nbit: positive:=16);
	port(enable,clk,resetn:in std_logic;
		num:out unsigned(nbit-1 downto 0));
end component;

component ScreenDriverBCD is
	port(enable:in std_logic;
		numBCD:in unsigned(15 downto 0);
		hex3,hex2,hex1,hex0:out std_logic_vector(0 to 6));
end component;

component Control is
	port(key,start,clk:in std_logic;
		en_c,en_s,en_l,resetn:out std_logic);
end component;

signal num00,to_ms,en_c,en_s,en_l,clk,resetn,start:std_logic;
signal num:unsigned(15 downto 0);

begin
	clk<=clock_50;
	
	cont_ms:SincCounter_nbit port map
		(enable=>en_c,
		clk=>clk,
		resetn=>resetn,
		num=>num00);
	
	process(num00)
	begin
		if(num00=49999 and enable='1') then to_ms<='1'; else to_ms<='0'; end if;
	end process;
	
	count:SincCounter_nbit port map
		(enable=>to_ms,
		clk=>clk,
		resetn=>resetn,
		num=>num);
		
	screen:ScreenDriverBCD port map
		(enable=>en_s,
		numBCD=>num,
		hex3=>hex3,
		hex2=>hex2,
		hex1=>hex1,
		hex0=>hex0);
		
	process(sw,num)
	variable i:positive;
	variable flag:std_logic;
	variable sw_c:std_logic_vector(15 downto 0);
	begin
		sw_c:="00000000"&sw;
		flag:='1';
		for i in 0 to 15 loop
			if((num(i)xor sw_c(i))='1') then flag:='0';
			end if;
		end loop;
		start<=flag;
	end process;
	
	cu:Control port map
		(key=>key(0),
		start=>start,
		clk=>clk,
		en_c=>en_c,
		en_s=>en_s,
		en_l=>en_l,
		resetn=>resetn);
		
	ledr<='0'&en_l;
	
end behavioral;

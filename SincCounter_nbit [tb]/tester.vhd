library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tester is
	generic(nbit: positive:=16);
	port(key:buffer std_logic_vector(0 downto 0);
		sw:buffer std_logic_vector(1 downto 0);
		hex3,hex2,hex1,hex0:in std_logic_vector(0 to 6);
		error:out std_logic);
end tester;


architecture behavioral of tester is

component coder_7seg is
	port(hex:in std_logic_vector(0 to 6);
		num:out unsigned(3 downto 0));
end component;

signal num,num_hex:integer;
signal hex3n,hex2n,hex1n,hex0n:unsigned(3 downto 0);

begin

	P1:process
	begin
		sw(0)<='0','1' after 6ns;
		sw(1)<='1','0' after 223ns;
		wait for 250ns;
	end process;
	
	P12:process
	begin
		key(0)<='0','1' after 10ns;
		wait for 20ns;
	end process;
	
	P2:process(sw(0),key(0))
	variable numero:integer;
	begin
		if(sw(0)='0') then numero:=0;
		elsif(key(0)'event and key(0)='1') then
			if(sw(1)='1') then numero:=numero+1;
			end if;
		end if;
		num<=numero;
	end process;
	
	dec00:coder_7seg port map(hex0,hex0n);
	dec01:coder_7seg port map(hex1,hex1n);
	dec02:coder_7seg port map(hex2,hex2n);
	dec03:coder_7seg port map(hex3,hex3n);
	num_hex<=(to_integer(hex3n&hex2n&hex1n&hex0n));
	
	P3:process(num_hex)
	begin
		if(num/=num_hex) then
			error<='1';
		else error<='0';
		end if;
	end process;
end behavioral;
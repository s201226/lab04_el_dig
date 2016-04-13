library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tester is
	generic(nbit: positive:=16);
	port(sw:out std_logic_vector(7 downto 0);
		key:out std_logic_vector(1 downto 0);
		clock_50:out std_logic;
		hex3,hex2,hex1,hex0:in std_logic_vector(0 to 6);
		ledr:in std_logic_vector(1 downto 0);
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
	sw<="00010000";
	key(1)<='0';
	error<='0';
	
	P1:process
	begin
		clock_50<='0','1' after 10ns;
		wait for 20ns;
	end process;
	
	P12:process
	begin
		wait for 5ns;
		key(0)<='0','1' after 15ns,'0' after 30ns,'1' after 45ns;
		wait for 200ns;
	end process;
	
	dec00:coder_7seg port map(hex0,hex0n);
	dec01:coder_7seg port map(hex1,hex1n);
	dec02:coder_7seg port map(hex2,hex2n);
	dec03:coder_7seg port map(hex3,hex3n);
	num_hex<=(to_integer(hex3n&hex2n&hex1n&hex0n));

end behavioral;
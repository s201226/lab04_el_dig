library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;


architecture test of testbench is

component SincCounter_nbit is
	generic(nbit: positive:=16);
	port(key:in std_logic_vector(0 downto 0);
		sw:in std_logic_vector(1 downto 0);
		hex3,hex2,hex1,hex0:out std_logic_vector(0 to 6));
end component;

component tester is
	generic(nbit: positive:=16);
	port(key:buffer std_logic_vector(0 downto 0);
		sw:buffer std_logic_vector(1 downto 0);
		hex3,hex2,hex1,hex0:in std_logic_vector(0 to 6);
		error:out std_logic);
end component;

signal error:std_logic;
signal key:std_logic_vector(0 downto 0);
signal sw:std_logic_vector(1 downto 0);
signal hex3,hex2,hex1,hex0:std_logic_vector(0 to 6);

begin
	uut:SincCounter_nbit port map(key,sw,hex3,hex2,hex1,hex0);
	testUnit:tester port map(key,sw,hex3,hex2,hex1,hex0,error);
end test;
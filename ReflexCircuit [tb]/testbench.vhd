library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;


architecture test of testbench is

component ReflexCircuit is
	port(sw:in std_logic_vector(7 downto 0);
		key:in std_logic_vector(1 downto 0);
		clock_50:in std_logic;
		hex3,hex2,hex1,hex0:out std_logic_vector(0 to 6);
		ledr:out std_logic_vector(1 downto 0));
end component;

component tester is
	generic(nbit: positive:=16);
	port(sw:out std_logic_vector(7 downto 0);
		key:out std_logic_vector(1 downto 0);
		clock_50:out std_logic;
		hex3,hex2,hex1,hex0:in std_logic_vector(0 to 6);
		ledr:in std_logic_vector(1 downto 0);
		error:out std_logic);
end component;

signal sw:std_logic_vector(7 downto 0);
signal clock_50,error: std_logic;
signal hex3,hex2,hex1,hex0:std_logic_vector(0 to 6);
signal ledr,key: std_logic_vector(1 downto 0);

begin
	uut:ReflexCircuit port map(sw,key,clock_50,hex3,hex2,hex1,hex0,ledr);
	tes:tester port map(sw,key,clock_50,hex3,hex2,hex1,hex0,ledr,error);
end test;
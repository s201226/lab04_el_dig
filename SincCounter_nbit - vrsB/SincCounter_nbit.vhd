library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SincCounter_nbit is
	generic(nbit: positive:=16);
	port(key:in std_logic_vector(0 downto 0);
		sw:in std_logic_vector(1 downto 0);
		hex3,hex2,hex1,hex0:out std_logic_vector(0 to 6));
end SincCounter_nbit;

architecture behavioral of SincCounter_nbit is

component D_flip_flop is
	generic(nbit:positive:=16);
	port(D:in unsigned(nbit-1 downto 0);
		enable,clk,resetn:in std_logic;
		Q:buffer unsigned(nbit-1 downto 0));
end component;

component decoder_7seg is
	port(num:in unsigned(3 downto 0);
		to_hex:out std_logic_vector(0 to 6));
end component;

signal enable,resetn:std_logic;
signal to_ff,num:unsigned(nbit-1 downto 0);

begin
	enable<=sw(1); resetn<=sw(0);
	
	D0:D_flip_flop port map
		(D=>to_ff,
		enable=>enable,
		clk=>key(0),
		resetn=>resetn,
		Q=>num);
		
	to_ff<=num+1;
	
	H3:decoder_7seg port map(num=>num(nbit-1 downto 12),to_hex=>hex3);
	H2:decoder_7seg port map(num=>num(11 downto 8),to_hex=>hex2);
	H1:decoder_7seg port map(num=>num(7 downto 4),to_hex=>hex1);
	H0:decoder_7seg port map(num=>num(3 downto 0),to_hex=>hex0);
		
end behavioral;
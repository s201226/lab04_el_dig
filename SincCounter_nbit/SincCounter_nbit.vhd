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

component T_flip_flop is
	port(T:in std_logic;
		clk,resetn:in std_logic;
		Q:buffer std_logic);
end component;

component decoder_7seg is
	port(num:in unsigned(3 downto 0);
		to_hex:out std_logic_vector(0 to 6));
end component;

signal enable,resetn:std_logic;
signal num:unsigned(nbit-1 downto 0);
signal in_tff:std_logic_vector(nbit-1 downto 1);
signal i,k:integer;

begin
	enable<=sw(1); resetn<=sw(0);
	
	gen_add:for i in 0 to nbit-1 generate
		gen01:if(i=0) generate
			T0:T_flip_flop port map
				(T=>enable,
				clk=>key(0),
				resetn=>resetn,
				Q=>num(i));
		end generate;
		
		gen02:if(i=1) generate
			in_tff(i)<=enable and num(i-1);
			T0:T_flip_flop port map
				(T=>in_tff(i),
				clk=>key(0),
				resetn=>resetn,
				Q=>num(i));
		end generate;
		
		gen03:if(i>1) generate
			in_tff(i)<=in_tff(i-1)and num(i-1);
			T0:T_flip_flop port map
				(T=>in_tff(i),
				clk=>key(0),
				resetn=>resetn,
				Q=>num(i));
		end generate;
	end generate;
	
	H3:decoder_7seg port map(num=>num(nbit-1 downto 12),to_hex=>hex3);
	H2:decoder_7seg port map(num=>num(11 downto 8),to_hex=>hex2);
	H1:decoder_7seg port map(num=>num(7 downto 4),to_hex=>hex1);
	H0:decoder_7seg port map(num=>num(3 downto 0),to_hex=>hex0);
		
end behavioral;
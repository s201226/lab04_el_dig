library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SincCounter_nbit is
	generic(nbit: positive:=16);
	port(enable,clk,resetn:in std_logic;
		num:buffer unsigned(nbit-1 downto 0));
end SincCounter_nbit;

architecture behavioral of SincCounter_nbit is

component T_flip_flop is
	port(T:in std_logic;
		clk,resetn:in std_logic;
		Q:buffer std_logic);
end component;

signal in_tff:std_logic_vector(nbit-1 downto 1);
signal i:integer;

begin
	gen_add:for i in 0 to nbit-1 generate
		gen01:if(i=0) generate
			T0:T_flip_flop port map
				(T=>enable,
				clk=>clk,
				resetn=>resetn,
				Q=>num(i));
		end generate;
		
		gen02:if(i=1) generate
			in_tff(i)<=enable and num(i-1);
			T0:T_flip_flop port map
				(T=>in_tff(i),
				clk=>clk,
				resetn=>resetn,
				Q=>num(i));
		end generate;
		
		gen03:if(i>1) generate
			in_tff(i)<=in_tff(i-1)and num(i-1);
			T0:T_flip_flop port map
				(T=>in_tff(i),
				clk=>clk,
				resetn=>resetn,
				Q=>num(i));
		end generate;
	end generate;
end behavioral;
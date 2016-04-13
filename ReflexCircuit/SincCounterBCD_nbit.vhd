library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SincCounterBCD_nbit is
	generic(nbit: positive:=16);
	port(enable,clk,resetn:in std_logic;
		num:buffer unsigned(nbit-1 downto 0));
end SincCounterBCD_nbit;

architecture behavioral of SincCounterBCD_nbit is

component SincCounter_nbit is
	generic(nbit: positive:=16);
	port(enable,clk,resetn:in std_logic;
		num:buffer unsigned(nbit-1 downto 0));
end component;

signal in_tff:std_logic_vector(nbit-1 downto 0);
signal i:integer;

begin
	gen_add:for i in 0 to 3 generate
		gen01:if(i=0) generate	
			S1:SincCounter_nbit generic map(nbit=>4)
				port map(enable=>enable,clk=>clk,resetn=>resetn,num=>num(3 downto 0));
		end generate;
		
		gen02:if(i=1) generate
			in_tff(i)<=enable and(num(4*i-4))and(num(4*i-1));	
			S2:SincCounter_nbit generic map(nbit=>4)
				port map(enable=>in_tff(i),clk=>clk,resetn=>resetn,num=>num(4*(i+1)-1 downto 4*i));
		end generate;
		
		gen03:if(i>1) generate
			in_tff(i)<=in_tff(i-1)and(num(4*i-4)and num(4*i-1));
			S3:SincCounter_nbit generic map(nbit=>4)
				port map(enable=>in_tff(i),clk=>clk,resetn=>resetn,num=>num(4*(i+1)-1 downto 4*i));
		end generate;
	end generate;
end behavioral;
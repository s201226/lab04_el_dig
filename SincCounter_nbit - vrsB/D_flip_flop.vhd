library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity D_flip_flop is
	generic(nbit:positive:=16);
	port(D:in unsigned(nbit-1 downto 0);
		enable,clk,resetn:in std_logic;
		Q:buffer unsigned(nbit-1 downto 0));
end D_flip_flop;

architecture behavioral of D_flip_flop is
begin
	process(resetn,clk)
	begin
		if(resetn='0') then Q<=(others=>'0');
		elsif(clk'event and clk='1') then
			if(enable='1') then Q<=D;
			end if;
		end if;
	end process;
end behavioral;
library ieee;
use ieee.std_logic_1164.all;

entity T_flip_flop is
	port(T:in std_logic;
		clk,resetn:in std_logic;
		Q:buffer std_logic);
end T_flip_flop;

architecture behavioral of T_flip_flop is
begin
	process(resetn,clk)
	begin
		if(resetn='0') then Q<='0';
		elsif(clk'event and clk='1') then
			if(T='1') then Q<=not(Q);
			end if;
		end if;
	end process;
end behavioral;
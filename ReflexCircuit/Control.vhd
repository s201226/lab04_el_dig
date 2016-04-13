library ieee;
use ieee.std_logic_1164.all;

entity Control is
	port(key,start,clk:in std_logic;
		en_c,en_s,en_l,resetn:out std_logic);
end Control;


architecture behavioral of Control is

type state_enum is (RESET,START01,COUNT01,START02,COUNT02,RESULT);
signal state,to_ff:state_enum;
signal resetn_ff:std_logic;

begin
	process(state)
	begin
		en_c<='0';
		en_s<='0';
		en_l<='0';
		resetn<='1';
	
		case state is
			when RESET => null;
			when START01 => en_c<='1'; en_s<='1'; resetn<='0';
			when COUNT01 => en_c<='1'; en_s<='1';
			when START02 => en_c<='1'; en_s<='1'; en_l<='1'; resetn<='0';
			when COUNT02 => en_c<='1'; en_s<='1'; en_l<='1';
			when RESULT => en_s<='1';
			when others => null;
		end case;
	end process;
	
	resetn_ff<='1';
	
	process(clk)
	begin
		if(resetn_ff='0') then state<=RESET;
		elsif(clk'event and clk='1') then
			state<=to_ff;
		end if;
	end process;
	
	process(key,start,state)
	begin
		assign:case state is 
			when RESET => if(key='0') then to_ff<=START01; else to_ff<=RESET; end if;
			when START01 => if(key='1') then
								if(start='0') then to_ff<=COUNT01; else to_ff<=RESULT; end if;
							else to_ff<=START01;
							end if;
			when COUNT01 => if(start='1') then to_ff<=START02; else to_ff<=COUNT01; end if;
			when START02 => if(key='1') then to_ff<=COUNT02; else to_ff<=START02; end if;
			when COUNT02 => if(key='0') then to_ff<=RESULT; else to_ff<=COUNT02; end if;
			when RESULT => if(key='1') then to_ff<=RESET; else to_ff<=RESULT; end if;
			when others => to_ff<=RESET;
		end case;
	end process;
end behavioral;
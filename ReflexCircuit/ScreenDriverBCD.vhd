library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ScreenDriverBCD is
	port(enable:in std_logic;
		numBCD:in unsigned(15 downto 0);
		hex3,hex2,hex1,hex0:out std_logic_vector(0 to 6));
end ScreenDriverBCD;


architecture behavioral of ScreenDriverBCD is

component decoder_7seg is
	port(num:in unsigned(3 downto 0);
		enable:in std_logic;
		to_hex:out std_logic_vector(0 to 6));
end component;

type hex_val is array(0 to 3) of std_logic_vector(0 to 6);
signal to_hex:hex_val;

begin
	gen01:for i in 1 to 4 generate
		dec01:decoder_7seg port map
			(num=>numBCD(4*i-1 downto 4*i-4),
			enable=>enable,
			to_hex=>to_hex(i-1));
	end generate;
	
	hex0<=to_hex(0);
	hex1<=to_hex(1);
	hex2<=to_hex(2);
	hex3<=to_hex(3);
end behavioral;